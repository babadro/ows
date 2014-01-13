<!---
Name:        movies8.cfm
Author:      Ben Forta (ben@forta.com)
Description: Data drill-down
Created:     07/01/07
--->

<!--- Get movie list from database --->
<cfquery name="movies" datasource="ows" result="result">
SELECT FilmID, MovieTitle, PitchText,
       Summary, DateInTheaters
FROM Films 
ORDER BY MovieTitle
</cfquery>

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
   Movie List (#result.RecordCount# movies)
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
    <a href="details3.cfm?FilmID=#URLEncodedFormat(Trim(FilmID))#">#MovieTitle#</a>
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
