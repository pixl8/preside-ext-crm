/**
 * Handler for the person rules engine context
 *
 */
component {

	property name="emailSendingContextService" inject="emailSendingContextService";

	private struct function getPayload() {
		var emailPayload = emailSendingContextService.getContextPayload();

		if ( emailPayload.keyExists( "person" ) ) {
			return emailPayload;
		}

		return { person = {} };
	}

}