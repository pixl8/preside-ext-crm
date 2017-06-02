<cfscript>
	objectName          = "organisation"
	gridFields          = ["name","trading_as","type","status","datecreated","datemodified"];
	objectTitle         = translateResource( uri = "preside-objects.#objectName#:title"         , defaultValue = objectName );
	objectTitleSingular = translateResource( uri = "preside-objects.#objectName#:title.singular", defaultValue = objectName );
	objectDescription   = translateResource( uri = "preside-objects.#objectName#:description"   , defaultValue = "" );
	addRecordTitle      = translateResource( uri = "cms:datamanager.addrecord.title"            , data = [ LCase( objectTitleSingular ) ] );
	canAdd              = IsTrue( prc.canAdd    ?: false );
	canDelete           = IsTrue( prc.canDelete ?: false );

	batchEditableFields = prc.batchEditableFields ?: {};
</cfscript>
<cfoutput>
	<div class="top-right-button-group">
		<cfif canAdd>
			<a class="pull-right inline" href="#event.buildAdminLink( linkTo="organisationManager.add" )#" data-global-key="a">
				<button class="btn btn-success btn-sm">
					<i class="fa fa-plus"></i>
					#addRecordTitle#
				</button>
			</a>
		</cfif>
	</div>

	#renderView( view="/admin/datamanager/_objectDataTable", args={
		  objectName          = objectName
		, useMultiActions     = canDelete
		, datasourceUrl       = event.buildAdminLink( linkTo="organisationManager.getRecordsForAjaxDataTables" )
		, multiActionUrl      = event.buildAdminLink( linkTo='organisationManager.multiAction' )
		, gridFields          = gridFields
		, batchEditableFields = batchEditableFields
		, allowDataExport     = true
        , dataExportUrl       = event.buildAdminLink( linkTo='organisationManager.exportDataAction' )
	} )#
</cfoutput>