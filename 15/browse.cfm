<!---
Name:        browse.cfm
Author:      Ben Forta (ben@forta.com)
Description: Demonstrate using bindings
Created:     07/07/07
--->

<!--- Page header --->
<cfinclude template="header.cfm">

<!--- Display --->
<cfform>

<table>
<tr valign="top">

<!--- The grid --->
<td>
<cfgrid name="movieGrid"
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
                 display="no">
</cfgrid>
</td>

<!--- Summary box --->
<td>
<cftextarea name="summary" rows="15"  cols="50"
            bind="{movieGrid.summary}" />
</td>

</tr>
</table>
</cfform>

<!--- Page footer --->
<cfinclude template="footer.cfm">
