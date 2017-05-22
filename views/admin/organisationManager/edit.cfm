<cfscript>
	recordId = rc.id      ?: "";
	version  = rc.version ?: "";
</cfscript>

<cfoutput>
	#renderViewlet( event='admin.datamanager.versionNavigator', args={
		  object         = "organisation"
		, id             = recordId
		, version        = version
		, isDraft        = IsTrue( prc.record._version_is_draft ?: "" )
		, baseUrl        = event.buildAdminLink( linkto="organisationManager.edit", queryString="id=#recordId#&version=" )
		, allVersionsUrl = event.buildAdminLink( linkto="organisationManager.versionHistory", queryString="id=#recordId#" )
	} )#

	#renderView( view="/admin/datamanager/_editRecordForm", args={
		  object           = "organisation"
		, id               = rc.id      ?: ""
		, record           = prc.record ?: {}
		, editRecordAction = event.buildAdminLink( linkTo='organisationManager.editAction' )
		, cancelAction     = event.buildAdminLink( linkTo='organisationManager' )
		, useVersioning    = true
	} )#
</cfoutput>