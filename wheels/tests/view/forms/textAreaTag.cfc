<cfcomponent extends="wheelsMapping.test">

	<cfset global.controller = createobject("component", "wheelsMapping.Controller")>

	<cffunction name="test_x_textAreaTag_valid">
		<cfset global.controller.textAreaTag(name="description")>
	</cffunction>

</cfcomponent>