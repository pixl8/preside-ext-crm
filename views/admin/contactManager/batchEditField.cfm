<cfoutput>
	#renderViewlet( event="admin.datamanager._batchEditForm", args={
		  saveChangesAction = event.buildAdminLink( linkTo='contactManager.batchEditFieldAction' )
		, cancelAction      = event.buildAdminLink( linkTo="contactManager" )
		, object            = "contact"
		, ids               = rc.id    ?: ""
		, field             = rc.field ?: ""
	} )#
</cfoutput>