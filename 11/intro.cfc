<!--- This is the introductory CFC --->
<cfcomponent>

<!--- Get today's date --->
<cffunction name="today" returntype="date">
   <cfreturn Now()>
</cffunction>

<!--- Get tomorrow's date --->
<cffunction name="tomorrow" returntype="date">
   <cfreturn DateAdd("d", 1, Now())>
</cffunction>

<!--- Get yesterday's date --->
<cffunction name="yesterday" returntype="date">
   <cfreturn DateAdd("d", -1, Now())>
</cffunction>

<!--- Perform geometric calculations --->
<cffunction name="geometry" returntype="struct">
   <!--- Need a radius --->
   <cfargument name="radius" type="numeric" required="yes">
   <!--- Define result variable --->
   <cfset var result=StructNew()>
   <!--- Save radius --->
   <cfset result.radius=radius>
   <!--- First circle --->
   <cfset result.circle=StructNew()>
   <!--- Calculate circle circumference --->
   <cfset result.circle.circumference=2*Pi()*radius>
   <!--- Calculate circle area --->
   <cfset result.circle.area=Pi()*(radius^2)>
   <!--- Now sphere --->
   <cfset result.sphere=StructNew()>
   <!--- Calculate sphere volume --->
   <cfset result.sphere.volume=(4/3)*Pi()*(radius^3)>
   <!--- Calculate sphere surface area --->
   <cfset result.sphere.surface=4*result.circle.area>
   <!--- Return it --->
   <cfreturn result>
</cffunction>

</cfcomponent>
