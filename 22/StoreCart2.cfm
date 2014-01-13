<!--- 
 Filename: StoreCart.cfm
 Created by: Nate Weiss (NMW)
 Purpose: Provides a simple shopping cart interface
--->

<!--- Show header images, etc., for Online Store --->
<cfinclude template="StoreHeader.cfm">

<!--- If MerchID was passed in URL --->
<cfif isDefined("URL.addMerchID")>
  <!--- Add item to userÕs cart data, via custom tag --->
  <cf_ShoppingCart
  action="Add"
  merchID="#URL.addMerchID#">

<!--- If user is submitting cart form ---> 
<cfelseif isDefined("FORM.merchID")>
  <!--- For each MerchID on Form, Update Quantity --->
  <cfloop list="#FORM.merchID#" INDEX="thisMerchID">
    <!--- Update Quantity, via Custom Tag --->
    <cf_ShoppingCart
    action="Update"
    merchID="#ThisMerchID#"
    quantity="#FORM['quant_#thisMerchID#']#">
  </cfloop>
 
  <!--- If user submitted form via "Checkout" button, --->
  <!--- send on to Checkout page after updating cart. --->
  <cfif isDefined("FORM.isCheckingOut")>
    <cflocation url="StoreCheckout.cfm">
  </cfif>
</cfif>

<!--- Get current cart contents, as a query object --->
<cf_ShoppingCart action="List" returnVariable="getCart">
 
<!--- Stop here if userÕs cart is empty --->
<cfif getCart.recordCount eq 0>
  There is nothing in your cart.
  <cfabort>
</cfif>


<!--- Create form that submits to this template --->
<cfform action="#CGI.script_name#">
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
