<cfcomponent extends="plugins.dbmigrate.Migration" hint="Adding version 1.0.5">
	
	<!----------------------------------------------------->
	<!--- Public --->
	
	<cffunction name="up">
	
		<!--- Version Data --->
		<cfset addRecord(table="versions", version="1.0.5", filename="cfwheels.1.0.5.zip", createdat="2010-06-18")>
		
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="down">
		<cfset removeRecord(table="versions", where="version='1.0.5'")>
		
	</cffunction>
	
	<!----------------------------------------------------->
	
</cfcomponent>