<%@page import="com.dao.ReaderDAO"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.dao.ManagerDAO"%>
<%@ page import="com.actionForm.ManagerForm"%>
<%
	String user_name = (String) session.getAttribute("user");
	Integer user_id = (Integer) session.getAttribute("user_id");
	ManagerDAO managerDAO = new ManagerDAO();
	ManagerForm form1 = (ManagerForm) managerDAO.query_p(user_name);
	ReaderDAO readerDAO = new ReaderDAO();
	boolean b = readerDAO.query_p(user_name);
	int sysset1 = 0;
	int readerset1 = 0;
	int bookset1 = 0;
	int borrowback1 = 0;
	int sysquery1 = 0;
	if (form1 != null) {
		sysset1 = form1.getSysset();
		readerset1 = form1.getReaderset();
		bookset1 = form1.getBookset();
		borrowback1 = form1.getBorrowback();
		sysquery1 = form1.getSysquery();
	} else {
		sysquery1 = 1;

	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<nav class="navbar navbar-default" role="navigation">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#example-navbar-collapse">
				<span class="sr-only">切换导航</span> <span class="icon-bar"></span> <span
					class="icon-bar"></span> <span class="icon-bar"></span>
			</button>
			<a class="navbar-brand">tyhu图书馆</a>
		</div>
		<div class="collapse navbar-collapse" id="example-navbar-collapse">
			<ul class="nav navbar-nav navbar-left">
				<li class="dropdown"><a
					href="${pageContext.request.contextPath }/main.jsp"
					onclick="onListBookButtonClicked()"> 首页 </a></li>


				<%
					if (form1 == null) {
				%><li class="dropdown"><a
					href="reader.do?action=readerModifyQuery&ID=<%=user_id%>"
					class="dropdown-toggle">个人信息</a>
				</li>
				<%
					}
				%>


				<%
					if (form1 != null) {
				%>
				<li class="dropdown"><a
					<c:if test="<%=(readerset1==1) %>">data-toggle="dropdown"</c:if>
					href="#" class="dropdown-toggle"> 读者管理 <b class="caret"></b> </a>
					<ul class="dropdown-menu">
						<li class="divider"></li>
						<li><a
							href="${pageContext.request.contextPath }/readerType.do?action=readerTypeQuery"
							onclick="onListBookButtonClicked()">读者类型管理</a>
						</li>
						<li class="divider"></li>
						<li><a
							href="${pageContext.request.contextPath }/reader.do?action=readerQuery"
							onclick="onAddBookButtonClicked()" data-toggle="modal">读者档案管理</a>
						</li>
					</ul>
				</li>
				<%
					}
				%>
				<%
					if (form1 != null) {
				%>
				<li class="dropdown"><a
					<c:if test="<%=(bookset1==1) %>">data-toggle="dropdown"</c:if>
					href="#" class="dropdown-toggle"> 图书管理 <b class="caret"></b> </a>
					<ul class="dropdown-menu">
						<li class="divider"></li>
						<li><a href="bookType.do?action=bookTypeQuery"
							onclick="onListAuthorButtonClicked()">图书类型管理</a>
						</li>
						<li class="divider"></li>
						<li><a href="book.do?action=bookQuery"
							onclick="onAddAuthorButtonClicked()" data-toggle="modal">图书档案管理</a>
						</li>

					</ul>
				</li>
				<%
					}
				%>
				<%
					if (form1 != null) {
				%>
				<li class="dropdown"><a
					<c:if test="<%=(borrowback1==1) %>">data-toggle="dropdown"</c:if>
					href="#" class="dropdown-toggle"> 图书借还 <b class="caret"></b> </a>
					<ul class="dropdown-menu">
						<li class="divider"></li>
						<li><a href="bookBorrow.jsp"
							onclick="onListAuthorButtonClicked()">图书借阅</a>
						</li>
						<li class="divider"></li>
						<li><a href="bookBack.jsp"
							onclick="onAddAuthorButtonClicked()">图书归还</a></li>
						<li class="divider"></li>
						<li><a <c:if test="<%=(borrowback1!=1)&&b %>">href="#"</c:if>
							href="bookRenew.jsp" onclick="onAddAuthorButtonClicked()">图书续借</a>
						</li>

					</ul>
				</li>
				<%
					}
				%>
				<li class="dropdown"><a
					<c:if test="<%=(sysquery1==1) %>">data-toggle="dropdown"</c:if>
					href="#" class="dropdown-toggle"> 系统查询 <b class="caret"></b> </a>
					<ul class="dropdown-menu">
						<li class="divider"></li>
						<li><a href="book.do?action=bookifQuery"
							onclick="onListAuthorButtonClicked()">图书查询</a>
						</li>
						<li class="divider"></li>
						<li><a href="borrow.do?action=borrowQuery"
							onclick="onAddAuthorButtonClicked()" data-toggle="modal">借阅查询</a>
						</li>
						<li class="divider"></li>
						<li><a href="borrow.do?action=Bremind"
							onclick="onQueryAuthorButtonClicked()" data-toggle="modal">借阅到期查询</a>
						</li>
					</ul>
				</li>
				<%
					if (form1 != null) {
				%>
				<li class="dropdown"><a
					<c:if test="<%=(sysset1==1) %>">data-toggle="dropdown"</c:if>
					href="#" class="dropdown-toggle">系统设置<b class="caret"></b> </a>
					<ul class="dropdown-menu">
						<li class="divider"></li>
						<li><a href="manager.do?action=managerQuery"
							onclick="onListAuthorButtonClicked()">管理员设置</a>
						</li>
						<li class="divider"></li>
						<li><a href="parameter.do?action=parameterQuery"
							onclick="onAddAuthorButtonClicked()" data-toggle="modal">参数设置</a>
						</li>
						<li class="divider"></li>
						<li><a href="bookCase.do?action=bookCaseQuery"
							onclick="onQueryAuthorButtonClicked()" data-toggle="modal">书架设置</a>
						</li>

					</ul>
				</li>
				<%
					}
				%>
				<li class="dropdown">
					<%
						if (form1 == null) {
					%><a href="reader.do?action=querypwd" class="dropdown-toggle">
						更改口令</a> <%
 	} else {
 %> <a href="manager.do?action=querypwd" class="dropdown-toggle">
						更改口令</a> <%
 	}
 %>
				</li>



				<li class="dropdown"><a href="login.jsp"
					class="dropdown-toggle"> 退出登录</a></li>
			</ul>
		</div>
	</div>
</nav>
