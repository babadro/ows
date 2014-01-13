<html>
<head>
   <title>Hello 6</title>
</head>

<body>

<cfset FirstName="Ben">
<cfset UpperFirstName=UCase(FirstName)>
<cfset LowerFirstName=LCase(FirstName)>
<cfset ReverseFirstName=Reverse(FirstName)>
<cfset LenFirstName=Len(FirstName)>
<cfset RepeatFirstName=RepeatString(firstName, 3)>

<cfoutput>
Hello #FirstName#, and welcome to ColdFusion!<p>
Your name in uppercase: #UpperFirstName#<br>
Your name in lowercase: #LowerFirstName#<br>
Your name in reverse: #ReverseFirstName#<br>
Characters in your name: #LenFirstName#<br>
Your name 3 times: #RepeatFirstName#<br>
</cfoutput>

</body>
</html>
