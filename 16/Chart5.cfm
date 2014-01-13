<!---
Name:        Chart5.cfm
Author:      Ben Forta
Description: Using multiple data series
Created:     07/10/2007
--->

<!--- Get information from the database --->
<cfinvoke component="ChartData"
          method="GetExpenses"
          returnvariable="ChartQuery"
          maxrows="5">

<html>
<head>
<title>Chart: Film Budgets</title>
</head>

<body>
<h2>Chart: Film Budgets</h2>

<!--- This defines the size and appearance of the chart --->
<cfchart chartwidth="750"
         chartheight="450"
         yaxistitle="Budget"
         seriesplacement="cluster"
          <!--- 3D appearance --->
         show3d="yes"
         xoffset=".01"
         yoffset=".03"
         <!--- Fonts and colors --->
         showborder="yes"
         databackgroundcolor="dddddd"
         fontbold="yes"
         fontitalic="yes"
         <!--- gridlines and axis labels --->
         scaleto="800000"
         gridlines="5"
         showxgridlines="yes"
         showygridlines="no"
         labelformat="currency">

 <!--- Budget chart --->  
 <cfchartseries type="horizontalbar" 
                seriescolor="99ff99"
                serieslabel="Amount Budgeted:"
                query="chartquery"
                valuecolumn="amountbudgeted"
                itemcolumn="movietitle">

 <!--- Expenses chart --->  
 <cfchartseries type="horizontalbar" 
                seriescolor="ff4444"
                serieslabel="Actual Expenses:"
                query="chartquery"
                valuecolumn="expensetotal"
                itemcolumn="movietitle"
                paintstyle="light">

</cfchart>

</body>
</html>
