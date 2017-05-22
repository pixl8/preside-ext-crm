<cfscript>
	recordId = rc.id      ?: "";
	version  = rc.version ?: "";
</cfscript>

<cfoutput>
	#renderViewlet( event='admin.datamanager.versionNavigator', args={
		  object         = "person"
		, id             = recordId
		, version        = version
		, isDraft        = IsTrue( prc.record._version_is_draft ?: "" )
		, baseUrl        = event.buildAdminLink( linkto="personManager.edit", queryString="id=#recordId#&version=" )
		, allVersionsUrl = event.buildAdminLink( linkto="personManager.versionHistory", queryString="id=#recordId#" )
	} )#

	#renderView( view="/admin/datamanager/_editRecordForm", args={
		  object           = "person"
		, id               = rc.id      ?: ""
		, record           = prc.record ?: {}
		, editRecordAction = event.buildAdminLink( linkTo='personManager.editAction' )
		, cancelAction     = event.buildAdminLink( linkTo='personManager' )
		, useVersioning    = true
	} )#
</cfoutput>