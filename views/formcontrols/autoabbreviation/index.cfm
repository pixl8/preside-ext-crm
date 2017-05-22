<cfscript>
    inputName    = args.name         ?: "";
    inputId      = args.id           ?: "";
    inputClass   = args.class        ?: "";
    placeholder  = args.placeholder  ?: "";
    defaultValue = args.defaultValue ?: "";
    basedOn      = args.basedOn      ?: "label";

    value  = event.getValue( name=inputName, defaultValue=defaultValue );
    if ( not IsSimpleValue( value ) ) {
        value = "";
    }

    event.include( "/js/admin/specific/autoabbreviation/" );
</cfscript>

<cfoutput>
    <input type="text" class="#inputClass# auto-abbreviation form-control" id="#inputId#" placeholder="#placeholder#" name="#inputName#" value="#HtmlEditFormat( value )#" data-based-on="#basedOn#" tabindex="#getNextTabIndex()#">
</cfoutput>