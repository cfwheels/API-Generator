<cfcomponent extends="Model" output="false">

	<!----------------------------------------------------->
	<!--- Public --->
	
	<cffunction name="init" hint="Sets associations, validations, and callbacks.">
		
		<!--- Associations --->
		<cfset hasMany("functionArguments")>
		<cfset hasMany("relatedFunctions")>
		<cfset belongsTo(name="parentFunctionSectionId", class="functionSection", foreignKey="parentFunctionSectionId")>
		<cfset belongsTo(name="childFunctionSectionId", class="functionSection", foreignKey="childFunctionSectionId")>
		<!--- Validations --->
		<cfset validatesPresenceOf("name,wheelsVersion,returnType,hint,examples")>
		<cfset validatesNumericalityOf("parentFunctionSectionId")>
		<cfset validatesNumericalityOf(property="childFunctionSectionId", allowBlank=true)>
		<cfset validatesUniquenessOf("name")>
		<!--- Callbacks --->
		<cfset beforeValidation("processCategories")>
		<cfset beforeSave("cleanExamples")>
		<cfset afterSave("saveArguments")><!---,saveRelatedFunctions--->
	
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="cleanup" hint="Cleans up documentation in database. Replaces references to 'See documentation for...', etc.">
		
		<cfset var loc = {}>
		<cfset loc.parameters = model("functionArgument").findAll(returnAs="objects")>
		<cfset loc.functions = model("function").findAll()>
		<cfset loc.parametersQuery = model("functionArgument").findAll()>
		
		<!--- Replace "See documentation for @..." references with intended documentation --->
		<cfloop array="#loc.parameters#" index="loc.parameter">
			<cfset loc.parameter = cleanHint(loc.parameter, loc.functions, loc.parametersQuery)>
			<cfif loc.parameter.hasChanged()>
				<cfset loc.parameter.save()>
			</cfif>
		</cfloop>
	
	</cffunction>
	
	<!----------------------------------------------------->
	<!--- Callbacks --->
	
	<cffunction name="cleanExamples" access="private" hint="Cleans up examples data.">
		
		<cfset this.examples = Replace(this.examples, Chr(9) & Chr(9), "", "all")>
		
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
				<cfif Left(loc.parameter.name, 1) is not "$">
					<cfset loc.argument = model("functionArgument").new()>
					<cfset loc.argument.functionId = this.id>
					<cfset loc.argument.name = loc.parameter.name>
					<cfif StructKeyExists(loc.parameter, "type")>
						<cfset loc.argument.type = loc.parameter.type>
					</cfif>
					<cfif StructKeyExists(loc.parameter, "required")>
						<cfset loc.argument.required = loc.parameter.required>
					</cfif>
					<cfif
						StructKeyExists(loc.parameter, "default")
						and Len(loc.parameter.default) eq 0
					>
						<cfset loc.argument.defaultValue = "">
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
					<cfset loc.argument.hint = loc.parameter.hint>
						
					<cftry>
						<cfif not loc.argument.save()>
							<cfoutput><p>Argument fail:</p></cfoutput>
							<cfdump var="#loc.argument.allErrors()#"><cfabort>
						</cfif>
						
						<cfcatch type="any">
							<cfoutput><p>Argument fail:</p></cfoutput>
							<cfdump var="#cfcatch#">
							<cfdump var="#loc.argument#"><cfabort>
						</cfcatch>
					</cftry>
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
		
		<cfif Left(arguments.parameter.hint, 23) is "See documentation for @">
			<cfset loc.referenceFunction = Replace(arguments.parameter.hint, ".", "")>
			<cfset loc.referenceFunction = Right(loc.referenceFunction, Len(loc.referenceFunction) - 23)>
			<!--- Get reference function ID from memory --->
			<cfquery dbtype="query" name="loc.function">
				SELECT
					id
				FROM
					arguments.functionsQuery
				WHERE
					name = '#loc.referenceFunction#'
			</cfquery>
			<!--- Get reference function's parameter's hint from memory --->
			<cfquery dbtype="query" name="loc.referenceParameter">
				SELECT
					hint
				FROM
					arguments.parametersQuery
				WHERE
					name = '#arguments.parameter.name#'
					AND functionId = #loc.function.id#
			</cfquery>
			<!--- Update parameter to use reference function's parameter's hint --->
			<cfset arguments.parameter.hint = loc.referenceParameter.hint>
		</cfif>
		
		<cfreturn arguments.parameter>
	
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