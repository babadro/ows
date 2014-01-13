<!--- 
 Filename: PersonnelMail2.cfm
 Author: Nate Weiss (NMW)
 Purpose: A simple form for sending email
--->

<html>
<head>
 <title>Personnel Office Mailer</title>
 <!--- Apply simple CSS formatting to <th> cells --->
 <style>
 th { background:blue;color:white;
 font-family:sans-serif;font-size:12px;
 text-align:right;padding:5px;} 
 </style>

 <!--- Function to guess email based on first/last name ---> 
 <script language="javaScript">
 function guessEmail() { 
  var guess;

   with (document.mailForm) { 
    guess = firstName.value.substr(0,1) + lastName.value;
    toAddress.value = guess.toLowerCase();
   } ;
 } ;
 </script>
</head>

<!--- Put cursor in FirstName field when page loads --->
<body <cfif not isDefined("FORM.subject")>
 onLoad="document.mailForm.firstName.focus()"
 </cfif>
>

<!--- If the user is submitting the form... --->
<cfif isDefined("FORM.subject")>
 <cfset recipEmail = listFirst(FORM.toAddress, "@") & "@orangewhipstudios.com">

 <!--- We do not want ColdFusion to suppress whitespace here --->
 <cfprocessingdirective suppressWhitespace="no">

 <!--- Send the mail message, based on form input --->
 <cfmail
 subject="#FORM.subject#"
 from="""Personnel Office"" <personnel@orangewhipstudios.com>"
 to="""#FORM.firstName# #FORM.lastName#"" <#recipEmail#>"
 bcc="personneldirector@orangewhipstudios.com"
>This is a message from the Personnel Office:

#uCase(FORM.subject)#

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
 <cfform action="#cgi.script_name#" name="mailForm" method="post">
 
 <table cellPadding="2" cellSpacing="2">
 <!--- Table row: Input for Recipient’s Name --->
 <tr>
 <th>Recipient’s Name:</th>
 <td>
 <cfinput type="text" name="firstName" required="yes" size="15"
 message="You must provide a first name."
 onChange="guessEmail()">
 
 <cfinput type="text" name="lastName" required="yes" size="20"
 message="You must provide a first name."
 onChange="guessEmail()">
 </td>
 </tr>

 <!--- Table row: Input for EMail Address --->
 <tr>
 <th>EMail Address:</th>
 <td>
 <cfinput type="text" name="toAddress" required="yes" size="20"
 message="You must provide the recipient’s email.">@orangewhipstudios.com
 </td>
 </tr>
 
 <!--- Table row: Input for EMail Subject --->
 <tr>
 <th>Subject:</th>
 <td>
 <cfselect name="subject">
 <option>Sorry, but you have been fired.
 <option>Congratulations! You got a raise!
 <option>Just FYI, you have hit the glass ceiling.
 <option>The company dress code, Capri Pants, and you
 <option>All your Ben Forta are belong to us.
 </cfselect> 
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
