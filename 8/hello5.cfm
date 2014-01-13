<html>
<head>
   <title>Hello 5</title>
</head>

<body>

<cfset FirstName="Ben">
<cfoutput>
Hello #FirstName#, and welcome to ColdFusion!<p>
Your name in uppercase: #UCase(FirstName)#<br>
Your name in lowercase: #LCase(FirstName)#<br>
Your name in reverse: #Reverse(FirstName)#<br>
Characters in your name: #Len(FirstName)#<br>
Your name 3 times: #RepeatString(FirstName, 3)#<br>
</cfoutput>

</body>
</html>
