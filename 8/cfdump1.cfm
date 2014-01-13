<html>
<head>
   <title>&lt;CFDUMP&gt; Example 1</title>
</head>

<body>

<cfset contact=StructNew()>
<cfset contact.FirstName="Ben">
<cfset contact.LastName="Forta">
<cfset contact.EMail="ben@forta.com">

<cfdump var="#contact#">

</body>
</html>
