<cfset CurrentPage=GetFileFromPath(GetBaseTemplatePath())>
<cfparam name="PageNum_art" default="1">
<cfquery name="art" datasource="cfartgallery">
SELECT *
FROM APP.ART
ORDER BY ARTNAME ASC 
</cfquery>
<cfset MaxRows_art=10>
<cfset StartRow_art=Min((PageNum_art-1)*MaxRows_art+1,Max(art.RecordCount,1))>
<cfset EndRow_art=Min(StartRow_art+MaxRows_art-1,art.RecordCount)>
<cfset TotalPages_art=Ceiling(art.RecordCount/MaxRows_art)>
<cfset QueryString_art=Iif(CGI.QUERY_STRING NEQ "",DE("&"&XMLFormat(CGI.QUERY_STRING)),DE(""))>
<cfset tempPos=ListContainsNoCase(QueryString_art,"PageNum_art=","&")>
<cfif tempPos NEQ 0>
  <cfset QueryString_art=ListDeleteAt(QueryString_art,tempPos,"&")>
</cfif>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Art List</title>
</head>

<body>
<p>[<a href="<cfoutput>#CurrentPage#?PageNum_art=1#QueryString_art#</cfoutput>">&lt;&lt; First</a>] [<a href="<cfoutput>#CurrentPage#?PageNum_art=#Max(DecrementValue(PageNum_art),1)##QueryString_art#</cfoutput>">&lt; Previous</a>] [<a href="<cfoutput>#CurrentPage#?PageNum_art=#Min(IncrementValue(PageNum_art),TotalPages_art)##QueryString_art#</cfoutput>">Next &gt;</a>] [<a href="<cfoutput>#CurrentPage#?PageNum_art=#TotalPages_art##QueryString_art#</cfoutput>">Last &gt;&gt;</a>]</p>
<table border="0">
  <tr>
    <th scope="col">Title</th>
    <th scope="col">Description</th>
    <th scope="col">Price</th>
  </tr>
  <cfoutput query="art" startRow="#StartRow_art#" maxRows="#MaxRows_art#">
    <tr>
      <td>#art.ARTNAME#</td>
      <td>#art.DESCRIPTION#</td>
      <td>#art.PRICE#</td>
    </tr>
  </cfoutput>
</table>
</body>
</html>
