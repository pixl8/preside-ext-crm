<cfscript>
    subMenuItems = [];
    highlightRelatedObjects = {
          organisation = "organisation,organisation_address,organisation_note,organisation_organisation_link,organisation_person_link"
        , person       = "person,person_address,person_note,person_person_link"
    };
    if ( hasCmsPermission( permissionKey="crm.organisation.navigate" ) ) {
        subMenuItems.append( {
              link   = event.buildAdminLink( objectName="organisation" )
            , title  = translateResource( "cms:crmDataManager.organisations" )
            , active = ReFindNoCase( "^admin\.datamanager", event.getCurrentEvent() )
                       && listFindNoCase( highlightRelatedObjects.organisation, ( prc.objectName ?: "" ) )
        } );
    }
    if ( hasCmsPermission( permissionKey="crm.person.navigate" ) ) {
        subMenuItems.append( {
               link   = event.buildAdminLink( objectName="person" )
            ,  title  = translateResource( "cms:crmDataManager.persons" )
            ,  active = ReFindNoCase( "^admin\.datamanager", event.getCurrentEvent() )
                        && listFindNoCase( highlightRelatedObjects.person, ( prc.objectName ?: "" ) )
        } );
    }

    if ( subMenuItems.len() ) {
        isActive = false;
        for ( var subMenuItem in subMenuItems ) {
            if ( subMenuItem.active ) {
                isActive = true;
                break;
            }
        }
        WriteOutput( renderView(
              view = "/admin/layout/sidebar/_menuItem"
            , args = {
                  active       = isActive
                , icon         = "fa-rocket"
                , title        = translateResource( 'cms:crmDataManager' )
                , subMenuItems = subMenuItems
              }
        ) );
    }
</cfscript>