<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>日记详情</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

<!-- <link rel="stylesheet" type="text/css"
	href="../static/css/user/user_list.css"> -->
<link href="../static/css/bootstrap.min.css" rel="stylesheet">
<link href="../static/css/bootstrapValidator.min.css" rel="stylesheet" />
<script src="../static/js/jquery-3.4.1.min.js"></script>
<script src="../static/js/bootstrap.min.js"></script>
<script src="../static/js/bootstrapValidator.min.js"></script>

<link rel="stylesheet" type="text/css" href="../static/css/easyui.css">
<link rel="stylesheet" type="text/css" href="../static/css/icon.css">
<link rel="stylesheet" type="text/css" href="../static/css/demo.css">

<script type="text/javascript" src="../static/ueditor/ueditor.config.js"></script>
<script type="text/javascript"
	src="../static/ueditor/ueditor.all.min.js"></script>

<!-- 手动加载语言，避免在IE下有时因为加载语言导致编辑器加载失败    在这里加载的语言会覆盖配置项目里添加的语言类型 -->
<script type="text/javascript"
	src="../static/ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript" src="../static/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../static/js/validateExtends.js"></script>

<style>
/* .main {
	margin: 20px;
	width: 100%;
	height: 100%;
} */

/* .diary_container {
   width:100%;
   height:100%;
  padding:20px;
	
} */

.diary {
  padding:15px;
	
}

.title {

	text-align: center;
	font-size:26px;
}

.info {
	margin-top: 10px;
	text-align: center;
}
.info span{
   font-size:18px;
}

.category {
	margin-left: 15px;
}

.diary-content {
	margin-top: 20px;
	font-size:17px;
	line-height:35px;
}

.back {
	margin-top: 10px;
}
/* 去掉button的边框 */
.btn:focus,
.btn:active:focus,
.btn.active:focus,
.btn.focus,
.btn:active.focus,
.btn.active.focus {
    outline: none;          
} 
</style>
</head>
<body>
	<div class="main">
		<%-- ${param.id} --%>
		<!-- 内容部分 -->
		<div class="diary_container">
			<!--  日记详情 -->
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2 class="panel-title">日记信息</h2>
				</div>
				<div class="panel-body">
					<div class="diary">
						<div class="title">第一篇日记</div>
						<div class="info">
						    <span>发布时间：</span>
						    <span class="time">2021年3月4日     </span> 
						    <span>日记类别：</span>
							<span class="category">学习类 </span>
						</div>
						<div class="diary-content"></div>
						<button class="btn btn-info back">返回</button>
					</div>
				</div>
			</div>

		</div>

	</div>

	<script type="text/javascript" charset="gb2312">
		
		
		$(function() {
			/* 页面加载完成后，直接发送一个ajax请求 获取日记信息*/
			getDiary(${param.id});
		});

		//根据id查询日记信息
		function getDiary(id) {
			//alert(id);
			$.ajax({
				url : "${APP_PATH}/diary/" + id,
				type : "GET",
				success : function(result) {
					//alert("查询到的日记信息：" + result);
					
					//获取查询到的日记数据
					var diary = result.datalist.diary;
					//console.log(diary);
					
					//将查询到的数据填充到对应位置
					$(".title").html(diary.title);
					$(".time").text(toDates(diary.releaseDate));
					$(".category").text(diary.diaryType.typeName);
					$(".diary-content").html(diary.content);
					
				}
			}); 
		}
		

		/* 返回按钮事件 */
		$(".back").click(function() {
			window.location.href ="<%=request.getContextPath()%>/diary/list"
		});

		
		//将时间戳转换为具体时间
		function toDates(times) {
			const date = new Date(times)
			const Y = date.getFullYear()
			const M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1)
					: date.getMonth() + 1)
			const D = (date.getDate() < 10 ? '0' + date.getDate() : date
					.getDate())
			const H = date.getHours() < 10 ? '0' + date.getHours() : date
					.getHours()
			const Min = date.getMinutes() < 10 ? '0' + date.getMinutes() : date
					.getMinutes()
			const S = date.getSeconds() < 10 ? '0' + date.getSeconds() : date
					.getSeconds()
			const dateTime = Y + '年' + M + '月' + D + '日'
			/*  const dateTime = Y + '年' + M + '月' + D + '日' + H + '时' + Min + '分' + S + '秒' */
			return dateTime
		}
	</script>
</body>
</html>