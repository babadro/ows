<!---
Name:        process1.cfm
Author:      Ben Forta (ben@forta.com)
Description: Basic server-side validation
Created:     07/01/07
--->

<html>

<head>
  <title>Orange Whip Studios - Intranet</title>
</head>

<body>

<!--- Page header --->
<cfinclude template="header.cfm">

<!--- Make sure LoginID is not empty --->
<cfif Len(Trim(LoginID)) IS 0>
 <h1>ERROR! ID cannot be left blank!</h1>
 <cfabort>
</cfif>

<!--- Make sure LoginID is a number --->
<cfif IsNumeric(LoginID) IS "No">
 <h1>ERROR! Invalid ID specified!</h1>
 <cfabort>
</cfif>

<!--- Make sure LoginPassword is not empty --->
<cfif Len(Trim(LoginPassword)) IS 0>
 <h1>ERROR! Password cannot be left blank!</h1>
 <cfabort>
</cfif>

<p align="center">
<h1>Intranet</h1>
</p>

Intranet would go here.

</body>

</html>
