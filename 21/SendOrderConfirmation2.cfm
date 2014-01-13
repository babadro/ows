<!--- 
 Filename: SendOrderConfirmation2.cfm
 Author: Nate Weiss (NMW)
 Purpose: Sends an email message to the person who placed an order
--->

<!--- Tag attributes --->
<cfparam name="ATTRIBUTES.orderID" type="numeric">
<cfparam name="ATTRIBUTES.useHTML" type="boolean" default="yes">

<!--- Local variables --->
<cfset imgSrcPath = "http://#CGI.HTTP_HOST#/ows/images">

<!--- Retrieve order information from database --->
<cfquery datasource="ows" name="getOrder">
 SELECT 
 c.ContactID, c.FirstName, c.LastName, c.Email,
 o.OrderDate, o.ShipAddress, o.ShipCity, 
 o.ShipState, o.ShipZip, o.ShipCountry,
 oi.OrderQty, oi.ItemPrice,
 m.MerchName, m.ImageNameSmall,
 f.MovieTitle
 FROM 
 Contacts c,
 MerchandiseOrders o,
 MerchandiseOrdersItems oi, 
 Merchandise m,
 Films f
 WHERE 
 o.OrderID = #ATTRIBUTES.OrderID#
 AND c.ContactID = o.ContactID
 AND m.MerchID = oi.ItemID
 AND o.OrderID = oi.OrderID
 AND f.FilmID = m.FilmID
 ORDER BY
 m.MerchName
</cfquery>

<!--- Display an error message if query returned no records --->
<cfif getOrder.recordCount eq 0>
 <cfthrow message="Failed to obtain order information."
 detail="Either the Order ID was incorrect, or order has no detail records.">
<!--- Display an error message if email blank or not valid ---> 
<cfelseif isValid("email", getOwer.email)>
 <cfthrow message="Failed to obtain order information."
 detail="Email addresses need to have an @ sign and at least one ÔdotÕ.">
</cfif>

<!--- Query the GetOrders query to find total $$ --->
<cfquery dbtype="query" name="getTotal">
 SELECT SUM(ItemPrice * OrderQty) AS OrderTotal
 FROM GetOrder
</cfquery>


<!--- *** If we are sending HTML-Formatted Email *** --->
<cfif ATTRIBUTES.useHTML>
 
 <!--- Send Email to the user --->
 <!--- Because of the GROUP attribute, the inner <CFOUTPUT> --->
 <!--- block will be repeated for each item in the order --->
 <cfmail query="getOrder" group="ContactID" groupCasesensitive="No"
 subject="Thanks for your order (Order number #ATTRIBUTES.orderID#)"
 to="""#FirstName# #LastName#"" <#Email#>"
 from="""Orange Whip Online Store"" <orders@orangewhipstudios.com>"
 type="HTML">
 
 <html>
 <head>
 <style type="text/css">
 body { font-family:sans-serif;font-size:12px;color:navy} 
 td { font-size:12px} 
 th { font-size:12px;color:white;
 background:navy;text-align:left} 
 </style>
 </head>
 <body>
 
 <h2>Thank you for your Order</h2>
 
 <p><b>Thank you for ordering from 
 <a href="http://www.orangewhipstudios.com">Orange Whip Studios</a>.</b><br>
 Here are the details of your order, which will ship shortly.
 Please save or print this email for your records.<br>
 
 <p>
 <strong>Order Number:</strong> #ATTRIBUTES.orderID#<br>
 <strong>Items Ordered:</strong> #recordCount#<br>
 <strong>Date of Order:</strong> 
 #dateFormat(OrderDate, "dddd, mmmm d, yyyy")#
 #timeFormat(OrderDate)#<br>
 
 <table>
 <cfoutput>
 <tr valign="top">
 <th colspan="2">
 #MerchName#
 </th>
 </tr>
 <tr> 
 <td>
 <!--- If there is an image available... --->
 <cfif ImageNameSmall neq "">
 <img src="#imgSrcPath#/#ImageNameSmall#"
 alt="#MerchName#" width="50" height="50" border="0">
 </cfif> 
 </td>
 <td>
 <em>(in commemoration of the film "#MovieTitle#")</em><br>
 <strong>Price:</strong> #lsCurrencyFormat(ItemPrice)#<br>
 <strong>Qty:</strong> #OrderQty#<br>&nbsp;<br>
 </td>
 </tr> 
 </cfoutput>
 </table>

 <p>Order Total: #lsCurrencyFormat(getTotal.OrderTotal)#<br>
 
 <p><strong>This order will be shipped to:</strong><br>
 #FirstName# #LastName#<br>
 #ShipAddress#<br>
 #ShipCity#<br>
 #ShipState# #ShipZip# #ShipCountry#<br>
 
 <p>If you have any questions, please write back to us at
 <a href="orders@orangewhipstudios.com">orders@orangewhipstudios.com</a>, 
 or just reply to this email.<br>
 </body>
 </html>
 </cfmail>


<!--- *** If we are NOT sending HTML-Formatted Email *** --->
<cfelse>

<!--- We do not want ColdFusion to suppress whitespace here --->
<cfprocessingdirective suppressWhitespace="no">

<!--- Send email to the user --->
<!--- Because of the GROUP attribute, the inner <CFOUTPUT> --->
<!--- block will be repeated for each item in the order --->
<cfmail query="getOrder" group="ContactID" groupCasesensitive="No"
 subject="Thanks for your order (Order number #ATTRIBUTES.OrderID#)"
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
 Price: #lsCurrencyFormat(ItemPrice)#
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

</cfif>
