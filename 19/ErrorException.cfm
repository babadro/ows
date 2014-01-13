<!--- 
 Filename: ErrorException.cfm
 Created by: Nate Weiss (NMW)
 Please Note Included via <CFERROR> in Application.cfc
--->

<html>
<head><title>Error</title></head>
<body>

<!--- Display sarcastic message to poor user --->
<h2>Who Knew?</h2>
<P>We are very sorry, but a technical problem prevents us from
showing you what you are looking for. Unfortunately, these things 
happen from time to time, even though we have only the most
top-notch people on our technical staff. Perhaps all of 
our programmers need a raise, or more vacation time. As always,
there is also the very real possibility that SPACE ALIENS
(or our rivals at Miramax Studios) have sabotaged our website.<br>
<p>That said, we will naturally try to correct this problem 
as soon as we possibly can. Please try again shortly. 
Thank you.<br>

<!--- Maybe the company logo will make them feel better --->
<img src="../images/logo_b.gif" width="73" height="73" alt="" border="0">

<!--- Send an email message to site administrator --->
<!--- (or whatever address provided to <cferror>) --->
<cfif ERROR.mailTo neq "">
 <cfmail to="#ERROR.mailTo#" from="errorsender@orangewhipstudios.com"
 subject="Error on Page #ERROR.Template#">
 Error Date/Time: #ERROR.dateTime#
 User’s Browser: #ERROR.browser#
 URL Parameters: #ERROR.queryString#
 Previous Page: #ERROR.HTTPReferer#
 ------------------------------------
 #ERROR.diagnostics#
 </cfmail>
</cfif>
