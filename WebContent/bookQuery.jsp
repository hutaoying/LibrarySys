<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
<%@ page import="com.dao.BookDAO"%>
<%@ page import="com.actionForm.BookForm"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<%
	Collection coll = (Collection) request.getAttribute("ifbook");
%>
<head>
<link rel="stylesheet"
	href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath }/JS/bootstrapmin.js"></script>

<title>图书馆管理系统</title>
<link href="CSS/style.css" rel="stylesheet">
<link rel="stylesheet" href="CSS/style1.css">
<link href="CSS/family.css" rel='stylesheet' type='text/css'>
</head>
<body onLoad="clockon(bgclock)" >
	<%@include file="banner.jsp"%>
	<%@include file="navigation.jsp"%>
	<div class="book_query">
		<div class="book_query1">当前位置：系统查询&gt; 图书档案查询 &gt;&gt;&gt;</div>
		<div class="book_query2">
			<form action="" method="post" name="form1">
				<div class="book_query3">
					<img src="Images/search.gif" width="45" height="28"> 请选择查询依据： <select
						name="f" class="wenbenkuang" id="f">
						<option value="barcode">条形码</option>
						<option value="typename">类别</option>
						<option value="bookname" selected>书名</option>
						<option value="author">作者</option>
						<option value="pub_name">出版社</option>
						<option value="bookcasename">书架</option>
					</select> <input name="key" type="text" id="key" size="50" value="${f }"> <input
						name="Submit" type="submit" class="btn_grey" value="查询">

				</div>

				<%
					if (coll == null || coll.isEmpty()) {
				%>
				<table width="100%" height="30" border="0" cellpadding="0"
					cellspacing="0">
					<tr>
						<td height="36" align="center">暂无图书信息！</td>
					</tr>
				</table>
				<%
					} else {
						//通过迭代方式显示数据
						Iterator it = coll.iterator();
						int ID = 0;
						String bookname = "";
						String barcode = "";
						String typename = "";
						String publishing = "";
						String bookcase = "";
						String author="";
						int storage = 0;
				%>
			</form>
				<div class="book_query4">
					<table width="950" border="1" cellpadding="0" cellspacing="0"
						bordercolor="#FFFFFF" bordercolordark="#F6B83B"
						bordercolorlight="#FFFFFF" align="center">
						<tr align="center" bgcolor="#e3F4F7">
							<td width="18%" bgcolor="#F9D16B">条形码</td>
							<td width="20%" bgcolor="#F9D16B">图书名称</td>
							<td width="14%" bgcolor="#F9D16B">图书类型</td>
							<td width="16%" bgcolor="#F9D16B">作者</td>
							<td width="19%" bgcolor="#F9D16B">出版社</td>
							<td width="2" bgcolor="#F9D16B">书架</td>
						</tr>
						<%
							while (it.hasNext()) {
									BookForm bookForm = (BookForm) it.next();
									ID = bookForm.getId().intValue();
									bookname = bookForm.getBookName();
									barcode = bookForm.getBarcode();
									if (barcode == null)
										barcode = "";
									typename = bookForm.getTypeName();
									author=bookForm.getAuthor();
									publishing = bookForm.getPublishing();
									bookcase = bookForm.getBookcaseName();
						%>
						<tr >
							<td style="padding:5px;"align="center">&nbsp; <%=barcode%></td>
							<td style="padding:5px;" align="center"><a
								href="book.do?action=bookDetail&ID=<%=ID%>"> <%=bookname%> </a>
							</td>
							<td style="padding:5px;"align="center">&nbsp; <%=typename%></td>
							<td style="padding:5px;"align="center">&nbsp; <%=author%></td>
							<td style="padding:5px;"align="center">&nbsp; <%=publishing%></td>
							<td style="padding:5px;"align="center">&nbsp; <%=bookcase%></td>
						</tr>
						<%
							}
							}
						%>
						</table>
						
						</div>
						

						</div>

						</div>
						<div class="copyright">
						<%@ include file="copyright.jsp"%>
						</div>
						
</body>
</html>
