<!---
Name:        search4.cfm
Author:      Ben Forta (ben@forta.com)
Description: Creating search screens
Created:     07/01/07
--->

<!--- Get ratings --->
<cfquery datasource="ows" name="ratings">
SELECT RatingID, Rating
FROM FilmsRatings
ORDER BY RatingID
</cfquery>

<html>

<head>
 <title>Orange Whip Studios - Movies</title>
</head>

<body>

<!--- Page header --->
<cfinclude template="header.cfm">

<!--- Search form --->
<form action="results3.cfm" method="POST">

<table align="center" border="1">
 <tr>
  <td>
  Movie:
  </td>
  <td>
  <input type="text" name="MovieTitle">
  </td>
 </tr>
 <tr>
  <td>
  Tag line:
  </td>
  <td>
  <input type="text" name="PitchText">
  </td>
 </tr>
 <tr>
  <td>
  Rating:
  </td>
  <td>
  <select name="RatingID">
   <option value=""></option>
   <cfoutput query="ratings">
    <option value="#RatingID#">#Rating#</option>
   </cfoutput>
  </select>
  </td>
 </tr>
 <tr>
  <td colspan="2" align="center">
  <input type="submit" value="Search">
  </td>
 </tr>
</table>

</form>

</body>

</html>
