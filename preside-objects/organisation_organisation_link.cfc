/**
* @dataManagerGridFields source,link_type,target,description,datecreated,datemodified
* @nolabel               true
* @feature               crmLinks
*/
component {
    property name="source"    relationship="many-to-one" relatedTo="organisation"                               required=true;
    property name="link_type" relationship="many-to-one" relatedTo="lookup_organisation_organisation_link_type" required=true;
    property name="target"    relationship="many-to-one" relatedTo="organisation"                               required=true;

    property name="description" type="string" dbtype="varchar" maxlength=100 required=false;
}