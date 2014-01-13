<!---
Name:        if4.cfm
Author:      Ben Forta (ben@forta.com)
Description: Demonstrate saving <cfif> results
Created:     07/01/2007
--->

<html>
<head>
 <title>If 4</title>
</head>

<body>

<!--- Is it the weekend? --->
<cfset weekend=(DayOfWeek(Now()) IS 1) OR (DayOfWeek(Now()) IS 7)>

<!--- Let the user know --->
<cfif weekend>
 <!--- Yes it is, great! --->
 It is the weekend, yeah!
<cfelse>
 <!--- No it is not :-( --->
 No, it's not the weekend yet, sorry!
</cfif>

</body>
</html>
