<cfcomponent extends="plugins.dbmigrate.Migration" hint="Initial versions creation">
	
	<!----------------------------------------------------->
	<!--- Public --->
	
	<cffunction name="up">
	
		<!--- Version Data --->
		<cfset addRecord(table="versions", id=16, version="1.0.3", filename="cfwheels.1.0.3.zip", createdat="2010-03-26")>
		
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="down">
	
		<cfset removeRecord(table="versions", where="id=16")>
		
	</cffunction>
	
	<!----------------------------------------------------->
	
</cfcomponent>