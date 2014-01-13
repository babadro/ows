<!---
Name:        movies4.cfm
Author:      Ben Forta (ben@forta.com)
Description: Data-driven HTML table
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
<table border="1">
 <cfoutput query="movies">
  <tr>
   <td>#MovieTitle#</td>
   <td>#PitchText#</td>
  </tr>
 </cfoutput>
</table>

</body>
</html>
