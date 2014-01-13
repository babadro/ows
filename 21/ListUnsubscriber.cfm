<!--- 
 Filename: ListUnsubscriber.cfm
 Author: Nate Weiss (NMW)
 Purpose: A simple automated POP agent for unsubscribing from mailing lists
--->

<!--- Mailbox info for Òmailings@orangewhipstudios.comÓ --->
<cfset popServer = "pop.orangewhipstudios.com">
<cfset username = "mailings">
<cfset password = "ThreeOrangeWhips">
<cfset popServer = "camdenfamily.com">
<cfset username = "test2@camdenfamily.com">
<cfset password = "redwolf6">

<!--- We will delete all messages in this list --->
<cfset msgDeleteList = "">

<html>
<head><title>List Unsubscriber Agent</title></head>
<body>

<h2>List Unsubscriber Agent</h2>
 
<p>Checking the mailings@orangewhipstudios.com mailbox for new messages...<br> 
This may take a minute, depending on traffic and the number of messages.<br>

<!--- Flush output buffer so the above messages --->
<!--- are shown while <CFPOP> is doing its work --->
<cfflush>

<!--- Contact POP Server and retrieve messages --->
<cfpop action="GetHeaderOnly" name="getMessages"
 server="#popServer#" username="#username#" password="#password#"
 maxrows="20">
 
<!--- Short status message ---> 
<cfoutput>
 <p><strong>#getMessages.recordCount# messages to process.</strong><br>
</cfoutput> 
 
<!--- For each message currently in the mailbox... --->
<cfloop query="getMessages">

 <!--- Short status message --->
 <cfoutput>
 <p><strong>Message from:</strong> #htmlEditFormat(getMessages.From)#<br>
 </cfoutput>

 <!--- If the subject line contains the word "Remove" --->
 <cfif getMessages.Subject does not contain "Remove">
   <!--- Short status message --->
   Message does not contain "Remove".<br>
 <cfelse> 

   <!--- Short status message --->
   Message contains "Remove".<br>
  
   <!--- Which "word" in From address contains @ sign? --->
   <cfset addrPos = listFind(getMessages.From, "@", "<> ")>
   <!--- Assuming one of the "words" contains @ sign, --->
   <cfif addrPos eq 0>
     <!--- Short status message --->
     Address not found in From line.<BR>
   <cfelse>
 
     <!--- Email address is that word in From address --->
     <cfset fromAddress = trim(listGetAt(getMessages.From, addrPos, "<> "))>
 
     <!--- Who in mailing list has this email address? --->
     <cfquery name="getContact" datasource="ows" maxrows="1">
     SELECT ContactID, FirstName, LastName 
     FROM Contacts
     WHERE Email = '#fromAddress#'
     AND MailingList = 1
     </cfquery>

     <!--- Assuming someone has this address... ---> 
     <cfif getContact.recordCount eq 0>
      <!--- Short status message --->
      <cfoutput>Recipient #fromAddress# not on list.<br></cfoutput>
     <cfelse>
       <!--- Short status message --->
       <cfoutput>Removing #fromAddress# from list.<br></cfoutput>
 
       <!--- Update the database to take them off list --->
       <cfquery datasource="ows">
       UPDATE Contacts SET
       MailingList = 0
       WHERE ContactID = #getContact.ContactID# 
       </cfquery>
       
       <!--- Short status message --->
       Sending confirmation message via email.<br>
 
       <!--- Mail user a confirmation note --->
       <cfmail
       to="""#getContact.FirstName# #getContact.LastName#"" <#fromAddress#>"
       from="""Orange Whip Studios"" <mailings@orangewhipstudios.com>"
       subject="Mailing List Request"
       >You have been removed from our mailing list.</cfmail>
 
     </cfif>
    </cfif>
  </cfif>
 
 <!--- Add this message to the list of ones to delete. --->
 <!--- If you wanted to only delete some messages, you --->
 <!--- would put some kind of <CFIF> test around this. --->
 <cfset msgDeleteList = listAppend(msgDeleteList, getMessages.uid)>
</cfloop>


<!--- If there are messages to delete --->
<cfif msgDeleteList neq "">
  <!--- Short status message --->
  <p>Deleting messages...

  <!--- Flush output buffer so the above messages --->
  <!--- are shown while <CFPOP> is doing its work --->
  <cfflush>
 
  <!--- Contact POP Server and delete messages --->
  <cfpop action="Delete" server="#popServer#"
  username="#username#"
  password="#password#"
  uid="#msgDeleteList#">
 
  Done.<br> 
</cfif>

</body>
</html>
