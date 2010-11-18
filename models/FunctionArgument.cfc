<cfcomponent extends="Model" output="false">

	<!----------------------------------------------------->
	<!--- Public --->
	
	<cffunction name="init" hint="Defines properties, associations, and validations.">
		
		<!--- Properties --->
		<cfset property(name="lookForReference", sql="LEFT(functionarguments.hint, 23)")>
		
		<!--- Associations --->
		<cfset belongsTo("function")>
		
		<!--- Validations --->
		<cfset validatesPresenceOf("name,hint")>
	
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="findAllForVersion" returntype="query" hint="Returns all arguments for a given Wheels version.">
		<cfargument name="version" type="string" hint="Version number.">
		
		<cfset var loc = {}>
		
		<cfquery datasource="#get('dataSourceName')#" name="loc.arguments">
			SELECT
				A.*
			FROM
				functionarguments A
				JOIN functions F
					ON A.functionid = F.id
			WHERE
				F.wheelsversion =
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.version#">
		</cfquery>
		
		<cfreturn loc.arguments>
		
	</cffunction>
	
	<!----------------------------------------------------->

</cfcomponent>