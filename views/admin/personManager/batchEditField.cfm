<cfoutput>
	#renderViewlet( event="admin.datamanager._batchEditForm", args={
		  saveChangesAction = event.buildAdminLink( linkTo='personManager.batchEditFieldAction' )
		, cancelAction      = event.buildAdminLink( linkTo="personManager" )
		, object            = "person"
		, ids               = rc.id    ?: ""
		, field             = rc.field ?: ""
	} )#
</cfoutput>