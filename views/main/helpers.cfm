<!----------------------------------------------------->

<cffunction name="sqlParameterFormat" returntype="string" hint="Escapes HTML and single quotes for building a SQL-friendly string.">
	<cfargument name="parameter" type="string" hint="String to format as a parameter.">
	
	<cfreturn h(Replace(arguments.parameter, "'", "\'", "all"))>
	
</cffunction>

<!----------------------------------------------------->

<cffunction name="valueOrNull" returntype="string" hint="Returns the value or `NULL` if it's an empty string. Also takes care of calling `sqlParameterFormat` so you don't need to worry about calling it from the view too.">
	<cfargument name="value" type="string" hint="Value to inspect.">
	
	<cfif Len(arguments.value) gt 0>
		<cfreturn "'" & sqlParameterFormat(arguments.value) & "'">
	<cfelse>
		<cfreturn 'NULL'>
	</cfif>

</cffunction>

<!----------------------------------------------------->