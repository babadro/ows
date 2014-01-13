<!---
Name:        if2.cfm
Author:      Ben Forta (ben@forta.com)
Description: Demonstrate use of multiple conditions
Created:     07/01/2007
--->

<html>
<head>
 <title>If 2</title>
</head>

<body>

<!--- Is it the weekend? --->
<cfif (DayOfWeek(Now()) IS 1) OR (DayOfWeek(Now()) IS 7)>
 <!--- Yes it is, great! --->
 It is the weekend, yeah!
</cfif>

</body>
</html>
