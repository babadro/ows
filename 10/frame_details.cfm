<!---
Name:        frame_details.cfm
Author:      Ben Forta (ben@forta.com)
Description: Detail for frames-based data drill-down
Created:     07/01/07
--->

<!--- Make sure FilmID was passed --->
<cfif not IsDefined("URL.filmid")>
 <!--- This should never happen --->
 <cflocation url="frame_blank.cfm">
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
 <!--- This should never happen --->
  <cflocation url="frame_blank.cfm">
</cfif>

<!--- Build image paths --->
<cfset image_src="../images/f#movie.FilmID#.gif">
<cfset image_path=ExpandPath(image_src)>

<!--- Create HTML page --->
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

</cfoutput>

</body>
