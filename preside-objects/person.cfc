/**
* @versioned             true
* @dataManagerEnabled    true
* @dataManagerGridFields title,first_name,last_name,organisation,type,status,datecreated,datemodified
* @dataExportFields      id,title,first_name,last_name,date_of_birth,salutation,gender,job_title,type,status,primary_email,primary_phone,website,datecreated,datemodified
* @minimalGridFields     first_name,last_name,type,status
*/
component {

    property name="first_name"         type="string" dbtype="varchar" maxLength="128"  required=true sortorder=1;
    property name="last_name"          type="string" dbtype="varchar" maxLength="128"  required=true sortorder=2;
    property name="middle_names"       type="string" dbtype="varchar" maxLength="128"  required=false sortorder=3;
    property name="initials"           type="string" dbtype="varchar" maxLength="16"   required=false sortorder=4;
    property name="date_of_birth"      type="date"   dbtype="date"                     required=false sortorder=5;
    property name="salutation"         type="string" dbtype="varchar" maxLength="256"  required=false sortorder=6;
    property name="gender"             type="string" dbtype="char"    maxLength="1"    required=false sortorder=7;
    property name="honours"            type="string" dbtype="varchar" maxLength="64"   required=false sortorder=8;
    property name="known_as"           type="string" dbtype="varchar" maxLength="128"  required=false sortorder=9;
    property name="job_title"          type="string" dbtype="varchar" maxLength="256"  required=false sortorder=10;

    property name="organisation"       relationship="many-to-one" relatedTo="organisation"         required=false                      sortorder=11;
    property name="title"              relationship="many-to-one" relatedTo="lookup_person_title"  required=false                      sortorder=12;
    property name="photo"              relationship="many-to-one" relatedTo="asset"                required=false allowedTypes="image" sortorder=13;
    property name="type"               relationship="many-to-one" relatedTo="lookup_person_type"   required=true                       sortorder=14;
    property name="status"             relationship="many-to-one" relatedTo="lookup_person_status" required=true                       sortorder=15;

    property name="primary_email"      type="string"              dbtype="varchar"              maxLength="256" required=true  adminViewGroup="email" sortorder=20;
    property name="primary_email_type" relationship="many-to-one" relatedTo="lookup_email_type"                 required=true  adminViewGroup="email" sortorder=21;
    property name="email2"             type="string"              dbtype="varchar"              maxLength="256" required=false adminViewGroup="email" sortorder=22;
    property name="email2_type"        relationship="many-to-one" relatedTo="lookup_email_type"                 required=false adminViewGroup="email" sortorder=23;
    property name="email3"             type="string"              dbtype="varchar"              maxLength="256" required=false adminViewGroup="email" sortorder=24;
    property name="email3_type"        relationship="many-to-one" relatedTo="lookup_email_type"                 required=false adminViewGroup="email" sortorder=25;

    property name="primary_phone"      type="string"              dbtype="varchar"              maxLength="256" required=false adminViewGroup="phone" sortorder=30;
    property name="primary_phone_type" relationship="many-to-one" relatedTo="lookup_phone_type"                 required=false adminViewGroup="phone" sortorder=31;
    property name="phone2"             type="string"              dbtype="varchar"              maxLength="256" required=false adminViewGroup="phone" sortorder=32;
    property name="phone2_type"        relationship="many-to-one" relatedTo="lookup_phone_type"                 required=false adminViewGroup="phone" sortorder=33;
    property name="phone3"             type="string"              dbtype="varchar"              maxLength="256" required=false adminViewGroup="phone" sortorder=34;
    property name="phone3_type"        relationship="many-to-one" relatedTo="lookup_phone_type"                 required=false adminViewGroup="phone" sortorder=35;

    property name="website"            type="string" dbtype="varchar" maxLength="256" required=false adminViewGroup="web" sortorder=40;
    property name="twitter"            type="string" dbtype="varchar" maxLength="256" required=false adminViewGroup="web" sortorder=41;
    property name="facebook"           type="string" dbtype="varchar" maxLength="256" required=false adminViewGroup="web" sortorder=42;
    property name="instagram"          type="string" dbtype="varchar" maxLength="256" required=false adminViewGroup="web" sortorder=43;
    property name="linkedin"           type="string" dbtype="varchar" maxLength="256" required=false adminViewGroup="web" sortorder=44;

    property name="notes"              relationship="one-to-many"  relatedTo="person_note"    relationshipKey="person" feature="crmNotes" adminViewGroup="notes"     sortorder=50;
    property name="addresses"          relationship="one-to-many"  relatedTo="person_address" relationshipKey="person" adminViewGroup="addresses" sortorder=60;

    property name="tags" relationship="many-to-many" relatedTo="lookup_tag" feature="crmTags" adminViewGroup="tags" sortorder=70;

    property name="organisation_links"    relationship="one-to-many"  relatedTo="organisation_person_link" relationshipKey="target" feature="crmLinks" adminViewGroup="links" sortorder=80;
    property name="outgoing_person_links" relationship="one-to-many"  relatedTo="person_person_link"       relationshipKey="source" feature="crmLinks" adminViewGroup="links" sortorder=81;
    property name="incoming_person_links" relationship="one-to-many"  relatedTo="person_person_link"       relationshipKey="target" feature="crmLinks" adminViewGroup="links" sortorder=82;

    property name="email_logs" relationship="one-to-many" relatedTo="email_template_send_log" relationshipkey="person_recipient" autofilter=false renderer="none";
}