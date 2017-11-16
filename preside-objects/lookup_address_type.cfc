/**
* @dataManagerGroup lookups
* @dataExportFields id,label,short_description,full_description,datecreated,datemodified
* @minimalGridFields label
*/
component {
    property name="label" uniqueindexes="label";
	property name="short_description";
	property name="full_description";
}