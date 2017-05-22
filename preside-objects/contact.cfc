/**
* @versioned true
*/
component {
    property name="organisation" relationship="many-to-one" relatedTo="organisation"     required=true uniqueindexes="contact|1";
    property name="person"       relationship="many-to-one" relatedTo="person"           required=true uniqueindexes="contact|2";
    
    property name="job_title"            type="string"  dbtype="varchar" maxLength="256" required=false;
    property name="is_main_contact"      type="boolean" dbtype="boolean"                 required=false;
    property name="is_main_organisation" type="boolean" dbtype="boolean"                 required=false;

    property name="type"   relationship="many-to-one" relatedTo="lookup_contact_type"    required=true;
    property name="status" relationship="many-to-one" relatedTo="lookup_contact_status"  required=true;

    property name="sort_order"           type="numeric" dbtype="int"                     required=false;
}