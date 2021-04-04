<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta charset="UTF-8">
<title>个人中心</title>
<!--  以服务器的路径为标准 http://localhost:3306/MyDiary -->
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
<!-- alert提示插件所需的样式文件 -->
<link rel="stylesheet" type="text/css" href="../static/css/toastr.css">
<!-- <script type="text/javascript" src="../static/js/jquery.min.js"></script> -->
<script type="text/javascript" src="../static/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../static/js/validateExtends.js"></script>
<!-- alert提示插件所需的js文件 -->
<script type="text/javascript" src="../static/js/toastr.min.js"></script>
<style type="text/css">
.main {
	margin: 20px;
	width: 100%;
	height: 100%
}

.personTitle {
	padding: 10px 20px;
	height: 54px;
	background-color: #f1f9fc;
	border-top: 1px solid #e0eaef;
	border-bottom: 1px solid #dbe7ed;
}

.personTitle h2 {
	font-size: 24px;
	line-height: 25px;
}

.persion_info {
	border: 1px solid black;
	background-color: #f1f9fc;
	margin-top: 20px;
	padding: 20px 30px;
	width: 100%;
	height: 100%;
}
/* 保存按钮 */
#user_update_btn{
margin-left:30px;
}

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
	
	 <!-- 标题部分 -->
	<div class="personTitle">
		<h2>个人中心</h2>
	</div>
	
	<!-- 个人信息部分 -->
	<div class="persion_info">
		<form class="form-horizontal" id="editPhotoForm" method="post"
			enctype="multipart/form-data" action="upload_photo"
			target="photo_target">

			<div class="form-group">
				<label for="edit_photo-preview" class="col-sm-1 control-label" style="min-width: 100px;">用户头像:</label>
				<img class="col-sm-10" id="edit_photo-preview" alt="照片"
					style="max-width: 200px; max-height: 200px;" title="照片"
					src="/MyDiary/photo/default_user.jpg" />
			</div>
			<div class="form-group row">
				<label for="edit-upload-photo" class="col-sm-1 control-label" style="min-width: 100px;">修改头像:</label>
				<div class="col-sm-10">
					<input type="file" id="edit-upload-photo" name="photo"
						style="display: inline-block">
					<button id="edit-upload-btn" class="btn btn-success btn-sm">上传图片</button>
					<span class="help-block"></span>
				</div>
			</div>
		</form>
		<form class="form-horizontal editForm">
			<!--  隐藏域  在页面存储但不需要显示出来的值 -->
			<div class="form-group">
				<input id="edit_photo" type="hidden" name="photo"
					value="/MyDiary/photo/default_user.jpg" />
			</div>

			<div class="form-group">
				<label for="username_edit_input" class="col-sm-1 control-label" style="min-width: 100px;">用户名:</label>
				<div class="col-sm-7">
					<!--  name 与实体类中的名字一致 -->
					<input type="text" class="form-control" id="username_edit_input"
						name="username" placeholder="请输入用户名" autoComplete="off"> 
						<span class="help-block"></span>

				</div>
			</div>
			<div class="form-group">
				<label for="password_edit_input" class="col-sm-1 control-label" style="min-width: 100px;">密码:</label>
				<div class="col-sm-7">
					<input type="password" class="form-control"
						id="password_edit_input" name="password" placeholder="请输入密码">
					<span class="help-block"></span>
				</div>
			</div>
			<div class="form-group">
				<label for="sex_edit" class="col-sm-1 control-label" style="min-width: 100px;">性别:</label>
				<div class="col-sm-7">
					<label class="radio-inline"> <input type="radio" name="sex"
						id="male_edit" value="男">男
					</label> <label class="radio-inline"> <input type="radio"
						name="sex" id="female_edit" value="女">女
					</label>
				</div>
			</div>
			<div class="form-group">
				<label for="signature_edit" class="col-sm-1 control-label" style="min-width: 100px;">个性签名:</label>
				<div class="col-sm-7">
					<!-- <input type="textarea" class="form-control" id="signature_edit"
									name="signature" placeholder="请输入个性签名" rows="3"> -->
					<textarea class="form-control" id="signature_edit" name="signature"
						placeholder="请输入个性签名" rows="3"></textarea>
				</div>
			</div>
		</form>

       <!-- 保存按钮 -->
		<button  class="btn btn-info" id="user_update_btn">更新</button>
	</div>

</div>

	<!-- 提交表单处理iframe框架 -->
	<iframe id="photo_target" name="photo_target" onload="uploaded(this)"
		style="display: none"> </iframe>

	<script type="text/javascript">
	  /* 设置提示框弹出的位置 */
	 toastr.options.positionClass = 'toast-center-center';
         
	   /* 用户id */
		var userId = ${user.id};
	/* 	console.log(userId); */
		
		var valiFlag = true;
		$(function() {
			/* 页面加载完成后，直接发送一个ajax请求 获取分页数据  显示数据列表的首页*/
			getUser(userId);
		});

	

		//清空表单样式和内容
		function reset_form(ele) {
			//重置表单内容
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}


		//表单校验时的信息提示
		function show_validate_msg(ele, status, msg) {
			//清除当前元素的校验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if ("success" == status) {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			} else if ("error" == status) {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}

		/* function usernameValidate(){
			//1.获取要校验的数据
			var username = $("#username_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,5})/; //中文2-5个
			//用户名校验
			if (!regName.test(username)) {
				valiFlag = false;
				show_validate_msg("#username_add_input",
						"error",
						"用户名可以是2-5位中文或者5-16位英文和数字，下划线，中划线的组合");
			} else {
				valiFlag = true;
				show_validate_msg("#username_add_input",
						"success", "");
				$("#username_add_input").parent().addClass(
						"has-success");
				$("#username_add_input").next("span").text("");
			}

			return valiFlag;
		} */

		//用户名修改失去焦点触发校验
		$("#username_edit_input")
				.blur(
						function() {
							//1.获取要校验的数据
							var username = $("#username_edit_input").val();
							var regName = /(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,5})/; //中文2-5个
							//用户名校验
							if (!regName.test(username)) {
								valiFlag = false;
								/* alert("用户名可以是2-5位中文或者6-16位英文和数字，下划线，中划线的组合"); */
								show_validate_msg("#username_edit_input",
										"error",
										"用户名可以是2-5位中文或者5-16位英文和数字，下划线，中划线的组合");
							} else {
								valiFlag = true;
								show_validate_msg("#username_edit_input",
										"success", "");
								$("#username_edit_input").parent().addClass(
										"has-success");
								$("#username_edit_input").next("span").text("");
							}

							return valiFlag;
						});
		
		
		$("#password_edit_input")
				.blur(
						function() {
							//密码校验
							var password = $("#password_edit_input").val();
							var regPassword = /^[a-zA-Z0-9_-]{5,18}$/;
							if (!regPassword.test(password)) {
								valiFlag = false;
								/* alert("密码为6-18位字母数字下划线中划线的组合"); */
								//清空这个元素之前的样式
								show_validate_msg("#password_edit_input",
										"error", "密码为5-18位字母数字下划线中划线的组合");
								/*  $("#password_add_input").parent().addClass("has-error");
								$("#password_add_input").next("span").text("密码为6-18位字母数字下划线中划线的组合"); */

							} else {
								valiFlag = true;
								show_validate_msg("#password_edit_input",
										"success", "");
								$("#password_edit_input").parent().addClass(
										"has-success");
								$("#password_edit_input").next("span").text("");
							}

							return valiFlag;
						});
		/* function passwordValidate(ele){
			console.log("修改窗口密码框失去焦点")
			//密码校验
			var password = $(ele).val();
			var regPassword = /^[a-zA-Z0-9_-]{5,18}$/;
			if (!regPassword.test(password)) {
				valiFlag = false;
				//清空这个元素之前的样式
				show_validate_msg(ele,
						"error", "密码为5-18位字母数字下划线中划线的组合");
			} else {
				valiFlag = true;
				show_validate_msg(ele,
						"success", "");
				$(ele).parent().addClass(
						"has-success");
				$(ele).next("span").text("");
			}

			return valiFlag;
		} */

		//密码校验(失去焦点时触发)
	/* 	$("#password_add_input")
				.blur(
						function() {
							//密码校验
							var password = $("#password_add_input").val();
							var regPassword = /^[a-zA-Z0-9_-]{5,18}$/;
							if (!regPassword.test(password)) {
								valiFlag = false;
								// alert("密码为6-18位字母数字下划线中划线的组合"); 
								//清空这个元素之前的样式
								show_validate_msg("#password_add_input",
										"error", "密码为5-18位字母数字下划线中划线的组合");
								//  $("#password_add_input").parent().addClass("has-error");
								//$("#password_add_input").next("span").text("密码为6-18位字母数字下划线中划线的组合"); 

							} else {
								valiFlag = true;
								show_validate_msg("#password_add_input",
										"success", "");
								$("#password_add_input").parent().addClass(
										"has-success");
								$("#password_add_input").next("span").text("");
							}

							return valiFlag;
						}); */
						
						

		//给修改按钮绑定修改模态框弹出事件
		/* $(document).on("click", ".edit_btn", function() {
			alert("点击了修改按钮");
			changeIndex(this);
			// reset_form("#editUserModal .editPhotoForm"); 
			//alert("edit");
			//1.查出并显示对应用户信息
			getUser($(this).attr("edit-id"));
			//2.把用户id传给修改模态框的更新按钮
			$("#user_update_btn").attr("edit-id", $(this).attr("edit-id"));
			$("#editUserModal").modal({
				backdrop : "static"
			})
		}); */

		//根据id查询用户信息
		function getUser(id) {
			console.log("调用获取用户信息的方法");
			$.ajax({
				url : "${APP_PATH}/user/" + id,
				type : "GET",
				success : function(result) {
					console.log(result);
					//获取查询到的管理员数据
					var user = result.datalist.user;
					//将查询到的数据填充到对应位置
					$("#edit_photo-preview").attr("src", user.photo);
					$("#edit-upload-photo").val();
					$("#edit_photo").val(user.photo);
					$("#username_edit_input").val(user.username);
					$("#password_edit_input").val(user.password);
					$("#signature_edit").val(user.signature);
					if (user.sex == "男") {
						$("#male_edit").attr("checked", 'checked');
					} else if (user.sex == "女") {
						$("#female_edit").attr("checked", 'checked');
					}
				}
			});
		}
		
		//点击更新 更新用户信息
		$('#user_update_btn').click(function() {
			if (!valiFlag) {
				alert("校验不通过");
				return false;
			}
			/* alert($("#editUserModal .editForm")
					.serialize()); */
			//发送ajax请求  保存更新的管理员数据
			$.ajax({
				//url : "${APP_PATH}/user/edit/" + $(this).attr("edit-id"),
				url : "${APP_PATH}/user/edit/" + userId,
				type : "POST",
				data : $(".editForm").serialize(),
				success : function(result) {
					/* alert(result.msg); */
					if(result.code == 100){
						//更新成功 弹出提示信息
						toastr.warning(result.msg);
						getUser(userId);
						window.parent.frames["topFrame"].location.reload(); //成功修改后刷新顶部，让用户图片也刷新
					
					}else if(result.code == 200){
						toastr.warning(result.msg);
					}
					
					
				}
			})

		})

		/* 上传图片按钮事件 */
		$("#photo-upload-btn").click(function() {

			/* alert($("#add-upload-photo").val()); */
			if ($("#add-upload-photo").val() == '') {
				show_validate_msg("#photo-upload-btn", "error", "请选择图片文件");
				return false;
			}

			$("#photoForm").submit();
		})

		//修改对话框上传图片按钮
		$("#edit-upload-btn").click(function() {
			if ($("#edit-upload-photo").val() == '') {
				show_validate_msg("#edit-upload-btn", "error", "请选择图片文件");
				return false;
			}
			$("#editPhotoForm").submit();
		})

		function uploaded(e) {
			var data = $(window.frames["photo_target"].document).find(
					"body pre").text();
			if (data == '')
				return;
			data = JSON.parse(data);
			if (data.code == 100) {
				//上传成功 
				if (data.datalist.successMsg != null) {
					show_validate_msg("#photo-upload-btn", "success",
							data.datalist.successMsg);
				}
				$("#photo-preview").attr("src", data.datalist.src);
				$("#add_photo").val(data.datalist.src);
				$("#edit_photo-preview").attr("src", data.datalist.src);
				$("#edit_photo").val(data.datalist.src);
			} else if (data.code == 200) {
				//上传失败
				/* print(data.datalist.errMsg ); */
				if (data.datalist.errMsg != null) {
					show_validate_msg("#edit-upload-btn", "error",
							data.datalist.errMsg);  //dit-upload-photo   photo-upload-btn
					/* return Msg.fail().add("errMsg", "文件格式不正确，请上传jpg,png,gif,jpeg格式的图片！"); */
				}
			}
		}
	</script>

</body>

</html>