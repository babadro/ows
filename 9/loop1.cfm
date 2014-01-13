<!---
Name:        loop1.cfm
Author:      Ben Forta (ben@forta.com)
Description: Demonstrate use of <cfloop from to>
Created:     07/01/2007
--->

<html>
<head>
 <title>Loop 1</title>
</head>

<body>

<!--- Start list --->
<ul>

<!--- loop from 1 to 10 --->
<cfloop from="1" to="10" index="i">
 <!--- Write item --->
 <cfoutput><li>Item #i#</li></cfoutput>
</cfloop>

<!--- end list --->
</ul>

</body>
</html>
