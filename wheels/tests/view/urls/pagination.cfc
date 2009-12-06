<cfcomponent extends="wheelsMapping.test">

	<cfset global.controller = createobject("component", "wheelsMapping.Controller")>
	<cfset loadModels("users")>

	<cffunction name="test_x_pagination_valid">
		<cfset loc.e = loc.user.findAll(where="firstname = 'somemoron'", perpage="2", page="1", handle="pagination_test_1", order="id")>
		<cfset loc.controller.pagination("pagination_test_1")>
	</cffunction>

</cfcomponent>