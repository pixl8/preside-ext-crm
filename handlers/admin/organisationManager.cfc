component extends="preside.system.base.AdminHandler" {

	property name="dao"                inject="presidecms:object:organisation";
	property name="messageBox"         inject="coldbox:plugin:messageBox";
	property name="dataManagerService" inject="dataManagerService";

	function prehandler( event, rc, prc ) {
		super.preHandler( argumentCollection = arguments );

		_checkPermissions( event=event, key="read" );

		event.addAdminBreadCrumb(
			  title = translateResource( "organisationmanager:breadcrumb" )
			, link  = event.buildAdminLink( linkTo="organisationManager" )
		);

		prc.pageIcon = "building";
	}

	function index( event, rc, prc ) {
		prc.pageTitle    = translateResource( "organisationmanager:page.title" );
		prc.pageSubtitle = translateResource( "organisationmanager:page.subtitle" );

		prc.canAdd    = hasCmsPermission( "organisationmanager.add"    );
		prc.canDelete = hasCmsPermission( "organisationmanager.delete" );

		prc.batchEditableFields = dataManagerService.listBatchEditableFields( "organisation" );
	}

	function add( event, rc, prc ) {
		_checkPermissions( event=event, key="add" );

		prc.pageTitle    = translateResource( "organisationmanager:add.page.title" );
		prc.pageSubtitle = translateResource( "organisationmanager:add.page.subtitle" );

		event.addAdminBreadCrumb(
			  title = translateResource( "organisationmanager:add.page.breadcrumb" )
			, link  = event.buildAdminLink( linkTo="organisationManager.add" )
		);
	}

	function addAction( event, rc, prc ) {
		_checkPermissions( event=event, key="add" );

		runEvent(
			  event          = "admin.DataManager._addRecordAction"
			, prePostExempt  = true
			, private        = true
			, eventArguments = {
				  object            = "organisation"
				, errorAction       = "organisationManager.add"
				, addAnotherAction  = "organisationManager.add"
				, successAction     = "organisationManager"
				, redirectOnSuccess = true
				, audit             = true
				, auditType         = "organisationmanager"
				, auditAction       = "add_record"
				, draftsEnabled     = false
			}
		);
	}

	function edit( event, rc, prc ) {
		_checkPermissions( event=event, key="edit" );

		var id      = rc.id ?: "";
		var version = Val( rc.version ?: "" );

		prc.record = dao.selectData(
			  filter             = { id=id }
			, fromVersionTable   = true
			, specificVersion    = version
		);

		if ( !prc.record.recordCount ) {
			messageBox.error( translateResource( uri="organisationmanager:record.not.found.error" ) );
			setNextEvent( url=event.buildAdminLink( linkTo="organisationManager" ) );
		}
		prc.record = queryRowToStruct( prc.record );

		prc.pageTitle    = translateResource( uri="organisationmanager:edit.page.title", data=[ prc.record.name ] );
		prc.pageSubtitle = translateResource( uri="organisationmanager:edit.page.subtitle", data=[ prc.record.name ] );

		event.addAdminBreadCrumb(
			  title = translateResource( uri="organisationmanager:edit.page.breadcrumb", data=[ prc.record.name ] )
			, link  = event.buildAdminLink( linkTo="organisationManager.edit", queryString="id=#id#" )
		);
	}

	function editAction( event, rc, prc ) {
		_checkPermissions( event=event, key="edit" );

		var id = rc.id ?: "";

		prc.record = dao.selectData( filter={ id=id } );

		if ( !prc.record.recordCount ) {
			messageBox.error( translateResource( uri="organisationmanager:record.not.found.error" ) );
			setNextEvent( url=event.buildAdminLink( linkTo="organisationManager" ) );
		}

		runEvent(
			  event          = "admin.DataManager._editRecordAction"
			, private        = true
			, prePostExempt  = true
			, eventArguments = {
				  object            = "organisation"
				, errorAction       = "organisationManager.edit"
				, successUrl        = event.buildAdminLink( linkto="organisationManager" )
				, redirectOnSuccess = true
				, audit             = true
				, auditType         = "organisationmanager"
				, auditAction       = "edit"
				, draftsEnabled     = false
			}
		);
	}

	function deleteAction( event, rc, prc ) {
		_checkPermissions( event=event, key="delete" );

		runEvent(
			  event          = "admin.DataManager._deleteRecordAction"
			, private        = true
			, prePostExempt  = true
			, eventArguments = {
				  object       = "organisation"
				, postAction   = "organisationManager"
				, audit        = true
				, auditType    = "organisationmanager"
				, auditAction  = "delete_record"
			}
		);
	}

	function multiAction( event, rc, prc ) {
		var action = rc.multiAction ?: "";
		var ids    = rc.id          ?: "";

		switch( action ){
			case "batchUpdate":
				setNextEvent(
					  url           = event.buildAdminLink( linkTo="organisationManager.batchEditField", queryString="field=#( rc.field ?: '' )#" )
					, persistStruct = { id = ids }
				);
			break;

			case "delete":
				return deleteAction( argumentCollection = arguments );
			break;
		}
		messageBox.error( translateResource( "cms:datamanager.invalid.multirecord.action.error" ) );
		setNextEvent( url=event.buildAdminLink( linkTo="organisationManager" ) );
	}

	function batchEditField( event, rc, prc ) {
		var ids         = Trim( rc.id    ?: "" );
		var field       = Trim( rc.field ?: "" );
		var fieldName   = translateResource( uri="preside-objects.organisation:field.#field#.title", defaultValue=field );
		var recordCount = ids.listLen();

		_checkPermissions( argumentCollection=arguments, key="edit" );
		if ( !field.len() || !ids.len() ) {
			messageBox.error( translateResource( uri="organisationmanager:record.not.found.error" ) );
			setNextEvent( url=event.buildAdminLink( linkTo="organisationManager" ) );
		}

		prc.pageTitle    = translateResource( uri="organisationmanager:batchedit.page.title", data=[ fieldName, recordCount ] );
		prc.pageSubtitle = translateResource( uri="organisationmanager:batchedit.page.subtitle", data=[ fieldName, recordCount ] );

		event.addAdminBreadCrumb(
			  title = translateResource( uri="organisationmanager:batchedit.page.breadcrumb", data=[ fieldName ] )
			, link  = ""
		);
	}

	function batchEditFieldAction( event, rc, prc ) {
		var updateField = rc.updateField ?: "";
		var sourceIds   = ListToArray( Trim( rc.sourceIds ?: "" ) );

		_checkPermissions( argumentCollection=arguments, key="edit" );
		if ( !sourceIds.len() ) {
			messageBox.error( translateResource( uri="organisationmanager:record.not.found.error" ) );
			setNextEvent( url=event.buildAdminLink( linkTo="organisationManager" ) );
		}

		var success = datamanagerService.batchEditField(
			  objectName         = "organisation"
			, fieldName          = updateField
			, sourceIds          = sourceIds
			, value              = rc[ updateField ]      ?: ""
			, multiEditBehaviour = rc.multiValueBehaviour ?: "append"
			, auditCategory      = "organisationmanager"
			, auditAction        = "batch_edit_record"
		);

		if ( success ) {
			messageBox.info( translateResource( uri="organisationmanager:batchedit.confirmation" ) );
		} else {
			messageBox.error( translateResource( uri="organisationmanager:batchedit.error" ) );
		}
		setNextEvent( url=event.buildAdminLink( linkTo="organisationManager" ) );
	}

	public void function versionHistory( event, rc, prc ) {
		var id = rc.id ?: "";

		prc.record = dao.selectData( id=id, selectFields=[ "name" ] );
		if ( !prc.record.recordCount ) {
			messageBox.error( translateResource( uri="organisationmanager:record.not.found.error" ) );
			setNextEvent( url=event.buildAdminLink( linkTo="organisationManager" ) );
		}
		prc.pageTitle    = translateResource( uri="organisationmanager:versionHistory.page.title"   , data=[ prc.record.name ] );
		prc.pageSubTitle = translateResource( uri="organisationmanager:versionHistory.page.subTitle", data=[ prc.record.name ] );

		event.addAdminBreadCrumb(
			  title = translateResource( uri="organisationmanager:versionHistory.breadcrumb"  , data=[ prc.record.name ] )
			, link  = event.buildAdminLink( linkTo="organisationManager.versionHistory", queryString="id=" & id )
		);
	}

	public void function getRecordsForAjaxDataTables( event, rc, prc ) {
		_checkPermissions( event=event, key="read" );

		runEvent(
			  event          = "admin.DataManager._getObjectRecordsForAjaxDataTables"
			, prePostExempt  = true
			, private        = true
			, eventArguments = {
				  object        = "organisation"
				, gridFields    = "name,trading_as,type,status,datecreated,datemodified"
				, actionsView   = "admin.organisationManager._gridActions"
			}
		);
	}

	private string function _gridActions( event, rc, prc, args={} ) {
		args.id                = args.id ?: "";
		args.deleteRecordLink  = event.buildAdminLink( linkTo="organisationManager.deleteAction"  , queryString="id=" & args.id );
		args.editRecordLink    = event.buildAdminLink( linkTo="organisationManager.edit"          , queryString="id=" & args.id );
		args.viewHistoryLink   = event.buildAdminLink( linkTo="organisationManager.versionHistory", queryString="id=" & args.id );
		args.deleteRecordTitle = translateResource( "organisationmanager:delete.record.link.title" );
		args.objectName        = "organisation";
		args.canEdit           = hasCmsPermission( "organisationmanager.edit"   );
		args.canDelete         = hasCmsPermission( "organisationmanager.delete" );
		args.canViewHistory    = hasCmsPermission( "organisationmanager.view"   );

		return renderView( view="/admin/organisationManager/_gridActions", args=args );
	}

	public void function getHistoryForAjaxDatatables( event, rc, prc ) {
		var id = rc.id ?: "";

		prc.record = dao.selectData( id=id, selectFields=[ "name as label" ] );
		if ( !prc.record.recordCount ) {
			event.notFound();
		}

		runEvent(
			  event          = "admin.DataManager._getRecordHistoryForAjaxDataTables"
			, prePostExempt  = true
			, private        = true
			, eventArguments = {
				  object     = "organisation"
				, recordId   = id
				, actionsView = "admin/organisationManager/_historyActions"
			}
		);
	}

	public void function exportDataAction( event, rc, prc ) {
        _checkPermissions( event=event, key="read" );

        runEvent(
              event          = "admin.DataManager._exportDataAction"
            , prePostExempt  = true
            , private        = true
            , eventArguments = { objectName="organisation" }
        );
    }

// private utility
	private void function _checkPermissions( required any event, required string key ) {
		if ( !hasCmsPermission( "organisationmanager." & arguments.key ) ) {
			event.adminAccessDenied();
		}
	}
}