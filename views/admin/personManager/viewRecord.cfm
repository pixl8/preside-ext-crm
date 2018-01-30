<cfscript>
	id = rc.id ?: "";

	version = Val( rc.version ?: "" );

	renderedRecord = prc.renderedRecord ?: "";

	canEdit   = IsTrue( prc.canEdit   ?: "" );
	canDelete = IsTrue( prc.canDelete ?: "" );
</cfscript>

<cfoutput>
	<div class="top-right-button-group">
		<cfif canDelete>
			<a class="pull-right inline confirmation-prompt" href="#prc.deleteRecordLink#" title="#HtmlEditFormat( translateResource( 'personmanager:delete.record.link.title' ) )#">
				<button class="btn btn-danger btn-sm">
					<i class="fa fa-trash-o"></i>
					#translateResource( uri="cms:datamanager.deleteRecord.btn" )#
				</button>
			</a>
		</cfif>
		<cfif canEdit>
			<a class="pull-right inline" data-global-key="e" href="#prc.editRecordLink#">
				<button class="btn btn-success btn-sm">
					<i class="fa fa-pencil"></i>
					#translateResource( uri="cms:datamanager.editRecord.btn" )#
				</button>
			</a>
		</cfif>
	</div>

	#renderViewlet( event='admin.datamanager.versionNavigator', args={
		  object         = "person"
		, id             = id
		, version        = version
		, isDraft        = IsTrue( prc.record._version_is_draft ?: "" )
		, baseUrl        = event.buildAdminLink( linkto="personManager.viewRecord", queryString="id=#id#&version={version}" )
		, allVersionsUrl = event.buildAdminLink( linkto="personManager.versionHistory", queryString="id=#id#" )
	} )#

	#renderedRecord#
</cfoutput>