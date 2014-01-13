<!---
Name:        Chart6.cfm
Author:      Ben Forta
Description: Display a pie chart with drill-down support
Created:     07/10/2007
--->

<!--- Get information from the database --->
<cfinvoke component="ChartData"
          method="GetExpenses"
          returnvariable="ChartQuery"
          maxrows="10">

<html>
<head>
<title>Chart: Film Budgets</title>
</head>

<body>
<h2>Chart: Film Budgets</h2>

<!--- This defines the size and appearance of the chart --->
<cfchart chartwidth="550"
         chartheight="300"
         pieslicestyle="solid"
         show3d="yes"
         yoffset=".9"
         url="FilmExpenseDetail.cfm?MovieTitle=$ITEMLABEL$">
  
  <!--- Within the chart --->  
  <cfchartseries type="pie" 
                 query="chartquery"
                 valuecolumn="amountbudgeted"
                 itemcolumn="movietitle">

</cfchart>

</body>
</html>
