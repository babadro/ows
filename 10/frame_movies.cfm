<!---
Name:        frame_movies.cfm
Author:      Ben Forta (ben@forta.com)
Description: Left frame for data drill-down
Created:     07/01/07
--->

<!--- Get movie list from database --->
<cfquery name="movies" datasource="ows" result="result">
SELECT FilmID, MovieTitle
FROM Films 
ORDER BY MovieTitle
</cfquery>

<body>

<!--- title and movine count --->
<cfoutput>
<strong>
Movie List (#result.RecordCount# movies)
</strong>
</CFOUTPUT>

<!--- Movie list --->
<ul>
 <cfoutput query="movies">
 <li><a href="frame_details.cfm?filmid=#URLEncodedFormat(Trim(FilmID))#" target="right">#MovieTitle#</a>
 </cfoutput>
</ul>

</body>
