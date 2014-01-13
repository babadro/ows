<html>
<head>
 <title>Array Example 2</title>
</head>

<body>

<cfset names=ArrayNew(2)>
<cfset names[1][1]="Ben">
<cfset names[1][2]="Forta">
<cfset names[2][1]="Ray">
<cfset names[2][2]="Camden">
<cfset names[3][1]="Leon">
<cfset names[3][2]="Chalnick">

<cfdump var="#names#">

</body>
</html>
