<cfoutput>
	#renderViewlet( event="admin.datamanager._batchEditForm", args={
		  saveChangesAction = event.buildAdminLink( linkTo='organisationManager.batchEditFieldAction' )
		, cancelAction      = event.buildAdminLink( linkTo="organisationManager" )
		, object            = "organisation"
		, ids               = rc.id    ?: ""
		, field             = rc.field ?: ""
	} )#
</cfoutput>