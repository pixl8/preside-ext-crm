component {

    private string function buildViewRecordLink( event, rc, prc, args={} ) {
        var recordId = args.recordId ?: "";
        return event.buildAdminLink( linkto="personManager.viewRecord", querystring="id=" & recordId );
    }
}