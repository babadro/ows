<!---
Name:        form6_action.cfm
Author:      Ben Forta (ben@forta.com)
Description: Introduction to forms
Created:     07/01/07
--->

<html>

<head>
 <title>Learning ColdFusion Forms 6</title>
</head>

<body>

<!--- Display feedback to user --->
<cfoutput>

Thank you for your comments. You entered:
<p>
<strong>#ParagraphFormat(FORM.comments)#</strong>

</cfoutput>

</body>

</html>
