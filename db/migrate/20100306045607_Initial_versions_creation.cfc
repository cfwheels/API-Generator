<cfcomponent extends="plugins.dbmigrate.Migration" hint="Initial versions creation">
	
	<!----------------------------------------------------->
	<!--- Public --->
	
	<cffunction name="up">
	
		<!--- Version --->
		<cfset local.t = createTable(name="versions", force=true)>
		<cfset local.t.string(columnNames="version", null=false, limit=10)>
		<cfset local.t.string(columnNames="filename", null=false, limit=255)>
		<cfset local.t.date(columnNames="createdat", null=false)>
		<cfset local.t.create()>
		<!--- Version Data --->
		<cfset addRecord(table="versions", version="0.6 Lite", filename="cfwheels_0.6_lite.zip", createdat="2006-12-01")>
		<cfset addRecord(table="versions", version="0.7", filename="cfwheels.0.7.zip", createdat="2008-04-21")>
		<cfset addRecord(table="versions", version="0.8", filename="cfwheels.0.8.zip", createdat="2008-08-18")>
		<cfset addRecord(table="versions", version="0.8.1", filename="cfwheels.0.8.1.zip", createdat="2008-08-21")>
		<cfset addRecord(table="versions", version="0.8.2", filename="cfwheels.0.8.2.zip", createdat="2008-09-29")>
		<cfset addRecord(table="versions", version="0.8.3", filename="cfwheels.0.8.3.zip", createdat="2008-10-28")>
		<cfset addRecord(table="versions", version="0.9", filename="cfwheels.0.9.zip", createdat="2009-03-04")>
		<cfset addRecord(table="versions", version="0.9.1", filename="cfwheels.0.9.1.zip", createdat="2009-04-27")>
		<cfset addRecord(table="versions", version="0.9.2", filename="cfwheels.0.9.2.zip", createdat="2009-05-18")>
		<cfset addRecord(table="versions", version="0.9.3", filename="cfwheels.0.9.3.zip", createdat="2009-07-10")>
		<cfset addRecord(table="versions", version="0.9.4", filename="cfwheels.0.9.4.zip", createdat="2009-09-15")>
		<cfset addRecord(table="versions", version="1.0 RC1", filename="cfwheels.1.0-rc1-public.zip", createdat="2009-11-02")>
		<cfset addRecord(table="versions", version="1.0", filename="cfwheels.1.0-final.zip", createdat="2009-11-24")>
		<cfset addRecord(table="versions", version="1.0.1", filename="cfwheels.1.0.1.zip", createdat="2010-02-16")>
		<cfset addRecord(table="versions", version="1.0.2", filename="cfwheels.1.0.2.zip", createdat="2010-02-18")>
	
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="down">
		
		<cfset dropTable("versions")>
		
	</cffunction>
	
	<!----------------------------------------------------->
	
</cfcomponent>