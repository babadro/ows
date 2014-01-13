<!---
Name:        insert1.cfm
Author:      Ben Forta (ben@forta.com)
Description: Advanced HTML controls
Created:     07/07/07
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
<cfform action="insert2.cfm">

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
   <cfinput type="Text"
            name="MovieTitle"
            message="MOVIE TITLE is required!"
            required="Yes"
            validateAt="onSubmit,onServer"
            size="50"
            maxlength="100">
  </td>
 </tr>
 <tr>
  <td>
   Tag line:
  </td>
  <td>
   <cfinput type="Text"
            name="PitchText"
            message="TAG LINE is required!"
            required="Yes"
            validateAt="onSubmit,onServer"
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
   <cfselect name="RatingID"
             query="ratings"
             display="Rating"
             value="RatingID" />
  </td>
 </tr>
 <tr>
  <td>
   Summary:
  </td>
  <td>
   <cftextarea name="summary"
               richtext="true"
               toolbar="Basic"
               height="150"
               wrap="virtual" />
  </td>
 </tr>
 <tr>
  <td>
   Budget:
  </td>
  <td>
   <cfinput type="Text"
            name="AmountBudgeted"
            message="BUDGET must be a valid numeric amount!"
            required="NO"
            validate="integer"
            validateAt="onSubmit,onServer"
            size="10"
            maxlength="10">
  </td>
 </tr>
 <tr>
  <td>
   Release Date:
  </td>
  <td>
   <cfinput type="DateField"
            name="DateInTheaters"
            message="RELEASE DATE must be a valid date!"
            required="NO"
            validate="date"
            validateAt="onSubmit,onServer"
            size="10"
            maxlength="10">
  </td>
 </tr>
 <tr>
  <td>
   Image File:
  </td>
  <td>
   <cfinput type="Text"
            name="ImageName"
            required="NO"
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

</cfform>

<!--- Page footer --->
<cfinclude template="footer.cfm">
