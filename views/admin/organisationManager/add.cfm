<cfoutput>
	#renderView( view="/admin/datamanager/_addRecordForm", args={
		  objectName            = "organisation"
		, addRecordAction       = event.buildAdminLink( linkTo='organisationManager.addAction' )
		, cancelAction          = event.buildAdminLink( linkTo='organisationManager' )
		, allowAddAnotherSwitch = true
	} )#
</cfoutput>