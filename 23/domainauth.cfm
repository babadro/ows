<!--- 
 Filename: DomainAuth.cfm
 Created by: Raymond Camden (ray@camdenfamily.com)
 Purpose: Uses <cfNTAuthenticate>
--->

<!--- Change this username! --->
<cfset username="changeme">

<!--- Change this password! --->
<cfset password="changeme">

<!--- Change this domain! --->
<cfset domain="changeme">

<!--- Attempt to logon --->
<cfNTAuthenticate username="#username#" password="#password#" result="result"
 domain="#domain#" listGroups="yes">

<cfdump var="#result#" label="Result of NT authentication.">
