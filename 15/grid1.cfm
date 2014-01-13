<!---
Name:        grid1.cfm
Author:      Ben Forta (ben@forta.com)
Description: Basic data grid
Created:     07/07/07
--->

<!--- Get movies --->
<cfinvoke component="movies"
          method="list"
          returnvariable="movies">

<!--- Page header --->
<cfinclude template="header.cfm">

<!--- Display grid --->
<cfform>
<cfgrid name="movieGrid"
        width="100%"
        format="html"
        query="movies" />
</cfform>

<!--- Page footer --->
<cfinclude template="footer.cfm">
