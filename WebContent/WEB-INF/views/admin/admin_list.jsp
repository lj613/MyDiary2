<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta charset="UTF-8">
<title>管理员列表</title>
<!--  以服务器的路径为标准 http://localhost:3306/MyDiary -->
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<%-- 使用如：
<link rel="stylesheet" type="text/css"  href="${APP_PATH}/static/css/user/user_list.css"> --%>
<link rel="stylesheet" type="text/css"
	href="../static/css/user/user_list.css">
<link href="../static/css/bootstrap.min.css" rel="stylesheet">
<link href="../static/css/bootstrapValidator.min.css" rel="stylesheet" />

<script src="../static/js/jquery-3.4.1.min.js"></script>
<script src="../static/js/bootstrap.min.js"></script>
<script src="../static/js/bootstrapValidator.min.js"></script>

<link rel="stylesheet" type="text/css" href="../static/css/easyui.css">
<link rel="stylesheet" type="text/css" href="../static/css/icon.css">
<link rel="stylesheet" type="text/css" href="../static/css/demo.css">

<script type="text/javascript" src="../static/js/jquery.easyui.min.js"></script>
<!-- 确认取消弹出框 -->
<script type="text/javascript" src="../static/js/sweetalert.min.js"></script>
<!-- <script type="text/javascript" src="../static/js/jquery.min.js"></script> -->
<script type="text/javascript" src="../static/js/validateExtends.js"></script>

<style type="text/css">
/* 模态框居中样式 */
.modal {
	display: table;
	width: 500px;
	height: 100%;
	margin: 0 auto;
}

.modal-dialog {
	display: table-cell;
	vertical-align: middle;
}

/*  控制校验时右侧的图标位置 */
.form-control-feedback {
	right: 16px;
}

#search_btn {
	height: 40px;
}

/* 去掉button的边框 */
.btn:focus, .btn:active:focus, .btn.active:focus, .btn.focus, .btn:active.focus,
	.btn.active.focus {
	outline: none;
}
</style>
</head>

<body>

	<section id="main"> <section class="main_container">
	<section id="projectTitle" class="clear">
	<div class="projectTitle_text l">
		<h2>管理员管理</h2>
	</div>
	</section> <section id="projectList">
	<div class="projectList_cons">
		<div class="row">
			<div class="col-md-3">
				<button type="button" class="btn btn-success" data-toggle="modal"
					id="user_add_btn">
					<span class="glyphicon glyphicon-plus"></span> 添加管理员
				</button>
				<button type="button" class="btn btn-danger" data-toggle="modal"
					id="user_delete_all_btn">
					<span class="glyphicon glyphicon-remove"></span> 批量删除
				</button>
			</div>
			<div class="sp_search class="col-md-3"">
				<input type="text" placeholder="请输入用户名" name="keywords"
					id="search_words" value="">
				<button type="button" class="btn btn-success" id="search_btn">
					<span class="glyphicon glyphicon-search"></span> 搜索
				</button>
			</div>
		</div>
		<!-- <div class="sp_search" style="margin-top:5px">
					<input type="text" placeholder="请输入用户名" name="keywords" id="search_words" value="">
					<button type="button" class="btn btn-success" id="search_btn">
						<span class="glyphicon glyphicon-search"></span> 搜索
					</button>
			</div> -->
		<div class="show">
			<table class="sp_table" id="users_table">
				<thead>
					<tr>
						<th width="80"><input type="checkbox" id="check_all"></th>
						<th width="300">ID</th>
						<th width="300">用户名</th>
						<th width="300">密码</th>
						<th style="min-width: 190px">操作</th>
					</tr>
				</thead>
				<tbody>

				</tbody>
			</table>
		</div>
	</div>
	</section> </section> </section>

	<!-- 添加用户模态框 -->
	<div class="modal fade" id="addUserModal" aria-labelledby="addUser1"
		aria-hidden="true">
		<div class="modal-dialog ">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">添加管理员</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form class="form-horizontal addForm">
						<div class="form-group">
							<label for="username_add_input" class="col-sm-2 control-label">用户名:</label>
							<div class="col-sm-7">
								<!--  name 与实体类中的名字一致 -->
								<input type="text" class="form-control" id="username_add_input"
									name="username" placeholder="请输入用户名" autoComplete="off">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="password_add_input" class="col-sm-2 control-label">密码:</label>
							<div class="col-sm-7">
								<input type="password" class="form-control"
									id="password_add_input" name="password" placeholder="请输入密码">
								<span class="help-block"></span>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="user_save_btn">保存</button>
				</div>
			</div>
		</div>
	</div>


	<!--修改用户模态框 -->
	<div class="modal fade" id="editUserModal" aria-labelledby="editUser1"
		aria-hidden="true">
		<div class="modal-dialog ">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">修改管理员</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form class="form-horizontal editForm">
						<div class="form-group">
							<label for="username_edit_input" class="col-sm-2 control-label">用户名:</label>
							<div class="col-sm-7">
								<!--  name 与实体类中的名字一致 -->
								<input type="text" class="form-control" id="username_edit_input"
									name="username" placeholder="请输入用户名"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="password_edit_input" class="col-sm-2 control-label">密码:</label>
							<div class="col-sm-7">
								<input type="password" class="form-control"
									id="password_edit_input" name="password" placeholder="请输入密码">
								<span class="help-block"></span>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="user_update_btn">更新</button>
				</div>
			</div>
		</div>
	</div>

	<div class="sp_footer">
		<div class="row">
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav"></div>

			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info"></div>

		</div>
	</div>

	<script type="text/javascript">
		//全局变量 保存表格中数据的总记录数,当前页数
		var totalRecord, currentPage;
		//记录弹出模态框的index
		var index = 1051;
		var valiFlag;
		$(function() {
			/* 页面加载完成后，直接发送一个ajax请求 获取分页数据  显示数据列表的首页*/
			to_page(1);
		});

		//页面跳转
		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/admin/get_list",
				data : "pn=" + pn,
				type : "get",
				success : function(result) {
					/*  console.log(result);  //打印后台返回的数据 */
					//1.解析并显示用户数据
					build_users_table(result);
					//2.解析并显示分页信息
					build_page_info(result);
					//3.解析并显示分页条
					build_page_nav(result);
				}
			})
			$("#check_all").prop("checked", false);
		}

		//1.解析并显示用户数据方法	用户数据表格
		function build_users_table(result) {
			//清除原来的数据
			$("#users_table tbody").empty();
			var users = result.datalist.pageInfo.list;
			$
					.each(
							users,
							function(index, user) {
								/* var checkboxTd = $("<td></td>").append(
										$("<input>").attr("type", "checkbox")); */
								/* var checkboxTd = $("<td></td>").append($("<input type='checkbox' class='check_item'/>")); */
								var checkboxTd = $("<td><input type='checkbox' class='check_item'/></td>");
								var userIdTd = $("<td></td>").append(user.id);
								var usernameTd = $("<td></td>").append(
										user.username);
								var passwordTd = $("<td></td>").append(
										user.password);

								var editBtn = $("<button></button>")
										.addClass(
												"btn btn-success btn-sm edit_btn")
										.append(
												$("<span></span>")
														.addClass(
																"glyphicon glyphicon-pencil "))
										.append("编辑");
								//为编辑按钮添加一个自定义属性，表示当前编辑的管理员id
								editBtn.attr("edit-id", user.id);
								var delBtn = $("<button></button>")
										.addClass(
												"btn btn-danger btn-sm delete_btn")
										.append(
												$("<span></span>")
														.addClass(
																"glyphicon glyphicon-remove"))
										.append("删除");
								//为删除按钮添加一个自定义属性，表示当前删除管理员id
								delBtn.attr("del-id", user.id);
								var btnTd = $("<td></td>").append(editBtn)
										.append(delBtn);
								$("<tr></tr>").append(checkboxTd).append(
										userIdTd).append(usernameTd).append(
										passwordTd).append(btnTd).appendTo(
										"#users_table tbody");
							})
		}
		//2.解析显示分页信息
		function build_page_info(result) {
			//清除原来的数据
			$("#page_info").empty();
			$("#page_info").append(
					"当前第 " + result.datalist.pageInfo.pageNum + " 页,总共 "
							+ result.datalist.pageInfo.pages + " 页，总共 "
							+ result.datalist.pageInfo.total + " 条记录");
			//保存总记录数
			totalRecord = result.datalist.pageInfo.total;
			//保存当前页数
			currentPage = result.datalist.pageInfo.pageNum;
		}
		//3.解析并显示分页条
		function build_page_nav(result) {
			//清除原来的数据
			$("#page_nav").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;"));
			if (result.datalist.pageInfo.hasPreviousPage == false) {
				//如果为首页就禁用前一页的点击 
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				/* 只有没有禁用的才添加点击事件 */
				//为首页添加点击翻页事件
				firstPageLi.click(function() {
					to_page(1);
				});
				//为前一页添加点击翻页事件
				prePageLi.click(function() {
					to_page(result.datalist.pageInfo.pageNum - 1);
				});

			}

			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));
			if (result.datalist.pageInfo.hasNextPage == false) {
				//如果为末页添加禁用的样式 
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				/* 只有没有禁用的才添加点击事件 */
				//为末页添加点击翻页事件
				lastPageLi.click(function() {
					to_page(result.datalist.pageInfo.pages);
				});
				//为下一页添加点击翻页事件
				nextPageLi.click(function() {
					to_page(result.datalist.pageInfo.pageNum + 1);
				});
			}

			//构造首页和前一页
			ul.append(firstPageLi).append(prePageLi);

			//连续显示的页数  遍历添加连续显示的页码提示
			$.each(result.datalist.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if (result.datalist.pageInfo.pageNum == item) {
					//给选中的添加样式
					numLi.addClass("active");
				}
				//为每一个页码添加点击跳转到对应页码的事件
				numLi.click(function() {
					to_page(item);
				})
				ul.append(numLi);

			});
			//构造前一页和末页
			ul.append(nextPageLi).append(lastPageLi);
			//将ul添加到nav中 
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav");
		}

		//清空表单样式和内容
		function reset_form(ele) {
			//重置表单内容
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}

		//改变弹出模态框的index 避免模态框被另一个模态框覆盖
		function changeIndex(obj) {

			var k = obj.getAttribute("data-target");
			$(k).css("z-index", index);
			index++;
			alert("当前模态框的index：" + index);
		}

		//点击添加弹出新增模态框  手动打开模态框
		$("#user_add_btn").click(function() {
			/* changeIndex(this); */
			//清空表单数据(表单完整重置(表单数据，表单样式))  jquery没有这个方法 所以取dom 对象
			reset_form("#addUserModal .addForm");
			$("#addUserModal").modal({
				backdrop : "static" //设置点击背景空白处模态框不被关闭
			})
		});

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
		//用户名校验(失去焦点时触发)
		$("#username_add_input")
				.blur(
						function() {
							//1.获取要校验的数据
							var username = $("#username_add_input").val();
							var regName = /(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,5})/; //中文2-5个
							//用户名校验
							if (!regName.test(username)) {
								valiFlag = false;
								/* alert("用户名可以是2-5位中文或者6-16位英文和数字，下划线，中划线的组合"); */
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
						});
		//密码校验(失去焦点时触发)
		$("#password_add_input")
				.blur(
						function() {
							//密码校验
							var password = $("#password_add_input").val();
							var regPassword = /^[a-zA-Z0-9_-]{5,18}$/;
							if (!regPassword.test(password)) {
								valiFlag = false;
								/* alert("密码为6-18位字母数字下划线中划线的组合"); */
								//清空这个元素之前的样式
								show_validate_msg("#password_add_input",
										"error", "密码为5-18位字母数字下划线中划线的组合");
								/*  $("#password_add_input").parent().addClass("has-error");
								$("#password_add_input").next("span").text("密码为6-18位字母数字下划线中划线的组合"); */

							} else {
								valiFlag = true;
								show_validate_msg("#password_add_input",
										"success", "");
								$("#password_add_input").parent().addClass(
										"has-success");
								$("#password_add_input").next("span").text("");
							}

							return valiFlag;
						});

		//提交新增用户模态框的信息 保存用户信息
		$("#user_save_btn").click(
				function() {
					//1.将新增用户模态框中的数据提交给服务器进行保存
					//校验要提交的数据 input输入框失去焦点触发校验
					/* if(!validate_add_form()){
						return false;
					} */
					//校验不通过则不执行ajax请求
					if (!valiFlag) {
						show_validate_msg("#username_add_input", "error",
								"用户名不能为空");
						return false;
						return false;
					}
					//2.发送ajax请求保存用户  
					//序列表格内容为字符串
					//alert($("#addUserModal form").serialize());
					$.ajax({
						url : "${APP_PATH}/admin/add",
						type : "POST",
						data : $("#addUserModal form").serialize(), //提交序列化表格内容为字符串后的数据
						success : function(result) {
							if (result.code == 100) {
								//用户数据保存成功
								//alert(result.msg);
								//1.关闭添加数据模态框
								$("#addUserModal").modal('hide');
								//2.跳转到用户数据表格的最后一页 显示刚添加的数据
								// 发送ajax请求显示最后一页的数据  此分页插件会把大于总页码的数据看作最后一页的数据   则可以传一个大于总页码的数据
								to_page(totalRecord);
							} else if (result.code == 200) {
								if (result.datalist.user_msg != null) {
									//用户名不合法
									show_validate_msg("#username_add_input",
											"error", result.datalist.user_msg);
								} else if (result.datalist.pass_msg != null) {
									//密码不合法
									show_validate_msg("#password_add_input",
											"error", result.datalist.pass_msg);
								}
							}
						}
					});

				});

		//给删除按钮绑定弹出删除对话框事件 (单个删除)
		$(document).on("click", ".delete_btn", function() {
			//1.弹出是否确认删除对话框
			var username = $(this).parents("tr").find("td:eq(2)").text(); //要删除的管理员的名字
			var id = $(this).attr("del-id");
			/* alert($(this).parents("tr").find("td:eq(2)").text()); */
			/* 确认删除弹出框 */
			swal({
				title : "确认删除【" + username + "】吗？",
				text : "一旦删除，您将无法恢复！",
				icon : "warning",
				buttons : true,
				dangerMode : true,
			}).then(function(willDelete) {
				if (willDelete) {
					$.ajax({
						url : "${APP_PATH}/admin/delete/" + id,
						type : "POST",
						success : function(result) {
							if (result.code == 100) {
								swal(result.msg, {
									icon : "success",
								});

							} else if (result.code == 200) {
								swal(result.msg, {
									icon : "warning",
								});
							}

						}
					})
				} else {
					swal("你取消了此操作！");
				}
				//回到当前页面
				to_page(currentPage);

			});

			/* if (confirm("确认删除【" + username + "】吗？")) {
				//确认，发送ajax请求删除
				$.ajax({
					url : "${APP_PATH}/admin/delete/" + id,
					type : "POST",
					success : function(result) {
						if (result.code == 100) {
							alert(result.msg);

						} else if (result.code == 200) {
							alert(result.msg);
						}
						//回到删除数据所在页
						to_page(currentPage);

					}
				});
			} */
		});

		//实现全选，全不选功能
		$("#check_all").click(function() {
			//通过prop获取  attr获取自定义属性的值     获取全选全部选框的当前状态  
			/* alert($(this).prop("checked")); */
			//将下面的子项的状态改为和它一致的状态
			$(".check_item").prop("checked", $(this).prop("checked"));
		})

		//给每一个check_item绑定事件
		$(document)
				.on(
						"click",
						".check_item",
						function() {
							//判断当前页的checkbox是否都选中
							/* alert($(".check_item:checked").length); */
							var flag = $(".check_item:checked").length == $(".check_item").length;
							$("#check_all").prop("checked", flag);
						});

		//点击全部删除，实现删除选中的所有
		$("#user_delete_all_btn").click(
				function() {
					//要删除的所有用户id的组合
					var del_idstr = "";
					$.each($(".check_item:checked"), function() {
						//组装用户id字符串
						del_idstr += $(this).parents("tr").find("td:eq(1)")
								.text()
								+ "-";
					});
					//去除最后一个“-”符号
					del_idstr = del_idstr.substring(0, del_idstr.length - 1);
					/*  当选择的要删除的数据为空，给出提示 */
					if (del_idstr.length <= 0) {
						swal("请选择要删除的数据", {
							icon : "warning",
						});
						return;
					}

					/* if (confirm("确认删除所有选中的用户吗？")) {
						//发送ajax请求删除所有选中的用户
						$.ajax({
							url : "${APP_PATH}/admin/delete/" + del_idstr,
							type : "POST",
							success : function(result) {
								alert(result.msg);
								//回到当前页面
								to_page(currentPage);
							}
						})
					} */
					/* 确认删除弹出框 */
					swal({
						title : "确认删除所有选中的日记吗？",
						text : "一旦删除，您将无法恢复！",
						icon : "warning",
						buttons : true,
						dangerMode : true,

					}).then(function(willDelete) {
						if (willDelete) {
							$.ajax({
								url : "${APP_PATH}/admin/delete/" + del_idstr,
								type : "POST",
								success : function(result) {
									/* alert(result.msg); */
									swal(result.msg, {
										icon : "success",
									});
									//回到当前页面
									to_page(currentPage);
								}
							})
						} else {
							swal("你取消了此操作！");
						}
					});
				});

		//给修改按钮绑定修改模态框弹出事件
		$(document).on("click", ".edit_btn", function() {
			/* changeIndex(this); */
			//alert("edit");
			//1.查出并显示对应用户信息
			getAdmin($(this).attr("edit-id"));
			//2.把管理员id传给修改模态框的更新按钮
			$("#user_update_btn").attr("edit-id", $(this).attr("edit-id"));
			$("#editUserModal").modal({
				backdrop : "static"
			})
		});

		/*  $(document).on("click","#search_btn",function(){
		 
		  var keywords = $("#search_words").val();
		  alert("点击了搜索按钮,keywords为：" + keywords);
		 }) */

		//搜索用户 模糊查询
		$("#search_btn").click(function() {
			var keywords = $("#search_words").val();
			/*   alert("点击了搜索按钮,keywords为：" + keywords); */
			$.ajax({
				url : "${APP_PATH}/admin/search/" + keywords,
				type : "GET",
				success : function(result) {
					/*  console.log(result);  //打印后台返回的数据 */
					//1.解析并显示用户数据
					build_users_table(result);
					//2.解析并显示分页信息
					build_page_info(result);
					//3.解析并显示分页条
					build_page_nav(result);
				}

			})
		})

		//根据id查询用户信息
		function getAdmin(id) {
			$.ajax({
				url : "${APP_PATH}/admin/" + id,
				type : "GET",
				success : function(result) {
					console.log(result);
					//获取查询到的管理员数据
					var admin = result.datalist.admin;
					//将查询到的数据填充到对应位置
					$("#username_edit_input").val(admin.username);
					$("#password_edit_input").val(admin.password);
				}
			});
		}
		//点击更新 更新管理员信息
		$('#user_update_btn')
				.click(
						function() {
							//用户名校验
							var username = $("#username_edit_input").val();
							var regName = /(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,5})/; //中文2-5个
							if (!regName.test(username)) {
								/* alert("用户名可以是2-5位中文或者6-16位英文和数字，下划线，中划线的组合"); */
								show_validate_msg("#username_edit_input",
										"error",
										"用户名可以是2-5位中文或者5-16位英文和数字，下划线，中划线的组合");
							} else {
								show_validate_msg("#username_edit_input",
										"success", "");
								$("#username_edit_input").parent().addClass(
										"has-success");
								$("#username_edit_input").next("span").text("");
							}

							//密码校验
							var password = $("#password_add_input").val();
							var regPassword = /^[a-zA-Z0-9_-]{5,18}$/;
							if (!regPassword.test(password)) {
								valiFlag = false;
								/* alert("密码为6-18位字母数字下划线中划线的组合"); */
								//清空这个元素之前的样式
								show_validate_msg("#password_add_input",
										"error", "密码为5-18位字母数字下划线中划线的组合");
								/*  $("#password_add_input").parent().addClass("has-error");
								$("#password_add_input").next("span").text("密码为6-18位字母数字下划线中划线的组合"); */

							} else {
								valiFlag = true;
								show_validate_msg("#password_add_input",
										"success", "");
								$("#password_add_input").parent().addClass(
										"has-success");
								$("#password_add_input").next("span").text("");
							}

							//发送ajax请求  保存更新的管理员数据
							$.ajax({
								/* url:"${APP_PATH}/admin/edit", */
								url : "${APP_PATH}/admin/edit/"
										+ $(this).attr("edit-id"),
								type : "POST",
								data : $("#editUserModal .editForm")
										.serialize(),
								success : function(result) {
									//alert(result.msg);
									//1.更新成功关闭修改模态框
									$("#editUserModal").modal('hide');
									//2.跳转到修改的数据所在的页面
									to_page(currentPage);
								}
							})

						})
	</script>
</body>

</html>