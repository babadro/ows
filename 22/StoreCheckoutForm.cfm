<!--- 
 Filename: StoreCheckoutForm.cfm
 Created by: Nate Weiss (NMW)
 Please Note Included by StoreCheckout.cfm
 Purpose: Displays a simple checkout form
--->

<!--- Used to pre-fill user’s choice of HTML or Plain email --->
<cfparam name="FORM.htmlMail" type="string" default="Yes">


<cfoutput>
<cfform action="#CGI.script_name#" method="post" preservedata="Yes">
<cfinput type="hidden" name="isPlacingOrder" value="Yes">
 
<table border="0" cellspacing="4">
<tr>
  <th colspan="2" bgcolor="silver">Shipping Information</th>
</tr>
 
<tr>
  <th align="right">Ship To:</th>
  <td>
  Your Name
  </td>
</tr>
<tr>
  <th align="right">Address:</th>
  <td>
  <cfinput name="shipAddress" size="30" 
           required="yes" value=""
           message="Please don’t leave the Address blank!">
  </td>
</tr>
<tr>
  <th align="right">City:</th>
  <td>
  <cfinput name="shipCity" size="30" required="yes" value=""
   message="Please don’t leave the City blank!">
  </td>
</tr>
<tr>
  <th align="right">State:</th>
  <td>
  <cfinput name="shipState" size="30" required="yes" value=""
   message="Please don’t leave the State blank!">
  </td>
</tr>
<tr>
  <th align="right">Postal Code:</th>
  <td>
  <cfinput name="shipZIP" size="10" required="yes" value=""
   message="Please don’t leave the ZIP blank!">
  </td>
</tr>
<tr>
  <th align="right">Country:</th>
  <td>
  <cfinput name="shipCountry" size="10" required="Yes" 
           value=""
           message="Please don’t leave the Country blank!">
  </td>
</tr>
<tr>
  <th align="right">Credit Card Number:</th>
  <td>
  <cfinput name="creditCard" size="30" required="yes" validate="creditcard"
   message="You must provide a credit card number.">
  </td>
</tr>
<tr>
  <th align="right">Credit Card Expires:</th>
  <td>
  <cfselect name="creditExpM">
  <cfloop from="1" to="12" index="i">
    <option value="#i#">#numberFormat(i, "00")#
  </cfloop>
  </cfselect>
  <cfselect name="creditExpY">
  <cfloop from="#year(now())#" to="#val(year(now())+10)#" index="i">
    <option value="#i#">#i#
  </cfloop>
  </cfselect>
  </td>
</tr>
<tr>
  <th align="right">Name On Card:</th>
  <td>
  <cfinput name="creditName" size="30" required="Yes" 
   value=""
   message="You must provide the Name on the Credit Card.">
  </td>
</tr>
<tr valign="baseline">
  <th align="right">Confirmation:</th>
  <td>
  We will send a confirmation message to you at foo@foo.com<br>
  <cfinput type="radio" name="htmlMail" value="Yes" 
           checked="#form.htmlMail#">
  HTML (I sometimes see pictures in Email messages)<br>
  <cfinput type="radio" name="htmlMail" value="No"
           checked="#not form.htmlmail#">
  Non-HTML (I never see any pictures in my messages)<br>
  </td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td>
  <cfinput type="submit" name="submit" value="Place Order Now">
  </td>
</tr>
</table>
 
</cfform>
</cfoutput>
