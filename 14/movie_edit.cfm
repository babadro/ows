<!---
Name:        movie_edit.cfm
Author:      Ben Forta (ben@forta.com)
Description: Dual purpose movie edit form
Created:     07/01/07
--->

<!--- Check that FilmID was provided --->
<!--- If yes, edit, else add --->
<cfset EditMode=IsDefined("URL.FilmID")>

<!--- If edit mode then get row to edit --->
<cfif EditMode>

 <!--- Get the film record --->
 <cfinvoke component="movies"
           method="get"
           filmid="#URL.FilmID#"
           returnvariable="film">

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
 <cfinvoke component="movies"
           method="getRatings"
           returnvariable="ratings">

<!--- Page header --->
<cfinclude template="header.cfm">

<!--- Add/update movie form --->
<cfform action="movie_process.cfm">

<cfif EditMode>
 <!--- Embed primary key as a hidden field --->
 <cfoutput>
 <input type="hidden" name="FilmID" value="#Film.FilmID#">
 </cfoutput>
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
   <cfselect name="RatingID"
             query="ratings"
             value="RatingID"
             display="Rating"
             selected="#VARIABLES.RatingID#">
   </cfselect>
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
