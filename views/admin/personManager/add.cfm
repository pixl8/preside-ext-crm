<cfoutput>
	#renderView( view="/admin/datamanager/_addRecordForm", args={
		  objectName            = "person"
		, addRecordAction       = event.buildAdminLink( linkTo='personManager.addAction' )
		, cancelAction          = event.buildAdminLink( linkTo='personManager' )
		, allowAddAnotherSwitch = true
	} )#
</cfoutput>