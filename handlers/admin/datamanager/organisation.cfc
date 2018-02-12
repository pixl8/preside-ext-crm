component {

    private string function buildViewRecordLink( event, rc, prc, args={} ) {
        var recordId = args.recordId ?: "";
        return event.buildAdminLink( linkto="organisationManager.viewRecord", querystring="id=" & recordId );
    }
}