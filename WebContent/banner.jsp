<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.core.ChStr"%>
<%
	ChStr chStr = new ChStr();
	String user = (String) session.getAttribute("user");
	//验证用户是否登录
	if (user == null || "".equals(user)) {
		response.sendRedirect("login.jsp");
	}
%>
<script language="javascript">
	function myclose() {
		if (confirm("真的要关闭当前窗口吗?")) {
			window.close();
		}
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">


<div class="banner">
	<div id="banner_1"><a href="#"
						onClick="window.location.reload();" class="word_dark">刷新页面</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="#" onClick="myclose()"
						class="word_dark">关闭系统</a></div>
	<div id="banner_2"> 当前登录用户：${user}</div>
</div>

