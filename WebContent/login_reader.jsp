<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<head>
<title>图书馆管理系统</title>
<link rel="stylesheet" href="CSS/style1.css">
<link href="CSS/family.css" rel='stylesheet' type='text/css'>

<script language="javascript">
function check(form){
	if (form.name.value==""){
		alert("请输入用户名!");form.name.focus();return false;
	}
	if (form.pwd.value==""){
		alert("请输入密码!");form.pwd.focus();return false;
	}	
}
</script>
</head>
<body class="login_body">
<form name="form1" method="post" action="reader.do?action=login_reader">
<div class="box">
<h1>读者登录</h1>

<input type="text" style="color: #000000;" name="name" placeholder="Your Username "  class="admin" />
  
<input type="password" style="color: #000000;" name="password" placeholder="Your Password " class="admin" />

<div>
<input name="Submit" class="btn" type="submit"value="登录" onClick="return check(form1)"></div>
                                             
<input name="reset" type="reset" class="btn3" value="reset">
  
</div> 
  
</form>

<p>Forgot your password? <u style="color:#f1c40f;">Click Here!</u></p>
</html>