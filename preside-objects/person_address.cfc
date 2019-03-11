/**
* @dataManagerEnabled    true
* @dataManagerGridFields person,address_type,is_primary,line1,line2,line3,town,county,post_code,country,datecreated,datemodified
* @minimalGridFields     address_type,is_primary,line1,town,post_code
*/
component {
    property name="person"       relationship="many-to-one"      relatedTo="person"              required=true;
    property name="is_primary"   type="boolean" dbtype="boolean" default="false"                 required=false;

    property name="address_type" relationship="many-to-one"      relatedTo="lookup_address_type" required=true;
    property name="line1"        type="string"  dbtype="varchar" maxLength="128"                 required=true;
    property name="line2"        type="string"  dbtype="varchar" maxLength="128"                 required=false;
    property name="line3"        type="string"  dbtype="varchar" maxLength="128"                 required=false;
    property name="town"         type="string"  dbtype="varchar" maxLength="128"                 required=true;
    property name="county"       type="string"  dbtype="varchar" maxLength="128"                 required=false;
    property name="post_code"    type="string"  dbtype="varchar" maxLength="16"                  required=true;
    property name="country"      relationship="many-to-one"      relatedTo="lookup_country"      required=true;
}