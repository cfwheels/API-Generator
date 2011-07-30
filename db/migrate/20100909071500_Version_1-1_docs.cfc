<cfcomponent extends="plugins.dbmigrate.Migration" hint="Version 1.1 docs.">
	
	<!----------------------------------------------------->
	<!--- Public --->
	
	<cffunction name="up">
		
		<!--- Add 1.1 Beta 1 and 1.1 versions --->
		<cfset addRecord(table="versions", version="1.1 Beta 1", filename="cfwheels.1.1-beta-1.zip", createdat="2010-09-10", ismajorrelease=0)>
		<cfset addRecord(table="versions", version="1.1", filename="cfwheels.1.1.zip", createdat="2010-09-11", ismajorrelease=1)>
		
		<!---  New function sections --->
		<cfset addRecord(table="functionsections", name="Provides Functions", ordering=1, parentfunctionsectionid=5, slug="provides")>
		<cfset addRecord(table="functionsections", name="Provides Functions", ordering=1, parentfunctionsectionid=6, slug="provides")>
		<cfset addRecord(table="functionsections", name="Form Association Functions", ordering=1, parentfunctionsectionid=4, slug="forms-association")>
		
		<!--- Add 1.1 docs to FunctionVersion model --->
		<cfset local.functionSections = model("functionSection").findAll(order="id")>
		<cfloop query="local.functionSections">
			<cfset addRecord(table="functionsectionversions", functionsectionid=local.functionSections.id, versionid=20)>
		</cfloop>
		
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="down">
	
		<!--- Remove 1.1 docs from FunctionVersion model --->
		<cfset local.functionSections = model("functionSection").findAll()>
		<cfloop query="local.functionSections">
			<cfset removeRecord(table="functionsectionversions", where="functionsectionid=#local.functionSections.id# AND versionid=20")>
		</cfloop>
		
		<!--- New versions --->
		<cfset removeRecord(table="versions", where="version='1.1 Beta 1'")>
		<cfset removeRecord(table="versions", where="version='1.1'")>
		
		<!--- Remove new function sections --->
		<cfset removeRecord(table="functionsections", where="parentfunctionsectionid=5 AND slug='provides'")>
		<cfset removeRecord(table="functionsections", where="parentfunctionsectionid=6 AND slug='provides'")>
		<cfset removeRecord(table="functionsections", where="parentfunctionsectionid=4 AND slug='forms-association'")>
		
	</cffunction>
	
	<!----------------------------------------------------->
	
</cfcomponent>