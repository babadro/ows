<!--- 
 Filename: ShoppingCart.cfc
 Created by: Nate Weiss (NMW)
 Purpose: Creates a CFC called ShoppingCart
--->

<cfcomponent output="false">
  <!--- Initialize the cartÕs contents --->
  <!--- Because this is outside of any <CFFUNCTION> tag, --->
  <!--- it only occurs when the CFC is first created --->
  <cfset VARIABLES.cart = structNew()>


  <!--- *** ADD Method *** --->
  <cffunction name="Add" access="public" returnType="void" output="false" 
              hint="Adds an item to the shopping cart">
    <!--- Two Arguments: MerchID and Quantity --->
    <cfargument name="merchID" type="numeric" required="Yes">
    <cfargument name="quantity" type="numeric" required="no" default="1">

    <!--- Is this item in the cart already? --->
    <cfif structKeyExists(VARIABLES.cart, arguments.merchID)>
      <cfset VARIABLES.cart[arguments.merchID] = 
             VARIABLES.cart[arguments.merchID] + arguments.quantity>
    <cfelse>
      <cfset VARIABLES.cart[arguments.merchID] = arguments.quantity>
    </cfif>

  </cffunction> 
 
 
  <!--- *** UPDATE Method *** --->
  <cffunction name="Update" access="public" returnType="void" output="false"
              hint="Updates an itemÕs quantity in the shopping cart">
    <!--- Two Arguments: MerchID and Quantity --->
    <cfargument name="merchID" type="numeric" required="Yes">
    <cfargument name="quantity" type="numeric" required="Yes">

    <!--- If the new quantity is greater than zero ---> 
    <cfif arguments.quantity gt 0>
      <cfset VARIABLES.cart[arguments.merchID] = arguments.quantity>    
      <!--- If new quantity is zero, remove the item from cart --->
    <cfelse>
      <cfset remove(arguments.merchID)>
    </cfif>
  </cffunction> 

 
  <!--- *** REMOVE Method *** --->
  <cffunction name="Remove" access="public" returnType="void" output="false"
              hint="Removes an item from the shopping cart">
    <!--- One Argument: MerchID --->
    <cfargument name="merchID" type="numeric" required="Yes">

    <cfset structDelete(VARIABLES.cart, arguments.merchID)>
  </cffunction> 
 
 
  <!--- *** EMPTY Method *** --->
  <cffunction name="Empty" access="public" returnType="void" output="false"
              hint="Removes all items from the shopping cart">
 
    <!--- Empty the cart by clearing the This.CartArray array --->
    <cfset structClear(VARIABLES.cart)>
  </cffunction>
 
  <!--- *** LIST Method *** --->
  <cffunction name="List" access="public" returnType="query" output="false"
              hint="Returns a query object containing all items in shopping 
              cart. The query object has two columns: MerchID and Quantity.">

    <!--- Create a query, to return to calling process --->
    <cfset var q = queryNew("MerchID,Quantity")>
    <cfset var key = "">
   
    <!--- For each item in cart, add row to query --->
    <cfloop collection="#VARIABLES.cart#" item="key">
      <cfset queryAddRow(q)>
      <cfset querySetCell(q, "MerchID", key)>
      <cfset querySetCell(q, "Quantity", VARIABLES.cart[key])>
    </cfloop>

    <!--- Return completed query ---> 
    <cfreturn q> 
  </cffunction> 

</cfcomponent>
