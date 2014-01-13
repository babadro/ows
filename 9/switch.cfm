<!---
Name:        switch.cfm
Author:      Ben Forta (ben@forta.com)
Description: Demonstrate use of <cfswitch> and <cfcase>
Created:     07/01/2007s
--->

<html>
<head>
 <title>Switch</title>
</head>

<body>

<!--- Get day of week --->
<cfset dow=DayOfWeek(Now())>

<!--- Let the user know --->
<cfswitch expression="#dow#">

 <!--- Is it Sunday? --->
 <cfcase value="1">
 It is the weekend! But make the most of it, tomorrow it's back to work.
 </cfcase>

 <!--- Is it Saturday? --->
 <cfcase value="7">
 It is the weekend! And even better, tomorrow is the weekend too!
 </cfcase>

 <!--- If code reaches here it's not the weekend --->
 <cfdefaultcase>
 No, it's not the weekend yet, sorry!
 </cfdefaultcase>
</cfswitch>

</body>
</html>
