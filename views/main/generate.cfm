<cfsetting enablecfoutputonly="true">

<cfparam name="controllerSavedItems" type="array">
<cfparam name="modelSavedItems" type="array">
<cfparam name="numFunctions" type="numeric">
<cfparam name="version" type="string">

<cfoutput>

<h1>Generated Functions</h1>
<p>Version <strong>#version#</strong></p>
<p><strong>#numFunctions#</strong> functions imported</p>

<h2>Controller Functions</h2>
<table>
	<thead>
		<tr>
			<th>Function</th>
			<th>Valid</th>
			<th>Saved</th>
		</tr>
	</thead>
	<tbody>
		<cfloop array="#controllerSavedItems#" index="savedItem">
			<tr>
				<td>#savedItem.name#()</td>
				<td>#YesNoFormat(not savedItem.dataError)#</td>
				<td>#YesNoFormat(not savedItem.saveError)#</td>
			</tr>
		</cfloop>
	</tbody>
</table>

<h2>Model Functions</h2>
<table>
	<thead>
		<tr>
			<th>Function</th>
			<th>Valid</th>
			<th>Saved</th>
		</tr>
	</thead>
	<tbody>
		<cfloop array="#modelSavedItems#" index="savedItem">
			<tr>
				<td>#savedItem.name#()</td>
				<td>#YesNoFormat(not savedItem.dataError)#</td>
				<td>#YesNoFormat(not savedItem.saveError)#</td>
			</tr>
		</cfloop>
	</tbody>
</table>

</cfoutput>

<cfsetting enablecfoutputonly="false">