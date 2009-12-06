<cfcomponent extends="Controller" output="false">

	<!----------------------------------------------------->
	<!--- Public --->
	
	<cffunction name="index" hint="Lists functions that will be imported.">
		
		<!--- Wheels version --->
		<cfset wheelsVersion = get("version")>
		<cfset controllerScope = super>
		<cfset modelScope = model("function")>
		
		<!--- Functions that will be imported --->
		<cfset controllerFunctions = StructKeyList(super)>
		<cfset modelFunctions = StructKeyList(modelScope)>
	
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="clean" hint="Runs clean operation only.">
	
		<cfset var loc = {}>
		<cfset loc.function = model("function")>
		<cfset loc.function.cleanup()>
		<cfset renderText("It worked!")>
	
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="generate" hint="Generates documentation.">
		
		<cfset var loc = {}>
		<cfset loc.function = model("function")>
		<cfset loc.argument = model("functionArgument")>
		<cfset loc.functions = loc.function.findAll(where="wheelsVersion='#get('version')#'", returnAs="objects")>
		
		<!--- Delete all functions for the version --->
		<cfloop array="#loc.functions#" index="loc.functionToDelete">
			<cfset loc.functionToDelete.deleteAllFunctionArguments()>
			<cfset loc.functionToDelete.deleteAllRelatedFunctions()>
			<cfset loc.functionToDelete.delete()>
		</cfloop>
		
		<!--- Controller functions --->
		<cfset generateFunctions(super)>
		<!--- Model functions. The "dummy" model is there so we can import a blank model. --->
		<cfset generateFunctions(model("dummy"))>
		<!--- Clean up argument hint data --->
		<cfset clean()>
		
		<cfset numFunctions = loc.function.count(where="wheelsVersion='#get('version')#'")>
		<cfoutput><p><strong>#numFunctions# functions imported</p></cfoutput><cfabort>
	
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="isApiFunction" hint="Whether or not the given function is a Wheels API function.">
		<cfargument name="functionName" type="string" hint="Name of function to check.">
		<cfargument name="functionScope" type="struct" hint="Struct containing functions.">
		
		<cfreturn
			not ListContainsNoCase("id,onMissingMethod", arguments.functionName, ",")
			and IsCustomFunction(arguments.functionScope[arguments.functionName])
			and Left(arguments.functionName, 1) is not "$"
			and StructKeyExists(GetMetaData(arguments.functionScope[arguments.functionName]), "hint")
		>
	
	</cffunction>
	
	<!----------------------------------------------------->
	<!--- Private --->
	
	<cffunction name="generateFunctions" access="private" returntype="boolean" hint="Generates a batch of functions based on scope and function names.">
		<cfargument name="scope" hint="Structure containing functions to process.">
	
		<cfset var loc = {}>
		<cfset loc.wheelsVersion = get("version")>
		<cfset loc.functionList = StructKeyList(arguments.scope)>
		<cfset loc.dataError = false>
	
		<cfloop list="#loc.functionList#" index="loc.currentFunction">
			<cfif isApiFunction(loc.currentFunction, arguments.scope)>
				<cftry>
					<!--- Dump function name so user can see what the app is doing --->
					<cfdump var="#loc.currentFunction#">
					<!--- New function object --->
					<cfset loc.function = model("function").new()>
					<!--- Parse function metadata --->
					<cfset loc.functionData = GetMetaData(arguments.scope[loc.currentFunction])>
					<cfset loc.function.name = loc.functionData.name>
					<cfif StructKeyExists(loc.functionData, "returnType")>
						<cfset loc.function.returnType = loc.functionData.returnType>
					</cfif>
					<cfset loc.function.hint = loc.functionData.hint>
					<cfset loc.function.examples = loc.functionData.examples>
					<cfset loc.function.categories = loc.functionData.categories>
					<cfif StructKeyExists(loc.functionData, "chapters")>
						<cfset loc.function.chapters = loc.functionData.chapters>
					</cfif>
					<cfif StructKeyExists(loc.functionData, "functions")>
						<cfset loc.function.functions = loc.functionData.functions>
					</cfif>
					<cfset loc.function.wheelsVersion = loc.wheelsVersion>
					<cfif StructKeyExists(loc.functionData, "parameters")>
						<cfset loc.function.parameters = loc.functionData.parameters>
					</cfif>
					<!--- Catch errors --->
					<cfcatch type="any">
						<cfset loc.dataError = true>
						<cfoutput>
							<p>#cfcatch.message#:</p>
							<cfdump var="#loc.functionData#">
						</cfoutput>
					</cfcatch>
				</cftry>
			
				<!--- On fail, return false transaction --->
				<cfif
					loc.dataError
					or not loc.function.save()
				>
					<cfoutput>
						<p>Error saving function:</p>
						<cfdump var="#loc.function.allErrors()#">
						<cfdump var="#loc.functionData#">
					</cfoutput>
				<cfelse>
					<cfoutput><br /></cfoutput>
				</cfif>
			</cfif>
		</cfloop>
		
		<cfreturn true>
	
	</cffunction>
	
	<!----------------------------------------------------->

</cfcomponent>