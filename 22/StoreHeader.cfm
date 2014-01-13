<!--- 
 Filename: StoreHeader.cfm
 Created by: Nate Weiss (NMW)
 Purpose: Provides consistent navigation within store
--->

<!--- "Online Store" page title and header --->
<cfoutput>
 <html>
 <head><title>#APPLICATION.companyName# Online Store</title></head>
 <body>
 <style type="text/css">
 BODY { font-family:arial,helvetica,sans-serif;font-size:12px} 
 TD { font-size:12px} 
 TH { font-size:12px} 
 </style>
 
 <table border="0" width="100%">
 <tr>
 <td width="101">
 <!--- Company logo, with link to company home page --->
 <a href="http://www.orangewhipstudios.com">
 <img src="../images/logo_c.gif" 
 width="101" height="101" alt="" border="0" align="left"></a>
 </td>
 <td>
 <hr>
 <strong>#APPLICATION.companyName#</strong><br>
 Online Store<br clear="all">
 <hr>
 </td>
 <td width="100" align="left">
 <!--- Link to "Shopping Cart" page --->
 <img src="../images/Arrow.gif" width="10" height="9" alt="" border="0">
 <a href="Store.cfm">Store Home</a><br>
 <!--- Link to "Shopping Cart" page --->
 <img src="../images/Arrow.gif" width="10" height="9" alt="" border="0">
 <a href="StoreCart.cfm">Shopping Cart</a><br>
 <!--- Link to "Checkout" page --->
 <img src="../images/Arrow.gif" width="10" height="9" alt="" border="0">
 <a href="StoreCheckout.cfm">Checkout</a><br>
 </td>
 </tr>
 </table>
 &nbsp;<br>
</cfoutput>
