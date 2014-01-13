<!---
Name:        grid3.cfm
Author:      Ben Forta (ben@forta.com)
Description: Ajax data grid
Created:     07/07/07
--->

<!--- Page header --->
<cfinclude template="header.cfm">

<!--- Display grid --->
<cfform>
<cfgrid name="movieGrid"
        width="100%"
        format="html"
        pagesize="10"
        striperows="yes"
        bind="cfc:movies.browse({cfgridpage},
                                {cfgridpagesize},
                                {cfgridsortcolumn},
                                {cfgridsortdirection})">
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
