/**
* @labelfield       name
* @versioned        true
* @dataExportFields id,name,trading_as,vat_number,type,status,primary_email,primary_phone,website,datecreated,datemodified
*/
component {
    property name="name"               type="string"              dbtype="varchar"              maxLength="256" required=true;
    property name="trading_as"         type="string"              dbtype="varchar"              maxLength="256" required=false;
    property name="vat_number"         type="string"              dbtype="varchar"              maxLength="64"  required=false;

    property name="type"               relationship="many-to-one" relatedTo="lookup_organisation_type"          required=true;
    property name="status"             relationship="many-to-one" relatedTo="lookup_organisation_status"        required=true;
    
    property name="primary_email"      type="string"              dbtype="varchar"              maxLength="256" required=false;
    property name="primary_email_type" relationship="many-to-one" relatedTo="lookup_email_type"                 required=false;
    property name="email2"             type="string"              dbtype="varchar"              maxLength="256" required=false;
    property name="email2_type"        relationship="many-to-one" relatedTo="lookup_email_type"                 required=false;
    property name="email3"             type="string"              dbtype="varchar"              maxLength="256" required=false;
    property name="email3_type"        relationship="many-to-one" relatedTo="lookup_email_type"                 required=false;

    property name="primary_phone"      type="string"              dbtype="varchar"              maxLength="256" required=false;
    property name="primary_phone_type" relationship="many-to-one" relatedTo="lookup_phone_type"                 required=false;
    property name="phone2"             type="string"              dbtype="varchar"              maxLength="256" required=false;
    property name="phone2_type"        relationship="many-to-one" relatedTo="lookup_phone_type"                 required=false;
    property name="phone3"             type="string"              dbtype="varchar"              maxLength="256" required=false;
    property name="phone3_type"        relationship="many-to-one" relatedTo="lookup_phone_type"                 required=false;
    
    property name="website"            type="string"              dbtype="varchar"              maxLength="256" required=false;
    property name="twitter"            type="string"              dbtype="varchar"              maxLength="256" required=false;
    property name="facebook"           type="string"              dbtype="varchar"              maxLength="256" required=false;
    property name="instagram"          type="string"              dbtype="varchar"              maxLength="256" required=false;
    property name="linkedin"           type="string"              dbtype="varchar"              maxLength="256" required=false;

    property name="addresses"          relationship="one-to-many" relatedTo="organisation_address" relationshipKey="organisation";
}