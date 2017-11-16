/**
* @dataManagerGroup  lookups
* @dataExportFields  id,label,code,short_description,full_description,datecreated,datemodified
* @minimalGridFields label
*/
component {
    property name="label" uniqueindexes="label";
	property name="code" uniqueindexes="code";
	property name="short_description";
	property name="full_description";
}