<!---
Name:        login1.cfm
Author:      Ben Forta (ben@forta.com)
Description: Basic server-side validation
Created:     07/01/07
--->

<html>

<head>
  <title>Orange Whip Studios - Intranet</title>
</head>

<body>

<!--- Page header --->
<cfinclude template="header.cfm">

<!--- Login form --->
<form action="process1.cfm" method="post">

<table align="center" bgcolor="orange">
  <tr>
    <td align="right">
      ID:
    </td>
    <td>
      <input type="text"
             name="LoginID"
             maxlength="5">
    </td>
  </tr>
  <tr>
    <td align="right">
      Password:
    </td>
    <td>
      <input type="password"
             name="LoginPassword"
             maxlength="20">
    </td>
  </tr>
  <tr>
    <td colspan="2" align="center">
      <input type="submit" value="Login">
    </td>
 </tr>
</table>

</form>

</body>

</html>
