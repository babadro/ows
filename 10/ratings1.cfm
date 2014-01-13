<!---
Name:        ratings1.cfm
Author:      Ben Forta (ben@forta.com)
Description: Query output grouping
Created:     07/01/07
--->

<!--- Get movie list from database --->
<cfquery name="movies" datasource="ows">
SELECT MovieTitle, RatingID
FROM Films 
ORDER BY RatingID, MovieTitle
</cfquery>

<!--- Create HTML page --->
<html>
<head>
 <title>Orange Whip Studios - Movie List</title>
</head>

<body>

<h1>Movie List</h1>

<!--- Display movie list --->
<ul>
 <!--- Loop through ratings --->
 <cfoutput query="movies" group="RatingID">
  <li>#RatingID#</li>
  <ul>
   <!--- For each rating, list movies --->
   <cfoutput>
    <li>#MovieTitle#</li>
   </cfoutput>
  </ul>
 </cfoutput>
</ul>

</body>
</html>
