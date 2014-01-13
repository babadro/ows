<!---
Name:        movie_process.cfm
Author:      Ben Forta (ben@forta.com)
Description: Process edit page
Created:     07/01/07
--->

<!--- Edit or update? --->
<cfif IsDefined("FORM.FilmID")>
 <cfset method="update">
<cfelse>
 <cfset method="add">
</cfif>

<!--- Do it --->
<cfinvoke component="movies"
          method="#method#">
 <!--- FilmID only if update method --->
  <cfif IsDefined("FORM.FilmID")>
  <cfinvokeargument name="FilmID"
                    value="#FORM.FilmID#">
 </cfif>
 <cfinvokeargument name="MovieTitle"
                   value="#Trim(FORM.MovieTitle)#">
 <cfinvokeargument name="PitchText"
                   value="#Trim(FORM.PitchText)#">
 <cfinvokeargument name="AmountBudgeted"
                   value="#Int(FORM.AmountBudgeted)#">
 <cfinvokeargument name="RatingID"
                   value="#Int(FORM.RatingID)#">
 <cfinvokeargument name="Summary"
                   value="#Trim(FORM.Summary)#">
 <cfinvokeargument name="ImageName"
                   value="#Trim(FORM.ImageName)#">
 <cfinvokeargument name="DateInTheaters"
                   value="#DateFormat(FORM.DateInTheaters)#">
</cfinvoke>

<!--- When done go back to movie list --->
<cflocation url="movies.cfm">
