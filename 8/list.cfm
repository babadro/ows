<html>
<head>
   <title>List Example</title>
</head>

<body>

<cfset fruit="apple,banana,cherry,grape,mango,orange">
<cfoutput>
Complete list: #fruit#<br>
Number of fruit in list: #ListLen(fruit)#<br>
First fruit: #ListFirst(fruit)#<br>
Last fruit: #ListLast(fruit)#<br>
<cfset fruit=ListAppend(fruit, "pineapple")>
Complete list: #fruit#<br>
Number of fruit in list: #ListLen(fruit)#<br>
First fruit: #ListFirst(fruit)#<br>
Last fruit: #ListLast(fruit)#<br>
</cfoutput>

</body>
</html>
