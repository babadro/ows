<!---
Name:        movies7.cfm
Author:      Ben Forta (ben@forta.com)
Description: Implementing alternating colors
Created:     07/01/07
--->

<!--- Get movie list from database --->
<cfquery name="movies" datasource="ows">
SELECT MovieTitle, PitchText
FROM Films 
ORDER BY MovieTitle
</cfquery>

<!--- Create HTML page --->
<html>
<head>
 <title>Orange Whip Studios - Movie List</title>
</head>

<body>

<h1>Movie List</h1>

<!--- Display movie list --->
<table>
 <cfoutput query="movies">
  <!--- What color should this row be? --->
   <cfif CurrentRow MOD 2 IS 1>
    <cfset bgcolor="MediumSeaGreen">
   <cfelse>
    <cfset bgcolor="White">
   </cfif>
  <tr bgcolor="#bgcolor#">
   <td>#MovieTitle#</td>
   <td>#PitchText#</td>
  </tr>
 </cfoutput>
</table>

</body>
</html>
