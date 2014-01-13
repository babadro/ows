<!--- 
 Filename: Application.cfc (The ÒApplication ComponentÓ)
 Created by: Raymond Camden (ray@camdenfamily.com)
 Purpose: Sets ÒconstantÓ variables and includes consistent header
--->

<cfcomponent output="false">

  <cffunction name="onRequestStart" returnType="boolean" output="true">
    <!--- Any variables set here can be used by all our pages --->
    <cfset REQUEST.dataSource = "ows">
    <cfset REQUEST.companyName = "Orange Whip Studios">

    <!--- Display our Site Header at top of every page --->
    <cfinclude template="SiteHeader.cfm">

    <cfreturn true>
  </cffunction>
  
</cfcomponent>
