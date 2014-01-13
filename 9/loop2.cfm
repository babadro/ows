<!---
Name:        loop2.cfm
Author:      Ben Forta (ben@forta.com)
Description: Demonstrate use of <cfloop list>
Created:     07/01/2007
--->

<html>
<head>
 <title>Loop 2</title>
</head>

<body>

<!--- Create list --->
<cfset fruit="apple,banana,cherry,grape,mango,orange,pineapple">

<!--- Start list --->
<ul>

<!--- Loop through list --->
<cfloop list="#fruit#" index="i">
 <!--- Write item --->
 <cfoutput><li>#i#</li></cfoutput>
</cfloop>

<!--- end list --->
</ul>

</body>
</html>
