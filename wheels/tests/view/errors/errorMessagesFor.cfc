<cfcomponent extends="wheelsMapping.test">

	<cfset global.controller = createobject("component", "wheelsMapping.tests._assets.controllers.ControllerWithModelErrors")>
	<cfset global.args = {}>
	<cfset global.args.objectName = "user">
	<cfset global.args.class = "errors-found">

	<cffunction name="test_show_duplicate_errors">
		<cfset loc.args.showDuplicates = true>
		<cfset loc.e = loc.controller.errorMessagesFor(argumentcollection=loc.args)>
		<cfset loc.r = '<ul class="errors-found"><li>firstname error1</li><li>firstname error2</li><li>firstname error2</li></ul>'>
		<cfset assert("loc.e eq loc.r")>
	</cffunction>

	<cffunction name="test_do_not_show_duplicate_errors">
		<cfset loc.args.showDuplicates = false>
		<cfset loc.e = loc.controller.errorMessagesFor(argumentcollection=loc.args)>
		<cfset loc.r = '<ul class="errors-found"><li>firstname error1</li><li>firstname error2</li></ul>'>
		<cfset assert("loc.e eq loc.r")>
	</cffunction>

</cfcomponent>