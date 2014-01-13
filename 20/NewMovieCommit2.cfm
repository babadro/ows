<!--- 
 Filename: NewMovieCommit2.cfm
 Created by: Nate Weiss (NMW)
 Date Created: 2/18/2001
--->

<!--- Compute Total Budget --->
<!--- First, add the directorÕs salary and miscellaneous expenses --->
<cfset TotalBudget = SESSION.movWiz.miscExpense + SESSION.movWiz.directorSal>
<!--- Now add the salary for each actor in the movie --->
<cfloop list="#SESSION.movWiz.ActorIDs#" index="ThisActor">
 <cfset thisSal = SESSION.movWiz.ActorSals[thisActor]>
 <cfset totalBudget = totalBudget + thisSal>
</cfloop>

<!--- Insert Film Record --->
<cftransaction>
  <cfquery datasource="ows">
   INSERT INTO Films(
   MovieTitle, 
   PitchText, 
   RatingID,
   AmountBudgeted)
   VALUES (
   '#SESSION.movWiz.movieTitle#', 
   '#SESSION.movWiz.pitchText#', 
   #SESSION.movWiz.ratingID#, 
   #totalBudget#)
  </cfquery>
  
  <!--- Get ID number of just-inserted film --->
  <cfquery datasource="ows" name="getNew">
   SELECT Max(FilmID) As NewID FROM Films
  </cfquery>
</cftransaction>

<!--- Insert director record --->
<cfquery datasource="ows">
 INSERT INTO FilmsDirectors(FilmID, DirectorID, Salary)
 VALUES (#getNew.newID#, #SESSION.movWiz.directorID#, #SESSION.movWiz.directorSal#)
</cfquery>

<!--- Insert actor records --->
<cfloop list="#SESSION.movWiz.actorIDs#" index="thisActor">
 <cfset isStar = iif(thisActor EQ SESSION.movWiz.starActorID, 1, 0)>
 <cfquery datasource="ows">
 INSERT INTO FilmsActors(FilmID, ActorID, Salary, IsStarringRole)
 VALUES (#getNew.newID#, #thisActor#, #SESSION.movWiz.actorSals[thisActor]#, #isStar#)
 </cfquery>
</cfloop>

<!--- Remove movWiz variable from SESSION structure --->
<!--- User will be started over on return to wizard --->
<cfset structDelete(SESSION, "movWiz")>


<!--- Display message to user --->
<html>
<head><title>Movie Added</title></head>
<body>
 <h2>Movie Added</h2>
 <p>The movie has been added to the database.</p>

 <!--- Link to go through the wizard again --->
 <p><a href="NewMovieWizard2.cfm">Enter Another Movie</a></p>
</body>
</html>
