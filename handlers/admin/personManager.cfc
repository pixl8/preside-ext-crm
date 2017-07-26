component extends="preside.system.base.AdminHandler" {

	property name="dao"                inject="presidecms:object:person";
	property name="messageBox"         inject="coldbox:plugin:messageBox";
	property name="dataManagerService" inject="dataManagerService";

	function prehandler( event, rc, prc ) {
		super.preHandler( argumentCollection = arguments );

		_checkPermissions( event=event, key="read" );

		event.addAdminBreadCrumb(
			  title = translateResource( "personmanager:breadcrumb" )
			, link  = event.buildAdminLink( linkTo="personManager" )
		);

		prc.pageIcon = "user";
	}

	function index( event, rc, prc ) {
		prc.pageTitle    = translateResource( "personmanager:page.title" );
		prc.pageSubtitle = translateResource( "personmanager:page.subtitle" );

		prc.canAdd    = hasCmsPermission( "personmanager.add"    );
		prc.canDelete = hasCmsPermission( "personmanager.delete" );

		prc.batchEditableFields = dataManagerService.listBatchEditableFields( "person" );
	}

	function add( event, rc, prc ) {
		_checkPermissions( event=event, key="add" );

		prc.pageTitle    = translateResource( "personmanager:add.page.title" );
		prc.pageSubtitle = translateResource( "personmanager:add.page.subtitle" );

		event.addAdminBreadCrumb(
			  title = translateResource( "personmanager:add.page.breadcrumb" )
			, link  = event.buildAdminLink( linkTo="personManager.add" )
		);
	}

	function addAction( event, rc, prc ) {
		_checkPermissions( event=event, key="add" );

		runEvent(
			  event          = "admin.DataManager._addRecordAction"
			, prePostExempt  = true
			, private        = true
			, eventArguments = {
				  object            = "person"
				, errorAction       = "personManager.add"
				, addAnotherAction  = "personManager.add"
				, successAction     = "personManager"
				, redirectOnSuccess = true
				, audit             = true
				, auditType         = "personmanager"
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
			messageBox.error( translateResource( uri="personmanager:record.not.found.error" ) );
			setNextEvent( url=event.buildAdminLink( linkTo="personManager" ) );
		}
		prc.record = queryRowToStruct( prc.record );

		prc.pageTitle    = translateResource( uri="personmanager:edit.page.title", data=[ prc.record.label ] );
		prc.pageSubtitle = translateResource( uri="personmanager:edit.page.subtitle", data=[ prc.record.label ] );

		event.addAdminBreadCrumb(
			  title = translateResource( uri="personmanager:edit.page.breadcrumb", data=[ prc.record.label ] )
			, link  = event.buildAdminLink( linkTo="personManager.edit", queryString="id=#id#" )
		);
	}

	function editAction( event, rc, prc ) {
		_checkPermissions( event=event, key="edit" );

		var id = rc.id ?: "";

		prc.record = dao.selectData( filter={ id=id } );

		if ( !prc.record.recordCount ) {
			messageBox.error( translateResource( uri="personmanager:record.not.found.error" ) );
			setNextEvent( url=event.buildAdminLink( linkTo="personManager" ) );
		}

		runEvent(
			  event          = "admin.DataManager._editRecordAction"
			, private        = true
			, prePostExempt  = true
			, eventArguments = {
				  object            = "person"
				, errorAction       = "personManager.edit"
				, successUrl        = event.buildAdminLink( linkto="personManager" )
				, redirectOnSuccess = true
				, audit             = true
				, auditType         = "personmanager"
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
				  object       = "person"
				, postAction   = "personManager"
				, audit        = true
				, auditType    = "personmanager"
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
					  url           = event.buildAdminLink( linkTo="personManager.batchEditField", queryString="field=#( rc.field ?: '' )#" )
					, persistStruct = { id = ids }
				);
			break;

			case "delete":
				return deleteAction( argumentCollection = arguments );
			break;
		}
		messageBox.error( translateResource( "cms:datamanager.invalid.multirecord.action.error" ) );
		setNextEvent( url=event.buildAdminLink( linkTo="personManager" ) );
	}

	function batchEditField( event, rc, prc ) {
		var ids         = Trim( rc.id    ?: "" );
		var field       = Trim( rc.field ?: "" );
		var fieldName   = translateResource( uri="preside-objects.person:field.#field#.title", defaultValue=field );
		var recordCount = ids.listLen();

		_checkPermissions( argumentCollection=arguments, key="edit" );
		if ( !field.len() || !ids.len() ) {
			messageBox.error( translateResource( uri="personmanager:record.not.found.error" ) );
			setNextEvent( url=event.buildAdminLink( linkTo="personManager" ) );
		}

		prc.pageTitle    = translateResource( uri="personmanager:batchedit.page.title", data=[ fieldName, recordCount ] );
		prc.pageSubtitle = translateResource( uri="personmanager:batchedit.page.subtitle", data=[ fieldName, recordCount ] );

		event.addAdminBreadCrumb(
			  title = translateResource( uri="personmanager:batchedit.page.breadcrumb", data=[ fieldName ] )
			, link  = ""
		);
	}

	function batchEditFieldAction( event, rc, prc ) {
		var updateField = rc.updateField ?: "";
		var sourceIds   = ListToArray( Trim( rc.sourceIds ?: "" ) );

		_checkPermissions( argumentCollection=arguments, key="edit" );
		if ( !sourceIds.len() ) {
			messageBox.error( translateResource( uri="personmanager:record.not.found.error" ) );
			setNextEvent( url=event.buildAdminLink( linkTo="personManager" ) );
		}

		var success = datamanagerService.batchEditField(
			  objectName         = "person"
			, fieldName          = updateField
			, sourceIds          = sourceIds
			, value              = rc[ updateField ]      ?: ""
			, multiEditBehaviour = rc.multiValueBehaviour ?: "append"
			, auditCategory      = "personmanager"
			, auditAction        = "batch_edit_record"
		);

		if ( success ) {
			messageBox.info( translateResource( uri="personmanager:batchedit.confirmation" ) );
		} else {
			messageBox.error( translateResource( uri="personmanager:batchedit.error" ) );
		}
		setNextEvent( url=event.buildAdminLink( linkTo="personManager" ) );
	}

	public void function versionHistory( event, rc, prc ) {
		var id = rc.id ?: "";

		prc.record = dao.selectData( id=id, selectFields=[ "label" ] );
		if ( !prc.record.recordCount ) {
			messageBox.error( translateResource( uri="personmanager:record.not.found.error" ) );
			setNextEvent( url=event.buildAdminLink( linkTo="personManager" ) );
		}
		prc.pageTitle    = translateResource( uri="personmanager:versionHistory.page.title"   , data=[ prc.record.label ] );
		prc.pageSubTitle = translateResource( uri="personmanager:versionHistory.page.subTitle", data=[ prc.record.label ] );

		event.addAdminBreadCrumb(
			  title = translateResource( uri="personmanager:versionHistory.breadcrumb"  , data=[ prc.record.label ] )
			, link  = event.buildAdminLink( linkTo="personManager.versionHistory", queryString="id=" & id )
		);
	}

	public void function getRecordsForAjaxDataTables( event, rc, prc ) {
		_checkPermissions( event=event, key="read" );

		runEvent(
			  event          = "admin.DataManager._getObjectRecordsForAjaxDataTables"
			, prePostExempt  = true
			, private        = true
			, eventArguments = {
				  object        = "person"
				, gridFields    = "title,first_name,last_name,type,status,datecreated,datemodified"
				, actionsView   = "admin.personManager._gridActions"
			}
		);
	}

	private string function _gridActions( event, rc, prc, args={} ) {
		args.id                = args.id ?: "";
		args.deleteRecordLink  = event.buildAdminLink( linkTo="personManager.deleteAction"  , queryString="id=" & args.id );
		args.editRecordLink    = event.buildAdminLink( linkTo="personManager.edit"          , queryString="id=" & args.id );
		args.viewHistoryLink   = event.buildAdminLink( linkTo="personManager.versionHistory", queryString="id=" & args.id );
		args.deleteRecordTitle = translateResource( "personmanager:delete.record.link.title" );
		args.objectName        = "person";
		args.canEdit           = hasCmsPermission( "personmanager.edit"   );
		args.canDelete         = hasCmsPermission( "personmanager.delete" );
		args.canViewHistory    = hasCmsPermission( "personmanager.view"   );

		return renderView( view="/admin/personManager/_gridActions", args=args );
	}

	public void function getHistoryForAjaxDatatables( event, rc, prc ) {
		var id = rc.id ?: "";

		prc.record = dao.selectData( id=id, selectFields=[ "label as label" ] );
		if ( !prc.record.recordCount ) {
			event.notFound();
		}

		runEvent(
			  event          = "admin.DataManager._getRecordHistoryForAjaxDataTables"
			, prePostExempt  = true
			, private        = true
			, eventArguments = {
				  object     = "person"
				, recordId   = id
				, actionsView = "admin/personManager/_historyActions"
			}
		);
	}

	public void function exportDataAction( event, rc, prc ) {
        _checkPermissions( event=event, key="read" );

        runEvent(
              event          = "admin.DataManager._exportDataAction"
            , prePostExempt  = true
            , private        = true
            , eventArguments = { objectName="person" }
        );
    }

// private utility
	private void function _checkPermissions( required any event, required string key ) {
		if ( !hasCmsPermission( "personmanager." & arguments.key ) ) {
			event.adminAccessDenied();
		}
	}
}