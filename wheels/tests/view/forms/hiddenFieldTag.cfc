<cfcomponent extends="wheelsMapping.test">

	<cfset global.controller = createobject("component", "wheelsMapping.Controller")>

	<cffunction name="test_x_hiddenFieldTag_valid">
		<cfset global.controller.hiddenFieldTag(name="userId", value="tony")>
	</cffunction>

</cfcomponent>