/**
* @dataManagerGridFields label,description,datecreated,datemodified
* @minimalGridFields     label,datecreated
*/
component {
    property name="organisation" relationship="many-to-one" relatedTo="organisation" required=true;
    property name="description" type="string" dbtype="varchar" maxLength="512" required=false;
}