<!---
Name:        form4.cfm
Author:      Ben Forta (ben@forta.com)
Description: Introduction to forms
Created:     07/01/07
--->

<html>

<head>
 <title>Learning ColdFusion Forms 4</title>
</head>

<body>

<!--- Payment and mailing list form --->
<form action="form3_action.cfm" method="POST">

Please fill in this form and then click <strong>Process</strong>.
<p>
<!--- Payment type select list --->
Payment type:<br>
<select name="PaymentType">
 <option value="Cash">Cash</option>
 <option value="Check">Check</option>
 <option value="Credit card">Credit card</option>
 <option value="P.O.">P.O.</option>
</select>
<p>
<!--- Mailing list checkbox --->
Would you like to be added to our mailing list?
<input type="checkbox" name="MailingList" value="Yes">
<p>
<input type="submit" value="Process">

</form>

</body>

</html>
