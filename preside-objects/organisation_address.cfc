/**
* @dataManagerGroup      organisation
* @dataManagerGridFields organisation,address_type,is_primary,is_head_office,line1,line2,line3,town,county,post_code,country,datecreated,datemodified
* @minimalGridFields     address_type,is_primary,is_head_office,line1,town,post_code
*/
component {
    property name="organisation"   relationship="many-to-one"      relatedTo="organisation"        required=true;
    property name="is_primary"     type="boolean" dbtype="boolean" default="false"                 required=false;
    property name="is_head_office" type="boolean" dbtype="boolean"                                 required=false;

    property name="address_type"   relationship="many-to-one"      relatedTo="lookup_address_type" required=true;
    property name="line1"          type="string"  dbtype="varchar" maxLength="128"                 required=true;
    property name="line2"          type="string"  dbtype="varchar" maxLength="128"                 required=false;
    property name="line3"          type="string"  dbtype="varchar" maxLength="128"                 required=false;
    property name="town"           type="string"  dbtype="varchar" maxLength="128"                 required=true;
    property name="county"         type="string"  dbtype="varchar" maxLength="128"                 required=false;
    property name="post_code"      type="string"  dbtype="varchar" maxLength="16"                  required=true;
    property name="country"        relationship="many-to-one"      relatedTo="lookup_country"      required=true;
}