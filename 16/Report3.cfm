<!---
Name:        Report3.cfm
Author:      Ben Forta
Description: Invoke a ColdFusion report
Created:     07/10/2007
--->

<cfparam name="FilmID" default="">

<cfquery name="Expenses" datasource="ows">
SELECT    Films.MovieTitle, Expenses.ExpenseDate,
          Expenses.Description,
          Expenses.ExpenseAmount
FROM      Films, Expenses 
WHERE     Expenses.FilmID = Films.FilmID
<cfif FilmID NEQ "">
 AND Films.FilmID = #FilmID#
</cfif>
ORDER BY  Films.MovieTitle, expenses.expensedate
</cfquery>

<cfreport template="Expenses.cfr"
          query="Expenses"
          format="PDF" />
