<!--- 
 Filename: PersonnelMail1.cfm
 Author: Nate Weiss (NMW)
 Purpose: A simple form for sending email
--->

<html>
<head>
 <title>Personnel Office Mailer</title>
 <!--- Apply simple CSS formatting to <th> cells --->
 <style>
 th { background:blue;color:white;text-align:right} 
 </style>
</head>
<body>

<h2>Personnel Office Mailer</h2>

<!--- If the user is submitting the Form... --->
<cfif isDefined("FORM.subject")>

  <!--- We do not want ColdFusion to suppress whitespace here --->
  <cfprocessingdirective suppressWhitespace="No">
 
<!--- Send the mail message, based on form input --->
<cfmail
 subject="#FORM.subject#"
 from="personnel@orangewhipstudios.com"
 to="#FORM.toAddress#"
 bcc="personneldirector@orangewhipstudios.com"
>This is a message from the Personnel Office:
#FORM.messageBody#

If you have any questions about this message, please
write back or call us at extension 352. Thanks!</cfmail>

  </cfprocessingdirective>
 
 <!--- Display "success" message to user --->
 <p>The email message was sent.<br>
 By the way, you look fabulous today. 
 You should be in pictures!<br>

<!--- Otherwise, display the form to user... ---> 
<cfelse>
 <!--- Provide simple form for recipient and message --->
 <cfform action="#cgi.script_name#" method="post">
 
 <table cellPadding="2" cellSpacing="2">
 <!--- Table row: Input for Email Address --->
 <tr>
 <th>EMail Address:</th>
 <td>
 <cfinput type="text" name="toAddress" required="yes" size="40"
 message="You must provide an email address.">
 </td>
 </tr>
 
 <!--- Table row: Input for E-mail Subject --->
 <tr>
 <th>Subject:</th>
 <td>
 <cfinput type="text" name="subject" required="yes" size="40"
 message="You must provide a subject for the email.">
 </td>
 </tr>

 <!--- Table row: Input for actual Message Text --->
 <tr>
 <th>Your Message:</th>
 <td>
 <cftextarea name="messageBody" cols="30" rows="5" wrap="hard"
 required="yes" message="You must provide a message body." />
 </td>
 </tr>

 <!--- Table row: Submit button to send message --->
 <tr>
 <td>&nbsp;</td>
 <td>
 <cfinput type="submit" name="submit" value="Send Message Now">
 </td>
 </tr>
 </table>
 </cfform>
</cfif> 

</body>
</html>
