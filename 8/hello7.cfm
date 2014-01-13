<!---
Name:        hello7.cfm
Author:      Ben Forta (ben@forta.com)
Description: Demonstrate use of comments
Created:     07/01/2007
--->

<html>
<head>
 <title>Hello 7</title>
</head>

<body>

<!--- Save name --->
<cfset firstName="ben">

<!--- Save converted versions of name --->
<cfset upperFirstname=UCase(firstName)>
<cfset lowerFirstname=LCase(firstName)>
<cfset reverseFirstname=Reverse(firstName)>
<!--- Save name length --->
<cfset lenFirstName=Len(firstName)>
<!--- Save repeated name --->
<cfset repeatFirstName=RepeatString(firstName, 3)>

<!--- Display output --->
<cfoutput>
Hello #FirstName#, and welcome to ColdFusion!<p>
Your name in uppercase: #upperFirstName#<br>
Your name in lowercase: #lowerFirstName#<br>
Your name in reverse: #reverseFirstName#<br>
Characters in your name: #lenFirstName#<br>
Your name 3 times: #repeatFirstName#<br>
</cfoutput>

</body>
</html>
