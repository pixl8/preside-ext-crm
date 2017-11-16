/**
* @dataManagerGridFields label,description,datecreated,datemodified
* @minimalGridFields     label,datecreated
*/
component {
    property name="person" relationship="many-to-one" relatedTo="person" required=true;
    property name="description" type="string" dbtype="varchar" maxLength="512" required=false;
}