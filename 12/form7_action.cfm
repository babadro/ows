<!---
Name:        form7_action.cfm
Author:      Ben Forta (ben@forta.com)
Description: Introduction to forms
Created:     07/01/07
--->

<html>

<head>
 <title>Learning ColdFusion Forms 7</title>
</head>

<body>

<!--- User feedback --->
<cfoutput>

<cfif FORM.Operation IS "Update">
 <!--- Update button clicked --->
 You opted to <strong>update</strong> #MovieTitle#
<cfelseif FORM.Operation IS "Delete">
 <!--- Delete button clicked --->
 You opted to <strong>delete</strong> #MovieTitle#
</cfif>

</cfoutput>

</body>

</html>
