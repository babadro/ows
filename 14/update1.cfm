<!---
Name:        update1.cfm
Author:      Ben Forta (ben@forta.com)
Description: Table row update demo
Created:     07/01/07
--->

<!--- Check that FilmID was provided --->
<cfif NOT IsDefined("URL.FilmID")>
 <h1>You did not specify the FilmID</h1>
 <cfabort>
</cfif>

<!--- Get the film record --->
<cfquery datasource="ows" name="film">
SELECT FilmID, MovieTitle, PitchText,
    AmountBudgeted, RatingID,
    Summary, ImageName, DateInTheaters
FROM Films
WHERE FilmID=#URL.FilmID#
</cfquery>

<!--- Get ratings --->
<cfquery datasource="ows" name="ratings">
SELECT RatingID, Rating
FROM FilmsRatings
ORDER BY RatingID
</cfquery>

<!--- Page header --->
<cfinclude template="header.cfm">

<!--- Update movie form --->
<cfform action="update2.cfm">

<!--- Embed primary key as a hidden field --->
<cfoutput>
<input type="hidden" name="FilmID" value="#Film.FilmID#">
</cfoutput>

<table align="center" bgcolor="orange">
 <tr>
  <th colspan="2">
   <font size="+1">Update a Movie</font>
  </th>
 </tr>
 <tr>
  <td>
   Movie:
  </td>
  <td>
   <cfinput type="Text"
            name="MovieTitle"
            value="#Trim(film.MovieTitle)#"
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
            value="#Trim(film.PitchText)#"
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
   <select name="RatingID">
    <cfoutput query="ratings">
     <option value="#RatingID#"<cfif ratings.RatingID IS film.RatingID>selected</cfif>>#Rating#</option>
    </cfoutput>
   </select>
  </td>
 </tr>
 <tr>
  <td>
   Summary:
  </td>
  <td>
   <cfoutput>
   <textarea name="summary"
             cols="40"
             rows="5"
             wrap="virtual">#Trim(Film.Summary)#</textarea>
   </cfoutput>
  </td>
 </tr>
 <tr>
  <td>
   Budget:
  </td>
  <td>
   <cfinput type="Text"
            name="AmountBudgeted"
            value="#Int(film.AmountBudgeted)#"
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
   <cfinput type="Text"
            name="DateInTheaters"
            value="#DateFormat(film.DateInTheaters, "MM/DD/YYYY")#"
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
            value="#Trim(film.ImageName)#"
            required="NO"
            size="20"
            maxlength="50">
  </td>
 </tr>
 <tr>
  <td colspan="2" align="center">
   <input type="submit" value="Update">
  </td>
   </tr>
</table>

</cfform>

<!--- Page footer --->
<cfinclude template="footer.cfm">
