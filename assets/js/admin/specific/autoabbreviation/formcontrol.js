( function( $ ) {

    $(".auto-abbreviation").each( function() {
        var $this = $(this);
        var basedOnFormFields = [];

        var detectInitials = function( e ) {
            var $initials = "";

            basedOnFormFields.forEach( function( item, index ) {
                var fieldValue = item.val();

                if ( fieldValue.length > 0 ) {
                    $initials += fieldValue.charAt( 0 );
                }
            });

            $this.val( $initials.toUpperCase() );
        }

        var basedOnFormFieldNames = $this.data( 'basedOn' ).split(",");

        basedOnFormFieldNames.forEach( function( item, index ) {
            var $basedOn = $this.parents( "form:first" ).find( "[name='" + item + "']" );
            basedOnFormFields.push( $basedOn );
            $basedOn.keyup( detectInitials );
        });
    });

} )( presideJQuery );
