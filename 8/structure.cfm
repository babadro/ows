<html>
<head>
 <title>Structure Example</title>
</head>

<body>

<cfset contact=StructNew()>
<cfset contact.FirstName="Ben">
<cfset contact.LastName="Forta">
<cfset contact.EMail="ben@forta.com">

<cfoutput>
E-Mail:
<a href="mailto:#contact.EMail#">#contact.FirstName# #contact.LastName#</a>
</cfoutput>

</body>
</html>

