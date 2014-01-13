<!---
Name:        results3.cfm
Author:      Ben Forta (ben@forta.com)
Description: Creating search screens
Created:     07/01/07
--->

<!--- Get movie list from database --->
<cfquery name="movies" datasource="ows">
SELECT MovieTitle, PitchText, Summary, DateInTheaters
FROM Films
WHERE 0=0
<!--- Search by movie title --->
<cfif FORM.MovieTitle IS NOT "">
 AND MovieTitle LIKE '%#FORM.MovieTitle#%'
</cfif>
<!--- Search by tag line --->
<cfif FORM.PitchText IS NOT "">
 AND PitchText LIKE '%#FORM.PitchText#%'
</cfif>
<!--- Search by rating --->
<cfif FORM.RatingID IS NOT "">
 AND RatingID = #FORM.RatingID#
</cfif>
ORDER BY MovieTitle
</cfquery>

<!--- Create HTML page --->
<html>
<head>
 <title>Orange Whip Studios - Movies</title>
</head>

<body>

<!--- Page header --->
<cfinclude template="header.cfm">

<!--- Display movie list --->
<table>
 <tr>
  <th colspan="2">
   <cfoutput>
   <font size="+3">Movie List (#Movies.RecordCount# movies)</font>
   </cfoutput>
  </th>
 </tr>
 <cfoutput query="movies">
  <tr>
   <td>
    <font size="+2"><strong>#CurrentRow#: #MovieTitle#</strong></font><br>
    <font size="+1"><em>#PitchText#</em></font>
   </td>
   <td>Released: #DateFormat(DateInTheaters)#</td>
  </tr>
  <tr>
   <td colspan="2">#Summary#</td>
  </tr>
 </cfoutput>
</table>

</body>
</html>
