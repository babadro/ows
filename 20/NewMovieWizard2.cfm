<!--- 
 Filename: NewMovieWizard2.cfm
 Created by: Nate Weiss (NMW)
 Please Note Session variables must be enabled
--->

<!--- Total Number of Steps in the Wizard --->
<cfset NumberOfSteps = 6>

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
 <cfset SESSION.movWiz.directorSal = "">
 <cfset SESSION.movWiz.ratingID = "">
 <cfset SESSION.movWiz.actorIDs = "">
 <cfset SESSION.movWiz.staractorID = "">
 <cfset SESSION.movWiz.miscExpense = "">
 <cfset SESSION.movWiz.actorSals = structNew()>
</cfif>


<!--- If user just submitted movieTitle, remember it --->
<!--- Do same for the directorID, Actors, and so on. --->
<cfif isDefined("Form.movieTitle")>
 <cfset SESSION.movWiz.movieTitle = Form.movieTitle>
 <cfset SESSION.movWiz.pitchText = Form.pitchText>
 <cfset SESSION.movWiz.ratingID = FORM.ratingID>
<cfelseif isDefined("Form.directorID")>
 <cfset SESSION.movWiz.directorID = Form.directorID>
<cfelseif isDefined("Form.actorID")>
 <cfset SESSION.movWiz.actorIDs = Form.actorID>
<cfelseif isDefined("Form.starActorID")>
 <cfset SESSION.movWiz.starActorID = Form.starActorID>
<cfelseif isDefined("Form.directorSal")>
 <cfset SESSION.movWiz.directorSal = Form.directorSal>
 <cfset SESSION.movWiz.miscExpense = Form.miscExpense>
 <!--- For each actor now in the movie, save their salary --->
 <cfloop LIST="#SESSION.movWiz.actorIDs#" index="thisActor">
 <cfset SESSION.movWiz.actorSals[thisActor] = FORM["actorSal#thisActor#"]>
 </cfloop>
</cfif>


<!--- If user clicked "Back" button, go back a step --->
<cfif isDefined("FORM.goBack")>
 <cfset SESSION.movWiz.stepNum = URL.stepNum - 1>
<!--- If user clicked "Next" button, go forward one --->
<cfelseif isDefined("FORM.goNext")>
 <cfset SESSION.movWiz.stepNum = URL.stepNum + 1>
<!--- If user clicked "Finished" button, weÕre done --->
<cfelseif isDefined("FORM.goDone")>
 <cflocation url="NewMovieCommit2.cfm">
</cfif>


<html>
<head><title>New Movie Wizard</title></head>
<body>

<!--- Show title and current step --->
<cfoutput>
 <b>New Movie Wizard</b><br>
 Step #SESSION.movWiz.stepNum# of #numberOfSteps#<br>
</cfoutput>


<!--- Data Entry Form, which submits back to itself --->
<cfform 
 action="NewMovieWizard2.cfm?StepNum=#SESSION.movWiz.StepNum#" 
 method="POST">
 <!--- Display the appropriate wizard step --->
 <cfswitch expression="#SESSION.movWiz.stepNum#">
 <!--- Step One: Movie Title --->
 <cfcase value="1">
 <!--- Get potential film ratings from database --->
 <cfquery name="getRatings" datasource="ows">
 SELECT ratingID, Rating
 FROM FilmsRatings
 ORDER BY ratingID
 </cfquery> 
 
 <!--- Show text entry field for title --->
 What is the title of the movie?<br>
 <cfinput 
 name="movieTitle" 
 size="50"
 required="Yes"
 message="Please donÕt leave the movie title blank."
 value="#SESSION.movWiz.movieTitle#">

 <!--- Show text entry field for title --->
 <p>What is the "pitch" or "one-liner" for the movie?<br>
 <cfinput 
 name="pitchText" 
 size="50"
 required="Yes"
 message="Please provide the pitch text first."
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
 SELECT directorID, FirstName || ' ' || LastName As FullName
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
 required="Yes"
 message="You must choose a director first."
 selected="#SESSION.movWiz.directorID#"/>
 </cfcase> 

 <!--- Step Three: Pick Actors --->
 <cfcase value="3">
 <!--- Get list of actors from database --->
 <cfquery name="getActors" datasource="ows">
 SELECT * FROM Actors
 ORDER BY NameLast
 </cfquery>

 What actors will be in the movie?<br>
 <!--- For each actor, display checkbox --->
 <cfloop query="getActors">
 <!--- Should checkbox be pre-checked? --->
 <cfset isChecked = listFind(SESSION.movWiz.actorIDs, actorID)>
 <!--- Checkbox itself --->
 <cfinput 
 type="checkbox"
 name="actorID"
 value="#actorID#"
 required="Yes"
 message="You must choose at least one actor first."
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
 <cfquery name="getActors" datasource="ows">
 SELECT * FROM Actors
 WHERE actorID IN (#SESSION.movWiz.actorIDs#)
 ORDER BY NameLast
 </cfquery>
 
 Which one of the actors will get top billing?<br> 
 <!--- For each actor, display radio button --->
 <cfloop query="getActors">
 <!--- Should radio be pre-checked? --->
 <cfset isChecked = SESSION.movWiz.StaractorID EQ actorID>
 <!--- Radio button itself --->
 <cfinput 
 type="radio"
 name="staractorID"
 value="#actorID#"
 required="Yes"
 message="Please select the starring actor first."
 checked="#isChecked#">
 <!--- Actor name --->
 <cfoutput>#NameFirst# #NameLast#</cfoutput><br>
 </cfloop> 
 </cfif>
 </cfcase> 

 
 <!--- Step Five: Expenses and Salaries --->
 <cfcase value="5">
 <!--- Get actors who are in the film --->
 <cfquery name="getActors" datasource="ows">
 SELECT * FROM Actors
 WHERE actorID IN (#SESSION.movWiz.actorIDs#)
 ORDER BY NameLast
 </cfquery>

 <!--- DirectorÕs Salary --->
 <p>How much will we pay the Director?<br>
 <cfinput 
 type="text"
 size="10"
 name="directorSal"
 required="Yes"
 validate="float"
 message="Please provide a number for the directorÕs salary."
 value="#SESSION.movWiz.directorSal#">
 
 <!--- Salary for each actor --->
 <p>How much will we pay the Actors?<br>
 <cfloop query="getActors">
 <!--- Grab actorsÕs salary from ActorSals structure --->
 <!--- Initialize to "" if no salary for actor yet --->
 <cfif not structKeyExists(SESSION.movWiz.actorSals, actorID)>
 <cfset SESSION.movWiz.actorSals[actorID] = "">
 </cfif>
 <!--- Text field for actorÕs salary --->
 <cfinput 
 type="text"
 size="10"
 name="actorSal#actorID#"
 required="Yes"
 validate="float"
 message="Please provide a number for each actorÕs salary."
 value="#SESSION.movWiz.actorSals[actorID]#">
 <!--- ActorÕs name --->
 <cfoutput>for #nameFirst# #nameLast#<br></cfoutput>
 </cfloop> 
 
 <!--- Additional Expenses --->
 <p>How much other money will be needed for the budget?<br>
 <cfinput 
 type="text"
 name="miscExpense"
 required="Yes"
 validate="float"
 message="Please provide a number for additional expenses."
 size="10"
 value="#SESSION.movWiz.miscExpense#">
 </cfcase>
 
 
 <!--- Step Six: Final Confirmation --->
 <cfcase value="6">
 You have successfully finished the New Movie Wizard.<br>
 Click the Finish button to add the movie to the database.<br>
 Click Back if you need to change anything.<br>
 </cfcase> 
 </cfswitch>
 

 <p>
 <!--- Show Back button, unless at first step ---> 
 <cfif SESSION.movWiz.stepNum gt 1>
 <INPUT type="Submit" NAME="goBack" value="&lt;&lt; Back">
 </cfif> 
 <!--- Show Next button, unless at last step --->
 <!--- If at last step, show "Finish" button --->
 <cfif SESSION.movWiz.stepNum lt numberOfSteps>
 <INPUT type="Submit" NAME="goNext" value="Next &gt;&gt;">
 <cfelse>
 <INPUT type="Submit" NAME="goDone" value="Finish">
 </cfif>
</cfform>

</body>
</html>
