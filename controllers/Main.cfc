<cfcomponent extends="Controller" output="false">

	<!----------------------------------------------------->
	<!--- Public --->

	<cffunction name="init" hint="Defines filters and verifications.">

		<!--- Filters --->
		<cfset filters(through="cleanVersionKey", only="sql")>

		<!--- Verifications --->
		<cfset verifies(only="generate", params="version")>
		<cfset verifies(only="sql", params="key")>

	</cffunction>

	<!----------------------------------------------------->

	<cffunction name="index" hint="Lists functions that will be imported.">

		<!--- Wheels version --->
		<cfset wheelsVersion = get("version")>
		<cfset wheelsMajorVersion = listGetAt(wheelsVersion,1,'.') & '.' & listGetAt(wheelsVersion,2,'.')>
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

		<cfset loc.version = model("Version").findOneByVersion(params.version)>

		<cfif not IsObject(loc.version)>
			<cfreturn renderText("Cannot find version #params.version# in versions table")>
		</cfif>

		<cfset loc.function = model("function")>

		<!--- Delete all functions for the version --->
		<cfset loc.allFunctions = loc.function.findAll(where="wheelsVersion='#params.version#'", returnAs="objects")>
		<cfloop array="#loc.allFunctions#" index="loc.functionToDelete">
			<cfset loc.functionToDelete.delete()>
		</cfloop>

		<!--- Controller functions --->
		<cfset controllerSavedItems = loc.function.generateFunctionsFromScope(super, params.version)>
		<!--- Model functions. The "dummy" model is there so we can import a blank model. --->
		<cfset modelSavedItems = loc.function.generateFunctionsFromScope(model("dummy"), params.version, controllerSavedItems)>
		<!--- Clean up argument hint data --->
		<cfset loc.function.cleanup(params.version)>

		<cfset numFunctions = loc.function.count(where="wheelsVersion='#params.version#'")>
		<cfset version = params.version>

	</cffunction>

	<!----------------------------------------------------->

	<cffunction name="sql" hint="Generates SQL for inserting documentation in production database.">

		<cfset version = params.key>
		<cfset functions = model("function").findAll(
			include="functionArguments",
			where="functions.wheelsVersion='#params.key#'",
			order="functionarguments.id"
		)>

	</cffunction>


	<!----------------------------------------------------->
	<!--- Filters --->

	<cffunction name="cleanVersionKey" hint="FILTER: Cleans version number stored in `params.key`.">

		<cfset params.key = Replace(params.key, "-", ".", "all")>

	</cffunction>

	<!----------------------------------------------------->

</cfcomponent>