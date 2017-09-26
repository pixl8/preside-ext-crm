/**
* @dataManagerGroup      lookups
* @dataManagerGridFields label,outward_description,inward_description,datecreated,datemodified
* @dataExportFields      id,label,outward_description,inward_description,datecreated,datemodified
* @versioned             false
*/
component {
    property name="label" uniqueindexes="label";
    property name="outward_description" type="string" dbtype="varchar" maxlength=50 required=true;
    property name="inward_description"  type="string" dbtype="varchar" maxlength=50 required=true;
}