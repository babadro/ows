<!--- 
 Filename: 404.cfm
 Created by: Raymond Camden (ray@camdenfamily.com)
 Purpose: Display an message about a missing file.
--->

<cfparam name="url.missingtemplate" default="">

<cfoutput>
<p>
Sorry, we could not load #url.missingtemplate#. Please try our <a href="index.cfm">home page</a> instead.
</p>
</cfoutput>