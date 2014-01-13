<!---
Name:        if5.cfm
Author:      Ben Forta (ben@forta.com)
Description: Demonstrate <cfelseif> use
Created:     07/01/2007
--->

<html>
<head>
 <title>If 5</title>
</head>

<body>

<!--- Get day of week --->
<cfset dow=DayOfWeek(Now())>

<!--- Let the user know --->
<cfif dow IS 1>
 <!--- It's Sunday --->
 It is the weekend! But make the most of it, tomorrow it's back to work.
<cfelseif dow IS 7>
 <!--- It's Saturday --->
 It is the weekend! And even better, tomorrow is the weekend too!
<cfelse>
 <!--- No it is not :-( --->
 No, it's not the weekend yet, sorry!
</cfif>

</body>
</html>
