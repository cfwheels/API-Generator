<cfcomponent extends="plugins.dbmigrate.Migration" hint="Adding version 1.1 beta 2.">
	
	<!----------------------------------------------------->
	<!--- Public --->
	
	<cffunction name="up">
	
		<!--- Shift back date of 1.1 final so it doesn't appear in archive list --->
		<cfset updateRecord(table="versions", where="version='1.1'", createdat="2010-10-06")>
		<!--- Version 1.1 beta 2 --->
		<cfset addRecord(table="versions", version="1.1 Beta 2", filename="cfwheels.1.1-beta-2.zip", createdat="2010-10-05", ismajorrelease=0)>
		
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="down">
	
		<!--- Remove 1.1 beta 2 --->
		<cfset removeRecord(table="versions", where="version='1.1 Beta 2'")>
		
	</cffunction>
	
	<!----------------------------------------------------->
	
</cfcomponent>