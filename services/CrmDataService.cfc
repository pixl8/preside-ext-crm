/**
* @singleton      true
* @presideService true
*/ 
component {

    property name="organisationDao"        inject="presidecms:object:organisation";
    property name="personDao"              inject="presidecms:object:person";
    property name="countryDao"             inject="presidecms:object:lookup_country";
    property name="addressTypeDao"         inject="presidecms:object:lookup_address_type";
    property name="presideObjectService"   inject="presideObjectService";

// CONSTRUCTOR
    public any function init() {
        return this;
    }

// PUBLIC FUNCTIONS
    public void function ensureUniquePrimaryAddress( required string objectName, required struct objectData ) {

        if ( ![ "organisation_address", "person_address" ].findNoCase( arguments.objectName ) ) {
            // invalid object type, nothing to do
            return;
        }

        _ensureUniqueFlaggedObject(
              objectName            = arguments.objectName
            , fieldName             = "is_primary"
            , parentObjectFieldName = listFirst( arguments.objectName, "_" )
            , objectData            = arguments.objectData
        );
    }

    public void function ensureUniqueHeadOfficeOrganisationAddress( required struct objectData ) {

        _ensureUniqueFlaggedObject(
              objectName            = "organisation_address"
            , fieldName             = "is_head_office"
            , parentObjectFieldName = "organisation"
            , objectData            = arguments.objectData
        );
    }

    public void function generateLabel( required string objectName, required struct objectData ) {

        if ( arguments.objectName == "person" ) {
            _generatePersonLabel( arguments.objectData );
            return;
        }

        if ( [ "organisation_address", "person_address" ].findNoCase( arguments.objectName ) ) {
            _generateAddressLabel( objectData );
            return;
        }
    }

// PRIVATE HELPERS
    private void function _ensureUniqueFlaggedObject(
          required string objectName
        , required string fieldName
        , required parentObjectFieldName
        , required struct objectData
    ) {

        var objectId       = arguments.objectData.id ?: "newrecord";
        var isFlagSet      = arguments.objectData.keyExists( arguments.fieldName ) && isBoolean( arguments.objectData[ arguments.fieldName ] ) && arguments.objectData[ arguments.fieldName ];
        var parentObjectId = arguments.objectData[ arguments.parentObjectFieldName ] ?: "";

        if ( isEmpty( parentObjectId ) ) {
            
            // parent object id was not supplied (typically an update and not an insert)
            // get it from the object itself

            var object = presideObjectService.selectData(
                  objectName   = arguments.objectName
                , id           = objectId
                , selectFields = [ "#arguments.parentObjectFieldName#.id as parentObjectId" ]
            );

            parentObjectId = object.parentObjectId;
        }

        var otherObjectsFilter       = "#arguments.fieldName# = :#arguments.fieldName# and #arguments.parentObjectFieldName#.id = :#arguments.parentObjectFieldName#.id and #arguments.objectName#.id <> :id";
        var otherObjectsFilterParams = { "#arguments.fieldName#"=1, "#arguments.parentObjectFieldName#.id"=parentObjectId, id=objectId };

        // identify other objects (same object type, same parent object, but not this one) that have the flag set that should be unique (should typically be only one)
        var otherObjects = presideObjectService.selectData(
              objectName   = arguments.objectName
            , selectFields = [ "#arguments.objectName#.id" ]
            , filter       = otherObjectsFilter
            , filterParams = otherObjectsFilterParams
        );

        // CASE 1: flag is set and no other object exists with flag set > nothing to do, all good
        if ( isFlagSet && isEmpty( otherObjects ) ) {
            return;
        }

        // CASE 2: flag is not set and other object exists with flag set > nothing to do, all good
        if ( !isFlagSet && !isEmpty( otherObjects ) ) {
            return;   
        }

        // CASE 3: flag is not set and no other object exists with flag set > set the flag on this object
        if ( !isFlagSet && isEmpty( otherObjects ) ) {
            arguments.objectData[ arguments.fieldName ] = 1;
            return;
        }

        // CASE 4: flag is set but there are other objects with the flag set as well > remove the flag from the other objects
        presideObjectService.updateData(
              objectName = arguments.objectName
            , data       = { "#arguments.fieldName#" = 0 }
            , filter       = otherObjectsFilter
            , filterParams = otherObjectsFilterParams
        );
    }

    private void function _generatePersonLabel( required struct objectData ) {

        var firstName = arguments.objectData.first_name ?: "";
        var lastName  = arguments.objectData.last_name  ?: "";

        if ( len( firstName ) && len( lastName ) ) {
            arguments.objectData.label = firstName & " " & lastName;
        }
    }

    private void function _generateAddressLabel( required struct objectData ) {

        var town          = arguments.objectData.town         ?: "";
        var countryId     = arguments.objectData.country      ?: "";
        var addressTypeId = arguments.objectData.address_type ?: "";

        if ( isEmpty( town ) || isEmpty( countryId ) || isEmpty( addressTypeId ) ) {
            return;
        }

        var country     = countryDao.selectData( id=countryId );
        var addressType = addressTypeDao.selectData( id=addressTypeId );

        if ( isEmpty( country ) || isEmpty( addressType ) ) {
            return;
        }

        arguments.objectData.label = addressType.label & ": " & town & ", " & country.label;
    }
}