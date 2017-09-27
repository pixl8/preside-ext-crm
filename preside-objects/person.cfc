/**
* @versioned        true
* @dataExportFields id,title,first_name,last_name,date_of_birth,salutation,gender,job_title,type,status,primary_email,primary_phone,website,datecreated,datemodified
*/
component {
    
    property name="initials"           type="string" dbtype="varchar" maxLength="16"   required=false;
    property name="first_name"         type="string" dbtype="varchar" maxLength="128"  required=true;
    property name="middle_names"       type="string" dbtype="varchar" maxLength="128"  required=false;
    property name="last_name"          type="string" dbtype="varchar" maxLength="128"  required=true;
    property name="date_of_birth"      type="date"   dbtype="date"                     required=false;
    property name="salutation"         type="string" dbtype="varchar" maxLength="256"  required=false;
    property name="gender"             type="string" dbtype="char"    maxLength="1"    required=false;
    property name="honours"            type="string" dbtype="varchar" maxLength="64"   required=false;
    property name="known_as"           type="string" dbtype="varchar" maxLength="128"  required=false;
    property name="job_title"          type="string" dbtype="varchar" maxLength="256"  required=false;

    property name="organisation"       relationship="many-to-one" relatedTo="organisation"         required=false;
    property name="title"              relationship="many-to-one" relatedTo="lookup_person_title"  required=false;
    property name="photo"              relationship="many-to-one" relatedTo="asset"                required=false allowedTypes="image";
    property name="type"               relationship="many-to-one" relatedTo="lookup_person_type"   required=true;
    property name="status"             relationship="many-to-one" relatedTo="lookup_person_status" required=true;

    property name="primary_email"      type="string"              dbtype="varchar"              maxLength="256" required=true;
    property name="primary_email_type" relationship="many-to-one" relatedTo="lookup_email_type"                 required=true;
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
    
    property name="website"            type="string" dbtype="varchar" maxLength="256" required=false;
    property name="twitter"            type="string" dbtype="varchar" maxLength="256" required=false;
    property name="facebook"           type="string" dbtype="varchar" maxLength="256" required=false;
    property name="instagram"          type="string" dbtype="varchar" maxLength="256" required=false;
    property name="linkedin"           type="string" dbtype="varchar" maxLength="256" required=false;

    property name="addresses"             relationship="one-to-many"  relatedTo="person_address" relationshipKey="person";

    property name="organisation_links"    relationship="one-to-many"  relatedTo="organisation_person_link" relationshipKey="target" feature="crmLinks";
    property name="outgoing_person_links" relationship="one-to-many"  relatedTo="person_person_link"       relationshipKey="source" feature="crmLinks";
    property name="incoming_person_links" relationship="one-to-many"  relatedTo="person_person_link"       relationshipKey="target" feature="crmLinks";
}