component {

    property name="crmDataService" inject="delayedInjector:crmDataService";

    public void function configure() {}

    public void function preInsertObjectData( event, interceptData ) {

        if ( IsBoolean( interceptData.skipTrivialInterceptors ?: "" ) && interceptData.skipTrivialInterceptors ) {
            return;
        }

        _maybeEnsureUniquePrimaryAddress( interceptData );
        _maybeEnsureUniqueHeadOfficeOrganisationAddress( interceptData );
        _maybeGenerateLabel( interceptData );
    }

    public void function preUpdateObjectData( event, interceptData ) {

        if ( IsBoolean( interceptData.skipTrivialInterceptors ?: "" ) && interceptData.skipTrivialInterceptors ) {
            return;
        }

        // only perform actions for single record updates, not for bulk updates
        if ( len( arguments.interceptData.id ?: "" ) ) {
            _maybeEnsureUniquePrimaryAddress( interceptData );
            _maybeEnsureUniqueHeadOfficeOrganisationAddress( interceptData );
            _maybeGenerateLabel( interceptData );
        }
    }

// PRIVATE HELPERS
    private void function _maybeEnsureUniquePrimaryAddress( interceptData ) {

        var objectName = arguments.interceptData.objectname ?: "";

        if ( [ "organisation_address", "person_address" ].findNoCase( objectName ) ) {
            crmDataService.ensureUniquePrimaryAddress(
                  objectName = objectName
                , objectData = arguments.interceptData.data ?: {}
            );
        }
    }

    private void function _maybeEnsureUniqueHeadOfficeOrganisationAddress( interceptData ) {

        var objectName = arguments.interceptData.objectname ?: "";

        if ( objectName == "organisation_address" ) {
            crmDataService.ensureUniqueHeadOfficeOrganisationAddress(
                objectData = arguments.interceptData.data ?: {}
            );
        }
    }

    private void function _maybeGenerateLabel( interceptData ) {

        var objectName = arguments.interceptData.objectname ?: "";

        if ( ![ "person", "organisation_address", "person_address" ].findNoCase( objectName ) ) {
            return;
        }
        var objectData = arguments.interceptData.data ?: {};

        if ( len( objectData.label ?: "" ) ) {
            return;
        }

        crmDataService.generateLabel(
              objectName = objectName
            , objectData = objectData
        );
    }
}