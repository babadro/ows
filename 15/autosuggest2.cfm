<!---
Name:        autosuggest2.cfm
Author:      Ben Forta (ben@forta.com)
Description: Ajax auto-suggest
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
   Movie:
  </td>
  <td>
   <cfinput type="Text"
            name="MovieTitle"
            autosuggest="cfc:movies.lookupMovie({cfautosuggestvalue})"
            size="50"
            maxlength="100">
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
