<!--- 
 Filename:   Application.cfc
 Created by:  Raymond Camden (ray@camdenfamily.com)
 Please Note Executes for every page request!
--->

<cfcomponent output="false">

  <!--- Name the application. --->
  <cfset this.name = "c22">
  <!--- Turn on session management. --->
  <cfset this.sessionManagement = true>
  <cfset this.clientManagement = true>

  <cffunction name="onApplicationStart" returnType="void" output="false">
    <cfset APPLICATION.dataSource="ows">
    <cfset APPLICATION.companyName="Orange Whip Studios">
  </cffunction>  

  <cffunction name="onSessionStart" returnType="void" output="false">

    <cfobject name="SESSION.myShoppingCart" component="ShoppingCart"> 
  
  </cffunction>

</cfcomponent>
