<cfcomponent extends="Controller" output="false">

	<!----------------------------------------------------->
	<!--- Public --->
	
	<cffunction name="init" hint="Defines verifications.">
	
		<!--- Verifications --->
		<cfset verifies(only="generate", params="version")>
	
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="index" hint="Lists functions that will be imported.">
		
		<!--- Wheels version --->
		<cfset wheelsVersion = get("version")>
		<cfset dataSourceName = get("dataSourceName")>
		<cfset controllerScope = super>
		<cfset modelScope = model("dummy")>
		<cfset functionModel = model("function").new()>
		
		<!--- Functions that will be imported --->
		<cfset controllerFunctions = StructKeyList(super)>
		<cfset modelFunctions = StructKeyList(modelScope)>
	
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="generate" hint="Generates documentation.">
		
		<cfset var loc = {}>
		
		<cfset loc.function = model("function")>
		
		<!--- Delete all functions for the version --->
		<cfset loc.function.deleteAllForVersion(params.version)>
		<!--- <cfset loc.functionToDelete.deleteAllRelatedFunctions() --->
		
		<!--- Controller functions --->
		<cfset controllerSavedItems = loc.function.generateFunctionsFromScope(super, params.version)>
		<!--- Model functions. The "dummy" model is there so we can import a blank model. --->
		<cfset modelSavedItems = loc.function.generateFunctionsFromScope(model("dummy"), params.version, controllerSavedItems)>
		<!--- Clean up argument hint data --->
		<cfset clean(params.version)>
		
		<cfset numFunctions = loc.function.count(where="wheelsVersion='#params.version#'")>
		<cfset version = params.version>
	
	</cffunction>
	
	
	<!----------------------------------------------------->
	<!--- Private --->
	
	<cffunction name="clean" access="private" hint="Runs clean operation only.">
		<cfargument name="version" type="string" hint="Version of Wheels.">
	
		<cfset var loc = {}>
		<cfset loc.function = model("function")>
		<cfset loc.function.cleanup(arguments.version)>
	
	</cffunction>
	
	<!----------------------------------------------------->
	
</cfcomponent>