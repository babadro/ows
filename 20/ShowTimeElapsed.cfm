<!---
 Filename: ShowTimeElapsed.cfm
 Created by: Nate Weiss (NMW)
 Please Note Can be <CFINCLUDED> in any page in your application
--->

<!--- Find number of seconds passed since visit started --->
<!--- (difference between cookie value and current time) --->
<cfset secsSinceStart = dateDiff("s", COOKIE.VisitStart, now())>
<!--- Break it down into numbers of minutes and seconds --->
<cfset minutesElapsed = int(secsSinceStart / 60)>
<cfset secondsElapsed = secsSinceStart MOD 60>

<!--- Display the minutes/seconds elapsed --->
<cfoutput>
 Minutes Elapsed:
 #minutesElapsed#:#numberFormat(secondsElapsed, "00")#
</cfoutput>
