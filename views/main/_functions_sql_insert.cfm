<cfparam name="arguments.functions" type="query">
<cfparam name="arguments.version" type="string">

<cfoutput>

<!--- DELETE existing functions and arguments for specified version --->
DELETE F.*, A.* FROM functions F JOIN functionarguments A ON F.id = A.functionid WHERE F.wheelsversion = '#arguments.version#';
DELETE FROM functions WHERE wheelsversion = '#arguments.version#';

</cfoutput>

<!--- INSERT statements for functions --->
<cfoutput query="arguments.functions" group="id">
	INSERT INTO functions (name, wheelsversion, returntype, hint, examples, parentfunctionsectionid, childfunctionsectionid)
	VALUES ('#arguments.functions.name#', '#arguments.version#', #valueOrNull(arguments.functions.returnType)#, '#sqlParameterFormat(arguments.functions.hint)#', '#sqlParameterFormat(arguments.functions.examples)#', #arguments.functions.parentFunctionSectionId#, #valueOrNull(arguments.functions.childFunctionSectionId)#);

	SELECT @function_id:=id FROM functions ORDER BY id DESC LIMIT 1;

	<!--- INSERT statements for arguments --->
	<cfoutput>
		<cfif Len(arguments.functions.functionArgumentName) gt 0>
			INSERT INTO functionarguments (functionid, name, type, required, defaultvalue, hint)
			VALUES(@function_id, '#arguments.functions.functionArgumentName#', '#arguments.functions.type#', #arguments.functions.required#, #valueOrNull(arguments.functions.defaultValue)#, '#sqlParameterFormat(arguments.functions.functionArgumentHint)#');
		</cfif>
	</cfoutput>
</cfoutput>