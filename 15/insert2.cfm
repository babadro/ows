<!---
Name:        insert2.cfm
Author:      Ben Forta (ben@forta.com)
Description: Advanced HTML controls
Created:     07/07/07
--->

<!--- Insert movie --->
<cfinsert datasource="ows"
          tablename="FILMS">

<!--- Page header --->
<cfinclude template="header.cfm">

<!--- Feedback --->
<cfoutput>
<h1>New movie '#FORM.MovieTitle#' added</h1>
</cfoutput>

<!--- Page footer --->
<cfinclude template="footer.cfm">
