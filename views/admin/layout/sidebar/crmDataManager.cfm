<cfscript>
    subMenuItems = [];
    if ( hasCmsPermission( "organisationmanager.read" ) ) {
        subMenuItems.append( {
              link  = event.buildAdminLink( linkTo="organisationManager" )
            , title = translateResource( "cms:crmDataManager.organisations" )
            , active = ReFindNoCase( "\.?organisationManager$", event.getCurrentHandler() )
        } );
    }
    if ( hasCmsPermission( "personmanager.read" ) ) {
        subMenuItems.append( {
              link  = event.buildAdminLink( linkTo="personManager" )
            , title = translateResource( "cms:crmDataManager.persons" )
            , active = ReFindNoCase( "\.?personManager$", event.getCurrentHandler() )
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