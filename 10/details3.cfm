<!---
Name:        details3.cfm
Author:      Ben Forta (ben@forta.com)
Description: Data drill-down details
             with complete validation
Created:     07/01/07
--->

<!--- Movie list page --->
<cfset list_page="movies8.cfm">

<!--- Make sure FilmID was passed --->
<cfif not IsDefined("URL.filmid")>
 <!--- it wasn’t, send to movie list --->
 <cflocation url="#list_page#">
</cfif>

<!--- Get a movie from database --->
<cfquery name="movie" datasource="ows" result="result">
SELECT FilmID, MovieTitle,
       PitchText, Summary,
       DateInTheaters, AmountBudgeted
FROM Films
WHERE FilmID=#URL.FilmID#
</cfquery>

<!--- Make sure have a movie --->
<cfif result.RecordCount IS 0>
 <!--- It wasn’t, send to movie list --->
 <cflocation url="#list_page#">
</cfif>

<!--- Build image paths --->
<cfset image_src="../images/f#movie.FilmID#.gif">
<cfset image_path=ExpandPath(image_src)>

<!--- Create HTML page --->
<html>
<head>
 <title>Orange Whip Studios - Movie Details</title>
</head>

<body>

<!--- Display movie details --->
<cfoutput query="movie">

<table>
 <tr>
  <td colspan="2">
   <!--- Check of image file exists --->
   <cfif FileExists(image_path)>
    <!--- If it does, display it --->
    <img src="#image_src#"
       alt="#movietitle#"
       align="middle">
   </cfif>
   <b>#MovieTitle#</b>
  </td>
 </tr>
 <tr valign="top">
  <th align="right">Tag line:</th>
  <td>#PitchText#</td>
 </tr>
 <tr valign="top">
  <th align="right">Summary:</th>
  <td>#Summary#</td>
 </tr>
 <tr valign="top">
  <th align="right">Released:</th>
  <td>#DateFormat(DateInTheaters)#</td>
 </tr>
 <tr valign="top">
  <th align="right">Budget:</th>
  <td>#DollarFormat(AmountBudgeted)#</td>
 </tr>
</table>

<p>

<!--- Link back to movie list --->
<CFOUTPUT>
[<a href="#list_page#">Movie list</a>]
</CFOUTPUT>

</cfoutput>

</body>
</html>
