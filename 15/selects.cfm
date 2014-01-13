<!---
Name:        selects.cfm
Author:      Ben Forta (ben@forta.com)
Description: Related SELECT controls
Created:     07/07/07
--->

<!--- Page header --->
<cfinclude template="header.cfm">

<!--- Search form --->
<cfform>

<table align="center" bgcolor="orange">
 <tr>
  <th colspan="2">
   <font size="+1">Find a Movie</font>
  </th>
 </tr>
 <tr>
  <td>
   Rating:<br>
   <cfselect name="RatingID"
             bind="cfc:movies.getRatings()"
             display="Rating"
             value="RatingID"
             bindonload="true" />
  </td>
  <td>
   Movie:<br>
   <cfselect name="FilmID"
             bind="cfc:movies.getFilms({RatingID})"
             display="MovieTitle"
             value="FilmID" />
  </td>
 </tr>
 <tr>
  <td colspan="2" align="center">
   <input type="submit" value="Search">
  </td>
   </tr>
</table>

</cfform>


<!--- Page footer --->
<cfinclude template="footer.cfm">
