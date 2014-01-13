<!--- 
  Filename:     LoginForm.cfm
  Created by:   Nate Weiss (NMW)
  Purpose:      Presented whenever a user has not logged in yet
  Please Note:  Included by Application.cfm
--->


<!--- This template defines the PassUrlVars() and PassFormVars() functions --->
<!--- These functions are user defined and can be adapted as needed --->
<cfinclude template="VarPassingFunctions.cfm">


<html>
<head>
  <title>Please Log In</title>
</head>

<!--- Place cursor in "User Name" field when page loads--->
<body onLoad="document.loginForm.userLogin.focus();">



<!--- Start our Login Form --->
<!--- Use the user-defined PassUrlVars() function in ACTION to make sure --->
<!--- that any URL variables are passed forward appropriately --->
<cfform action="#CGI.script_name#?#PassUrlVars()#" name="loginForm" 
  method="post" preservedata="yes">
  
  <!--- Use the user-defined PassFormVars() function to make sure --->
  <!--- that any form variables are passed forward appropriately --->
  <cfoutput>#passFormVars("UserLogin,UserPassword")#</cfoutput>
  
  <!--- Make the UserLogin and UserPassword fields required --->
  <input type="hidden" name="userLogin_required">
  <input type="hidden" name="userPassword_required">

  <!--- Use an HTML table for simple formatting --->
  <table border="0">
    <tr><th colspan="2" bgcolor="silver">Please Log In</th></tr>
    <tr>
      <th>Username:</th>
      <td>
        
      <!--- Text field for "User Name" --->  
      <cfinput type="text" name="userLogin" size="20" value=""
        maxlength="100" required="yes"
        message="Please type your Username first.">

      </td>
    </tr><tr>
      <th>Password:</th>
      <td>
    
      <!--- Text field for Password --->  
      <cfinput type="password" name="userPassword" size="12" value=""
        maxlength="100" required="yes"
        message="Please type your Password first.">

      <!--- Submit Button that reads "Enter" --->  
      <input type="submit" value="Enter">
        
      </td>
    </tr>
  </table>
  
</cfform>

</body>
</html>

