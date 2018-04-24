<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.dao.BookTypeDAO" %>
<%@ page import="com.actionForm.BookTypeForm" %>
<%@ page import="java.util.*"%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<%
Collection coll=(Collection)request.getAttribute("bookType");
%>
<head>
<link rel="stylesheet"
	href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath }/JS/bootstrapmin.js"></script>
    
<title>图书馆管理系统</title>
<link href="CSS/style.css" rel="stylesheet">
<link rel="stylesheet" href="CSS/style1.css">
<link href="CSS/family.css" rel='stylesheet' type='text/css'>
</head>
<body onLoad="clockon(bgclock)"class="main_body">
<%@include file="banner.jsp"%>
<%@include file="navigation.jsp"%>
<table width="778"  border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td valign="top" bgcolor="#FFFFFF"><table width="99%" height="510"  border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="tableBorder_gray">
  <tr>
    <td height="510" valign="top" style="padding:5px;"><table width="98%" height="487"  border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="22" valign="top" class="word_orange">当前位置：图书管理 &gt; 图书类型设置 &gt;&gt;&gt;</td>
      </tr>
      <tr>
        <td align="center" valign="top"><%
if(coll==null || coll.isEmpty()){
%>
          <table width="100%" height="30"  border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td height="36" align="center">暂无图书类型信息！</td>
            </tr>
          </table>
          <table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <a href="${pageContext.request.contextPath }/bookType_add.jsp" target='_blank'>添加图书类型信息</a> </td>
  </tr>
</table>
 <%
}else{
  //通过迭代方式显示数据
  Iterator it=coll.iterator();
  int ID=0;
  String typename="";
  int days=0;
  %>
 <table width="91%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="82%">&nbsp;      </td>
<td width="18%" align="right">
      <a href="${pageContext.request.contextPath }/bookType_add.jsp" target='_blank'>添加图书类型信息</a> </td>	  
  </tr>
</table>  
  <table width="91%"  border="1" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolordark="#F6B83B" bordercolorlight="#FFFFFF">
  <tr align="center" bgcolor="#e3F4F7">
    <td width="35%" bgcolor="#F9D16B">图书类型名称</td>
    <td width="35%" bgcolor="#F9D16B">可借天数</td>
    <td width="16%" bgcolor="#F9D16B">修改</td>
    <td width="14%" bgcolor="#F9D16B">删除</td>
  </tr>
<%
  while(it.hasNext()){
    BookTypeForm bookTypeForm=(BookTypeForm)it.next();
	ID=bookTypeForm.getId().intValue();
	typename=bookTypeForm.getTypeName();
	days=bookTypeForm.getDays();
	%> 
  <tr>
    <td align="center" style="padding:5px;"><%=typename%></td>
    <td align="center" style="padding:5px;"><%=days%></td>
   
    <td align="center"><a href="${pageContext.request.contextPath }/bookType.do?action=bookTypeModifyQuery&ID=<%=ID%>" target='_blank'>修改</a></td>
    <td align="center"><a href="${pageContext.request.contextPath }/bookType.do?action=bookTypeDel&ID=<%=ID%>">删除</a></td>
  </tr>
<%
  }
}
%>  
</table></td>
      </tr>
    </table>
</td>
  </tr>
</table><%@ include file="copyright.jsp"%></td>
  </tr>
</table>
</body>
</html>
