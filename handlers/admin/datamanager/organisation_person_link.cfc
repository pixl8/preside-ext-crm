component {

	private boolean function checkPermission( event, rc, prc, args={} ) {
		var key           = "crm.organisation.#( args.key ?: "" )#";
		var hasPermission = hasCmsPermission( key );

		if ( !hasPermission && isTrue( args.throwOnError ?: "" ) ) {
			event.adminAccessDenied();
		}

		return hasPermission;
	}

}