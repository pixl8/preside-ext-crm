<cfscript>
    subMenuItems = [];
    if ( hasCmsPermission( "presideobject.organisation.read" ) ) {
        subMenuItems.append( {
              link  = event.buildAdminLink( objectName="organisation" )
            , title = translateResource( "cms:crmDataManager.organisations" )
            , active = ReFindNoCase( "^admin\.datamanager", event.getCurrentEvent() ) && ( prc.objectName ?: "" ) == "organisation"
        } );
    }
    if ( hasCmsPermission( "presideobject.person.read" ) ) {
        subMenuItems.append( {
              link  = event.buildAdminLink( objectName="person" )
            , title = translateResource( "cms:crmDataManager.persons" )
            , active = ReFindNoCase( "^admin\.datamanager", event.getCurrentEvent() ) && ( prc.objectName ?: "" ) == "person"
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