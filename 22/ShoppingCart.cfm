<!--- 
 Filename: ShoppingCart.cfm
 Created by: Nate Weiss (NMW)
 Purpose: Creates the <CF_ShoppingCart> Custom Tag
--->

<!--- Tag Parameters --->
<cfparam name="ATTRIBUTES.action" type="string">


<!--- These two variables track MerchIDs / Quantities --->
<!--- for items in userÕs cart (start with empty cart) --->
<cfparam name="CLIENT.cartMerchList" type="string" default="">
<cfparam name="CLIENT.cartQuantList" type="string" default="">


<!--- This tag is being called with what ACTION? --->
<cfswitch expression="#ATTRIBUTES.action#">
 
  <!--- *** ACTION="Add" or ACTION="Update" *** --->
  <cfcase value="Add,Update">
    <!--- Tag attributes specific to this ACTION --->
    <cfparam name="ATTRIBUTES.merchID" type="numeric">
    <cfparam name="ATTRIBUTES.quantity" type="numeric" default="1">

    <!--- Get position, if any, of MerchID in cart list --->
    <cfset currentListPos = listFind(CLIENT.cartMerchList, ATTRIBUTES.merchID)>
    <!--- If this item *is not* already in cart, add it --->
    <cfif currentListPos eq 0>
      <cfset CLIENT.cartMerchList = 
      listAppend(CLIENT.cartMerchList, ATTRIBUTES.merchID)>
      <cfset CLIENT.cartQuantList = 
      listAppend(CLIENT.cartQuantList, ATTRIBUTES.quantity)>
     <!--- If item *is* already in cart, change its qty ---> 
    <cfelse>
      <!--- If Action="Add", add new Qty to existing --->
      <cfif ATTRIBUTES.action eq "Add">
        <cfset ATTRIBUTES.quantity = 
         ATTRIBUTES.quantity + listGetAt(CLIENT.cartQuantList, currentListPos)>
      </cfif>
 
      <!--- If new quantity is zero, remove item from cart --->
      <cfif ATTRIBUTES.quantity eq 0>
        <cfset CLIENT.cartMerchList = 
         listDeleteAt(CLIENT.cartMerchList, currentListPos)>
        <cfset CLIENT.cartQuantList = 
         listDeleteAt(CLIENT.cartQuantList, currentListPos)>
      <!--- If new quantity not zero, update cart quantity ---> 
      <cfelse>
        <cfset CLIENT.cartQuantList = 
         listSetAt(CLIENT.cartQuantList, currentListPos, ATTRIBUTES.quantity)>
      </cfif>
    </cfif> 
  </cfcase>
 
 
  <!--- *** ACTION="Remove" *** --->
  <cfcase value="Remove">
    <!--- Tag attributes specific to this ACTION --->
    <cfparam name="ATTRIBUTES.merchID" type="numeric">
    <!--- Treat "Remove" action same as "Update" with Quant=0 --->
    <cf_ShoppingCart
      aCTION="Update"
      merchID="#ATTRIBUTES.MerchID#"
      quantity="0">
  </cfcase>
 
 
  <!--- *** ACTION="Empty" *** --->
  <cfcase value="Empty">
    <cfset CLIENT.cartMerchList = "">
    <cfset CLIENT.cartQuantList = "">
  </cfcase>
 
 
  <!--- *** ACTION="List" *** --->
  <cfcase value="List">
    <!--- Tag attributes specific to this ACTION --->
    <cfparam name="ATTRIBUTES.returnVariable" type="variableName">

    <!--- Create a query, to return to calling template --->
    <cfset q = queryNew("MerchID,Quantity")>
 
    <!--- For each item in CLIENT lists, add row to query --->
    <cfloop from="1" to="#listLen(CLIENT.cartMerchList)#" index="i">
      <cfset queryAddRow(q)>
      <cfset querySetCell(q, "MerchID", listGetAt(CLIENT.cartMerchList, i))>
      <cfset querySetCell(q, "Quantity", listGetAt(CLIENT.cartQuantList, i))>
    </cfloop>
 
    <!--- Return query to calling template --->
    <cfset "Caller.#ATTRIBUTES.returnVariable#" = q>
  </cfcase>


  <!--- If an unknown ACTION was provided, display error --->
  <cfdefaultcase>
    <cfthrow 
    message="Unknown ACTION passed to &lt;CF_ShoppingCart&gt;"
    detail="Recognized ACTION values are <B>List</B>, <B>Add</B>, 
    <B>Update</B>, <B>Remove</B>, and <B>Empty</B>.">
  </cfdefaultcase>

</cfswitch>
