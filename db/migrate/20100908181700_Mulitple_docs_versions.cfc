<cfcomponent extends="plugins.dbmigrate.Migration" hint="Multiple docs versions">
	
	<!----------------------------------------------------->
	<!--- Public --->
	
	<cffunction name="up">
		
		<!--- Major release property in Version --->
		<cfset addColumn(table="versions", columnName="ismajorrelease", columnType="boolean", default=0, null=false)>
		<!--- Data --->
		<cfset updateRecord(table="versions", where="id=13", ismajorrelease=1)>
		
		<!--- FunctionSectionVersion --->
		<cfset local.t = createTable(name="functionsectionversions", force=true)>
		<cfset local.t.integer(columnNames="functionsectionid,versionid", null=false)>
		<cfset local.t.create()>
		<!--- Data --->
		<cfset local.functionSections = model("functionSection").findAll(order="id")>
		<cfloop query="local.functionSections">
			<cfif Len(functionSections.parentFunctionSectionId) eq 0>
				<cfset addRecord(table="functionsectionversions", functionsectionid=local.functionSections.id, versionid=13)>
			</cfif>
		</cfloop>
		
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="down">
		
		<cfset removeColumn(table="versions", columnName="ismajorrelease")>
		<cfset dropTable("functionsectionversions")>
		
	</cffunction>
	
	<!----------------------------------------------------->
	
</cfcomponent>