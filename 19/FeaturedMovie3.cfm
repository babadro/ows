<!--- 
 Filename: FeaturedMovie.cfm
 Created by: Nate Weiss (NMW)
 Purpose: Displays a single movie on the page, on a rotating basis
 Please Note Application variables must be enabled
--->

<!--- We want to obtain an exclusive lock if this --->
<!--- is the first time this template has executed, --->
<!--- or the time for this featured movie has expired --->
<cfif (not isDefined("APPLICATION.movieRotation"))
 or (dateCompare(APPLICATION.movieRotation.currentUntil, now()) eq -1)>

  <!--- Make sure all requests wait for this block --->
  <!--- to finish before displaying the featured movie --->
  <cflock scope="APPLICATION" type="Exclusive" timeout="10">
 
       <!--- If this is the first time the template has executed... --->
       <cfif not isDefined("APPLICATION.movieRotation")>
       
              <!--- Get all current FilmIDs from the database --->
              <cfquery name="GetFilmIDs" datasource="#REQUEST.dataSource#">
              SELECT FilmID FROM Films
              ORDER BY MovieTitle
              </cfquery>
              
              <!--- Create structure for rotating featured movies --->
              <cfset st = structNew()>
              <cfset st.movieList = valueList(getFilmIDs.FilmID)>
              <cfset st.currentPos = 1>
              
              <!--- Place structure into APPLICATION scope --->
              <cfset APPLICATION.movieRotation = st>
 
  <!--- ...otherwise, the time for the featured movie has expired --->
  <cfelse>
    <!--- Shorthand name for structure in application scope --->
    <cfset st = APPLICATION.movieRotation>
 
    <!--- If we havenÕt gotten to the last movie yet --->
    <cfif st.currentPos lt listLen(st.movieList)>
      <cfset st.currentPos = st.currentPos + 1>
    <!--- if already at last movie, start over at beginning ---> 
    <cfelse>
      <cfset st.currentPos = 1> 
    </cfif>
 
  </cfif>
 
  <!--- In any case, choose the movie at the current position in list --->
  <cfset st.currentMovie = listGetAt(st.movieList, st.currentPos)>
  <!--- This featured movie should "expire" a short time from now --->
  <cfset st.currentUntil = dateAdd("s", 5, now())> 
  </cflock>

</cfif>

<!--- Use a ReadOnly lock to grab current movie from application scope... --->
<!--- If the exclusive block above is current executing in another thread, --->
<!--- then ColdFusion will ÔwaitÕ before executing the code in this block. --->
<cflock scope="APPLICATION" type="ReadOnly" timeout="10">
  <cfset thisMovieID = APPLICATION.movieRotation.currentMovie>
</cflock>


<!--- Now that we have chosen the film to "Feature", --->
<!--- Get all important info about it from database. --->
<cfquery name="GetFilm" datasource="#REQUEST.dataSource#">
 SELECT 
 MovieTitle, Summary, Rating, 
 AmountBudgeted, DateInTheaters
 FROM Films f, FilmsRatings r
 WHERE FilmID = #thisMovieID#
 AND f.RatingID = r.RatingID
</cfquery>

<!--- Now Display Our Featured Movie --->
<cfoutput>
 <!--- Define formatting for our "feature" display --->
 <style type="text/css">
 TH.fm { background:RoyalBlue;color:white;text-align:left;
 font-family:sans-serif;font-size:10px} 
 TD.fm { background:LightSteelBlue;
 font-family:sans-serif;font-size:12px} 
 </style>

 <!--- Show info about featured movie in HTML Table --->
 <table width="150" align="right" border="0" cellspacing="0">
 <tr><th class="fm">
 Featured Film
 </th></tr>
 <!--- Movie Title, Summary, Rating --->
 <tr><td class="fm">
 <b>#getFilm.MovieTitle#</b><br>
 #getFilm.Summary#<br>
 <p align="right">Rated: #getFilm.Rating#</p>
 </td></tr>
 <!--- Cost (rounded to millions), release date --->
 <tr><th class="fm">
 Production Cost $#round(val(getFilm.AmountBudgeted) / 1000000)# Million<br>
 In Theaters #dateFormat(getFilm.DateInTheaters, "mmmm d")#<br>
 </th></tr>
 </table>
 <br clear="all">
</cfoutput>
