<cfsetting enablecfoutputonly="true">

<cfparam name="wheelsVersion" type="string">
<cfparam name="controllerScope" type="struct">
<cfparam name="controllerFunctions" type="string">
<cfparam name="modelScope" type="struct">
<cfparam name="modelFunctions" type="string">

<cfoutput>

<h1>Wheels <abbr title="Application Programming Interface">API</abbr> Generator</h1>
<p><strong>Version:</strong> #wheelsVersion#</p>

#buttonTo(text="Generate API Docs", action="generate")#

<h2>Functions That Will be Generated</h2>

<h3>Controller/View</h3>
<ul>
	<cfloop list="#controllerFunctions#" index="function">
		<cfif isApiFunction(function, controllerScope)>
			<li><strong>#function#()</strong> = #GetMetaData(controllerScope[function]).hint#</li>
		</cfif>
	</cfloop>
</ul>

<h3>Model</h3>
<ul>
	<cfloop list="#modelFunctions#" index="function">
		<cfif isApiFunction(function, modelScope)>
			<li><strong>#function#()</strong> - #GetMetaData(modelScope[function]).hint#</li>
		</cfif>
	</cfloop>
</ul>

</cfoutput>

<cfsetting enablecfoutputonly="false">