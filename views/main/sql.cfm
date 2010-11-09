<cfparam name="functions" type="query">
<cfparam name="version" type="string">

<cfoutput>

<h1><abbr title="Structured Query Language">SQL</abbr> for Functions</h1>

<textarea rows="50" cols="100">
	#Trim(includePartial(partial="functions_sql_insert", functions=functions, version=version))#
</textarea>

</cfoutput>