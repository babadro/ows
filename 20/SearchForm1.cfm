<!---
 Filename: SearchForm1.cfm
 Created by: Nate Weiss (NMW)
 Please Note Maintains ÒlastÓ search via Client variables
--->

<!--- Determine value for ÒSearch PrefillÓ feature --->
<!--- When user submits form, save search criteria in client variable --->
<cfif isDefined("FORM.searchCriteria")>
 <cfset CLIENT.lastSearch = FORM.searchCriteria>
 <cfset searchPreFill = FORM.searchCriteria>

<!--- If not submitting yet, get prior search word (if possible) --->
<cfelseif isDefined("CLIENT.lastSearch")>
 <CFSET searchPreFill = CLIENT.lastSearch>

<!--- If no prior search criteria exists, just show empty string --->
<cfelse>
 <cfset searchPreFill = "">
</cfif>


<html>
<head><title>Search Orange Whip</title></head>
<body>
 <h2>Search Orange Whip</h2>

 <!--- Simple search form, which submits back to this page --->
 <cfform action="#cgi.script_name#" method="post">

 <!--- "Search Criteria" field --->
 Search For:
 <cfinput name="SearchCriteria" value="#searchPreFill#"
 required="Yes"
 message="You must type something to search for!">

 <!--- Submit button --->
 <input type="submit" value="Search"><br>

 </cfform>

</body>
</html>
