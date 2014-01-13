<!--- 
 Filename: OrderHistory3.cfm
 Created by: Nate Weiss (NMW)
 Purpose: Displays a user's order history
--->

<html>
<head>
 <title>Order History</title>
 
 <!--- Apply some simple CSS style formatting --->
 <style type="text/css">
 BODY {font-family:sans-serif;font-size:12px;color:navy}
 H2 {font-size:20px}
 TH {font-family:sans-serif;font-size:12px;color:white;
 background:MediumBlue;text-align:left}
 TD {font-family:sans-serif;font-size:12px}
 </style> 
</head>
<body>

<!--- getAuthUser() returns whatever was supplied to the name --->
<!--- attribute of the <cflogin> tag when the user logged in. --->
<!--- We provided user's ID and first name, separated by --->
<!--- commas; we can use list functions to get them back. --->
<cfset contactID = listFirst(getAuthUser())>
<cfset contactName = listRest(getAuthUser())>


<!--- Personalized message at top of page--->
<cfoutput>
 <h2>YourOrder History</h2>
 <p><strong>Welcome back, #contactName#!</strong><br>
</cfoutput>
 


<!--- Retrieve user's orders, based on ContactID --->
<cfquery name="getOrders" datasource="#APPLICATION.dataSource#">
 SELECT OrderID, OrderDate, 
 (SELECT Count(*) 
 FROM MerchandiseOrdersItems oi
 WHERE oi.OrderID = o.OrderID) AS ItemCount
 FROM MerchandiseOrders o
 WHERE ContactID = #contactID#
 ORDER BY OrderDate DESC
</cfquery>


<!--- Determine if a numeric OrderID was passed in URL --->
<cfset showDetail = isDefined("URL.orderID") and isNumeric(URL.orderID)>

<!--- If an OrderID was passed, get details for the order --->
<!--- Query must check against ContactID for security --->
<cfif showDetail>
 <cfquery name="getDetail" datasource="#APPLICATION.dataSource#">
 SELECT m.MerchName, oi.ItemPrice, oi.OrderQty
 FROM Merchandise m, MerchandiseOrdersItems oi 
 WHERE m.MerchID = oi.ItemID
 AND oi.OrderID = #URL.orderID#
 AND oi.OrderID IN 
 (SELECT o.OrderID FROM MerchandiseOrders o
 WHERE o.ContactID = #contactID#)
 </cfquery>
 
 <!--- If no Detail records, don't show detail --->
 <!--- User may be trying to "hack" URL parameters --->
 <cfif getDetail.recordCount eq 0>
 <cfset showDetail = False>
 </cfif>
</cfif>
<cfif getOrders.recordCount eq 0>
 <p>No orders placed to date.<br>
<cfelse>
 <cfoutput>
 <p>Orders placed to date: 
 <strong>#getOrders.recordCount#</strong><br>
 </cfoutput>
 
 <!--- Display orders in a simple HTML table --->
 <table border="1" width="300" cellpadding="5" cellspacing="2">
 <!--- Column headers --->
 <tr>
 <th>Date Ordered</th>
 <th>Items</th>
 </tr>
 
 <!--- Display each order as a table row --->
 <cfoutput query="getOrders">
 <!--- Determine whether to show details for this order --->
 <!--- Show Down arrow if expanded, otherwise Right --->
 <cfset isExpanded = showDetail and (getOrders.OrderID eq URL.orderID)>
 <cfset arrowIcon = iif(isExpanded, "'ArrowDown.gif'", "'ArrowRight.gif'")>
 
 <tr>
 <td>
 <!--- Link to show order details, with arrow icon --->
 <a href="OrderHistory3.cfm?OrderID=#orderID#">
 <img src="../images/#ArrowIcon#" width="16" height="16" border="0">
 #dateFormat(orderDate, "mmmm d, yyyy")#
 </a>
 </td>
 <td>
 <strong>#ItemCount#</strong>
 </td>
 </tr>
 
 <!--- Show details for this order, if appropriate ---> 
 <cfif isExpanded>
 <cfset orderTotal = 0>
 <tr>
 <td colspan="2">
 
 <!--- Show details within nested table --->
 <table width="100%" cellspacing="0" border="0">
 <!--- Nested table's column headers --->
 <tr>
 <th>Item</th><th>Qty</th><th>Price</th>
 </tr>
 
 <!--- Show each ordered item as a table row --->
 <cfloop query="getDetail">
 <cfset orderTotal = orderTotal + itemPrice>
 <tr>
 <td>#merchName#</td>
 <td>#orderQty#</td>
 <td>#dollarFormat(itemPrice)#</td>
 </tr>
 </cfloop>
 
 <!--- Last row in nested table for total ---> 
 <tr>
 <td colspan="2"><strong>Total:</strong></td>
 <td><strong>#dollarFormat(orderTotal)#</strong></td>
 </tr>
 </table>
 </td>
 </tr>
 </cfif>
 </cfoutput>
 </table>
</cfif>

</body>
</html>
