<!--- 
 Filename: ProcessPayment.cfm
 Created by: Nate Weiss (NMW)
 Please Note Creates the <CF_ProcessPayment> Custom Tag
 Purpose: Handles credit card and other transactions
--->


<!--- Tag Parameters --->
<cfparam name="ATTRIBUTES.orderID" type="numeric">
<cfparam name="ATTRIBUTES.orderAmount" type="numeric">
<cfparam name="ATTRIBUTES.creditCard" type="string">
<cfparam name="ATTRIBUTES.creditExpM" type="string">
<cfparam name="ATTRIBUTES.creditExpY" type="string">
<cfparam name="ATTRIBUTES.returnVariable" type="variableName">
<cfparam name="ATTRIBUTES.creditName" type="string">

 
<!--- Values to return to calling template ---> 
<cfset s = structNew()>
<!--- Always return IsSuccessful (Boolean) --->
<cfset s.isSuccessful = True>
<!--- Always return status of transaction --->
<cfset s.status = "success">
<!--- Return other data, as if transaction succeeded --->
<cfset s.authCode = "DummyAuthCode">
<cfset s.orderID = ATTRIBUTES.orderID>
<cfset s.orderAmount = ATTRIBUTES.orderAmount>

<!--- Return values to calling template --->
<cfset "Caller.#ATTRIBUTES.returnVariable#" = s>
