<!---
 Filename: Application.cfc
 Created by: Raymond Camden (ray@camdenfamily.com)
 Handles application events.
--->

<cfcomponent output="false">

  <cffunction name="onRequestStart" output="false" returnType="boolean">
    <cfparam name="COOKIE.VisitStart" type="date" default="#now()#">
	<cfreturn true>
  </cffunction>

</cfcomponent>
