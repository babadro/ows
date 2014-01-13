<!--- 
 Filename: Store.cfm
 Created by: Nate Weiss (NMW)
 Purpose: Provides simple online shopping interface
 Please Note Relies upon CF_MerchDisplay custom tag
--->

<!--- Get list of merchandise from database --->
<cfquery name="getMerch" datasource="#APPLICATION.dataSource#"
 cachedwithin="#createTimeSpan(0,1,0,0)#">
 SELECT MerchID, MerchPrice
 FROM Merchandise
 ORDER BY MerchName
</cfquery>

<!--- Show header images, etc., for Online Store --->
<cfinclude template="StoreHeader.cfm">

<!--- Show merchandise in a HTML table --->
<p>
<table>
 <tr>
 <!--- For each piece of merchandise --->
 <cfloop query="getMerch">
 <td>
 <!--- Show this piece of merchandise --->
 <cf_MerchDisplay
 merchID="#MerchID#">
 </td> 
 
 <!--- Alternate left and right columns --->
 <cfif currentRow mod 2 eq 0></tr><tr></cfif>
 </cfloop> 
 </tr>
</table>

</body>
</html>
