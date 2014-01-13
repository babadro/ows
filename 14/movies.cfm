<!---
Name:        movies.cfm
Author:      Ben Forta (ben@forta.com)
Description: Movie maintenance application
Created:     07/01/07
--->

<!--- Get all movies --->
<cfinvoke component="movies"
          method="list"
          returnvariable="movies">

<!--- Page header --->
<cfinclude template="header.cfm">

<table align="center" bgcolor="orange">

 <!--- Loop through movies --->
 <cfoutput query="movies">
  <tr>
   <!--- Movie name --->
   <td><strong>#MovieTitle#</strong></td>
   <!--- Edit link --->
   <td>
    [<a href="movie_edit.cfm?FilmID=#FilmID#">Edit</a>]
   </td>
   <!--- Delete link --->
   <td>
    [<a href="movie_delete.cfm?FilmID=#FilmID#">Delete</a>]
   </td>
  </tr>
 </cfoutput>

 <tr>
  <td></td>
  <!--- Add movie link --->
  <td colspan="2" align="center">
   [<a href="movie_edit.cfm">Add</a>]
  </td>
 </tr>

</table>

<!--- Page footer --->
<cfinclude template="footer.cfm">
