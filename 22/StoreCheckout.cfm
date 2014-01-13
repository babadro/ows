<!--- 
 Filename: StoreCheckout.cfm (save with Chapter 22's listings)
 Created by: Nate Weiss (NMW)
 Purpose: Provides final Checkout/Payment page
 Please Note Depends on <CF_PlaceOrder> and StoreCheckoutForm.cfm
--->

<!--- Show header images, etc., for Online Store --->
<cfinclude template="StoreHeader.cfm">

<!--- Get current cart contents, as a query object --->
<cfset getCart = SESSION.myShoppingCart.List()>
 
<!--- Stop here if userÕs cart is empty --->
<cfif getCart.recordCount eq 0>
 There is nothing in your cart.
 <cfabort>
</cfif>

<!--- If user is not logged in, force them to now ---> 
<!---
<cfif not isDefined("SESSION.auth.isLoggedIn")>
 <cfinclude template="LoginForm.cfm">
 <cfabort>
</cfif> 
--->
<!--- If user is attempting to place order --->
<cfif isDefined("FORM.isPlacingOrder")>

  <cftry> 
  <!--- Attempt to process the transaction --->
  <!--- Change to PayflowPro to use VeriSign --->
  <cf_PlaceOrder
  Processor="JustTesting" 
  contactID="1"
  merchList="#valueList(getCart.MerchID)#"
  quantList="#valueList(getCart.Quantity)#"
  creditCard="#FORM.creditCard#"
  creditExpM="#FORM.creditExpM#"
  creditExpY="#FORM.creditExpY#"
  creditName="#FORM.creditName#"
  shipAddress="#FORM.shipAddress#"
  shipState="#FORM.shipState#"
  shipCity="#FORM.shipCity#"
  shipZIP="#FORM.shipZIP#"
  shipCountry="#FORM.shipCountry#"
  htmlMail="#FORM.htmlMail#"
  returnVariable="orderInfo">

  <!--- If any exceptions in the "ows.MerchOrder" family are thrown... ---> 
  <cfcatch type="ows.MerchOrder">
  <p>Unfortunately, we are not able to process your order at the moment.<br>
  Please try again later. We apologize for the inconvenience.<br>
  <cfabort>
  </cfcatch> 
  </cftry> 

 
  <!--- If the order was processed successfully --->
  <cfif orderInfo.isSuccessful>

    <!--- Empty userÕs shopping cart --->
    <cfset SESSION.myShoppingCart.Empty()>
 
    <!--- Display Success Message --->
    <cfoutput>
    <h2>Thanks For Your Order</h2>
    <p><b>Your Order Has Been Placed.</b><br>
    Your order number is: #orderInfo.orderID#<br>
    Your credit card has been charged:
    #lsCurrencyFormat(orderInfo.OrderAmount)#<br>
    <p>A confirmation is being Emailed to you.<br>
    </cfoutput>
 
    <!--- Stop here. --->
    <cfabort>
  <cfelse>
    <!--- Display "Error" message --->
    <font color="red">
    <strong>Your credit card could not be processed.</strong><br>
    Please verify the credit card number, expiration date, and 
    name on the card.<br>
    </font>
 
    <!--- Show debug info if viewing page on server --->
    <cftrace inline="True" var="OrderInfo">
  </cfif> 
</cfif>


<!--- Show Checkout Form (Ship Address/Credit Card) --->
<cfinclude template="StoreCheckoutForm.cfm">
