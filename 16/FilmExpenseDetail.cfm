<!---
Name:        FilmExpenseDetail.cfm
Author:      Ben Forta
Description: Movie drill-down
Created:     07/10/2007
--->

<!--- These URL parameters will be passed by the chart --->
<cfparam name="URL.MovieTitle" type="string">

<!--- Get information from the database --->
<cfinvoke component="ChartData"
          method="GetFilmID"
          returnvariable="FilmID"
          movietitle="#URL.MovieTitle#">

<!--- Show an error message if we could not determine the FilmID --->
<cfif FilmID IS -1>
  <cfthrow message="Could not retrieve film information." 
           detail="Unknown movie title provided.">
</cfif>

<!--- Now that we know the FilmID, we can select the --->
<!--- corresponding expense records from the database --->
<cfinvoke component="ChartData"
          method="GetExpenseDetails"
          returnvariable="ExpenseQuery"
          filmid="#FilmID#">

<html>
<head>
<title>Expense Detail</title>
</head>

<body>

<cfoutput>
 <!--- page heading --->
 <h3>#URL.MovieTitle#</h3>
 
 <!--- html table for expense display --->
 <table border="1" width="500">
  <tr>
   <th width="100">Date</th>
   <th width="100">Amount</th>
   <th width="300">Description</th>
  </tr>
    
  <!--- for each expense in the query... --->
  <cfloop query="expensequery">
   <tr>
    <td>#LSDateFormat(ExpenseDate)#</td>
    <td>#LSCurrencyFormat(ExpenseAmount)#</td>
    <td>#Description#</td>
   </tr>
  </cfloop>
  
 </table>
</cfoutput>

</body>
</html>
