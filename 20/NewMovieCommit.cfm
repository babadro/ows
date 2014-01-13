<!--- 
 Filename: NewMovieCommit.cfm
 Created by: Nate Weiss (NMW)
 Purpose: Inserts new movie and associated records into 
 database. Gets called by NewMovieWizard.cfm 
--->


<!--- Insert film record --->
<cftransaction>
  <cfquery datasource="ows">
   INSERT INTO Films(
   MovieTitle, 
   PitchText, 
   RatingID)
   VALUES (
   '#SESSION.MovWiz.MovieTitle#', 
   '#SESSION.MovWiz.PitchText#', 
   #SESSION.MovWiz.RatingID# )
  </cfquery>
  <!--- Get ID number of just-inserted film --->
  <cfquery datasource="ows" name="getNew">
   SELECT Max(FilmID) As NewID FROM Films
  </cfquery>
</cftransaction>

<!--- Insert director record --->
<cfquery datasource="ows">
 INSERT INTO FilmsDirectors(FilmID, DirectorID, Salary)
 VALUES (#getNew.NewID#, #SESSION.MovWiz.DirectorID#, 0)
</cfquery>
<!--- Insert actor records --->
<cfloop list="#SESSION.movWiz.actorIDs#" index="thisActor">
 <cfset isStar = iif(thisActor eq SESSION.movWiz.starActorID, 1, 0)>
 <cfquery datasource="ows">
 INSERT INTO FilmsActors(FilmID, ActorID, Salary, IsStarringRole)
 VALUES (#getNew.newID#, #thisActor#, 0, #isStar#)
 </cfquery>
</cfloop>


<!--- Remove MovWiz variable from SESSION structure --->
<!--- User will be started over on return to wizard --->
<cfset structDelete(SESSION, "movWiz")>


<!--- Display message to user --->
<html>
<head><title>Movie Added</title></head>
<body>
 <h2>Movie Added</h2>
 <p>The movie has been added to the database.</p>

 <!--- Link to go through the wizard again --->
 <p><a href="NewMovieWizard.cfm">Enter Another Movie</a></p>

</body>
</html>
