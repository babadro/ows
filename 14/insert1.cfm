<!---
Name:        insert1.cfm
Author:      Ben Forta (ben@forta.com)
Description: Table row insertion demo
Created:     07/01/07
--->

<!--- Get ratings --->
<cfquery datasource="ows" name="ratings">
SELECT RatingID, Rating
FROM FilmsRatings
ORDER BY RatingID
</cfquery>

<!--- Page header --->
<cfinclude template="header.cfm">

<!--- New movie form --->
<form action="insert2.cfm" method="post">

<table align="center" bgcolor="orange">
 <tr>
  <th colspan="2">
   <font size="+1">Add a Movie</font>
  </th>
 </tr>
 <tr>
  <td>
   Movie:
  </td>
  <td>
   <input type="Text"
          name="MovieTitle"
          size="50"
          maxlength="100">
  </td>
 </tr>
 <tr>
  <td>
   Tag line:
  </td>
  <td>
   <input type="Text"
          name="PitchText"
          size="50"
          maxlength="100">
  </td>
 </tr>
 <tr>
  <td>
   Rating:
  </td>
  <td>
   <!--- Ratings list --->
   <select name="RatingID">
    <cfoutput query="ratings">
     <option value="#RatingID#">#Rating#</option>
    </cfoutput>
   </select>
  </td>
 </tr>
 <tr>
  <td>
   Summary:
  </td>
  <td>
   <textarea name="summary"
             cols="40"
             rows="5"
             wrap="virtual"></textarea>
  </td>
 </tr>
 <tr>
  <td>
   Budget:
  </td>
  <td>
   <input type="Text"
          name="AmountBudgeted"
          size="10"
          maxlength="10">
  </td>
 </tr>
 <tr>
  <td>
   Release Date:
  </td>
  <td>
   <input type="Text"
          name="DateInTheaters"
          size="10"
          maxlength="10">
  </td>
 </tr>
 <tr>
  <td>
   Image File:
  </td>
  <td>
   <input type="Text"
          name="ImageName"
          size="20"
          maxlength="50">
  </td>
 </tr>
 <tr>
  <td colspan="2" align="center">
   <input type="submit" value="Insert">
  </td>
   </tr>
</table>

</form>

<!--- Page footer --->
<cfinclude template="footer.cfm">
