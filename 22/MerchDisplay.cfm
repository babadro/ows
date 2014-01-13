<!--- 
 Filename: MerchDisplay.cfm
 Created by: Nate Weiss (NMW)
 Purpose: Provides simple online shopping interface
 Please Note Used by Store.cfm page
--->

<!--- Tag Attributes --->
<!--- MerchID to display (from Merchandise table) --->
<cfparam name="ATTRIBUTES.merchID" type="numeric">

<!--- Controls whether to show "Add To Cart" link --->
<cfparam name="ATTRIBUTES.showAddLink" type="boolean" default="Yes">

<!--- Get information about this part from database --->
<!--- Query-Caching cuts down on database accesses. --->
<cfquery name="getMerch" datasource="#APPLICATION.dataSource#"
 cachedWithin="#createTimeSpan(0,1,0,0)#">
 SELECT 
 m.MerchName, m.MerchDescription, m.MerchPrice,
 m.ImageNameSmall, m.ImageNameLarge,
 f.FilmID, f.MovieTitle
 FROM 
 Merchandise m INNER JOIN Films f 
 ON m.FilmID = f.FilmID
 WHERE 
 m.MerchID = #ATTRIBUTES.merchID# 
</cfquery>

<!--- Exit tag silently (no error) if item not found --->
<cfif getMerch.recordCount neq 1>
 <cfexit>
</cfif>

<!--- URL for "Add To Cart" link/button --->
<cfset addLinkURL = "StoreCart.cfm?addMerchID=#ATTRIBUTES.merchID#">


<!--- Now display information about the merchandise --->
<cfoutput>
 <table width="300" cellspacing="0" border="0">
 <tr>
 <!--- Pictures go on left --->
 <td align="center">
 <!--- If there is an image available for item --->
 <!--- (allow user to click for bigger picture) --->
 <cfif getMerch.imageNameLarge neq "">
 <a href="../images/#getMerch.ImageNameLarge#">
 <img src="../images/#getMerch.ImageNameSmall#" border="0"
 alt="#getMerch.MerchName# (click for larger picture)"></a>
 </cfif>
 </td>
 <!--- Item description, price, etc., go on right --->
 <td style="font-family:arial;font-size:12px">
 <!--- Name of item, associated movie title, etc --->
 <strong>#getMerch.MerchName#</strong><br>
 <font size="1">From the film: #getMerch.MovieTitle#</font><br>
 #GetMerch.MerchDescription#<br>
 <!--- Display Price --->
 <b>Price: #lsCurrencyFormat(getMerch.MerchPrice)#</b><br>
 
 <!--- If we are supposed to show an "AddToCart" link --->
 <cfif ATTRIBUTES.showAddLink>
   <img src="../images/Arrow.gif" width="10" height="9" alt="" border="0">
   <a href="#addLinkURL#">Add To Cart</a><br>
 </cfif>
 </td>
 </tr>
 </table>
</cfoutput>
