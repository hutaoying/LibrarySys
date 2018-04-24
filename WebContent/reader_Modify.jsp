<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.dao.ReaderDAO" %>
<%@ page import="com.dao.ReaderTypeDAO" %>
<%@ page import="com.actionForm.ReaderForm" %>
<%@ page import="com.actionForm.ReaderTypeForm"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ page import="java.util.Date " %>
<html>
<%
String str=null;
ReaderTypeDAO readerTypeDAO=new ReaderTypeDAO();
Collection coll=(Collection)readerTypeDAO.query(str);
Iterator it=coll.iterator();
ReaderForm readerForm=(ReaderForm)request.getAttribute("readerQueryif");
%>
<script language="jscript">
function check(form){
	if(form.name.value==""){
		alert("请输入读者姓名!");form.name.focus();return false;
	}
	if(form.paperNO.value==""){
		alert("请输入证件号码!");form.paperNO.focus();return false;
	}
}
</script>
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
<body onLoad="clockon(bgclock)">
<%@include file="banner.jsp"%>
<%@include file="navigation.jsp"%>
<table width="778"  border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td valign="top" bgcolor="#FFFFFF"><table width="99%" height="510"  border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="tableBorder_gray">
  <tr>
    <td height="510" valign="top" style="padding:5px;"><table width="98%" height="487"  border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="22" valign="top" class="word_orange">当前位置：读者管理 &gt; 读者档案管理 &gt; 修改读者信息 &gt;&gt;&gt;</td>
      </tr>
      <tr>
        <td align="center" valign="top"><table width="100%" height="493"  border="0" cellpadding="0" cellspacing="0">
  <tr>
<%  Integer ID=readerForm.getId();
  String name=readerForm.getName();
  String sex=readerForm.getSex();  
  String numid=readerForm.getNumid();
  String vocation=readerForm.getVocation();
  String birthday=readerForm.getBirthday();
  String paperType=readerForm.getPaperType();
  String paperNO=readerForm.getPaperNO();
  String tel=readerForm.getTel();
  String email=readerForm.getEmail();
  Date createDate=readerForm.getCreateDate();
  String remark=readerForm.getRemark();
  String operator=readerForm.getOperator();
  int typeid=readerForm.getTypeid();
  String typename=readerForm.getTypename();
  String typeName="";
  int typeID=0;
  %>
    <td align="center" valign="top">
	<form name="form1" method="post" action="reader.do?action=readerModify">
	<table width="600" height="432"  border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <tr>
        <td width="173" align="center">姓&nbsp;&nbsp;&nbsp;&nbsp;名：</td>
        <td width="427" height="39">
          <input name="name" type="text" value="<%=name%>" readonly="yes"> 
          *         
          <input name="id" type="hidden" id="id" value="<%=ID%>"></td>
      </tr>
      <tr>
        <td width="173" align="center">性&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
        <td height="35"><input name="sex" type="radio" class="noborder" id="radiobutton" value="男" <%if("男".equals(sex)) out.println("checked");%>>
          <label for="radiobutton">男 </label>
          <label>
          <input name="sex" type="radio" class="noborder" value="女" <%if("女".equals(sex)) out.println("checked");%>>
          女</label></td>
      </tr>
      <tr>
        <td align="center">条&nbsp;形&nbsp;码：</td>
        <td><input name="numid" type="text" id="barcode" value="<%=numid%>" readonly="yes"></td>
      </tr>
      <tr>
        <td align="center">读者类型：</td>
        <td>
		<select name="typeid" class="wenbenkuang" id="typeid">
<%
  while(it.hasNext()){
    ReaderTypeForm readerTypeForm=(ReaderTypeForm)it.next();
	typeID=readerTypeForm.getId().intValue();
	typeName=readerTypeForm.getName();
	%> 		
				
          <option value="<%=typeID%>" <%if(typeid==typeID) out.println("selected");%>><%=typeName%></option>
<%}%> 
        </select>        </td>
      </tr>
      <tr>
        <td align="center">院&nbsp;&nbsp;&nbsp;&nbsp;系：</td>
        <td><input name="vocation" type="text" id="vocation" value="<%=vocation%>"></td>
      </tr>
      <tr>
        <td align="center">出生日期：</td>
        <td><input name="birthday" type="text" id="birthday" value="<%=birthday%>"></td>
      </tr>
      <tr>
        <td align="center">有效证件：</td>
        <td><select name="paperType" class="wenbenkuang" id="paperType">
          <option value="身份证"<%if("身份证".equals(paperType)) out.println(" selected");%>>身份证</option>
          <option value="学生证"<%if("学生证".equals(paperType)) out.println(" selected");%>>学生证</option>
          
                        </select></td>
      </tr>
      <tr>
        <td align="center">证件号码：</td>
        <td><input name="paperNO" type="text" id="paperNO" value="<%=paperNO%>"> 
          * </td>
      </tr>
      <tr>
        <td align="center">电&nbsp;&nbsp;&nbsp;&nbsp;话：</td>
        <td><input name="tel" type="text" id="tel" value="<%=tel%>"></td>
      </tr>
      <tr>
        <td align="center">Email：</td>
        <td><input name="email" type="text" id="email" value="<%=email%>" size="50">
          <input name="operator" type="hidden" id="operator" value="<%=operator%>"></td>
      </tr>
      <tr>
        <td height="30" align="center">操&nbsp;作&nbsp;员：</td>
        <td><input name="operator" type="text" id="operator" value="<%=operator%>" readonly="yes">
        </td>
      </tr>
      <tr>
        <td align="center">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
        <td><textarea name="remark" cols="50" rows="5" class="wenbenkuang" id="remark"><%=remark%></textarea></td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
        <td><input name="Submit" type="submit" class="btn_grey" value="保存" onClick="return check(form1)">
&nbsp;
<input name="Submit2" type="button" class="btn_grey" value="返回" onClick="history.back()"></td>
      </tr>
    </table>
	</form>
	</td>
  </tr>
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
