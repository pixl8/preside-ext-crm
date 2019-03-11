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

        settings.adminPermissions.crm = [
            organisation = [ "read", "add", "edit", "delete", "navigate", "viewversions" ],
            person       = [ "read", "add", "edit", "delete", "navigate", "viewversions" ]
        ];

        settings.adminRoles.personManager =       [ "crm.person.*"      , "crm.organisation.navigate", "crm.organisation.read" ];
        settings.adminRoles.organisationManager = [ "crm.organisation.*", "crm.person.navigate"      , "crm.person.read" ];

        // add some new permissions to some existing core roles
        settings.adminRoles.sysAdmin = settings.roles.sysAdmin ?: [];
        settings.adminRoles.sysAdmin.append( "crm.*" );

        settings.rulesEngine.contexts.person = { object="person" };

        settings.email.recipientTypes.person = {
              parameters             = [ "first_name", "last_name", "primary_email" ]
            , filterObject           = "person"
            , gridFields             = [ "first_name", "last_name", "primary_email" ]
            , recipientIdLogProperty = "person_recipient"
        };

        settings.filters.personEmailTemplates = {
              filter       = "email_template.recipient_type = :email_template.recipient_type or ( email_template.recipient_type is null and email_blueprint.recipient_type = :email_template.recipient_type )"
            , filterParams = { "email_template.recipient_type" = "person" }
        };

        settings.features.crmLinks = { enabled=true , siteTemplates=[ "*" ], widgets=[] };
        settings.features.crmTags  = { enabled=false, siteTemplates=[ "*" ], widgets=[] };
        settings.features.crmNotes = { enabled=false, siteTemplates=[ "*" ], widgets=[] };
    }
}