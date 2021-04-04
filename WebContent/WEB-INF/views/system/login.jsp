<!-- 成功1 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta charset="utf-8">
<title>登录|日记本系统</title>
<meta name="keywords" content="日记本系统">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="shortcut icon" href="favicon.ico" />
<link rel="bookmark" href="favicon.ico" />

<link rel="stylesheet" type="text/css"
	href="../static/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="../static/js/bootstrap.min.js">

<link rel="stylesheet" type="text/css" href="../static/css/easyui.css">
<link rel="stylesheet" type="text/css" href="../static/css/icon.css">

<!-- 
    <script type="text/javascript" src="../static/js/jquery-3.4.1.min.js"></script>  -->
<script type="text/javascript" src="../static/js/easyui/jquery.min.js"></script>
<script type="text/javascript" src="../static/js/H-ui.js"></script>
<script type="text/javascript" src="../static/js/jquery.icheck.min.js"></script>
<!-- 验证 -->

<script type="text/javascript" src="../static/js/jquery.easyui.min.js"></script>

<style>
body, html {
	margin: 0;
	padding: 0;
}

body {
	background: url("../static/images/login_bg.png");
}

/* 登陆框 */
.login-wrap {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 400px;
	padding: 30px;
	background: rgba(0, 0, 0, .4);
	box-sizing: border-box;
	box-shadow: 0 15px 25px rgba(0, 0, 0, .5);
	border-radius: 10px;
}

/* 系统名称 */
.title {
	margin: 0 0 30px;
	padding: 0;
	color: #fff;
	text-align: center;
}

/* 输入框 */
.input-box {
	position: relative;
}

.input-box input {
	width: 100%;
	padding: 10px 0;
	/* font-side: 16px; */
	color: #fff;
	letter-spacing: 1px;
	margin-bottom: 30px;
	/*输入框设置*/
	border: none;
	border-bottom: 1px solid #fff;
	outline: none;
	background: transparent;
}

.input-box label {
	position: absolute;
	top: 0;
	left: 0;
	padding: 10px 0;
	font-size: 16px;
	color: #fff;
	pointer-events: none;
	transition: .5s;
}

.login-wrap .input-box input:focus ~label, .login-wrap .input-box input:valid
	~label {
	top: -18px;
	left: 0;
	color: #03a9f4;
	font-size: 12px;
}

/* 验证码部分 */
/* .vcode-box {
            padding-left: 16px;
        } */
.vcode-box .input-box label {
	left: 16px;
}

.vcode-box .input-box input:focus ~label, .vcode-box .input-box input:valid
	~label {
	top: -18px;
	left: 16px;
	color: #03a9f4;
	font-size: 12px;
}
/* 单选按钮部分 */
.radio-box {
	margin-bottom: 15px;
}

.radio-inline {
	margin-right: 30px;
	color: white;
}

/* 按钮部分 */
.button-box {
	display: flex;
	justify-content: space-between;
}

.button-box button {
	background: transparent;
	border: none;
	outline: none;
	color: #fff;
	background: #03a9f4;
	padding: 10px 20px;
	cursor: pointer;
	border-radius: 5px;
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

<script type="text/javascript">
	$(function() {
		//点击图片切换验证码
		$("#vcodeImg").click(function() {
			this.src = "get_cpacha?vl=5&w=150&h=40&t=" + new Date().getTime(); //修改
		});

		//登录
		$("#loginBtn").click(function() {

			var data = $("#form").serialize();
			$.ajax({
				type : "post",
				url : "login",
				data : data,
				dataType : "json", //返回数据类型text
				success : function(data) {
					if ("success" == data.type) {
						window.parent.location.href = "index"; //登陆成功跳转到后台首页
					} else {

						$.messager.alert("消息提醒", data.msg, "warning");
						$("#vcodeImg").click(); //切换验证码
						$("input[name='vcode']").val(""); //清空验证码输入框
					}
				}

			});
		});

		//注册
		$("#toRegister").click(function() {
			window.parent.location.href = "register";
		});

		//设置复选框
		$(".skin-minimal input").iCheck({
			radioClass : 'iradio-blue',
			increaseArea : '25%'
		});
	})
</script>

</head>

<body>
	<div class="container">
		<div class="login-wrap">
			<h2 class="title">系统登陆</h2>
			<!-- 表单部分 -->
			<form id="form">
				<!-- 输入框部分 -->
				<div class="input-box">
					<input type="text" class="" name="username" id="username"
						required="" autoComplete="off"> <label>用户名</label>
				</div>
				<div class="input-box">
					<input type="password" class="" name="password" id="password"
						placeholder="" required="" autoComplete="off"> <label>密码</label>
				</div>
				<!-- 验证码部分 -->
				<div class="vcode-box row">
					<div class="input-box col-md-6">
						<input type="text" class="" name="vcode" id="" required=""
							autoComplete="off"> <label>验证码</label>
					</div>
					<div class="col-md-6">
						<img title="点击图片切换验证码" id="vcodeImg"
							src="get_cpacha?vl=5&w=150&h=40">
					</div>
				</div>

				<!-- 单选按钮部分(内联单选按钮) -->
				<div class="radio-box">
					<label class="radio-inline"> <input type="radio"
						name="type" id="radio2" value="2" checked> 用户
					</label> <label class="radio-inline"> <input type="radio"
						name="type" id="radio1" value="1"> 管理员
					</label>
				</div>
				<!-- 按钮部分 -->
				<div class="button-box row">
					<button type="button" id="loginBtn" class="btn col-md-3">登陆</button>
					<!--   <a href="" id="rigisterBtn" class="btn col-md-3">注册</a> -->
					<button type="button" id="toRegister" class="btn col-md-3">注册</button>
				</div>

			</form>
		</div>
	</div>
</body>

</html>