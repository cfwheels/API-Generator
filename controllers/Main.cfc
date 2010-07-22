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
	
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="generate" hint="Generates documentation.">
		
		<cfset var loc = {}>
		<cfset loc.function = model("function")>
		<cfset loc.argument = model("functionArgument")>
		<cfset loc.functions = loc.function.findAll(where="wheelsVersion='#params.version#'", returnAs="objects")>
		
		<!--- Delete all functions for the version --->
		<cfloop array="#loc.functions#" index="loc.functionToDelete">
			<cfset loc.functionToDelete.deleteAllFunctionArguments()>
			<!--- <cfset loc.functionToDelete.deleteAllRelatedFunctions() --->
			<cfset loc.functionToDelete.delete()>
		</cfloop>
		
		<!--- Controller functions --->
		<cfset controllerSavedItems = generateFunctions(super, params.version)>
		<!--- Model functions. The "dummy" model is there so we can import a blank model. --->
		<cfset modelSavedItems = generateFunctions(model("dummy"), params.version)>
		<!--- Clean up argument hint data --->
		<cfset clean()>
		
		<cfset numFunctions = loc.function.count(where="wheelsVersion='#params.version#'")>
		<cfset version = params.version>
	
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
	
	<cffunction name="generateFunctions" access="private" hint="Generates a batch of functions based on scope and function names.">
		<cfargument name="scope" hint="Structure containing functions to process.">
		<cfargument name="version" type="string" hint="Version to store in DB.">
	
		<cfset var loc = {}>
		<cfset loc.functionList = StructKeyList(arguments.scope)>
		<cfset loc.saveStatus = []>
		<cfset loc.saveStatusItem = {}>
		
		<cfloop list="#loc.functionList#" index="loc.currentFunction">
			<cfif isApiFunction(loc.currentFunction, arguments.scope)>
				<cfset loc.saveStatusItem = {}>
				<cfset loc.saveStatusItem.dataError = false>
				<cftry>
					<!--- New function object --->
					<cfset loc.function = model("function").new()>
					<!--- Parse function metadata --->
					<cfset loc.functionData = GetMetaData(arguments.scope[loc.currentFunction])>
					<!--- Set properties --->
					<!--- Name --->
					<cfset loc.saveStatusItem.name = loc.currentFunction>
					<cfset loc.function.name = loc.functionData.name>
					<!--- Return type --->
					<cfif StructKeyExists(loc.functionData, "returnType")>
						<cfset loc.function.returnType = loc.functionData.returnType>
						<cfset loc.saveStatusItem.returnType = loc.functionData.returnType>
					</cfif>
					<!--- Hint --->
					<cfset loc.function.hint = loc.functionData.hint>
					<cfset loc.saveStatusItem.hint = loc.functionData.hint>
					<!--- Examples --->
					<cfset loc.function.examples = loc.functionData.examples>
					<cfset loc.saveStatusItem.examples = loc.functionData.examples>
					<!--- Categories --->
					<cfset loc.function.categories = loc.functionData.categories>
					<cfset loc.saveStatusItem.categories = loc.functionData.categories>
					<!--- Chapters --->
					<cfif StructKeyExists(loc.functionData, "chapters")>
						<cfset loc.function.chapters = loc.functionData.chapters>
						<cfset loc.saveStatusItem.chapters = loc.functionData.chapters>
					</cfif>
					<!--- Functions --->
					<cfif StructKeyExists(loc.functionData, "functions")>
						<cfset loc.function.functions = loc.functionData.functions>
						<cfset loc.saveStatusItem.functions = loc.functionData.functions>
					</cfif>
					<!--- Version --->
					<cfset loc.function.wheelsVersion = arguments.version>
					<!--- Parameters --->
					<cfif StructKeyExists(loc.functionData, "parameters")>
						<cfset loc.function.parameters = loc.functionData.parameters>
						<cfset loc.saveStatusItem.parameters = loc.functionData.parameters>
					</cfif>
					<!--- Catch errors --->
					<cfcatch type="any">
						<cfset loc.saveStatusItem.dataError = true>
					</cfcatch>
				</cftry>
				
				<!--- Try saving data --->
				<cftry>
					<cfif loc.function.save()>
						<cfset loc.saveStatusItem.saveError = false>
					<cfelse>
						<cfset loc.saveStatusItem.saveError = true>
					</cfif>
					
					<cfcatch>
						<cfset loc.saveStatusItem.saveError = true>
					</cfcatch>
				</cftry>
			
				<!--- Save what was collected about status item --->
				<cfset ArrayAppend(loc.saveStatus, loc.saveStatusItem)>
			</cfif>
		</cfloop>
		
		<cfreturn loc.saveStatus>
		
	</cffunction>
	
	<!----------------------------------------------------->

</cfcomponent>