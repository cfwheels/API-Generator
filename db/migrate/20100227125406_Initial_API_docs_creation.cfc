<cfcomponent extends="plugins.dbmigrate.Migration" hint="Initial API docs creation">

	<!----------------------------------------------------->
	<!--- Public --->
	
	<cffunction name="up">
	
		<!--- Function --->
		<cfset local.t = createTable(name="functions", force=true)>
		<cfset local.t.string(columnNames="name", null=false, limit=30)>
		<cfset local.t.string(columnNames="wheelsversion", null=false, limit=15)>
		<cfset local.t.string(columnNames="returntype", null=false, limit=15)>
		<cfset local.t.text(columnNames="hint", null=false)>
		<cfset local.t.text(columnNames="examples", null=false)>
		<cfset local.t.integer(columnNames="parentfunctionsectionid", null=false)>
		<cfset local.t.integer(columnNames="childfunctionsectionid", null=true)>
		<cfset local.t.create()>
		
		<!--- FunctionArgument --->
		<cfset local.t = createTable(name="functionarguments", force=true)>
		<cfset local.t.integer(columnNames="functionid", null=false)>
		<cfset local.t.string(columnNames="name", null=false, limit=100)>
		<cfset local.t.string(columnNames="type", null=true, default="any", limit=20)>
		<cfset local.t.boolean(columnNames="required", null=false, default=0)>
		<cfset local.t.string(columnNames="defaultvalue", null=true, limit=255)>
		<cfset local.t.text(columnNames="hint", null=false)>
		<cfset local.t.create()>
		
		<!--- FunctionSection --->
		<cfset local.t = createTable(name="functionsections", force=true)>
		<cfset local.t.string(columnNames="name", null=false, limit=50)>
		<cfset local.t.text(columnNames="description", null=true)>
		<cfset local.t.integer(columnNames="ordering", null=false)>
		<cfset local.t.integer(columnNames="parentfunctionsectionid", null=true)>
		<cfset local.t.string(columnNames="slug", null=false, limit=30)>
		<cfset local.t.create()>
		<!--- FunctionSection Data --->
		<cfset addRecord(table="functionsections", name="Model Initialization Functions", description="These methods are called from the <code>init()</code> methods of your model files.", ordering=1, slug="model-initialization")>
		<cfset addRecord(table="functionsections", name="Model Class Functions", description="These methods operate on the class as a whole and not on individual objects and thus need to be prefaced with <code>model(&quot;name&quot;)</code>. You can call these methods from anywhere, but it is not recommended to call them from view pages. When calling them from their own model files, it is recommended to reference the scope explicitly with the <code>this</code> keyword.", ordering=2, slug="model-class")>
		<cfset addRecord(table="functionsections", name="Model Object Functions", description="These methods operate on individual objects, which means you first need to fetch or create an object and then call the method on that object. You can call these methods from anywhere, but it is not recommended to call them from view pages. When calling them from their own model files, it is recommended to reference them explicitly with the <code>this</code> scope keyword.", ordering=3, slug="model-object")>
		<cfset addRecord(table="functionsections", name="View Helper Functions", description='These functions can be called from the views to create output for use in a <abbr title="Hypertext Markup Language">HTML</abbr> page.', ordering=4, slug="view-helper")>
		<cfset addRecord(table="functionsections", name="Controller Initialization Functions", description="These functions are called from the <code>init()</code> methods of your controller files.", ordering=5, slug="controller-initialization")>
		<cfset addRecord(table="functionsections", name="Controller Request Functions", description="These functions are called from actions in your controller files.", ordering=6, slug="controller-request")>
		<cfset addRecord(table="functionsections", name="Global Helper Functions", description="These functions are general purpose functions and can be called from anywhere.", ordering=7, slug="global")>
		<cfset addRecord(table="functionsections", name="Configuration Functions", description="These functions should be called from files in the <kbd>config</kbd> folder.", ordering=8, slug="configuration")>
		<cfset addRecord(table="functionsections", name="Statistics Functions", ordering=1, parentfunctionsectionid=2, slug="statistics")>
		<cfset addRecord(table="functionsections", name="Read Functions", ordering=1, parentfunctionsectionid=2, slug="read")>
		<cfset addRecord(table="functionsections", name="Validation Functions", ordering=1, parentfunctionsectionid=1, slug="validations")>
		<cfset addRecord(table="functionsections", name="Association Functions", ordering=1, parentfunctionsectionid=1, slug="associations")>
		<cfset addRecord(table="functionsections", name="Update Functions", ordering=1, parentfunctionsectionid=2, slug="update")>
		<cfset addRecord(table="functionsections", name="Miscellaneous Functions", ordering=1, parentfunctionsectionid=3, slug="miscellaneous")>
		<cfset addRecord(table="functionsections", name="Error Functions", ordering=1, parentfunctionsectionid=3, slug="errors")>
		<cfset addRecord(table="functionsections", name="Callback Functions", ordering=1, parentfunctionsectionid=1, slug="callbacks")>
		<cfset addRecord(table="functionsections", name="Form Tag Functions", ordering=1, parentfunctionsectionid=4, slug="forms-plain")>
		<cfset addRecord(table="functionsections", name="Miscellaneous Functions", ordering=1, parentfunctionsectionid=7, slug="miscellaneous")>
		<cfset addRecord(table="functionsections", name="Miscellaneous Functions", ordering=1, parentfunctionsectionid=6, slug="miscellaneous")>
		<cfset addRecord(table="functionsections", name="Text Functions", ordering=1, parentfunctionsectionid=4, slug="text")>
		<cfset addRecord(table="functionsections", name="Error Functions", ordering=1, parentfunctionsectionid=4, slug="errors")>
		<cfset addRecord(table="functionsections", name="Form Object Functions", ordering=1, parentfunctionsectionid=4, slug="forms-object")>
		<cfset addRecord(table="functionsections", name="Link Functions", ordering=1, parentfunctionsectionid=4, slug="links")>
		<cfset addRecord(table="functionsections", name="String Functions", ordering=1, parentfunctionsectionid=7, slug="string")>
		<cfset addRecord(table="functionsections", name="Asset Functions", ordering=1, parentfunctionsectionid=4, slug="assets")>
		<cfset addRecord(table="functionsections", name="Date Functions", ordering=1, parentfunctionsectionid=4, slug="dates")>
		<cfset addRecord(table="functionsections", name="General Form Functions", ordering=1, parentfunctionsectionid=4, slug="forms-general")>
		<cfset addRecord(table="functionsections", name="Sanitization Functions", ordering=1, parentfunctionsectionid=4, slug="sanitize")>
		<cfset addRecord(table="functionsections", name="URL Functions", ordering=1, parentfunctionsectionid=4, slug="urls")>
		<cfset addRecord(table="functionsections", name="Flash Functions", ordering=1, parentfunctionsectionid=6, slug="flash")>
		<cfset addRecord(table="functionsections", name="Rendering Functions", ordering=1, parentfunctionsectionid=6, slug="rendering")>
		<cfset addRecord(table="functionsections", name="Miscellaneous Functions", ordering=1, parentfunctionsectionid=1, slug="miscellaneous")>
		<cfset addRecord(table="functionsections", name="Create Functions", ordering=1, parentfunctionsectionid=2, slug="create")>
		<cfset addRecord(table="functionsections", name="Delete Functions", ordering=1, parentfunctionsectionid=2, slug="delete")>
		<cfset addRecord(table="functionsections", name="Miscellaneous Functions", ordering=1, parentfunctionsectionid=2, slug="miscellaneous")>
		<cfset addRecord(table="functionsections", name="Change Functions", ordering=1, parentfunctionsectionid=3, slug="changes")>
		<cfset addRecord(table="functionsections", name="CRUD Functions", ordering=1, parentfunctionsectionid=3, slug="crud")>
		<cfset addRecord(table="functionsections", name="Miscellaneous Functions", ordering=1, parentfunctionsectionid=4, slug="miscellaneous")>
		
		<!--- Dummy for API generation application --->
		<cfset local.t = createTable(name="dummies", force=true)>
		<cfset local.t.create()>
		
	</cffunction>
	
	<!----------------------------------------------------->
	
	<cffunction name="down">
	
		<cfset dropTable("functions")>
		<cfset dropTable("functionarguments")>
		<cfset dropTable("functionsections")>
		<cfset dropTable("dummies")>
		
	</cffunction>
	
	<!----------------------------------------------------->

</cfcomponent>