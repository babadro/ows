<!---
Name:        dynamicsql.cfm
Author:      Ben Forta (ben@forta.com)
Description: Dynamic SQL demonstration
Created:     07/01/07
--->

<!--- Create FilmID variable --->
<cfset FilmID=1>

<!--- Get a movie from database --->
<cfquery name="movie"
         datasource="ows"
         result="results">
SELECT FilmID, MovieTitle, PitchText
FROM Films
WHERE FilmID=#FilmID#
</cfquery>

<h1>Dump Returned Query (NAME)</h1>
<cfdump var="#movie#">
<h1>Dump Returned Result (RESULT)</h1>
<cfdump var="#results#">
