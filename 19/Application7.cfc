<!--- 
 Filename: Application.cfc (The ÒApplication ComponentÓ)
 Created by: Raymond Camden (ray@camdenfamily.com)
 Purpose: Sets ÒconstantÓ variables and includes consistent header
--->

<cfcomponent output="false">

  <cfset THIS.name = "ows19">
  <cferror type="Request" template="ErrorRequest.cfm" 
           mailto="webmaster@orangewhipstudios.com">
  <cferror type="Exception" template="ErrorException.cfm" 
           mailto="webmaster@orangewhipstudios.com">

  <cffunction name="onApplicationStart" returnType="boolean" output="false">
    <!--- When did the application start? --->
    <cfset APPLICATION.appStarted = now()>

    <cfreturn true>
  </cffunction>

  <cffunction name="onApplicationEnd" returnType="void" output="false">
    <cfargument name="appScope" required="true"> 

    <!--- Log how many minutes the application stayed alive --->
    <cflog file="#THIS.name#" text=
"App ended after #dateDiff('n',ARGUMENTS.appScope.appStarted,now())# minutes.">

  </cffunction>
  
  <cffunction name="onRequestStart" returnType="boolean" output="true">
    <!--- Any variables set here can be used by all our pages --->
    <cfset request.dataSource = "ows">
    <cfset request.companyName = "Orange Whip Studios">

    <!--- Display our Site Header at top of every page --->
    <cfinclude template="SiteHeader.cfm">

    <cfreturn true>
  </cffunction>

  <cffunction name="onRequestEnd" returnType="void" output="true">

    <!--- Display our Site Footer at bottom of every page --->
    <cfinclude template="SiteFooter.cfm">

  </cffunction>

  <cffunction name="onError" returnType="void" output="false">
    <cfargument name="exception" required="true">
    <cfargument name="eventName" type="string" required="true">
    
    <!--- Use the cflog tag to record info on the error --->
    <cfif arguments.eventName is "">
      <cflog file="#THIS.name#" type="error" 
             text="#arguments.exception.message#">
    <cfelse>
      <cflog file="#THIS.name#" type="error"
 text="Error in Method [#arguments.eventName#] #arguments.exception.message#">
     </cfif>
     
     <!--- Let the <cferror> tags do their job. --->
     <cfthrow object="#arguments.exception#">
                 
  </cffunction>


  <cffunction name="onMissingTemplate" returnType="boolean" output="false">
    <cfargument name="targetpage" type="string" required="true">
	
    <!--- log it --->
    <cflog file="#THIS.name#" text="Missing Template: #arguments.targetpage#">
    <cflocation url="404.cfm?missingtemplate=#urlEncodedFormat(arguments.targetpage)#" addToken="false">
	
</cffunction>
    
</cfcomponent>
