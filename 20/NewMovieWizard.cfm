<!--- 
 Filename: NewMovieWizard.cfm
 Created by: Nate Weiss (NMW)
 Please Note Session variables must be enabled
--->

<!--- Total Number of Steps in the Wizard --->
<cfset numberOfSteps = 5>

<!--- The SESSION.movWiz structure holds usersÕ entries --->
<!--- as they move through wizard. Make sure it exists! --->
<cfif not isDefined("SESSION.movWiz")>
 <!--- If structure undefined, create/initialize it --->
 <cfset SESSION.movWiz = structNew()>
 <!--- Represents current wizard step; start at one --->
 <cfset SESSION.movWiz.stepNum = 1>
 <!--- We will collect these from user; start blank --->
 <cfset SESSION.movWiz.movieTitle = "">
 <cfset SESSION.movWiz.pitchText = "">
 <cfset SESSION.movWiz.directorID = "">
 <cfset SESSION.movWiz.ratingID = "">
 <cfset SESSION.movWiz.actorIDs = "">
 <cfset SESSION.movWiz.starActorID = "">
</cfif>


<!--- If user just submitted MovieTitle, remember it --->
<!--- Do same for the DirectorID, Actors, and so on. --->
<cfif isDefined("FORM.movieTitle")>
 <cfset SESSION.movWiz.movieTitle = FORM.movieTitle>
 <cfset SESSION.movWiz.pitchText = FORM.pitchText>
 <cfset SESSION.movWiz.ratingID = FORM.ratingID>
<cfelseif isDefined("FORM.directorID")>
 <cfset SESSION.movWiz.directorID = FORM.directorID>
<cfelseif isDefined("FORM.actorID")>
 <cfset SESSION.movWiz.actorIDs = FORM.actorID>
<cfelseif isDefined("FORM.starActorID")>
 <cfset SESSION.movWiz.starActorID = FORM.starActorID>
</cfif>


<!--- If user clicked "Back" button, go back a step --->
<cfif isDefined("FORM.goBack")>
 <cfset SESSION.movWiz.stepNum = URL.stepNum - 1>
<!--- If user clicked "Next" button, go forward one --->
<cfelseif isDefined("FORM.goNext")>
 <cfset SESSION.movWiz.stepNum = URL.stepNum + 1>
<!--- If user clicked "Finished" button, weÕre done --->
<cfelseif isDefined("FORM.goDone")>
 <cflocation url="NewMovieCommit.cfm">
</cfif>


<html>
<head><title>New Movie Wizard</title></head>
<body>

<!--- Show title and current step --->
<cfoutput>
 <b>New Movie Wizard</b><br>
 Step #SESSION.movWiz.StepNum# of #NumberOfSteps#<br>
</cfoutput>


<!--- Data Entry Form, which submits back to itself --->
<cfform 
 action="NewMovieWizard.cfm?StepNum=#SESSION.movWiz.stepNum#" 
 method="POST">
 
 <!--- Display the appropriate wizard step --->
 <cfswitch expression="#SESSION.movWiz.stepNum#">
 <!--- Step One: Movie Title --->
 <cfcase value="1">
 <!--- Get potential film ratings from database --->
 <cfquery name="getRatings" datasource="ows">
 SELECT RatingID, Rating
 FROM FilmsRatings
 ORDER BY RatingID
 </cfquery>
 
 <!--- Show text entry field for title --->
 What is the title of the movie?<br>
 <cfinput 
 name="MovieTitle" 
 SIZE="50"
 VALUE="#SESSION.movWiz.MovieTitle#">

 <!--- Show text entry field for short description --->
 <p>What is the "pitch" or "one-liner" for the movie?<br>
 <cfinput 
 name="pitchText" 
 size="50"
 value="#SESSION.movWiz.pitchText#">

 <!--- Series of radio buttons for movie rating ---> 
 <p>Please select the rating:<br>
 <cfloop query="getRatings">
 <!--- Re-select this rating if it was previously selected --->
 <cfset isChecked = ratingID EQ SESSION.movWiz.ratingID>
 <!--- Display radio button --->
 <cfinput 
 type="radio"
 name="ratingID"
 checked="#isChecked#"
 value="#ratingID#"><cfoutput>#rating#<br></cfoutput>
 </cfloop> 
 </cfcase> 

 <!--- Step Two: Pick Director --->
 <cfcase value="2">
 <!--- Get list of directors from database --->
 <cfquery name="getDirectors" datasource="ows">
 SELECT DirectorID, FirstName || ' ' || LastName As FullName
 FROM Directors
 ORDER BY LastName
 </cfquery>
 
 <!--- Show all Directors in SELECT list --->
 <!--- Pre-select if user has chosen one --->
 Who will be directing the movie?<br>
 <cfselect
 size="#getDirectors.recordCount#"
 query="getDirectors"
 name="directorID"
 display="fullName"
 value="directorID"
 selected="#SESSION.movWiz.directorID#"/>
 </cfcase> 

 <!--- Step Three: Pick Actors --->
 <cfcase value="3">
 <!--- get list of actors from database --->
 <cfquery name="getActors" datasource="ows">
 SELECT * FROM Actors
 ORDER BY NameLast
 </cfquery>

 What actors will be in the movie?<br>
 <!--- For each actor, display checkbox --->
 <cfloop query="GetActors">
 <!--- Should checkbox be pre-checked? --->
 <cfset isChecked = listFind(SESSION.movWiz.actorIDs, actorID)>
 <!--- Checkbox itself --->
 <cfinput 
 type="checkbox"
 name="actorID"
 value="#actorID#"
 checked="#isChecked#">
 <!--- Actor name --->
 <cfoutput>#nameFirst# #nameLast#</cfoutput><br>
 </cfloop> 
 </cfcase> 

 <!--- Step Four: Who is the star? --->
 <cfcase value="4">
 <cfif SESSION.movWiz.actorIDs EQ "">
 Please go back to the last step and choose at least one
 actor or actress to be in the movie. 
 <cfelse>
 <!--- Get actors who are in the film --->
 <cfquery name="getActors" DATASOURCE="ows">
 SELECT * FROM Actors
 WHERE ActorID IN (#SESSION.movWiz.ActorIDs#)
 ORDER BY NameLast
 </cfquery>
 
 Which one of the actors will get top billing?<br> 
 <!--- For each actor, display radio button --->
 <cfloop query="getActors">
 <!--- Should radio be pre-checked? --->
 <cfset isChecked = SESSION.movWiz.starActorID EQ actorID>
 <!--- Radio button itself --->
 <cfinput 
 type="radio"
 name="starActorID"
 value="#actorID#"
 checked="#isChecked#">
 <!--- Actor name --->
 <cfoutput>#nameFirst# #nameLast#</cfoutput><br>
 </cfloop> 
 </cfif>
 </cfcase> 
 
 <!--- Step Five: Final Confirmation --->
 <cfcase value="5">
 You have successfully finished the New Movie Wizard.<br>
 Click the Finish button to add the movie to the database.<br>
 Click Back if you need to change anything.<br>
 </cfcase> 
 </cfswitch>
 

 <p>
 <!--- Show Back button, unless at first step ---> 
 <cfif SESSION.movWiz.stepNum GT 1>
 <input type="submit" name="goBack" value="&lt;&lt; Back">
 </cfif> 
 <!--- Show Next button, unless at last step --->
 <!--- If at last step, show "Finish" button --->
 <cfif SESSION.movWiz.stepNum lt numberOfSteps>
 <input type="submit" name="goNext" value="Next &gt;&gt;">
 <CFELSE>
 <input type="submit" name="goDone" value="Finish">
 </cfif>
</cfform>

</body>
</html>
