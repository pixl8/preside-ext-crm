<cfoutput>
	#renderView( view="/admin/datamanager/_addRecordForm", args={
		  objectName            = "contact"
		, addRecordAction       = event.buildAdminLink( linkTo='contactManager.addAction' )
		, cancelAction          = event.buildAdminLink( linkTo='contactManager' )
		, allowAddAnotherSwitch = true
	} )#
</cfoutput>