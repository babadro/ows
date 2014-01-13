<!--- 
 Filename: Application.cfc (The ÒApplication ComponentÓ)
 Created by: Raymond Camden (ray@camdenfamily.com)
 Purpose: Sets ÒconstantÓ variables and includes consistent header
--->

<cfcomponent output="false">

  <cffunction name="onRequestStart" returnType="boolean" output="true">
    <!--- Any variables set here can be used by all our pages --->
    <cfset REQUEST.dataSource = Òows">
    <cfset REQUEST.companyName = ÒOrange Whip Studios">

    <!--- Display our Site Header at top of every page --->
    <cfinclude template="SiteHeader.cfm">

    <cfreturn true>
  </cffunction>

  <cffunction name="onRequestEnd" returnType="void" output="true">

       <!--- Display our Site Footer at bottom of every page --->
       <cfinclude template="SiteFooter.cfm">

  </cffunction>
  
</cfcomponent>
