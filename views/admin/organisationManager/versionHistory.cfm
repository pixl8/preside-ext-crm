<cfset id = rc.id ?: ""/>
<cfoutput>
	#renderView( view="/admin/datamanager/_objectVersionHistoryTable", args={
		  objectName    = "organisation"
		, datasourceUrl = event.buildAdminLink( linkTo="organisationManager.getHistoryForAjaxDatatables", queryString="id=#id#" )
	} )#
</cfoutput>