<cfcomponent extends="plugins.dbmigrate.Migration" hint="Adding version 1.0.5">
	
	<!----------------------------------------------------->
	<!--- Public --->
	
	<cffunction name="up">
	
		<!--- Version Data --->
		<cfset addRecord(table="versions", id=18, version="1.0.5", filename="cfwheels.1.0.5.zip", createdat="2010-06-18")>
		
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="down">
		<cfset removeRecord(table="versions", where="id=18")>
		
	</cffunction>
	
	<!----------------------------------------------------->
	
</cfcomponent>