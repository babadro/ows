<!---
Name:        grid2.cfm
Author:      Ben Forta (ben@forta.com)
Description: Controlling data grid display
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
        query="movies">
   <cfgridcolumn name="FilmID"
                 display="no">
   <cfgridcolumn name="MovieTitle"
                 header="Title"
                 width="200">
   <cfgridcolumn name="Rating"
                 header="Rating"
                 width="100">
   <cfgridcolumn name="Summary"
                 header="Summary"
                 width="400">
</cfgrid>
</cfform>

<!--- Page footer --->
<cfinclude template="footer.cfm">
