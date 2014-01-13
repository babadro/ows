<!--- 
 Filename: DeleteClientVars.cfm
 Created by: Nate Weiss (NMW)
 Purpose: Deletes all client variables associated with browser
--->

<html>
<head><title>Clearing Your Preferences</title></head>
<body>

<h2>Clearing Your Preferences</h2>

<!--- For each client-variable set for this browser... --->
<cfloop list="#getClientVariablesList()#" index="thisVarName">
 <!--- Go ahead and delete the client variable! --->
 <cfset deleteClientVariable(thisVarName)>

 <cfoutput>#thisVarName# deleted.<br></cfoutput>
</cfloop>

<p>Your preferences have been cleared.</p>

</body>
</html>
