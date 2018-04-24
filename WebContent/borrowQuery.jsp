<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
<%@ page import="com.dao.BorrowDAO"%>
<%@ page import="com.actionForm.BorrowForm"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<%
	Collection coll = (Collection) request.getAttribute("borrowQuery");
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
<script src="JS/function.js"></script>
<script language="javascript">
	function check(myform) {
		if (myform.flag[0].checked == false && myform.flag[1].checked == false) {
			alert("请选择查询方式!");
			return false;
		}
		if (myform.flag[1].checked) {
			if (myform.sdate.value == "") {
				alert("请输入开始日期");
				myform.sdate.focus();
				return false;
			}
			if (CheckDate(myform.sdate.value)) {
				alert("您输入的开始日期不正确（如：2006-07-05）\n 请注意闰年!");
				myform.sDate.focus();
				return false;
			}
			if (myform.edate.value == "") {
				alert("请输入结束日期");
				myform.edate.focus();
				return false;
			}
			if (CheckDate(myform.edate.value)) {
				alert("您输入的结束日期不正确（如：2006-07-05）\n 请注意闰年!");
				myform.edate.focus();
				return false;
			}
		}
	}
</script>
</head>
<body onLoad="clockon(bgclock)">
	<%@include file="banner.jsp"%>
	<%@include file="navigation.jsp"%>


	<div class="book_query" style="background:#ffffff">
		<div class="book_query1">当前位置：系统查询 &gt; 图书借阅查询 &gt;&gt;&gt;</div>
		<div class="book_query2">
			<form name="myform" method="post"
				action="borrow.do?action=borrowQuery">
				<div class="book_query3">
					<img src="Images/search.gif" width="45" height="28"> <input
						name="flag" type="checkbox" class="noborder" value="a" checked>请选择查询依据：
					<select name="f" class="wenbenkuang" id="f">
						<option value="barcode">图书条形码</option>
						<option value="bookname">图书名称</option>
						<option value="numid">学号/教职工号</option>
						<option value="readername">读者名称</option>
					</select> <input name="key" type="text" id="key" size="50"> <input
						name="Submit" type="submit" class="btn_grey" value="查询"
						onClick="return check(myform)">

				</div>
				<div class="book_query3_1">

					<input name="flag" type="checkbox" class="noborder" value="b">
					借阅时间： 从 <input name="sdate" type="text" id="sdate"> 到 <input
						name="edate" type="text" id="edate"> (日期格式为：2006-07-05)
				</div>
			</form>
		</div>

		<div class="book_query5">
			<%
				if (coll == null || coll.isEmpty()) {
			%>
			<table width="100%" height="30" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td height="36" align="center">暂无图书借阅信息！</td>
				</tr>
			</table>
			<%
				} else {
					//通过迭代方式显示数据
					Iterator it = coll.iterator();
					String bookname = "";
					String bookbarcode = "";
					String numid = "";
					String readername = "";
					String borrowTime = "";
					String backTime = "";
					int ifback = 0;
					String ifbackstr = "";
			%>
			<table width="98%" border="1" cellpadding="0" cellspacing="0"
				bordercolor="#FFFFFF" bordercolordark="#F6B83B"
				bordercolorlight="#FFFFFF" align="center">
				<tr align="center" bgcolor="#e3F4F7">
					<td width="11%" bgcolor="#F9D16B">图书条形码</td>
					<td width="27%" bgcolor="#F9D16B">图书名称</td>
					<td width="15%" bgcolor="#F9D16B">读者条形码</td>
					<td width="13%" bgcolor="#F9D16B">读者名称</td>
					<td width="13%" bgcolor="#F9D16B">借阅时间</td>
					<td width="13%" bgcolor="#F9D16B">应还时间</td>
					<td width="8%" bgcolor="#F9D16B">是否归还</td>
				</tr>
				<%
					while (it.hasNext()) {
							BorrowForm borrowForm = (BorrowForm) it.next();
							bookname = borrowForm.getBookName();
							bookbarcode = borrowForm.getBookBarcode();
							numid = borrowForm.getNumId();
							readername = borrowForm.getReaderName();
							borrowTime = borrowForm.getBorrowTime();
							backTime = borrowForm.getBackTime();
							ifback = borrowForm.getIfBack();
							if (ifback == 0) {
								ifbackstr = "未归还";
							} else {
								ifbackstr = "已归还";
							}
				%>
				<tr>
					<td style="padding:5px;">&nbsp;<%=bookbarcode%></td>
					<td style="padding:5px;" align="center"><%=bookname%></td>
					<td style="padding:5px;" align="center">&nbsp;<%=numid%></td>
					<td style="padding:5px;" align="center">&nbsp;<%=readername%></td>
					<td style="padding:5px;" align="center">&nbsp;<%=borrowTime%></td>
					<td style="padding:5px;" align="center">&nbsp;<%=backTime%></td>
					<td align="center" style="padding:5px;" align="center">&nbsp;<%=ifbackstr%></td>
				</tr>
				<%
					}
					}
				%>

</table>
</div>
				</div>
				<div class="copyright">
					<%@ include file="copyright.jsp"%>
				</div></body>
</html>
