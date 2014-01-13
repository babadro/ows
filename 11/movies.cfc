<!--- Movie component --->
<cfcomponent hint="Movie database abstraction">

 <!--- List method --->
 <cffunction name="List" access="public" returnType="query" output="false" hint="List all movies">

  <!--- Define local variables --->
  <cfset var movies="">

  <!--- Get movie list from database --->
  <cfquery name="movies" datasource="ows">
  SELECT FilmID, MovieTitle, PitchText,
         Summary, DateInTheaters
  FROM Films 
  ORDER BY MovieTitle
  </cfquery>

  <cfreturn movies>

 </cffunction>

 <!--- GetDetails method --->
 <cffunction name="GetDetails" access="public" returnType="query" output="false" hint="Get movie details for a specific movie">
  <cfargument name="FilmID" type="numeric" required="true" hint="Film ID">

  <!--- Define local variables --->
  <cfset var movie="">

  <!--- Get a movie from database --->
  <cfquery name="movie" datasource="ows">
  SELECT FilmID, MovieTitle,
         PitchText, Summary,
         DateInTheaters, AmountBudgeted
  FROM Films
  WHERE FilmID=#ARGUMENTS.FilmID#
  </cfquery>
  
  <cfreturn movie>
  
</cffunction>

</cfcomponent>
