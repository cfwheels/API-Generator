<cfcomponent extends="Model" output="false">

	<!----------------------------------------------------->
	<!--- Public --->
	
	<cffunction name="init" hint="Sets associations and validations.">
	
		<!--- Associations --->
		<cfset belongsTo("function")>
		<!--- Validations --->
		<cfset validatesPresenceOf("name,hint")>
	
	</cffunction>
	
	<!----------------------------------------------------->

</cfcomponent>