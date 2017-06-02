component extends="preside.system.base.AdminHandler" {

	property name="dao"        		   inject="presidecms:object:contact";
	property name="messageBox" 		   inject="coldbox:plugin:messageBox";
	property name="dataManagerService" inject="dataManagerService";

	function prehandler( event, rc, prc ) {
		super.preHandler( argumentCollection = arguments );

		_checkPermissions( event=event, key="read" );

		event.addAdminBreadCrumb(
			  title = translateResource( "contactmanager:breadcrumb" )
			, link  = event.buildAdminLink( linkTo="contactManager" )
		);

		prc.pageIcon = "user";
	}

	function index( event, rc, prc ) {
		prc.pageTitle    = translateResource( "contactmanager:page.title" );
		prc.pageSubtitle = translateResource( "contactmanager:page.subtitle" );

		prc.canAdd    = hasCmsPermission( "contactmanager.add"    );
		prc.canDelete = hasCmsPermission( "contactmanager.delete" );

		prc.batchEditableFields = dataManagerService.listBatchEditableFields( "contact" );

	}

	function add( event, rc, prc ) {
		_checkPermissions( event=event, key="add" );

		prc.pageTitle    = translateResource( "contactmanager:add.page.title" );
		prc.pageSubtitle = translateResource( "contactmanager:add.page.subtitle" );

		event.addAdminBreadCrumb(
			  title = translateResource( "contactmanager:add.page.breadcrumb" )
			, link  = event.buildAdminLink( linkTo="contactManager.add" )
		);
	}
	function addAction( event, rc, prc ) {
		_checkPermissions( event=event, key="add" );

		runEvent(
			  event          = "admin.DataManager._addRecordAction"
			, prePostExempt  = true
			, private        = true
			, eventArguments = {
				  object            = "contact"
				, errorAction       = "contactManager.add"
				, addAnotherAction  = "contactManager.add"
				, successAction     = "contactManager"
				, redirectOnSuccess = true
				, audit             = true
				, auditType         = "contactmanager"
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
			messageBox.error( translateResource( uri="contactmanager:record.not.found.error" ) );
			setNextEvent( url=event.buildAdminLink( linkTo="contactManager" ) );
		}
		prc.record = queryRowToStruct( prc.record );

		prc.pageTitle    = translateResource( uri="contactmanager:edit.page.title", data=[ prc.record.label ] );
		prc.pageSubtitle = translateResource( uri="contactmanager:edit.page.subtitle", data=[ prc.record.label ] );

		event.addAdminBreadCrumb(
			  title = translateResource( uri="contactmanager:edit.page.breadcrumb", data=[ prc.record.label ] )
			, link  = event.buildAdminLink( linkTo="contactManager.edit", queryString="id=#id#" )
		);
	}
	function editAction( event, rc, prc ) {
		_checkPermissions( event=event, key="edit" );

		var id = rc.id ?: "";

		prc.record = dao.selectData( filter={ id=id } );

		if ( !prc.record.recordCount ) {
			messageBox.error( translateResource( uri="contactmanager:record.not.found.error" ) );
			setNextEvent( url=event.buildAdminLink( linkTo="contactManager" ) );
		}

		runEvent(
			  event          = "admin.DataManager._editRecordAction"
			, private        = true
			, prePostExempt  = true
			, eventArguments = {
				  object            = "contact"
				, errorAction       = "contactManager.edit"
				, successUrl        = event.buildAdminLink( linkto="contactManager" )
				, redirectOnSuccess = true
				, audit             = true
				, auditType         = "contactmanager"
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
				  object       = "contact"
				, postAction   = "contactManager"
				, audit        = true
				, auditType    = "contactmanager"
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
					  url           = event.buildAdminLink( linkTo="contactManager.batchEditField", queryString="field=#( rc.field ?: '' )#" )
					, persistStruct = { id = ids }
				);
			break;

			case "delete":
				return deleteAction( argumentCollection = arguments );
			break;
		}
		messageBox.error( translateResource( "cms:datamanager.invalid.multirecord.action.error" ) );
		setNextEvent( url=event.buildAdminLink( linkTo="contactManager" ) );
	}

	function batchEditField( event, rc, prc ) {
		var ids         = Trim( rc.id    ?: "" );
		var field       = Trim( rc.field ?: "" );
		var fieldName   = translateResource( uri="preside-objects.contact:field.#field#.title", defaultValue=field );
		var recordCount = ids.listLen();

		_checkPermissions( argumentCollection=arguments, key="edit" );
		if ( !field.len() || !ids.len() ) {
			messageBox.error( translateResource( uri="contactmanager:record.not.found.error" ) );
			setNextEvent( url=event.buildAdminLink( linkTo="contactManager" ) );
		}

		prc.pageTitle    = translateResource( uri="contactmanager:batchedit.page.title", data=[ fieldName, recordCount ] );
		prc.pageSubtitle = translateResource( uri="contactmanager:batchedit.page.subtitle", data=[ fieldName, recordCount ] );

		event.addAdminBreadCrumb(
			  title = translateResource( uri="contactmanager:batchedit.page.breadcrumb", data=[ fieldName ] )
			, link  = ""
		);
	}

	function batchEditFieldAction( event, rc, prc ) {
		var updateField = rc.updateField ?: "";
		var sourceIds   = ListToArray( Trim( rc.sourceIds ?: "" ) );

		_checkPermissions( argumentCollection=arguments, key="edit" );
		if ( !sourceIds.len() ) {
			messageBox.error( translateResource( uri="contactmanager:record.not.found.error" ) );
			setNextEvent( url=event.buildAdminLink( linkTo="contactManager" ) );
		}

		var success = datamanagerService.batchEditField(
			  objectName         = "contact"
			, fieldName          = updateField
			, sourceIds          = sourceIds
			, value              = rc[ updateField ]      ?: ""
			, multiEditBehaviour = rc.multiValueBehaviour ?: "append"
			, auditCategory      = "contactmanager"
			, auditAction        = "batch_edit_record"
		);

		if( success ) {
			messageBox.info( translateResource( uri="contactmanager:batchedit.confirmation" ) );
		} else {
			messageBox.error( translateResource( uri="contactmanager:batchedit.error" ) );
		}
		setNextEvent( url=event.buildAdminLink( linkTo="contactManager" ) );
	}

	public void function versionHistory( event, rc, prc ) {
		var id = rc.id ?: "";

		prc.record = dao.selectData( id=id, selectFields=[ "label" ] );
		if ( !prc.record.recordCount ) {
			messageBox.error( translateResource( uri="contactmanager:record.not.found.error" ) );
			setNextEvent( url=event.buildAdminLink( linkTo="contactManager" ) );
		}
		prc.pageTitle    = translateResource( uri="contactmanager:versionHistory.page.title"   , data=[ prc.record.label ] );
		prc.pageSubTitle = translateResource( uri="contactmanager:versionHistory.page.subTitle", data=[ prc.record.label ] );

		event.addAdminBreadCrumb(
			  title = translateResource( uri="contactmanager:versionHistory.breadcrumb"  , data=[ prc.record.label ] )
			, link  = event.buildAdminLink( linkTo="contactManager.versionHistory", queryString="id=" & id )
		);
	}

	public void function getRecordsForAjaxDataTables( event, rc, prc ) {
		_checkPermissions( event=event, key="read" );

		runEvent(
			  event          = "admin.DataManager._getObjectRecordsForAjaxDataTables"
			, prePostExempt  = true
			, private        = true
			, eventArguments = {
				  object        = "contact"
				, gridFields    = "organisation,person,job_title,is_main_contact,is_main_organisation,type,status,datecreated,datemodified"
				, actionsView   = "admin.contactManager._gridActions"

			}
		);
	}

	private string function _gridActions( event, rc, prc, args={} ) {
		args.id                = args.id ?: "";
		args.deleteRecordLink  = event.buildAdminLink( linkTo="contactManager.deleteAction"  , queryString="id=" & args.id );
		args.editRecordLink    = event.buildAdminLink( linkTo="contactManager.edit"          , queryString="id=" & args.id );
		args.viewHistoryLink   = event.buildAdminLink( linkTo="contactManager.versionHistory", queryString="id=" & args.id );
		args.deleteRecordTitle = translateResource( "contactmanager:delete.record.link.title" );
		args.objectName        = "contact";
		args.canEdit           = hasCmsPermission( "contactmanager.edit"   );
		args.canDelete         = hasCmsPermission( "contactmanager.delete" );
		args.canViewHistory    = hasCmsPermission( "contactmanager.view"   );

		return renderView( view="/admin/contactManager/_gridActions", args=args );
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
				  object     = "contact"
				, recordId   = id
				, actionsView = "admin/contactManager/_historyActions"
			}
		);
	}

	public void function exportDataAction( event, rc, prc ) {
        _checkPermissions( event=event, key="read" );

        runEvent(
              event          = "admin.DataManager._exportDataAction"
            , prePostExempt  = true
            , private        = true
            , eventArguments = { objectName="contact" }
        );
    }

// private utility
	private void function _checkPermissions( required any event, required string key ) {
		if ( !hasCmsPermission( "contactmanager." & arguments.key ) ) {
			event.adminAccessDenied();
		}
	}

}