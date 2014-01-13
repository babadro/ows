<!---
Name:        details.cfm
Author:      Ben Forta (ben@forta.com)
Description: CFC driven data drill-down details
             with complete validation
Created:     12/15/04
--->

<!--- Movie list page --->
<cfset list_page="movies.cfm">

<!--- Make sure FilmID was passed --->
<cfif not IsDefined("URL.filmid")>
 <!--- it wasn’t, send to movie list --->
 <cflocation url="#list_page#">
</cfif>

<!--- Get movie details --->
<cfinvoke 
 component="ows.11.movies"
 method="GetDetails"
 returnvariable="movie"
 FilmID="#URL.filmid#">

<!--- Make sure have a movie --->
<cfif movie.RecordCount IS 0>
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
    <img src="../images/f#filmid#.gif"
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

<!--- Links --->
[<a href="detailsprint.cfm?FilmID=#URL.FilmID#">Printable page</a>]
[<a href="#list_page#">Movie list</a>]

</cfoutput>

</body>
</html>
