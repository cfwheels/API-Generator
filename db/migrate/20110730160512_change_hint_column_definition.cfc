<cfcomponent extends="plugins.dbmigrate.Migration" hint="change hint column definition">
  <cffunction name="up">
    <cfscript>
	changeColumn(table="functionarguments", columnName="hint", columnType="string", limit="2000");
	changeColumn(table="functions", columnName="hint", columnType="string", limit="2000");
    </cfscript>
  </cffunction>
  <cffunction name="down">
    <cfscript>
	changeColumn(table="functionarguments", columnName="hint", columnType="text");
	changeColumn(table="functions", columnName="hint", columnType="string", limit="2000");
    </cfscript>
  </cffunction>
</cfcomponent>
