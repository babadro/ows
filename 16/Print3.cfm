<!---
Name:        Print3.cfm
Author:      Ben Forta
Description: Printable output with additional options
Created:     07/10/2007
--->

<!--- Get budget data --->
<cfinvoke component="ChartData"
          method="GetBudgetData"
          returnvariable="BudgetData">

<!--- Generate document --->
<cfdocument format="pdf">

<!--- Header --->
<cfdocumentitem type="header">
OWS Budget Report
</cfdocumentitem>
<!--- Footer --->
<cfdocumentitem type="footer">
<p align="center">
<cfoutput>
#CFDOCUMENT.currentpagenumber# of #CFDOCUMENT.totalpagecount#
</cfoutput>
</p>
</cfdocumentitem>


<!--- Header --->
<table align="center">
 <tr>
  <td><img src="../images/logo_c.gif" alt="Orange Whip Studios"></td>
  <td align="center"><font size="+2">Orange Whip Studios<br>Movies</font></td>
 </tr>
</table>

<!--- Title --->
<div align="center">
<h2>Budget Data</h2>
</div>

<!--- Page break --->
<cfdocumentitem type="pagebreak" />

<!--- Details --->
<table>
 <tr>
  <th>Movie</th>
  <th>Budget</th>
 </tr>
 <cfoutput query="BudgetData">
  <tr>
   <td><strong>#MovieTitle#</strong></td>
   <td>#LSCurrencyFormat(AmountBudgeted)#</td>
  </tr>
 </cfoutput>
</table>

</cfdocument>
