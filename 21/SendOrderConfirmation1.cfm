<!--- 
 Filename: SendOrderConfirmation1.cfm
 Author: Nate Weiss (NMW)
 Purpose: Sends an email message to the person who placed an order
--->

<!--- Tag attributes --->
<cfparam name="ATTRIBUTES.orderID" type="numeric">

<!--- Retrieve order information from database --->
<cfquery datasource="ows" name="getOrder">
 SELECT 
 c.ContactID, c.FirstName, c.LastName, c.Email,
 o.OrderDate, o.ShipAddress, o.ShipCity, 
 o.ShipState, o.ShipZip, o.ShipCountry,
 oi.OrderQty, oi.ItemPrice,
 m.MerchName,
 f.MovieTitle
 FROM 
 Contacts c,
 MerchandiseOrders o,
 MerchandiseOrdersItems oi, 
 Merchandise m,
 Films f
 WHERE 
 o.OrderID = #ATTRIBUTES.orderID#
 AND c.ContactID = o.ContactID
 AND m.MerchID = oi.ItemID
 AND o.OrderID = oi.OrderID
 AND f.FilmID = m.FilmID
 ORDER BY
 m.MerchName
</cfquery>

<!--- Re-Query the GetOrders query to find total $ spent --->
<!--- The DBTYPE="Query" invokes CFÕs ÒQuery Of Queries" --->
<cfquery dbtype="query" name="getTotal">
 SELECT SUM(ItemPrice * OrderQty) AS OrderTotal
 FROM GetOrder
</cfquery>

<!--- We do not want ColdFusion to suppress whitespace here --->
<cfprocessingdirective suppressWhitespace="no">

<!--- Send email to the user --->
<!--- Because of the GROUP attribute, the inner <CFOUTPUT> --->
<!--- block will be repeated for each item in the order --->
<cfmail query="getOrder" group="ContactID" groupCasesensitive="no"
 startrow="1" subject="Thanks for your order (Order number #ATTRIBUTES.orderID#)"
 to="""#FirstName# #LastName#"" <#Email#>"
 from="""Orange Whip Online Store"" <orders@orangewhipstudios.com>"
>Thank you for ordering from Orange Whip Studios.
Here are the details of your order, which will ship shortly.
Please save or print this email for your records.

Order Number: #ATTRIBUTES.orderID#
Items Ordered: #recordCount#
Date of Order: #dateFormat(OrderDate, "dddd, mmmm d, yyyy")#
 #timeFormat(OrderDate)#
 
------------------------------------------------------
<cfoutput>
#currentRow#. #MerchName# 
 (in commemoration of the film "#MovieTitle#")
 Price: #LSCurrencyFormat(ItemPrice)#
 Qty: #OrderQty#
</cfoutput>
------------------------------------------------------
Order Total: #lsCurrencyFormat(getTotal.OrderTotal)#

This order will be shipped to:
#FirstName# #LastName#
#ShipAddress#
#ShipCity#
#ShipState# #ShipZip# #ShipCountry#

If you have any questions, please write back to us at
orders@orangewhipstudios.com, or just reply to this email.
</cfmail>

</cfprocessingdirective>
