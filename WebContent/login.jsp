<%@ page contentType="text/html; charset=utf-8" language="java"%>

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
<form name="form1" method="post" action="manager.do?action=login">
<div class="box">
<h1>管理员登录</h1>

<input type="text"  style="color:black" name="name" placeholder="Your Username "  class="admin" />
  
<input type="password"  style="color:black" name="pwd" placeholder="Your Password " class="admin" />

<div>
<input name="Submit" class="btn" type="submit"value="登录" onClick="return check(form1)"></div>
                                             
<a href="${pageContext.request.contextPath }/login_reader.jsp"><div id="btn2">读者登录</div></a>

<input name="reset" type="reset" class="btn3" value="reset">
  
</div> 
  
</form>

<p>Forgot your password? <u style="color:#f1c40f;">Click Here!</u></p>

</html>
