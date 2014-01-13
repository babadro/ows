<!---
Name:        search3.cfm
Author:      Ben Forta (ben@forta.com)
Description: Creating search screens
Created:     07/01/07
--->

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
    <option value="1">General</option>
    <option value="2">Kids</option>
    <option value="3">Accompanied Minors</option>
    <option value="4">Teens</option>
    <option value="5">Adults</option>
    <option value="6">Mature Audiences</option>
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
