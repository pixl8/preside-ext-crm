/**
* @labelfield              name
* @versioned               true
* @dataManagerEnabled      true
* @dataManagerGridFields   name,trading_as,type,status,datecreated,datemodified
* @dataExportFields        id,name,trading_as,vat_number,type,status,primary_email,primary_phone,website,datecreated,datemodified
* @minimalGridFields       name,type,status
*/
component {
    property name="name"               type="string"              dbtype="varchar"              maxLength="256" required=true  sortorder=5;
    property name="trading_as"         type="string"              dbtype="varchar"              maxLength="256" required=false sortorder=10;
    property name="vat_number"         type="string"              dbtype="varchar"              maxLength="64"  required=false sortorder=15;

    property name="type"               relationship="many-to-one" relatedTo="lookup_organisation_type"          required=true sortorder=20;
    property name="status"             relationship="many-to-one" relatedTo="lookup_organisation_status"        required=true sortorder=25;

    property name="primary_email"      type="string"              dbtype="varchar"              maxLength="256" required=false adminViewGroup="email" sortorder=30;
    property name="primary_email_type" relationship="many-to-one" relatedTo="lookup_email_type"                 required=false adminViewGroup="email" sortorder=31;
    property name="email2"             type="string"              dbtype="varchar"              maxLength="256" required=false adminViewGroup="email" sortorder=32;
    property name="email2_type"        relationship="many-to-one" relatedTo="lookup_email_type"                 required=false adminViewGroup="email" sortorder=33;
    property name="email3"             type="string"              dbtype="varchar"              maxLength="256" required=false adminViewGroup="email" sortorder=34;
    property name="email3_type"        relationship="many-to-one" relatedTo="lookup_email_type"                 required=false adminViewGroup="email" sortorder=35;

    property name="primary_phone"      type="string"              dbtype="varchar"              maxLength="256" required=false adminViewGroup="phone" sortorder=40;
    property name="primary_phone_type" relationship="many-to-one" relatedTo="lookup_phone_type"                 required=false adminViewGroup="phone" sortorder=41;
    property name="phone2"             type="string"              dbtype="varchar"              maxLength="256" required=false adminViewGroup="phone" sortorder=42;
    property name="phone2_type"        relationship="many-to-one" relatedTo="lookup_phone_type"                 required=false adminViewGroup="phone" sortorder=43;
    property name="phone3"             type="string"              dbtype="varchar"              maxLength="256" required=false adminViewGroup="phone" sortorder=44;
    property name="phone3_type"        relationship="many-to-one" relatedTo="lookup_phone_type"                 required=false adminViewGroup="phone" sortorder=45;

    property name="website"            type="string"              dbtype="varchar"              maxLength="256" required=false adminViewGroup="web" sortorder=50;
    property name="twitter"            type="string"              dbtype="varchar"              maxLength="256" required=false adminViewGroup="web" sortorder=51;
    property name="facebook"           type="string"              dbtype="varchar"              maxLength="256" required=false adminViewGroup="web" sortorder=52;
    property name="instagram"          type="string"              dbtype="varchar"              maxLength="256" required=false adminViewGroup="web" sortorder=53;
    property name="linkedin"           type="string"              dbtype="varchar"              maxLength="256" required=false adminViewGroup="web" sortorder=54;

    property name="notes"              relationship="one-to-many"  relatedTo="organisation_note"    relationshipKey="organisation" feature="crmNotes" adminViewGroup="notes"     sortorder=60;
    property name="addresses"          relationship="one-to-many"  relatedTo="organisation_address" relationshipKey="organisation" adminViewGroup="addresses" sortorder=70;
    property name="persons"            relationship="one-to-many"  relatedTo="person"               relationshipKey="organisation" adminViewGroup="persons"   sortorder=80;

    property name="tags" relationship="many-to-many" relatedTo="lookup_tag" feature="crmTags" adminViewGroup="tags" sortorder=90;

    property name="person_links"                relationship="one-to-many"  relatedTo="organisation_person_link"       relationshipKey="source" feature="crmLinks" adminViewGroup="links" sortorder=100;
    property name="outgoing_organisation_links" relationship="one-to-many"  relatedTo="organisation_organisation_link" relationshipKey="source" feature="crmLinks" adminViewGroup="links" sortorder=101;
    property name="incoming_organisation_links" relationship="one-to-many"  relatedTo="organisation_organisation_link" relationshipKey="target" feature="crmLinks" adminViewGroup="links" sortorder=102;
}