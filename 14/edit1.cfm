<!---
Name:        edit1.cfm
Author:      Ben Forta (ben@forta.com)
Description: Dual purpose form demo
Created:     07/01/07
--->

<!--- Check that FilmID was provided --->
<!--- If yes, edit, else add --->
<cfset EditMode=IsDefined("URL.FilmID")>

<!--- If edit mode then get row to edit --->
<cfif EditMode>

 <!--- Get the film record --->
 <cfquery datasource="ows" name="film">
 SELECT FilmID, MovieTitle, PitchText,
        AmountBudgeted, RatingID,
        Summary, ImageName, DateInTheaters
 FROM Films
 WHERE FilmID=#URL.FilmID#
 </cfquery>

 <!--- Save to variables --->
 <cfset MovieTitle=Trim(film.MovieTitle)>
 <cfset PitchText=Trim(film.PitchText)>
 <cfset AmountBudgeted=Int(film.AmountBudgeted)>
 <cfset RatingID=film.RatingID>
 <cfset Summary=Trim(film.Summary)>
 <cfset ImageName=Trim(film.ImageName)>
 <cfset DateInTheaters=DateFormat(film.DateInTheaters, "MM/DD/YYYY")>
 
 <!--- Form text --->
 <cfset FormTitle="Update a Movie">
 <cfset ButtonText="Update">
 
<cfelse>

 <!--- Save to variables --->
 <cfset MovieTitle="">
 <cfset PitchText="">
 <cfset AmountBudgeted="">
 <cfset RatingID="">
 <cfset Summary="">
 <cfset ImageName="">
 <cfset DateInTheaters="">

 <!--- Form text --->
 <cfset FormTitle="Add a Movie">
 <cfset ButtonText="Insert">

</cfif>

<!--- Get ratings --->
<cfquery datasource="ows" name="ratings">
SELECT RatingID, Rating
FROM FilmsRatings
ORDER BY RatingID
</cfquery>

<!--- Page header --->
<cfinclude template="header.cfm">

<!--- Add/update movie form --->
<cfform action="edit2.cfm">

<cfif EditMode>
 <!--- Embed primary key as a hidden field --->
 <cfinput type="hidden" name="FilmID" value="#Film.FilmID#">
</cfif>

<table align="center" bgcolor="orange">
 <tr>
  <th colspan="2">
   <cfoutput>
   <font size="+1">#FormTitle#</font>
   </cfoutput>
  </th>
 </tr>
 <tr>
  <td>
   Movie:
  </td>
  <td>
   <cfinput type="Text"
            name="MovieTitle"
            value="#MovieTitle#"
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
            value="#PitchText#"
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
     <option value="#RatingID#" <cfif ratings.RatingID IS VARIABLES.RatingID>selected</cfif>>#Rating#</option>
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
             wrap="virtual">#Summary#</textarea>
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
            value="#AmountBudgeted#"
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
            value="#DateInTheaters#"
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
            value="#ImageName#"
            required="NO"
            size="20"
            maxlength="50">
  </td>
 </tr>
 <tr>
  <td colspan="2" align="center">
   <cfoutput>
   <input type="submit" value="#ButtonText#">
   </cfoutput>
  </td>
   </tr>
</table>

</cfform>

<!--- Page footer --->
<cfinclude template="footer.cfm">
