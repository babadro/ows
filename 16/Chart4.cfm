<!---
Name:        Chart4.cfm
Author:      Ben Forta
Description: Extensive chart formatting
Created:     07/10/2007
--->

<!--- Get information from the database --->
<cfinvoke component="ChartData"
          method="GetBudgetData"
          returnvariable="ChartQuery"
          maxrows="8">

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
         <!--- 3D appearance --->
         show3d="yes"
         xoffset=".04"
         yoffset=".04"
         <!--- Fonts and colors --->
         showborder="yes"
         foregroundcolor="003366"
         backgroundcolor="99dddd"
         databackgroundcolor="66bbbb"
         tipbgcolor="ffff99"
         fontsize="11"
         fontbold="yes"
         fontitalic="yes"
         <!--- gridlines and axis labels --->
         scalefrom="0"
         scaleto="1500000"
         gridlines="6"
         showygridlines="yes"
         labelformat="currency">

 <!--- within the chart --->  
 <cfchartseries type="bar" 
                seriescolor="green"
                serieslabel="Budget Details:"
                query="chartquery"
                valuecolumn="amountbudgeted"
                itemcolumn="movietitle"
                paintstyle="light">
</cfchart>

</body>
</html>
