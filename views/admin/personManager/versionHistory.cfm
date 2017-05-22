<cfset id = rc.id ?: ""/>
<cfoutput>
	#renderView( view="/admin/datamanager/_objectVersionHistoryTable", args={
		  objectName    = "person"
		, datasourceUrl = event.buildAdminLink( linkTo="personManager.getHistoryForAjaxDatatables", queryString="id=#id#" )
	} )#
</cfoutput>