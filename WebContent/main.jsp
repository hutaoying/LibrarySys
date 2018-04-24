<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ page import="com.dao.BorrowDAO"%>

<%@ page import="com.actionForm.BorrowForm"%>
<%@ page import="java.util.*"%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
<body onLoad="clockon(bgclock)" class="main_body">
	<%@include file="banner.jsp"%>
	<%@include file="navigation.jsp"%>
	<%
		BorrowDAO borrowDAO = new BorrowDAO();
		Collection coll_book = (Collection) borrowDAO.bookBorrowSort();
	%>
	<table class="tableBorder_gray" align="center">
		<tr>
			<td align="center" valign="top" style="padding:5px;"><table
					width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td height="20" align="right" valign="middle" class="word_orange">当前位置：首页
							&gt;&gt;&gt;&nbsp;</td>
					</tr>
					<tr>
						<td valign="top"><table width="100%" border="0"
								cellspacing="0" cellpadding="0">
								<tr>
									<td height="57" background="Images/main_booksort.gif">&nbsp;</td>
								</tr>
								<tr >
									<td height="72" valign="top"><table width="100%"
											height="63" border="0" cellpadding="0" cellspacing="0">
											<tr>
												<td width="2%" rowspan="2">&nbsp;</td>
												<td width="96%" align="center" valign="top"><table
														width="100%" border="1" cellpadding="0" cellspacing="0"
														bordercolor="#FFFFFF" bordercolordark="#B7B6B6"
														bordercolorlight="#FFFFFF">
														<tr align="center">
															<td width="5%" height="25">排名</td>
															<td width="10%">图书条形码</td>
															<td width="24%">图书名称</td>
															<td width="10%">图书类型</td>
															<td width="10%">书架</td>
															<td width="14%">出版社</td>
															<td width="11%">作者</td>
															<td>定价(元)</td>
															<td>借阅次数</td>
														</tr>
														<%
															if (coll_book != null && !coll_book.isEmpty()) {
																Iterator it_book = coll_book.iterator();
																int i = 1;
																int degree = 0;
																String bookname = "";
																String typename = "";
																String barcode_book = "";
																String bookcase = "";
																String pub = "";
																String author = "";
																String translator = "";
																Float price = new Float(0);
																while (it_book.hasNext() && i < 6) {
																	BorrowForm borrowForm = (BorrowForm) it_book.next();
																	bookname = borrowForm.getBookName();
																	barcode_book = borrowForm.getBookBarcode();
																	typename = borrowForm.getBookType();
																	degree = borrowForm.getDegree();
																	bookcase = borrowForm.getBookcaseName();
																	pub = borrowForm.getPubName();
																	author = borrowForm.getAuthor();
																	price = borrowForm.getPrice();
														%>
														<tr>
															<td height="25" align="center"><%=i%></td>
															<td style="padding:5px;"align="center">&nbsp;<%=barcode_book%></td>
															<td style="padding:5px;"align="center"><%=bookname%></td>
															<td style="padding:5px;"align="center"><%=typename%></td>
															<td align="center">&nbsp;<%=bookcase%></td>
															<td align="center">&nbsp;<%=pub%></td>
															<td width="11%" align="center"><%=author%></td>
															<td width="8%" align="center"><%=price%></td>
															<td width="8%" align="center"><%=degree%></td>
														</tr>
														<%
															i++;
																}
															}
														%>
													</table>
												</td>
												<td width="2%" rowspan="2">&nbsp;</td>
											</tr>
											<tr>
												<td height="30" align="right" valign="middle"><a
													href=borrow.do?action=bookBorrowSort><img
														src="Images/more.GIF" width="50" height="20" border="0">&nbsp;</a>
												</td>
											</tr>
										</table></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<%@ include file="copyright.jsp"%>
</body>
</html>