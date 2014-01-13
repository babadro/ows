<!---
Name:        Chart3.cfm
Author:      Ben Forta
Description: 3D bar chart
Created:     07/10/2007
--->

<!--- Get information from the database --->
<cfinvoke component="ChartData"
          method="GetBudgetData"
          returnvariable="ChartQuery"
          maxrows="10">

<html>
<head>
<title>Chart: Film Budgets</title>
</head>

<body>
<h2>Chart: Film Budgets</h2>

<!--- This defines the size and appearance of the chart --->
<cfchart chartwidth="750"
         chartheight="500"
         yaxistitle="Budget"
         show3d="yes"
         xoffset=".03"
         yoffset=".06">

 <!--- within the chart --->  
 <cfchartseries type="bar" 
                query="chartquery"
                valuecolumn="amountbudgeted"
                itemcolumn="movietitle">

</cfchart>


</body>
</html>
