<!---
Name:        loop3.cfm
Author:      Ben Forta (ben@forta.com)
Description: Demonstrate use of nested loops
Created:     07/01/2007
--->

<html>
<head>
 <title>Loop 3</title>
</head>

<body>

<!--- Hex value list --->
<cfset hex="00,33,66,99,CC,FF">

<!--- Create table --->
<table>

<!--- Start RR loop --->
<cfloop index="red" list="#hex#">
 <!--- Start GG loop --->
 <cfloop index="green" list="#hex#">
  <tr>
  <!--- Start BB loop --->
  <cfloop index="blue" list="#hex#">
   <!--- Build RGB value --->
   <cfset rgb=red&green&blue>
   <!--- And display it --->
   <cfoutput>
   <td bgcolor="###rgb#" width="100" align="center">#rgb#</td>
   </cfoutput>
  </cfloop>
  </tr>
 </cfloop>
</cfloop>

</table>

</body>
</html>
