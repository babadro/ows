<!---
 Filename: SearchForm2.cfm
 Created by: Nate Weiss (NMW)
 Please Note Maintains ÒlastÓ search via Client variables
--->

<!--- 
  When user submits form, save search criteria in Client variable 
--->
<cfif isDefined("FORM.searchCriteria")>
 <cfset CLIENT.lastSearch = FORM.searchCriteria>
 <cfset CLIENT.lastMaxRows = FORM.searchMaxRows>
<!--- if not submitting yet, get prior search word (if possible) --->
<cfelseif isDefined("CLIENT.lastSearch") and 
          isDefined("CLIENT.lastMaxRows")>
 <cfset searchCriteria = CLIENT.lastSearch>
 <cfset searchMaxRows = CLIENT.lastMaxRows>
<!--- if no prior search criteria exists, just show empty string --->
<cfelse>
 <cfset searchCriteria = "">
 <cfset searchMaxRows = 10>
</cfif>

<html>
<head><title>Search Orange Whip</title></head>
<body>

<h2>Search Orange Whip</h2>

<!--- Simple search form, which submits back to this page --->
<cfform action="#cgi.script_name#" method="post">

<!--- "Search Criteria" field --->
Search For:
<cfinput name="SearchCriteria" value="#searchCriteria#"
required="Yes"
message="You must type something to search for!">

<!--- Submit button --->
<input type="Submit" value="Search"><br>

<!--- "Max Matches" field --->
<i>show up to
<cfinput name="SearchMaxRows" value="#searchMaxRows#" size="2"
required="Yes" validate="integer" range="1,500"
message="Provide a number from 1-500 for search maximum.">
matches</i><br>
</cfform>
<!--- If we have something to search for, do it now --->
<cfif searchCriteria neq "">
  <!--- Get matching film entries from database --->
  <cfquery name="getMatches" datasource="ows">
  SELECT FilmID, MovieTitle, Summary
  FROM Films
  WHERE MovieTitle LIKE '%#SearchCriteria#%'
  OR Summary LIKE '%#SearchCriteria#%'
  ORDER BY MovieTitle
  </cfquery>

  <!--- Show number of matches --->
  <cfoutput>
  <hr><i>#getMatches.recordCount# records found for
  "#searchCriteria#"</i><br>
  </cfoutput>

  <!--- Show matches, up to maximum number of rows --->
  <cfoutput query="getMatches" maxrows="#searchMaxRows#">
  <p><b>#MovieTitle#</b><br>
  #Summary#<br>
  </cfoutput>
</cfif>

</body>
</html>
