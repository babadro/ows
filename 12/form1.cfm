<!---
Name:        forms.cfm
Author:      Ben Forta (ben@forta.com)
Description: Introduction to forms 
Created:     07/01/07
--->

<html>
<head>
 <title>Learning ColdFusion Forms 1</title>
</head>

<body>

<!--- Movie search form --->
<form action="form1_action.cfm" method="POST">

Please enter the movie name and then click
<strong>Process</strong>.
<p>
Movie:
<input type="text" name="MovieTitle">
<br>
<input type="submit" value="Process">

</form>

</body>
</html>
