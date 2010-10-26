<cfcomponent extends="Model" output="false">

	<!----------------------------------------------------->
	<!--- Public --->
	
	<cffunction name="init" hint="Defines associations, validations, and callbacks.">
		
		<!--- Associations --->
		<cfset hasMany("functionArguments")>
		<cfset hasMany("relatedFunctions")>
		<cfset belongsTo(name="parentFunctionSectionId", modelName="functionSection", foreignKey="parentFunctionSectionId")>
		<cfset belongsTo(name="childFunctionSectionId", modelName="functionSection", foreignKey="childFunctionSectionId")>
		
		<!--- Validations --->
		<cfset validatesPresenceOf("name,wheelsVersion,returnType,hint,examples")>
		<cfset validatesNumericalityOf("parentFunctionSectionId")>
		<cfset validatesNumericalityOf(property="childFunctionSectionId", allowBlank=true)>
		
		<!--- Callbacks --->
		<cfset beforeValidation("processCategories")>
		<cfset beforeSave("cleanExamples")>
		<cfset afterSave("saveArguments")><!---,saveRelatedFunctions--->
		<cfset beforeDelete("deleteArguments")>
	
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="cleanup" hint="Cleans up documentation in database. Replaces references to 'See documentation for...', etc.">
		<cfargument name="version" type="string" hint="Wheels version.">
		
		<cfset var loc = {}>
		<cfset var functions = "">
		<cfset loc.parameters = model("functionArgument").findAll(returnAs="objects", reload=true)>
		<cfset functions = model("function").findAll(where="wheelsVersion='#arguments.version#'", reload=true)>
		<cfset loc.parametersQuery = model("functionArgument").findAllForVersion(arguments.version)>
		
		<!--- Replace "See documentation for @..." references with intended documentation --->
		<cfloop array="#loc.parameters#" index="loc.parameter">
			<cfset loc.parameter = cleanHint(loc.parameter, functions, loc.parametersQuery)>
			<cfset loc.parameter.save()>
		</cfloop>
	
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="generateFunctionsFromScope" hint="Generates a batch of functions based on scope and function names.">
		<cfargument name="scope" hint="Structure containing functions to process.">
		<cfargument name="version" type="string" hint="Version to store in DB.">
		<cfargument name="functionsGenerated" type="array" required="false" default="#ArrayNew(1)#" hint="Functions already generated in this operation that can be safely skipped to avoid duplicates.">
	
		<cfset var loc = {}>
		<cfset loc.functionList = StructKeyList(arguments.scope)>
		<cfset loc.saveStatus = []>
		<cfset loc.saveStatusItem = {}>
		
		<cfloop list="#loc.functionList#" index="loc.currentFunction">
			<cfif
				isApiFunction(loc.currentFunction, arguments.scope)
				and not isFunctionAlreadyGenerated(arguments.functionsGenerated, loc.currentFunction)
			>
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
					<cfset loc.result = loc.function.save()>
					<cfif loc.result>
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
	
	<cffunction name="isApiFunction" returntype="boolean" hint="Whether or not the given function is a Wheels API function.">
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
	<!--- Callbacks --->
	
	<cffunction name="cleanExamples" access="private" hint="Cleans up examples data.">
		
		<cfset this.examples = Replace(this.examples, Chr(9) & Chr(9), "", "all")>
		
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="deleteArguments" access="private" hint="Deletes all arguments related to this function.">
	
		<cfset this.deleteAllFunctionArguments()>
	
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="processCategories" access="private" hint="Processes category slugs at `this.categories` into proper functionSectionIds.">
	
		<!--- Parent category --->
		<cfset this.parentFunctionSectionId = translateCategory(ListGetAt(this.categories, 1, ","))>
		<!--- Child category (if it is set) --->
		<cfif ListLen(this.categories, ",") eq 2>
			<cfset this.childFunctionSectionId = translateCategory(ListGetAt(this.categories, 2, ","))>
		</cfif>
	
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="saveArguments" access="private" hint="Saves all associated arguments set through the parameters array.">
	
		<cfset var loc = {}>
		
		<cfif StructKeyExists(this, "parameters")>
			<cfloop array="#this.parameters#" index="loc.parameter">
				<!--- Ignore private parameters --->
				<cfif Left(loc.parameter.name, 1) is not "$">
					<cfset loc.argument = model("functionArgument").new()>
					<cfset loc.argument.functionId = this.id>
					<cfset loc.argument.name = loc.parameter.name>
					<!--- `type` --->
					<cfif StructKeyExists(loc.parameter, "type")>
						<cfset loc.argument.type = loc.parameter.type>
					</cfif>
					<!--- `required` --->
					<cfif StructKeyExists(loc.parameter, "required")>
						<cfset loc.argument.required = loc.parameter.required>
					</cfif>
					<!--- `default` --->
					<cfif
						StructKeyExists(loc.parameter, "default")
						and Len(loc.parameter.default) eq 0
					>
						<cfset loc.argument.defaultValue = "">
					<!--- `default` is `[runtime expression]` --->
					<cfelseif
						StructKeyExists(loc.parameter, "default")
						and loc.parameter.default is "[runtime expression]"
						and StructKeyExists(application.wheels.functions, this.name)
						and StructKeyExists(application.wheels.functions[this.name], loc.parameter.name)
					>
						<cfset loc.argument.defaultValue = application.wheels.functions[this.name][loc.parameter.name]>
					<cfelseif StructKeyExists(loc.parameter, "default")>
						<cfset loc.argument.defaultValue = loc.parameter.default>
					</cfif>
					<!--- `hint` --->
					<cfif StructKeyExists(loc.parameter, "hint")>
						<cfset loc.argument.hint = loc.parameter.hint>
					</cfif>
						
					<cfif not loc.argument.save()>
						<cfloop array="#loc.argument.allErrors()#" index="loc.error">
							<cfset addErrorToBase(argumentCollection=loc.error)>
						</cfloop>
					</cfif>
				</cfif>
			</cfloop>
		</cfif>
	
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="saveRelatedFunctions" access="private" hint="Saves related functions set in the functions list.">
	
		<cfset var loc = {}>
		
		<cfif StructKeyExists(this, "functions")>
			<cfloop list="#this.functions#" index="loc.functionName" delimiters=",">
				<cfset loc.function = model("function").findOneByName(loc.functionName)>
				<cfset this.createRelatedFunction(loc.function)>
			</cfloop>
		</cfif>
	
	</cffunction>
	
	
	<!----------------------------------------------------->
	<!--- Private --->
	
	<cffunction name="cleanHint" access="private" hint="Cleans up parameter's hint text.">
		<cfargument name="parameter" hint="Parameter to clean up.">
		<cfargument name="functionsQuery" type="query" hint="Complete list of functions to reference.">
		<cfargument name="parametersQuery" type="query" hint="Complete list of parameters to reference.">
		
		<cfset var loc = {}>
		
		<cfif Left(Trim(arguments.parameter.hint), 23) is "See documentation for @">
			<cfset loc.referenceFunction = Replace(arguments.parameter.hint, ".", "")>
			<cfset loc.referenceFunction = Right(loc.referenceFunction, Len(loc.referenceFunction) - 23)>
			<!--- Get reference function ID from memory --->
			<cfquery dbtype="query" name="loc.function">
				SELECT
					id
				FROM
					arguments.functionsQuery
				WHERE
					LOWER(name) = LOWER('#loc.referenceFunction#')
			</cfquery>
			<!--- Get reference function's parameter's hint from memory --->
			<cfif loc.function.RecordCount gt 0>
				<cfquery dbtype="query" name="loc.referenceParameter">
					SELECT
						hint
					FROM
						arguments.parametersQuery
					WHERE
						name = '#arguments.parameter.name#'
						AND functionId = #loc.function.id#
				</cfquery>
				<!--- Update parameter to use hint from reference function's parameter --->
				<cfset arguments.parameter.hint = loc.referenceParameter.hint>
			<!--- If the hint doesn't exist, then show error --->
			<cfelse>
				<cfdump var="No hint to reference for function #loc.referenceFunction#()'s (#loc.function.id#) #arguments.parameter.name# argument.">
				<cfdump var="#arguments.functionsQuery#">
				<cfdump var="#arguments.parametersQuery#" abort>
			</cfif>
		</cfif>
		
		<cfreturn arguments.parameter>
	
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="isFunctionAlreadyGenerated" access="private" returntype="boolean" hint="Returns whether or not a given function appears in an array of functions already generated in a previous operation.">
		<cfargument name="generatedFunctions" type="array" hint="Functions already generated to search through.">
		<cfargument name="functionName" type="variablename" hint="Name of function to search for.">
		
		<cfset var loc = {}>
		
		<!--- Search array --->
		<cfloop array="#arguments.generatedFunctions#" index="loc.function">
			<cfif LCase(Trim(arguments.functionName)) is LCase(Trim(loc.function.name))>
				<cfreturn true>
			</cfif>
		</cfloop>
		
		<!--- If we get here, the function wasn't found --->
		<cfreturn false>
		
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="translateCategory" access="private" hint="Translates category slug at `this.categories` into the proper functionSectionId.">
		<cfargument name="categorySlug" type="string" hint="Category slug to translate into an id.">
		
		<cfset var loc = {}>
		
		<!--- Get categories --->
		<cfset loc.categories = model("functionSection").findAll(cache=1)>
		
		<!--- Get category by slug --->
		<cfquery dbtype="query" name="loc.category">
			SELECT
				id,
				parentFunctionSectionId
			FROM
				loc.categories
			WHERE
				slug = '#arguments.categorySlug#'
		</cfquery>
		
		<!--- If more than one result, choose by parentFunctionSectionId --->
		<cfif loc.category.RecordCount gt 1>
			<cfquery dbtype="query" name="loc.category">
				SELECT
					id
				FROM
					loc.category
				WHERE
					parentFunctionSectionId = #this.parentFunctionSectionId#
			</cfquery>
		</cfif>
		
		<cfreturn loc.category.id>
	
	</cffunction>
	
	<!----------------------------------------------------->

</cfcomponent>