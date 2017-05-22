<cfset id = rc.id ?: ""/>
<cfoutput>
	#renderView( view="/admin/datamanager/_objectVersionHistoryTable", args={
		  objectName    = "contact"
		, datasourceUrl = event.buildAdminLink( linkTo="contactManager.getHistoryForAjaxDatatables", queryString="id=#id#" )
	} )#
</cfoutput>