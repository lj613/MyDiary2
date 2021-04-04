<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- <script type="text/javascript" src="http://libs.baidu.com/jquery/1.9.1/jquery.js"></script> -->
<title>侧边栏</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

<!--  <style type="text/css">
        #tree a:link{text-decoration:none;}
    </style> -->
<link href="../static/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="../static/iconfont/iconfont.css">
		<script src="../static/js/jquery-3.4.1.min.js"></script>
		<script src="../static/js/bootstrap.min.js"></script>
		<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

html, body {
	font-family: Arial;
	height: 100%;
	background-color: rgba(66, 65, 71, 0.3);
	/* 取消y轴的滚动条 */
	/* overflow: hidden; */
}

a, a:hover, a:focus {
	color: #ffffff;
	text-decoration: none;
}

#menu {
	width: 260px;
	background-color: rgba(66, 65, 71, 0.3);
	height: calc(100% - 85px);
}

#menu .panel {
	color: #fff;
	background-color: rgba(66, 65, 71, 0);
}

#menu .panel-group {
	width: 260px;
	height: 600px;
	overflow-y: auto;
}

#menu .panel-group .panel {
	border: none;
}

#menu .panel-heading {
	border-top-left-radius: 0px;
	border-top-right-radius: 0px;
}

#menu .panel-default>.panel-heading {
	color: #fff;
	border: none;
	background-color: rgba(66, 65, 71, 0);
}

#menu .panel-default>.panel-heading>span {
	font-size: 10px;
}

#menu .panel-default>.panel-heading:active, #menu .panel-default>.panel-heading:hover
	{
	color: greenyellow;
}

#menu .panel-default>.panel-heading:hover a {
	color: greenyellow;
}

#menu .panel-default>.panel-heading>a:hover {
	text-decoration: none;
	color: greenyellow;
}

#menu .panel-group .panel-heading+.panel-collapse>.panel-body {
	border: none;
}

#menu .panel-body {
	padding: 0px;
}

.nav>li {
	padding: 1px 0px 0px 0px;
}

.nav>li>a {
	text-decoration: none;
	padding: 10px 10px 10px 35px;
}

.nav>li>a:hover, .nav>li>a:focus {
	background-color: rgba(66, 65, 71, .5);
	color: greenyellow;
}
</style>
</head>
<body>
	<div id="menu">
		<div class="panel-group" id="panelContainer">
			<div class="panel panel-default">
				<div id="header1" class="panel-heading" data-toggle="collapse"
					data-target="#sub0" data-parent="#panelContainer">
					<!-- <i class="glyphicon glyphicon-list-alt"></i> <a href="#">后台首页</a>  -->
					<!-- <span class="iconfont icon-user"></span> -->
					<c:if test="${userType == 1 }">
						<i class="iconfont icon-index"></i>
						<a href="../system/welcome1" target="body">后台首页</a>
					</c:if>
					<c:if test="${userType == 2}">
						<i class="iconfont icon-index"></i>
						<a href="../system/welcome2" target="body">后台首页</a>
					</c:if>
					<!-- <span
						class="glyphicon glyphicon-triangle-right pull-right"></span> -->
				</div>
			</div>

			<c:if test="${userType == 1 }">
				<div class="panel panel-default">
					<div id="header1" class="panel-heading" data-toggle="collapse"
						data-target="#sub1" data-parent="#panelContainer">
						<!-- <i class="glyphicon glyphicon-list-alt"></i>  -->
						<i class="iconfont icon-admin"></i> <a href="#">管理员中心</a> <span
							class="iconfont icon-arrow-right pull-right"></span>
					</div>
					<div id="sub1" class="collapse panel-collapse">
						<div class="panel-body">
							<ul class="nav">
								<li><a href="../admin/list" target="body">
								<span class="iconfont icon-list"></span>管理员列表</a></li>
							</ul>
						</div>
					</div>
				</div>
			</c:if>

			<div class="panel panel-default">
				<div id="header2" class="panel-heading" data-toggle="collapse"
					data-target="#sub2" data-parent="#panelContainer">
					<!-- 	<i class="glyphicon glyphicon-leaf"></i> -->
					<i class="iconfont icon-user"></i> <a href="#">用户中心</a> <span
						class="iconfont icon-arrow-right pull-right"></span>
				</div>
				<div id="sub2" class="collapse panel-collapse">
					<div class="panel-body">
						<ul class="nav">
							<c:if test="${userType == 1 }">
								<li><a href="../user/list" target="body"><span
										class="iconfont icon-list"></span>用户列表</a></li>
							</c:if>
							<c:if test="${userType == 2 }">
							<li><a href="../user/personal" target="body"><span
										class="iconfont icon-list"></span>个人中心</a></li>
							</c:if>
						</ul>
					</div>
				</div>
			</div>
			<div class="panel panel-default">
				<div id="header3" class="panel-heading" data-toggle="collapse"
					data-target="#sub3" data-parent="#panelContainer">
					<i class="iconfont icon-diary"></i> <a href="#">日记管理</a> <span
						class="iconfont icon-arrow-right pull-right"></span>
				</div>
				<div id="sub3" class="collapse panel-collapse">
					<div class="panel-body">
						<ul class="nav">
							<li><a href="../diary/list" target="body"><span class="iconfont icon-list"></span> 日记列表</a></li>
							<li><a href="#">添加栏目3</a></li>
							<c:if test="${userType == 2 }">
							     <li><a href="../diary/w_diary" target="body"><span class="iconfont icon-write"></span> 写日记</a></li>
							</c:if>
						    <!--  
							<li><a href="../diaryType/list" target="body"><span class="iconfont icon-category"></span>日记类型</a></li>
						     -->
							<li><a href="#">添加栏目4</a></li>
						</ul>
					</div>
				</div>
			</div>
			
			<c:if test="${userType == 1 }">
			<div class="panel panel-default">
				<div id="header3" class="panel-heading" data-toggle="collapse"
					data-target="#sub4" data-parent="#panelContainer">
					<i class="iconfont icon-category"></i> <a href="#">日记类别管理</a> <span
						class="iconfont icon-arrow-right pull-right"></span>
				</div>
				<div id="sub4" class="collapse panel-collapse">
					<div class="panel-body">
						<ul class="nav">
							<li><a href="../diaryType/list" target="body"><span class="iconfont icon-list"></span>日记类型列表</a></li>
						</ul>
					</div>
				</div>
			</div>
            </c:if>
			<div class="panel panel-default">
				<div id="header2" class="panel-heading" data-toggle="collapse"
					data-target="#sub5" data-parent="#panelContainer">
					<!-- <i class="glyphicon glyphicon-leaf"></i>  -->
					<i class="iconfont icon-settings"></i> <a href="#">系统管理</a> <span
						class="iconfont icon-arrow-right pull-right"></span>
				</div>
				<div id="sub5" class="collapse panel-collapse">
					<div class="panel-body">
						<ul class="nav">
							<li><a href="#" onclick="logout()"><span
									class="iconfont icon-login-out"></span>退出登陆</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
	
		$(function() {
			$(".panel-heading")
					.on(
							"click",
							function(e) {
								var idLength = e.currentTarget.id.length;
								var index = e.currentTarget.id.substr(
										idLength - 1, idLength);
								$("#sub" + index)
										.on(
												'hidden.bs.collapse',
												function() {
													$(e.currentTarget)
															.find("span")
															.removeClass(
																	"iconfont icon-arrow-bottom");
													$(e.currentTarget)
															.find("span")
															.addClass(
																	"iconfont icon-arrow-right");
												})
								$("#sub" + index)
										.on(
												'shown.bs.collapse',
												function() {
													$(e.currentTarget)
															.find("span")
															.removeClass(
																	"iconfont icon-arrow-right");
													$(e.currentTarget)
															.find("span")
															.addClass(
																	"iconfont icon-arrow-bottom");
												})
							})

		});
		
		function logout(){  
		    parent.window.location = "<%=request.getContextPath()%>/system/login_out";
		}
	</script>
</body>
</html>
