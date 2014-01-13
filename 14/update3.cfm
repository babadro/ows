<!---
Name:        update3.cfm
Author:      Ben Forta (ben@forta.com)
Description: Table row update demo
Created:     07/01/07
--->

<!--- Update movie --->
<cfupdate datasource="ows"
          tablename="FILMS">

<!--- Page header --->
<cfinclude template="header.cfm">

<!--- Feedback --->
<cfoutput>
<h1>Movie '#FORM.MovieTitle#' updated</h1>
</cfoutput>

<!--- Page footer --->
<cfinclude template="footer.cfm">
