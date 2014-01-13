<cfset CurrentPage=GetFileFromPath(GetTemplatePath())>
<cfparam name="PageNum_movies" default="1">
<cfinvoke
  component="ows.11.movies"
  method="List"
  returnvariable="movies">
</cfinvoke>
<cfset MaxRows_movies=10>
<cfset StartRow_movies=Min((PageNum_movies-1)*MaxRows_movies+1,Max(movies.RecordCount,1))>
<cfset EndRow_movies=Min(StartRow_movies+MaxRows_movies-1,movies.RecordCount)>
<cfset TotalPages_movies=Ceiling(movies.RecordCount/MaxRows_movies)>
<cfset QueryString_movies=Iif(CGI.QUERY_STRING NEQ "",DE("&"&XMLFormat(CGI.QUERY_STRING)),DE(""))>
<cfset tempPos=ListContainsNoCase(QueryString_movies,"PageNum_movies=","&")>
<cfif tempPos NEQ 0>
  <cfset QueryString_movies=ListDeleteAt(QueryString_movies,tempPos,"&")>
</cfif>

<table border="0" width="50%" align="center">
  <cfoutput>
    <tr>
      <td width="23%" align="center"><cfif PageNum_movies GT 1>
          <a href="#CurrentPage#?PageNum_movies=1#QueryString_movies#">First</a>
        </cfif>
      </td>
      <td width="31%" align="center"><cfif PageNum_movies GT 1>
          <a href="#CurrentPage#?PageNum_movies=#Max(DecrementValue(PageNum_movies),1)##QueryString_movies#">Previous</a>
        </cfif>
      </td>
      <td width="23%" align="center"><cfif PageNum_movies LT TotalPages_movies>
          <a href="#CurrentPage#?PageNum_movies=#Min(IncrementValue(PageNum_movies),TotalPages_movies)##QueryString_movies#">Next</a>
        </cfif>
      </td>
      <td width="23%" align="center"><cfif PageNum_movies LT TotalPages_movies>
          <a href="#CurrentPage#?PageNum_movies=#TotalPages_movies##QueryString_movies#">Last</a>
        </cfif>
      </td>
    </tr>
  </cfoutput>
</table>
<table border="1">
  <tr>
    <td>FilmID</td>
    <td>MovieTitle</td>
    <td>PitchText</td>
    <td>Summary</td>
    <td>DateInTheaters</td>
  </tr>
  <cfoutput query="movies" startRow="#StartRow_movies#" maxRows="#MaxRows_movies#">
    <tr>
      <td>#movies.FilmID#</td>
      <td>#movies.MovieTitle#</td>
      <td>#movies.PitchText#</td>
      <td>#movies.Summary#</td>
      <td>#movies.DateInTheaters#</td>
    </tr>
  </cfoutput>
</table>
