<!---
Name:        movies.cfc
Author:      Ben Forta (ben@forta.com)
Description: Movie database access component
Created:     07/07/07
--->

<cfcomponent hint="OWS movie database access">

 <!--- Set the datsources --->
 <cfset ds="ows">


 <!--- Get movie list --->
 <cffunction name="list"
             returntype="query"
             hint="List all movies">

  <!--- Create local variables --->
  <cfset var movies="">

  <cfquery datasource="#ds#"
           name="movies">
  SELECT FilmID, MovieTitle, Summary, Rating
  FROM Films, FilmsRatings
  WHERE Films.RatingID=FilmsRatings.RatingID
  ORDER BY MovieTitle
  </cfquery>
  <cfreturn movies>
  
 </cffunction>


 <!--- Browse movies --->
 <cffunction name="browse"
             access="remote"
             returntype="struct"
             hint="Browse method for Ajax grid">
   <cfargument name="page"
               type="numeric"
               required="yes">
   <cfargument name="pageSize"
               type="numeric"
               required="yes">
   <cfargument name="gridsortcolumn"
               type="string"
               required="no"
               default="">
   <cfargument name="gridsortdir"
               type="string"
               required="no"
               default="">

   <!--- Local variables --->
   <cfset var movies="">

   <cfquery datasource="#ds#"
            name="movies">
   SELECT FilmID, MovieTitle, Summary, Rating
   FROM Films, FilmsRatings
   WHERE Films.RatingID=FilmsRatings.RatingID
    <cfif ARGUMENTS.gridsortcolumn NEQ ""
         and ARGUMENTS.gridsortdir NEQ "">
      ORDER BY #ARGUMENTS.gridsortcolumn# #ARGUMENTS.gridsortdir#
    </cfif>
   </cfquery>

   <!--- And return it as a grid structure --->
   <cfreturn QueryConvertForGrid(movies,
                                 ARGUMENTS.page,
                                 ARGUMENTS.pageSize)>
 </cffunction>


 <!--- Lookup used for auto suggest --->
 <cffunction name="lookupMovie"
             access="remote"
             returntype="string"
             hint="Lookup method for Ajax auto-suggest">
   <cfargument name="search"
               type="any"
               required="false"
               default="">

   <!--- Define variables --->
   <cfset var data="">
    
   <!--- Do search --->
   <cfquery datasource="#ds#" name="data">
   SELECT MovieTitle
   FROM Films
   WHERE UCase(MovieTitle) LIKE UCase('#ARGUMENTS.search#%')
   ORDER BY MovieTitle
   </cfquery>
    
   <!--- And return it --->
   <cfreturn ValueList(data.MovieTitle)>
 </cffunction>


 <!--- Get array of ratings types --->
 <cffunction name="getRatings"
             access="remote"
             returnType="query"
             hint="Get ratings for Ajax SELECT">
   <!--- Define variables --->
   <cfset var data="">

   <!--- Get data --->
   <cfquery name="data" datasource="#ds#">
   SELECT RatingID, Rating
   FROM FilmsRatings
   ORDER BY Rating
   </cfquery>
        
   <!--- And return it --->
   <cfreturn data>
 </cffunction>


 <!--- Get films by rating --->
 <cffunction name="getFilms"
             access="remote"
             returnType="query"
             hint="Get films by rating for Ajax SELECT">
   <cfargument name="RatingID"
               type="numeric"
               required="true">

   <!--- Define variables --->
   <cfset var data="">

   <!--- Get data --->
   <cfquery name="data" datasource="#ds#">
   SELECT FilmID, MovieTitle
   FROM Films
   WHERE RatingID = #ARGUMENTS.RatingID#
   ORDER BY MovieTitle
   </cfquery>
	
   <!--- And return it --->
   <cfreturn data>
 </cffunction>


</cfcomponent>