<!--- 
 Filename: StoreCart.cfm
 Created by: Nate Weiss (NMW)
 Purpose: Provides a simple shopping cart interface
--->

<!--- Show header images, etc., for Online Store --->
<cfinclude template="StoreHeader.cfm">

<!--- If MerchID was passed in URL --->
<cfif isDefined("URL.AddMerchID")>
  <!--- Add item to userÕs cart data --->
  <cfinvoke component="#SESSION.myShoppingCart#" method="Add"
  merchid="#URL.addMerchID#">

<!--- If user is submitting cart form ---> 
<cfelseif isDefined("FORM.merchID")>
  <!--- For each MerchID on Form, Update Quantity --->
  <cfloop list="#FORM.merchID#" index="thisMerchID">
    <!--- Add item to userÕs cart data --->
    <cfinvoke component="#SESSION.myShoppingCart#" method="Update"
    merchid="#thisMerchID#" quantity="#FORM['quant_#thisMerchID#']#">
  </cfloop>
 
  <!--- If user submitted form via ÒCheckout" button, --->
  <!--- send on to Checkout page after updating cart. --->
  <cfif isDefined("FORM.isCheckingOut")>
    <cflocation url="StoreCheckout.cfm">
  </cfif>
</cfif>

<!--- Get current cart contents, as a query object --->
<cfset getCart = SESSION.myShoppingCart.List()>
 
<!--- Stop here if userÕs cart is empty --->
<cfif getCart.recordCount eq 0>
 There is nothing in your cart.
 <cfabort>
</cfif>


<!--- Create form that submits to this template --->
<cfform action="#CGI.SCRIPT_NAME#">
<table>
<tr>
  <th colspan="2" bgcolor="Silver">Your Shopping Cart</th>
</tr>
<!--- For each piece of merchandise --->
<cfloop query="getCart">
  <tr>
    <td>
    <!--- Show this piece of merchandise --->
    <cf_MerchDisplay
    merchID="#getCart.MerchID#"
    showAddLink="No">
    </td> 
    <td>
    <!--- Display Quantity in Text entry field --->
    <cfoutput>
    Quantity: 
    <cfinput type="hidden" name="merchID" value="#getCart.MerchID#">
    <cfinput type="text" size="3" name="quant_#getCart.MerchID#" 
           value="#getCart.Quantity#">
    </cfoutput>
    </td>
  </tr>
</cfloop>
</table>
 
 <!--- Submit button to update quantities --->
 <cfinput type="submit" name="submit" value="Update Quantities">

 <!--- Submit button to Check out --->
 <cfinput type="submit" value="Checkout" name="IsCheckingOut">
</cfform>
