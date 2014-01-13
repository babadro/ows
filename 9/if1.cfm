<!---
Name:        if1.cfm
Author:      Ben Forta (ben@forta.com)
Description: Demonstrate use of <cfif>
Created:     07/01/2007
--->

<html>
<head>
 <title>If 1</title>
</head>

<body>

<!--- Is it the weekend? --->
<cfif DayOfWeek(Now()) IS 1>
 <!--- Yes it is, great! --->
 It is the weekend, yeah!
</cfif>

</body>
</html>
