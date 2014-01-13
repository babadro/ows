<!---
Name:        guess4.cfm
Author:      Ben Forta (ben@forta.com)
Description: if statement demonstration
Created:     07/01/2007
--->

<html>
<head>
 <title>Guess the Number - 4</title>
</head>

<body>

<!--- Set range --->
<cfset GuessLow=1>
<cfset GuessHigh=10>

<!--- Pick a random number --->
<cfset RandomNumber=RandRange(GuessLow, GuessHigh)>

<!--- Was a guess specified? --->
<cfset HaveGuess=IsDefined("URL.guess")>

<!--- If specified, did it match? --->
<cfset Match=(HaveGuess)
       AND (RandomNumber IS URL.guess)>

<!--- Feedback --->
<cfoutput>
<cfif Match>
 <!--- It matched --->
 You got it, I picked #RandomNumber#! Good job!
<cfelseif HaveGuess>
 <!--- Did not match --->
 Sorry, I picked #RandomNumber#! Try again!
<cfelse>
 <!--- No guess specified, give instructions --->
 You did not guess a number.<BR>
 To guess a number, reload this page adding
 <B>?guess=n</B> (where n is the guess, for
 example, ?guess=5). Number should be between
 #GuessLow# and #GuessHigh#.
</cfif>
</cfoutput>

</body>
</html>
