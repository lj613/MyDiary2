<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" href="../static/iconfont/iconfont.css">
	<script type="text/javascript"
		src="http://libs.baidu.com/jquery/1.9.1/jquery.js"></script>
	<script src="../static/iconfont//iconfont.js"></script>
	<title>系统顶部</title>
	<style type="text/css">
.icon {
	width: 1em;
	height: 1em;
	vertical-align: -0.15em;
	fill: currentColor;
	overflow: hidden;
}

img {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	overflow: hidden;
}

a {
	text-decoration: none
}

.top {
	line-height: 50px;
}

.title {
	/* padding-left: 10px; */
	font-family: 华文行楷;
	font-size: x-large;
	color: Blue;
}

.right {
	float: right;
	padding-right: 20px;
	line-height: 50px;
}

.info {
	float: right;
	margin-left: 5px;
	line-height: 50px;
}

.date {
	/* background-color: #9d9d9d; */
	font-family: 华文行楷;
	font-size: x-large;
	color: #fff;
	width: 160px;
	margin-left: 10px;
	
}

.icon-top-diary2 {
	margin-left: 10px;
	font-size: 24px;
}

</style>
</head>
<body>
	<form id="homeheader" runat="server">
		<div class="top">
			<span class="icon-top-diary2"> 
			<svg class="icon" aria-hidden="true"> 
			    <use xlink:href="#icon--top-diary2"></use>
			</svg>
			</span> 
			<span class="title">日记本系统</span> 
	    	<!-- 日期显示 -->
			<span class="date"></span>
			<div class="right">
				<c:if test="${userType == 2}">
					<img src="${user.photo}" alt="头像"></img>
				</c:if>
				<c:if test="${userType == 1}">
					<span class="iconfont icon-user"></span>
				</c:if>
				<div class="info">
					<span class="" style="color: red; font-size: large;">${user.username}&nbsp;</span>您好
					<!-- &nbsp;&nbsp;&nbsp;<a href="login_out" id="loginOut">安全退出</a> -->
					&nbsp;&nbsp;&nbsp;<span class="iconfont icon-login-out"></span><a
						href="#" id="loginOut" onclick="logout()">安全退出</a>
				</div>
			</div>
		</div>
	</form>

	<script>
	
	 $(function () {
	        /* 页面加载完成后，直接发送一个ajax请求 获取分页数据  显示数据列表的首页*/
	        /* weather(); */
	        //设置时间
	        var time = new Date().Format("yyyy-MM-dd hh:mm:ss");
	        $(".date").html(time);
	    });
	   
	    //每个1秒修改时间
	    setInterval(function(){
	        var time = new Date().Format("yyyy-MM-dd hh:mm:ss");
	        $(".date").html(time);
	    },1000);
         
	    //格式化时间函数
	    Date.prototype.Format = function (fmt) { // author: meizz
	        var o = {
	            "M+": this.getMonth() + 1, // 月份
	            "d+": this.getDate(), // 日
	            "h+": this.getHours(), // 小时
	            "m+": this.getMinutes(), // 分
	            "s+": this.getSeconds(), // 秒
	            "q+": Math.floor((this.getMonth() + 3) / 3), // 季度
	            "S": this.getMilliseconds() // 毫秒
	        };
	        if (/(y+)/.test(fmt))
	            fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	        for (var k in o)
	            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) :
	                (("00" + o[k]).substr(("" + o[k]).length)));
	        return fmt;
	    }
	    
		function logout(){  
		    parent.window.location = "<%=request.getContextPath()%>/system/login_out";
		}
		
		
	</script>
</body>
</html>
