﻿<cfcomponent extends="plugins.dbmigrate.Migration" hint="Adding version 1.0.4">
	
	<!----------------------------------------------------->
	<!--- Public --->
	
	<cffunction name="up">
	
		<!--- Version Data --->
		<cfset addRecord(table="versions", version="1.0.4", filename="cfwheels.1.0.4.zip", createdat="2010-04-21")>
		
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="down">
	
		<cfset removeRecord(table="versions", where="version='1.0.4'")>
		
	</cffunction>
	
	<!----------------------------------------------------->
	
</cfcomponent>