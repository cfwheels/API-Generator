<cfcomponent extends="Model" output="false">

	<!----------------------------------------------------->
	<!--- Public --->
	
	<cffunction name="init" hint="Sets up associations.">
	
		<!--- Associations --->
		<cfset belongsTo("function")>
		<cfset hasOne(name="relatedFunction", class="function", foreignKey="relatedFunctionId")>
	
	</cffunction>
	
	<!----------------------------------------------------->

</cfcomponent>