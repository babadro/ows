<!---
Name:        movies.cfm
Author:      Ben Forta (ben@forta.com)
Description: CFC driven data drill-down
Created:     07/01/07
--->

<!--- Get movie list --->
<cfinvoke 
 component="movies"
 method="List"
 returnvariable="movies">

<!--- Create HTML page --->
<html>
<head>
 <title>Orange Whip Studios - Movie List</title>
</head>

<body>

<!--- Start table --->
<table>
 <tr>
  <th colspan="2">
   <font size="+2">
   <cfoutput>
   Movie List (#Movies.RecordCount# movies)
   </cfoutput>
   </font>
  </th>
 </tr>
 <!--- loop through movies --->
 <cfoutput query="movies">
  <tr bgcolor="##cccccc">
   <td>
    <strong>
    #CurrentRow#:
    <a href="details.cfm?FilmID=#URLEncodedFormat(Trim(FilmID))#">#MovieTitle#</a>
    </strong>
    <br>
    #PitchText#
   </td>
   <td>
    #DateFormat(DateInTheaters)#
   </td>
  </tr>
  <tr>
   <td colspan="2">
    <font size="-2">#Summary#</font>
   </td>
  </tr>
 </cfoutput>
 <!--- End of movie loop --->
</table>

</body>
</html>
