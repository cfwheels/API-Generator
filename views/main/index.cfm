<cfsetting enablecfoutputonly="true">

<cfparam name="wheelsVersion" type="string">
<cfparam name="controllerScope" type="struct">
<cfparam name="controllerFunctions" type="string">
<cfparam name="modelScope" type="struct">
<cfparam name="modelFunctions" type="string">

<cfoutput>

<h1>Wheels <abbr title="Application Programming Interface">API</abbr> Generator</h1>
<p><strong>Version Loaded:</strong> #wheelsVersion#</p>

#startFormTag(action="generate")#
	#textFieldTag(label="Version: ", name="version")#
	#submitTag(value="Generate API Docs")#
#endFormTag()#

<h2>Functions That Will be Generated</h2>

<h3>Controller/View</h3>
<dl>
	<cfloop list="#controllerFunctions#" index="function">
		<cfif isApiFunction(function, controllerScope)>
			<dt>#function#()</dt>
			<dd>#GetMetaData(controllerScope[function]).hint#</dd>
		</cfif>
	</cfloop>
</dl>

<h3>Model</h3>
<dl>
	<cfloop list="#modelFunctions#" index="function">
		<cfif isApiFunction(function, modelScope)>
			<dt>#function#()</dt>
			<dd>#GetMetaData(modelScope[function]).hint#</dd>
		</cfif>
	</cfloop>
</dl>

</cfoutput>

<cfsetting enablecfoutputonly="false">