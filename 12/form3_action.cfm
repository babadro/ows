<!---
Name:        form3_action.cfm
Author:      Ben Forta (ben@forta.com)
Description: Introduction to forms
Created:     07/01/07
--->

<!--- Initialize variables --->
<cfparam name="MailingList" default="No">

<html>

<head>
 <title>Learning ColdFusion Forms 2</title>
</head>

<body>

<!--- Display feedback to user --->
<cfoutput>

<!--- Payment type --->
Hello,<br>
You selected <strong>#FORM.PaymentType#</strong> as your payment type.<br>

<!--- Mailing list --->
<cfif MailingList IS "Yes">
 You will be added to our mailing list.
<cfelse>
 You will not be added to our mailing list.
</cfif>

</cfoutput>

</body>

</html>
