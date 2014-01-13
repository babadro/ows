<!---
Name:        edit2.cfm
Author:      Ben Forta (ben@forta.com)
Description: Dual purpose form demo
Created:     07/01/07
--->

<!--- Insert or update? --->
<cfset EditMode=IsDefined("FORM.FilmID")>

<cfif EditMode>
 <!--- Update movie --->
 <cfupdate datasource="ows" tablename="FILMS">
 <cfset action="updated">
<cfelse>
 <!--- Add movie --->
 <cfinsert datasource="ows" tablename="FILMS">
 <cfset action="added">
</cfif>

<!--- Page header --->
<cfinclude template="header.cfm">

<!--- Feedback --->
<cfoutput>
<h1>Movie #FORM.MovieTitle# #action#</h1>
</cfoutput>

<!--- Page footer --->
<cfinclude template="footer.cfm">
