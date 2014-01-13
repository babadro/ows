<!--- 
 Filename: SendBulkEmail.cfm
 Author: Nate Weiss (NMW)
 Purpose: Creates form for sending email to everyone on the mailing list
--->

<html>
<head>
 <title>Mailing List</title>
 <!--- Apply simple CSS formatting to <TH> cells --->
 <style>
 th { background:blue;color:white;
 font-family:sans-serif;font-size:12px;
 text-align:right;padding:5px;} 
 </style>
</head>

<!--- Put cursor in FirstName field when page loads --->
<body>

<!--- Page Title --->
<h2>Send Message To Mailing List</h2>

<!--- If the user is submitting the form... --->
<cfif isDefined("FORM.subject")>
 <!--- Retrieve "mailing list" records from database --->
 <cfquery datasource="ows" name="getList">
 SELECT FirstName, LastName, EMail 
 FROM Contacts
 WHERE MailingList = 1
 </cfquery>

 <!--- Send the mail message, based on form input --->
 <cfmail query="getList" subject="#FORM.subject#"
 from="""Orange Whip Studios"" <mailings@orangewhipstudios.com>"
 to="""#FirstName# #LastName#"" <#EMail#>"
 bcc="personneldirector@orangewhipstudios.com"
>#FORM.messageBody#

----------------------------------------------------
We respect your privacy here at Orange Whip Studios.
To be removed from this mailing list, reply to this
message with the word "Remove" in the subject line.
----------------------------------------------------
</cfmail>
 
 <!--- Display "success" message to user --->
 <p>The email message was sent.<br>
 By the way, you look fabulous today. 
 You should be in pictures!<br>

<!--- Otherwise, display the form to user... ---> 
<cfelse>
 <!--- Provide simple form for recipient and message --->
 <cfform action="#CGI.script_name#" name="mailForm" method="POST">
 
 <table cellPadding="2" cellSpacing="2">
 <!--- Table row: Input for email Subject --->
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
 <cfinput type="submit" name="submit" value="Send Message Now" onClick="return confirm(ÔAre you sure? This message will be sent to everyone on the mailing list. This is your last chance to cancel the bulk mailing.Õ)">
 </td>
 </tr>
 </table>
 </cfform>
</cfif> 

</body>
</html>
