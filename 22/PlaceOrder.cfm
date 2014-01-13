<!--- 
 Filename: PlaceOrder.cfm (creates <CF_PlaceOrder> Custom Tag)
 Created by: Nate Weiss (NMW)
 Please Note Depends on <CF_ProcessPayment> and <CF_SendOrderConfirmation>
 Purpose: Handles all operations related to placing a customerÕs order
--->

<!--- Tag Parameters --->
<cfparam name="ATTRIBUTES.processor" type="string" default="PayflowPro">
<cfparam name="ATTRIBUTES.merchList" type="string">
<cfparam name="ATTRIBUTES.quantList" type="string">
<cfparam name="ATTRIBUTES.contactID" type="numeric">
<cfparam name="ATTRIBUTES.creditCard" type="string">
<cfparam name="ATTRIBUTES.creditExpM" type="string">
<cfparam name="ATTRIBUTES.creditExpY" type="string">
<cfparam name="ATTRIBUTES.creditName" type="string">
<cfparam name="ATTRIBUTES.shipAddress" type="string">
<cfparam name="ATTRIBUTES.shipCity" type="string">
<cfparam name="ATTRIBUTES.shipCity" type="string">
<cfparam name="ATTRIBUTES.shipState" type="string">
<cfparam name="ATTRIBUTES.shipZIP" type="string">
<cfparam name="ATTRIBUTES.shipCountry" type="string">
<cfparam name="ATTRIBUTES.htmlMail" type="boolean">
<cfparam name="ATTRIBUTES.returnVariable" type="variableName">


<!--- Begin Òorder" database transaction here --->
<!--- Can be rolled back or committed later --->
<cftransaction action="begin">
  <!--- Insert new record into Orders table --->
  <cfquery datasource="#APPLICATION.dataSource#">
  INSERT INTO MerchandiseOrders (
  ContactID, 
  OrderDate, 
  ShipAddress, ShipCity,
  ShipState, ShipZip, 
  ShipCountry)
  VALUES (
  #ATTRIBUTES.contactID#, 
  <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" 
  VALUE="#dateFormat(now())# #timeFormat(now())#">, 
  '#ATTRIBUTES.shipAddress#', '#ATTRIBUTES.shipCity#',
  '#ATTRIBUTES.shipState#', '#ATTRIBUTES.shipZip#', 
  '#ATTRIBUTES.shipCountry#'
  )
  </cfquery> 
 
  <!--- Get just-inserted OrderID from database --->
  <cfquery datasource="#APPLICATION.dataSource#" name="getNew">
  SELECT MAX(OrderID) AS NewID
  FROM MerchandiseOrders
  </cfquery>
 
  <!--- For each item in user's shopping cart --->
  <cfloop from="1" to="#listLen(ATTRIBUTES.merchList)#" index="i">
    <cfset thisMerchID = listGetAt(ATTRIBUTES.merchList, i)>
    <cfset thisQuant = listGetAt(ATTRIBUTES.quantList, i)>
 
    <!--- Add the item to ÒOrdersItems" table --->
    <cfquery datasource="#APPLICATION.dataSource#">
    INSERT INTO MerchandiseOrdersItems
    (OrderID, ItemID, OrderQty, ItemPrice)
    SELECT
    #getNew.NewID#, MerchID, #thisQuant#, MerchPrice
    FROM Merchandise
    WHERE MerchID = #thisMerchID#
    </cfquery>
  </cfloop>
 
  <!--- Get the total of all items in user's cart --->
  <cfquery datasource="#APPLICATION.dataSource#" name="getTotal">
  SELECT SUM(ItemPrice * OrderQty) AS OrderTotal
  FROM MerchandiseOrdersItems
  WHERE OrderID = #getNew.NewID#
  </cfquery>

  <!--- Attempt to process the transaction --->
  <cf_ProcessPayment
  processor="#ATTRIBUTES.processor#"
  orderID="#getNew.NewID#"
  orderAmount="#getTotal.OrderTotal#"
  creditCard="#ATTRIBUTES.creditCard#"
  creditExpM="#ATTRIBUTES.creditExpM#"
  creditExpY="#ATTRIBUTES.creditExpY#"
  creditName="#ATTRIBUTES.creditName#"
  returnVariable="chargeInfo">

  <!--- If the order was processed successfully --->
  <cfif chargeInfo.IsSuccessful>
    <!--- Commit the transaction to database --->
    <cftransaction action="Commit"/>
  <cfelse> 
    <!--- Rollback the Order from the Database --->
    <cftransaction action="RollBack"/>
  </cfif> 
</cftransaction>


<!--- If the order was processed successfully --->
<cfif ChargeInfo.isSuccessful>
  <!--- Send Confirmation E-Mail, via Custom Tag --->
  <cf_SendOrderConfirmation
  orderID="#getNew.NewID#"
  useHTML="#ATTRIBUTES.htmlMail#"> 
</cfif>

<!--- Return status values to callling template --->
<cfset "Caller.#ATTRIBUTES.returnVariable#" = chargeInfo>
