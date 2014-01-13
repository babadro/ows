<!---
Name:        form3.cfm
Author:      Ben Forta (ben@forta.com)
Description: Introduction to forms
Created:     07/01/07
--->

<html>

<head>
 <title>Learning ColdFusion Forms 3</title>
</head>

<body>
<!--- Payment and mailing list form --->
<form action="form3_action.cfm" method="POST">

Please fill in this form and then click <strong>Process</strong>.
<p>
<!--- Payment type radio buttons --->
Payment type:<br>
<input type="radio" name="PaymentType" value="Cash" CHECKED>Cash<br>
<input type="radio" name="PaymentType" value="Check">Check<br>
<input type="radio" name="PaymentType" value="Credit card">Credit card<br>
<input type="radio" name="PaymentType" value="P.O.">P.O.
<p>
<!--- Mailing list checkbox --->
Would you like to be added to our mailing list?
<input type="checkbox" name="MailingList" value="Yes">
<p>
<input type="submit" value="Process">

</form>

</body>

</html>
