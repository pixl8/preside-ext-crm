component {
    
    public void function configure( required struct config ) output=false {

        // core settings that will effect Preside
        var settings            = arguments.config.settings             ?: {};

        // other ColdBox settings
        var coldbox             = arguments.config.coldbox              ?: {};
        var i18n                = arguments.config.i18n                 ?: {};
        var interceptors        = arguments.config.interceptors         ?: [];
        var interceptorSettings = arguments.config.interceptorSettings  ?: {};
        var cacheBox            = arguments.config.cacheBox             ?: {};
        var wirebox             = arguments.config.wirebox              ?: {};
        var logbox              = arguments.config.logbox               ?: {};
        var environments        = arguments.config.environments         ?: {};

        var appMappingPath      = settings.appMappingPath               ?: "app";

        interceptors.prepend(
            { class="#appMappingPath#.extensions.preside-ext-crm.interceptors.CrmDataInterceptor", properties={} }
        );

        settings.adminSideBarItems.append( "crmDataManager" );

        settings.adminPermissions[ "organisationmanager" ] = [ "add", "edit", "delete", "read" ];
        settings.adminPermissions[ "personmanager"       ] = [ "add", "edit", "delete", "read" ];

        settings.adminRoles.sysAdmin.append( "organisationmanager.*" );
        settings.adminRoles.sysAdmin.append( "personmanager.*"       );

        settings.email.recipientTypes.person = {
              parameters             = [ "first_name", "last_name", "primary_email" ]
            , filterObject           = "person"
            , gridFields             = [ "first_name", "last_name", "primary_email" ]
            , recipientIdLogProperty = "person_recipient"
        };

        settings.features.crmLinks = { enabled=true , siteTemplates=[ "*" ], widgets=[] };
        settings.features.crmTags  = { enabled=false, siteTemplates=[ "*" ], widgets=[] };
        settings.features.crmNotes = { enabled=false, siteTemplates=[ "*" ], widgets=[] };
    }
}