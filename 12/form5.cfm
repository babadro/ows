<!---
Name:        form5.cfm
Author:      Ben Forta (ben@forta.com)
Description: Introduction to forms
Created:     07/01/07
--->

<html>

<head>
 <title>Learning ColdFusion Forms 5</title>
</head>

<body>

<!--- Comments form --->
<form action="form5_action.cfm" method="POST">
Please enter your comments in the box provided, and then click <strong>Send</strong>.
<p>
<textarea name="Comments" rows="6" cols="40"></textarea>
<p>
<input type="submit" value="Send">

</form>

</body>

</html>
