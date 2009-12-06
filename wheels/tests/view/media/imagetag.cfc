<cfcomponent extends="wheelsMapping.test">

	<cfset global.controller = createobject("component", "wheelsMapping.Controller")>
	<cfset global.args = {}>
	<cfset global.args.source = "../wheels/tests/_assets/files/wheelslogo.jpg">
	<cfset global.args.alt = "wheelstestlogo">
	<cfset global.args.class = "wheelstestlogoclass">
	<cfset global.args.id = "wheelstestlogoid">
	<cfset global.imagePath = application.wheels.webPath & application.wheels.imagePath>

	<cffunction name="test_just_source">
		<cfset structdelete(loc.args, "alt")>
		<cfset structdelete(loc.args, "class")>
		<cfset structdelete(loc.args, "id")>
		<cfset loc.r = '<img alt="Wheelslogo" height="90" src="#loc.imagePath#/#loc.args.source#" width="123" />'>
		<cfset loc.e = loc.controller.imageTag(argumentcollection=loc.args)>
		<cfset assert("loc.e eq loc.r")>
	</cffunction>

	<cffunction name="test_supplying_an_alt">
		<cfset structdelete(loc.args, "class")>
		<cfset structdelete(loc.args, "id")>
		<cfset loc.r = '<img alt="#loc.args.alt#" height="90" src="#loc.imagePath#/#loc.args.source#" width="123" />'>
		<cfset loc.e = loc.controller.imageTag(argumentcollection=loc.args)>
		<cfset assert("loc.e eq loc.r")>
	</cffunction>

	<cffunction name="test_supplying_class_and_id">
		<cfset loc.r = '<img alt="#loc.args.alt#" class="#loc.args.class#" height="90" id="#loc.args.id#" src="#loc.imagePath#/#loc.args.source#" width="123" />'>
		<cfset loc.e = loc.controller.imageTag(argumentcollection=loc.args)>
		<cfset assert("loc.e eq loc.r")>
	</cffunction>

	<cffunction name="test_grabbing_from_http">
		<cfset structdelete(loc.args, "alt")>
		<cfset structdelete(loc.args, "class")>
		<cfset structdelete(loc.args, "id")>
		<cfset loc.args.source = "http://www.cfwheels.org/images/logo.jpg">
		<cfset loc.r = '<img alt="Logo" src="#loc.args.source#" />'>
		<cfset loc.e = loc.controller.imageTag(argumentcollection=loc.args)>
		<cfset assert("loc.e eq loc.r")>
	</cffunction>

	<cffunction name="test_grabbing_from_https">
		<cfset structdelete(loc.args, "alt")>
		<cfset structdelete(loc.args, "class")>
		<cfset structdelete(loc.args, "id")>
		<cfset loc.args.source = "https://www.cfwheels.org/images/logo.jpg">
		<cfset loc.r = '<img alt="Logo" src="#loc.args.source#" />'>
		<cfset loc.e = loc.controller.imageTag(argumentcollection=loc.args)>
		<cfset assert("loc.e eq loc.r")>
	</cffunction>

</cfcomponent>