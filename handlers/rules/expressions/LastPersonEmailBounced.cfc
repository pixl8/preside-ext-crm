/**
 * Expression handler for "Last email to person bounced" expression
 *
 * @expressionCategory email
 * @expressionContexts person
 */
component {

	property name="personDao" inject="presidecms:object:person";

	private boolean function evaluateExpression() {
		var personId = payload.person.id ?: "";

		if ( !personId.len() ) {
			return false;
		}

		return personDao.dataExists(
			  id           = personId
			, extraFilters = prepareFilters( argumentCollection=arguments )
		);
	}

	/**
	 * @objects person
	 *
	 */
	private array function prepareFilters(
		  string parentPropertyName = ""
		, string filterPrefix       = ""
	){
		var paramSuffix = CreateUUId().lCase().replace( "-", "", "all" );
		var params      = {
			"bounced#paramSuffix#" = { type="cf_sql_boolean", value=true }
		};

		var subQuery = personDao.selectData(
			  selectFields        = [ "Max( email_logs.datecreated ) as log_date", "person.id" ]
			, groupBy             = "person.id"
			, forceJoins          = "inner"
			, getSqlAndParamsOnly = true
		);
		var subQueryAlias = "emailLogCount" & CreateUUId().lCase().replace( "-", "", "all" );
		var filterSql     = "email_logs.hard_bounced = :bounced#paramSuffix# and email_logs.datecreated = #subQueryAlias#.log_date";

		return [ { filter=filterSql, filterParams=params, extraJoins=[ {
			  type           = "inner"
			, subQuery       = subQuery.sql
			, subQueryAlias  = subQueryAlias
			, subQueryColumn = "id"
			, joinToTable    = filterPrefix.len() ? filterPrefix : ( parentPropertyName.len() ? parentPropertyName : "person" )
			, joinToColumn   = "id"
		} ] } ];
	}

}