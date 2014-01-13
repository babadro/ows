<!---
Name:        guess2.cfm
Author:      Ben Forta (ben@forta.com)
Description: if statement demonstration
Created:     07/01/2007
--->

<html>
<head>
 <title>Guess the Number - 2</title>
</head>

<body>

<!--- Pick a random number --->
<cfset RandomNumber=RandRange(1, 10)>

<!--- Check if number was passed --->
<cfif IsDefined("URL.guess")>

 <!--- Yes it was, did it match? --->
 <cfif RandomNumber IS URL.guess>
 <!--- It matched --->
 <cfoutput>
 You got it, I picked #RandomNumber#! Good job!
 </cfoutput>
 <cfelse>
 <!--- No match --->
 <cfoutput>
 Sorry, I picked #RandomNumber#! Try again!
 </cfoutput>
 </cfif>

<cfelse>

 <!--- No guess specified, give instructions --->
 You did not guess a number.<BR>
 To guess a number, reload this page adding
 <B>?guess=n</B> (where n is the guess, for
 example, ?guess=5). Number should be between
 1 and 10.

</cfif>

</body>
</html>
