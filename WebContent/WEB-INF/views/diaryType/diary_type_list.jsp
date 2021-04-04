<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta charset="UTF-8">
<title>日记类型列表</title>
<!--  以服务器的路径为标准 http://localhost:3306/MyDiary -->
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

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
<!-- 确认取消弹出框 -->
<script type="text/javascript" src="../static/js/sweetalert.min.js"></script>
<script type="text/javascript" src="../static/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../static/js/validateExtends.js"></script>

<style type="text/css">
/* 模态框居中样式 */
.modal {
	display: table;
	width: 600px;
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

	<section id="main"> <section class="main_container">
	<section id="projectTitle" class="clear">
	<div class="projectTitle_text l">
		<h2>日记类型管理</h2>
	</div>
	</section> <section id="projectList">
	<div class="projectList_cons">
		<div class="row">
			<div class="col-md-3">
				<button type="button" class="btn btn-success" data-toggle="modal"
					id="diarytype_add_btn">
					<span class="glyphicon glyphicon-plus"></span> 添加
				</button>

				<button type="button" class="btn btn-danger" data-toggle="modal"
					id="diaryType_delete_all_btn">
					<span class="glyphicon glyphicon-remove"></span> 删除
				</button>
			</div>
		</div>
		<div class="show">
			<table class="sp_table table-bordered" id="diarytype_table">
				<thead>
					<tr>
						<th width="60"><input type="checkbox" id="check_all"></th>
						<th width="300">ID</th>
						<th width="600">类别名称</th>
						<th style="min-width: 190px">操作</th>
					</tr>
				</thead>
				<tbody>

				</tbody>
			</table>
		</div>
	</div>
	</section> 
	<!-- 添加日记类型模态框 -->
	<div class="modal fade" id="addDiaryTypeModal"
		aria-labelledby="addDiaryType" aria-hidden="true">
		<div class="modal-dialog ">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">添加日记类别</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form class="form-horizontal addForm">
						<div class="form-group">
							<label for="typename_add_input" class="col-sm-2 control-label">类别名称:</label>
							<div class="col-sm-7">
								<!--  name 与实体类中的名字一致 -->
								<input type="text" class="form-control" id="typename_add_input"
									name="typeName" placeholder="请输入日记类别名称" autoComplete="off"> <span
									class="help-block"></span>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary"
						id="diarytype_save_btn">保存</button>
				</div>
			</div>
		</div>

	</div>

	<!--修改日记类别模态框 -->
	<div class="modal fade" id="editDiaryTypeModal"
		aria-labelledby="editDiaryType" aria-hidden="true">
		<div class="modal-dialog ">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">修改日记类型</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form class="form-horizontal editForm">
						<div class="form-group">
							<label for="typename_edit_input" class="col-sm-2 control-label">类别名称:</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="typename_edit_input"
									name="typeName" placeholder="请输入类别名称"> <span
									class="help-block"></span>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary"
						id="diaryType_update_btn">更新</button>
				</div>
			</div>
		</div>
	</div>

	</section> </section>

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
				url : "${APP_PATH}/diaryType/get_list",
				data : "pn=" + pn,
				type : "get",
				success : function(result) {
					/*  console.log(result);  //打印后台返回的数据 */
					//1.解析并显示日记类型数据
					build_diaryType_table(result);
					//2.解析并显示分页信息
					build_page_info(result);
					//3.解析并显示分页条
					build_page_nav(result);
				}
			})
			$("#check_all").prop("checked", false);
		}

		//1.解析并显示用户数据方法	用户数据表格
		function build_diaryType_table(result) {
			//清除原来的数据
			$("#diarytype_table tbody").empty();
			var diaryTypes = result.datalist.pageInfo.list;
			/* alert("日记类别列表:"+diaryTypes); */
			$.each(diaryTypes,function(index, diaryType) {
								/*  alert("每一diaryType个:"+ diaryType + diaryType.diaryTypeId); */
								var checkboxTd = $("<td><input type='checkbox' class='check_item'/></td>");
								var diaryTypeIdTd = $("<td></td>").append(
										diaryType.diaryTypeId);
								var typeNameTd = $("<td></td>").append(
										diaryType.typeName);
								var editBtn = $("<button></button>")
										.addClass(
												"btn btn-success btn-sm edit_btn")
										.append(
												$("<span></span>")
														.addClass(
																"glyphicon glyphicon-pencil "))
										.append("编辑");
								//为编辑按钮添加一个自定义属性，表示当前编辑的管理员id
								editBtn.attr("edit-id", diaryType.diaryTypeId);
								var delBtn = $("<button></button>")
										.addClass(
												"btn btn-danger btn-sm delete_btn")
										.append(
												$("<span></span>")
														.addClass(
																"glyphicon glyphicon-remove"))
										.append("删除");
								//为删除按钮添加一个自定义属性，表示当前删除管理员id
								delBtn.attr("del-id", diaryType.diaryTypeId);
								var btnTd = $("<td></td>").append(editBtn)
										.append(delBtn)
								$("<tr></tr>").append(checkboxTd).append(
										diaryTypeIdTd).append(typeNameTd)
										.append(btnTd).appendTo(
												"#diarytype_table tbody");
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
		$("#diarytype_add_btn").click(function() {
			/* changeIndex(this); */
			//清空表单数据(表单完整重置(表单数据，表单样式))  jquery没有这个方法 所以取dom 对象
			reset_form("#addDiaryTypeModal .addForm");
			$("#addDiaryTypeModal").modal({
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

		//日记类别名称修改失去焦点触发校验
		$("#typename_edit_input")
				.blur(
						function() {
							//1.获取要校验的数据
							var typeName = $("#typename_edit_input").val();
							//日记类别名称校验
							if (typeName == "") {
								valiFlag = false;
								show_validate_msg("#typename_edit_input",
										"error", "日记类别名称不能为空");
							} else {
								valiFlag = true;
								show_validate_msg("#typename_edit_input",
										"success", "");
								$("#typename_edit_input").parent().addClass(
										"has-success");
								$("#typename_edit_input").next("span").text("");
							}

							return valiFlag;
						});

		//添加窗口用户名校验(失去焦点时触发)
		$("#typename_add_input")
				.blur(
						function() {
							//1.获取要校验的数据
							var typeName = $("#typename_add_input").val();
							//日记类别名称校验
							if (typeName == "") {
								valiFlag = false;
								/* alert("用户名可以是2-5位中文或者6-16位英文和数字，下划线，中划线的组合"); */
								show_validate_msg("#typename_add_input",
										"error", "日记类别名称不能为空");
							} else {
								valiFlag = true;
								show_validate_msg("#typename_add_input",
										"success", "");
								$("#typename_add_input").parent().addClass(
										"has-success");
								$("#typename_add_input").next("span").text("");
							}

							return valiFlag;
						});

		//提交新增日记类别模态框的信息 保存日记类别信息
		$("#diarytype_save_btn").click(
				function() {
					/* alert("点击了保存按钮"); */
					//校验不通过则不执行ajax请求
					if (!valiFlag) {
						show_validate_msg("#typename_add_input", "error",
								"日记类别名称不能为空");
						return false;
					}
					//2.发送ajax请求保存用户  
					//序列表格内容为字符串
					//alert($("#addDiaryTypeModal .addForm").serialize());
					$.ajax({
								url : "${APP_PATH}/diaryType/add",
								type : "POST",
								data : $("#addDiaryTypeModal .addForm")
										.serialize(), //提交序列化表格内容为字符串后的数据
								success : function(result) {
									if (result.code == 100) {
										/* alert(result.msg); */
										swal(result.msg, {
				                            icon: "success",
				                        });
										//1.关闭添加数据模态框
										$("#addDiaryTypeModal").modal('hide');
										//2.跳转到日记类别数据表格的最后一页 显示刚添加的数据
										to_page(totalRecord);
									} else if (result.code == 200) {
										//alert(result.msg);
										if (result.datalist.error_msg != null) {
											//用户名不合法
											show_validate_msg(
													"#typename_add_input",
													"error",
													result.datalist.error_msg);
										}else{
											swal(result.msg, {
					                            icon: "warning",
					                        });
										}
										
									}
								}
							});

				});

		//给删除按钮绑定弹出删除对话框事件 (单个删除)
		$(document).on("click", ".delete_btn", function() {
			//1.弹出是否确认删除对话框
			var typeName = $(this).parents("tr").find("td:eq(2)").text(); //要删除的日记类别名称的名字
			var id = $(this).attr("del-id");
			/* alert($(this).parents("tr").find("td:eq(2)").text()); */
			/* 确认删除弹出框 */
			 swal({
                   title: "确认删除【" + typeName + "】日记类别吗？",
                   text: "一旦删除，您将无法恢复！",
                   icon: "warning",
                   buttons: true,
                   dangerMode: true,
               }).then((willDelete) => {
                   if (willDelete) {
                   	$.ajax({
                   		url : "${APP_PATH}/diaryType/delete/" + id,
							type : "POST",
							success : function(result) {
								/* alert(result.msg); */
								if (result.code == 100) {
									swal(result.msg, {
			                            icon: "success",
			                        });
					        	} else if (result.code == 200) {							
							        swal(result.msg, {
	                                    icon: "warning",
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
			
			/* if (confirm("确认删除【" + typeName + "】吗？")) {
				//确认，发送ajax请求删除
				$.ajax({
					url : "${APP_PATH}/diaryType/delete/" + id,
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
		$(document).on("click",".check_item",
			function() {
				//判断当前页的checkbox是否都选中
				/* alert($(".check_item:checked").length); */
				var flag = $(".check_item:checked").length == $(".check_item").length;
				$("#check_all").prop("checked", flag);
			}
	    );

		//点击全部删除，实现删除选中的所有
		$("#diaryType_delete_all_btn").click(
				function() {
					//要删除的所有日记类别id的组合
					var del_idstr = "";
					$.each($(".check_item:checked"), function() {
						//组装日记类别id字符串
						del_idstr += $(this).parents("tr").find("td:eq(1)")
								.text()
								+ "-";
					});
					//去除最后一个“-”符号
					del_idstr = del_idstr.substring(0, del_idstr.length - 1);
					 /*  当选择的要删除的数据为空，给出提示 */
					if(del_idstr.length <= 0){
						swal("请选择要删除的数据", {
                            icon: "warning",
                        });
						return ;
					}
					/* 确认删除弹出框 */
					 swal({
		                    title: "确认删除所有选中的日记类别吗？",
		                    text: "一旦删除，您将无法恢复！",
		                    icon: "warning",
		                    buttons: true,
		                    dangerMode: true,
		                   
		                }).then(function(willDelete){
		                    if (willDelete) {
		                    	$.ajax({
		                    		url : "${APP_PATH}/diaryType/delete/" + del_idstr,
									type : "POST",
									success : function(result) {
										/* alert(result.msg); */
										if(result.code == 100){
											swal(result.msg, {
					                            icon: "success",
					                        });
										}else if(result.code == 200){
											swal(result.msg, {
					                            icon: "warning",
					                        });
										}
										//回到当前页面
										to_page(currentPage);
									}
								})
		                    } else {
		                        swal("你取消了此操作！");
		                    }
		                });
					/* if (confirm("确认删除所有选中的日记类别吗？")) {
						//发送ajax请求删除所有选中的日记类别
						$.ajax({
							url : "${APP_PATH}/diaryType/delete/" + del_idstr,
							type : "POST",
							success : function(result) {
								alert(result.msg);
								//回到当前页面
								to_page(currentPage);
							}
						})
					} */
				});

		//给修改按钮绑定修改模态框弹出事件
		$(document).on(
				"click",
				".edit_btn",
				function() {
				/* 	changeIndex(this); */
					//alert("edit");
					//1.查出并显示对应日记类别信息
					getDiaryType($(this).attr("edit-id"));
					//2.把日记类别id传给修改模态框的更新按钮
					$("#diaryType_update_btn").attr("edit-id",
							$(this).attr("edit-id"));
					$("#editDiaryTypeModal").modal({
						backdrop : "static"
					})
				});

		//根据id查询日记类别信息
		function getDiaryType(id) {
			$.ajax({
				url : "${APP_PATH}/diaryType/" + id,
				type : "GET",
				success : function(result) {
					console.log(result);
					//获取查询到的日记类别数据
					var diaryType = result.datalist.diaryType;
					//将查询到的数据填充到对应位置
					$("#typename_edit_input").val(diaryType.typeName);
				}
			});
		}
		//点击更新 更新日记类别信息
		$('#diaryType_update_btn').click(function() {
			/* alert("点击了更新按钮"); */
			if (!valiFlag) {
				alert("校验不通过");
				return false;
			}
			/* alert($("#editDiaryTypeModal .editForm").serialize()); */
			//发送ajax请求  保存更新的管理员数据
			$.ajax({
				url : "${APP_PATH}/diaryType/edit/" + $(this).attr("edit-id"),
				type : "POST",
				data : $("#editDiaryTypeModal .editForm").serialize(),
				success : function(result) {
					//alert(result.msg);
					if(result.code == 100){
						swal(result.msg, {
                            icon: "success",
                        });
					}else if(result.code == 200){
						swal(result.msg, {
                            icon: "warning",
                        });
						
					}
					//1.更新成功关闭修改模态框
					$("#editDiaryTypeModal").modal('hide');
					//2.跳转到修改的数据所在的页面
				/* 	alert("currentPage:" + currentPage); */
					to_page(currentPage);
				}
			})

		})
	</script>

</body>

</html>