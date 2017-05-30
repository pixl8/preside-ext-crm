component {

    property name="personDao" inject="presidecms:object:person";

    private struct function prepareParameters( required string recipientId ) {
        var person = personDao.selectData( id=arguments.recipientId, selectFields=[ "first_name", "last_name", "primary_email" ] );

        for ( var p in person ) {
            return p;
        }

        var p = {};
        
        for ( var col in ListToArray( person.columnList ) ) {
            p[ col ] = "";
        }

        return p;
    }

    private struct function getPreviewParameters() {
        return {
              first_name    = "John"
            , last_name     = "Doe"
            , primary_email = "jd@johndoe.com"
        };
    }

    private string function getToAddress( required string recipientId ) {
        var person = personDao.selectData( id=arguments.recipientId, selectFields=[ "primary_email" ] );

        return person.primary_email ?: "";
    }
}