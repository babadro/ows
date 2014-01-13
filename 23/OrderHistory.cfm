<!--- 
 Filename: OrderHistory.cfm
 Created by: Nate Weiss (NMW)
 Purpose: Displays a userÕs order history
--->

<!--- Retrieve userÕs orders, based on ContactID --->
<cfquery name="getOrders" datasource="#APPLICATION.dataSource#">
 SELECT OrderID, OrderDate, 
 (SELECT Count(*) 
 FROM MerchandiseOrdersItems oi
 WHERE oi.OrderID = o.OrderID) AS ItemCount
 FROM MerchandiseOrders o
 WHERE ContactID = #SESSION.auth.contactID#
 ORDER BY OrderDate DESC
</cfquery>

<html>
<head>
 <title>Your Order History</title>
</head>
<body>
<!--- Personalized message at top of page--->
<cfoutput>
 <h2>Your Order History</h2>
 <p><strong>Welcome back, #SESSION.auth.firstName#!</strong><br>
 You have placed <strong>#getOrders.recordCount#</strong> 
 orders with us to date.</p>
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
 <tr>
 <td>
 <a href="OrderHistory.cfm?OrderID=#OrderID#">
 #dateFormat(orderDate, "mmmm d, yyyy")#
 </a>
 </td>
 <td>
 <strong>#itemCount#</strong>
 </td>
 </tr>
 </cfoutput>
</table>

</body>
</html>
