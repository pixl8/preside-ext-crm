component {

    this.name = "CRM Test Suite";

    this.mappings[ '/tests'   ] = ExpandPath( "/" );
    this.mappings[ '/testbox' ] = ExpandPath( "/testbox" );
    this.mappings[ '/crm'     ] = ExpandPath( "../" );

    setting requesttimeout="6000";

    public void function onRequest( required string requestedTemplate ) output=true {
        include template=arguments.requestedTemplate;
    }
}