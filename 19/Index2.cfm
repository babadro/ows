<!--- 
 Filename: Index.cfm 
 Created by: Nate Weiss (NMW)
 Please Note Header and Footer are automatically provided
--->

<cfoutput>
 <p>Hello, and welcome to the home of 
 #REQUEST.companyName# on the web! We certainly 
 hope you enjoy your visit. We take pride in
 producing movies that are almost as good 
 as the ones they are copied from. We’ve
 been doing it for years. On this site, you’ll
 be able to find out about all our classic films
 from the golden age of Orange Whip Studios,
 as well as our latest and greatest new releases. 
 Have fun!<br>
</cfoutput>

<!--- Show a “Featured Movie” --->
<cfinclude template="FeaturedMovie.cfm">
