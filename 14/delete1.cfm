<!---
Name:        delete1.cfm
Author:      Ben Forta (ben@forta.com)
Description: Table row delete demo
Created:     07/01/07
--->

<!--- Check that FilmID was provided --->
<cfif NOT IsDefined("FilmID")>
 <h1>You did not specify the FilmID</h1>
 <cfabort>
</cfif>

<!--- Delete a movie --->
<cfquery datasource="ows">
DELETE FROM Films
WHERE FilmID=#FilmID#
</cfquery>

<!--- Page header --->
<cfinclude template="header.cfm">

<!--- Feedback --->
<h1>Movie deleted</h1>

<!--- Page footer --->
<cfinclude template="footer.cfm">
