<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta charset="UTF-8">
<title>日记列表</title>
<!--  以服务器的路径为标准 http://localhost:3306/MyDiary -->
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

<link rel="stylesheet" type="text/css"
	href="../static/css/user/user_list.css">
<link href="../static/css/bootstrap.min.css" rel="stylesheet">
<link href="../static/css/bootstrapValidator.min.css" rel="stylesheet" />
<link
	href="https://cdn.bootcss.com/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.min.css"
	rel="stylesheet">
<script src="../static/js/jquery-3.4.1.min.js"></script>
<script src="../static/js/bootstrap.min.js"></script>
<script src="../static/js/bootstrapValidator.min.js"></script>

<link rel="stylesheet" type="text/css" href="../static/css/easyui.css">
<link rel="stylesheet" type="text/css" href="../static/css/icon.css">
<link rel="stylesheet" type="text/css" href="../static/css/demo.css">
<!-- <script type="text/javascript" src="../static/js/jquery.min.js"></script> -->
<script type="text/javascript" src="../static/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../static/js/validateExtends.js"></script>
<!-- 确认取消弹出框 -->
<script type="text/javascript" src="../static/js/sweetalert.min.js"></script>
<script
	src="https://cdn.bootcss.com/moment.js/2.22.0/moment-with-locales.js"></script>
<script
	src="https://cdn.bootcss.com/bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script>

<style type="text/css">
html {
	
}

/* .diary_content p{
     max-width: 640px;
     white-space: nowrap;
     overflow: hidden;
     text-overflow: ellipsis;
} */
.diary_content {
	max-width: 640px;
}
/* .diary_content {
	max-width: 640px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
} */

/* .diary_content{
text-overflow: -o-ellipsis-lastline;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 1;
  line-clamp: 1;
  -webkit-box-orient: vertical;
  width:500px;
} */
.diary_title {
	text-align: center;
	line-height: 1;
}

.date_select {
	width: 500px;
	height: 50px;
	/* border: 1px solid pink; */
	display: flex;
}

.tip_text {
	height: 36px;
	/* border: 1px solid plum; */
	line-height: 36px;
	font-size: 16px;
}

#datetimepicker1 {
	margin-left: 10px;
	margin-right: 10px;
	height: 36px;
}

#search_btn {
	height: 40px;
}

#search_btn2 {
	width: 60px;
	height: 36px;
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
		<h2>日记列表</h2>
	</div>
	</section> <section id="projectList">
	<div class="projectList_cons">
		<div class="row">
			<div class="col-md-3">
				<c:if test="${userType == 2 }">
					<button type="button" class="btn btn-success" data-toggle="modal"
						id="diary_add_btn">
						<span class="glyphicon glyphicon-plus"></span> 写日记
					</button>
				</c:if>
				<button type="button" class="btn btn-danger" data-toggle="modal"
					id="diary_delete_all_btn">
					<span class="glyphicon glyphicon-remove"></span> 批量删除
				</button>
			</div>

			<!-- 按日记发布日期搜索 -->

			<div class="date_select col-md-3">
				<div class="tip_text">按日期查询:</div>
				<div class="input-group" id='datetimepicker1'>
					<input type='text' class="form-control " id="search_time" /> <span
						class="input-group-addon"> <span
						class="glyphicon glyphicon-calendar"></span>
					</span>
				</div>
				<button class="btn btn-primary btn-success" id="search_btn2">查询</button>
			</div>

			<!-- 按日记标题搜索 -->
			<div class="sp_search ">
				<!--   实现点击回车执行搜索功能 -->
				<input type="text" placeholder="请输入日记标题" name="keywords"
					id="search_words" value=""
					onkeydown="if(event.keyCode==13)searchDiary()">
				<button type="button" class="btn btn-success" id="search_btn">
					<span class="glyphicon glyphicon-search"></span> 查询
				</button>
			</div>


			<!-- 	<div class="row">
				<div class='col-sm-6'>
					<div class="form-group">
						<label>选择查询时间：</label>
						指定 date标记
						<div class='input-group date' id='datetimepicker1'>
							<input type='text' class="form-control " id="search_time" /> <span
								class="input-group-addon"> <span
								class="glyphicon glyphicon-calendar"></span>
							</span>
						</div>
					</div>
				</div>
				<div>
					<button class="btn btn-primary" id="search_btn2">查询</button>
				</div>
			</div>  -->


		</div>

		<div class="show">
			<table class="sp_table table-bordered" id="diary_table">
				<thead>
					<tr>
						<th width="50"><input type="checkbox" id="check_all"></th>
						<th width="80">ID</th>
						<th width="150">日记标题</th>
						<th>日记内容</th>
						<th width="150">日记类型</th>
						<th width="140">编写日期</th>
						<th style="width: 150px; min-width: 150px;">操作</th>
					</tr>
				</thead>
				<tbody>

				</tbody>
			</table>
		</div>
	</div>
	</section> </section> </section>

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
		var valiFlag = true;
		$(function() {
			/* 页面加载完成后，直接发送一个ajax请求 获取分页数据  显示数据列表的首页*/
			to_page(1); 
			 $('#datetimepicker1').datetimepicker({
	                format: 'YYYY-MM-DD',
	                locale: moment.locale('zh-cn'),
	               /*  defaultDate: "1990-1-1"  */
	                 defaultDate: new Date(),//初始化当前日期 
	            });
		});
		
		 $("#search_btn2").click(function () {
	            var keywords = $("#search_time").val();
	            console.log("选择的时间" + keywords);
	            searchDiaryBydate();
	            // searchDiary();
	        });

		//页面跳转
		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/diary/get_list",
				data : "pn=" + pn,
				type : "get",
				success : function(result) {
					/*  console.log(result);  //打印后台返回的数据 */
					//1.解析并显示日记数据
					build_diary_table(result);
					//2.解析并显示分页信息
					build_page_info(result);
					//3.解析并显示分页条
					build_page_nav(result);
				}
			})
			$("#check_all").prop("checked", false);
		}

		//1.解析并显示日记数据方法	日记数据表格
		function build_diary_table(result) {
			//清除原来的数据
			$("#diary_table tbody").empty();
			var diarylist = result.datalist.pageInfo.list;
			
			/* alert("日记列表:"+diarylist);  */
			$.each(diarylist,
							function(index, diary) {
				               /*  alert("单条日记内容" + diary); */
				                var diaryId = diary.id;
				               // console.log(diaryId);
				                var url = "../diary/detail?id=" + diaryId ;
				               // console.log(url);
								var checkboxTd = $("<td><input type='checkbox' class='check_item'/></td>");
								var diaryIdTd = $("<td></td>").append(diary.id);
								/* var titleTd = $("<td><a class='diary_title' href='../diary/w_diary'></a></td>").append(
										diary.title); */
							   /*  var titleTd = $("<a class='diary_title' href='../diary/w_diary'><td ></td></a>").append(
												diary.title);  */
								/* var titleTd = $("<a class='diary_title' href='../diary/w_diary'></a>").append($("<td></td>").append(
										diary.title));  */
							   /*var titleTd = $("<td></td>").append($("<a href='../diary/detail/80'></a>").append(
														diary.title)); */ 
								var titleTd = $("<td></td>").append($("<a></a>").attr("href",url).append(
												diary.title)); 
								/* var contentTd = $("<td class='diary_content'></td>").append(
										diary.content); */
								var contentTd = $("<td class='diary_content'></td>").append(
												cutString2(diary.content,60));
										
								var diaryTypeTd = $("<td></td>").append(
										diary.diaryType.typeName);
								var releaseDateTd = $("<td></td>").append(
										toDates(diary.releaseDate));
							/* 	var editBtn = $("<a href='javascript:goDiaryModify()'></a>") */
								var editBtn = $("<button></button>")
										.addClass(
												"btn btn-success btn-sm edit_btn")
										.append(
												$("<span></span>")
														.addClass(
																"glyphicon glyphicon-pencil "))
										.append("编辑");
								//为编辑按钮添加一个自定义属性，表示当前编辑的管理员id
								editBtn.attr("edit-id", diary.id);
								
								var delBtn = $("<button></button>")
								.addClass(
										"btn btn-danger btn-sm delete_btn")
								.append(
										$("<span></span>")
												.addClass(
														"glyphicon glyphicon-remove"))
								.append("删除");
								//为删除按钮添加一个自定义属性，表示当前删除管理员id
								delBtn.attr("del-id", diary.id);
								if(${userType == 1}){
									//管理员登陆不能编辑普通用户的日记信息
									var btnTd = $("<td></td>").append(delBtn);
								}else{
									//普通用户可以编辑，删除日记信息
									var btnTd = $("<td></td>").append(editBtn)
									.append(delBtn);
								}
								
								$("<tr></tr>").append(checkboxTd).append(
										diaryIdTd).append(titleTd).append(
												contentTd).append(
														diaryTypeTd).append(
														releaseDateTd).append(btnTd).appendTo(
										"#diary_table tbody");
							}); 
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

		
		//点击添加跳转到写日记页面 
		$("#diary_add_btn").click(function() {
			window.location.href ="<%=request.getContextPath()%>/diary/w_diary"
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

		//给删除按钮绑定弹出删除对话框事件 (单个删除)
		$(document).on("click", ".delete_btn", function() {
			//1.弹出是否确认删除对话框
			var title = $(this).parents("tr").find("td:eq(2)").text(); //要删除的日记标题
			var id = $(this).attr("del-id");
			/* 确认删除弹出框 */
			 swal({
                   title: "确认删除【" + title + "】这篇日记吗？",
                   text: "一旦删除，您将无法恢复！",
                   icon: "warning",
                   buttons: true,
                   dangerMode: true,
               }).then((willDelete) => {
                   if (willDelete) {
                   	$.ajax({
							url : "${APP_PATH}/diary/delete/" + id,
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
			
			 /* if (confirm("确认删除【" + title + "】吗？")) {
				//确认，发送ajax请求删除
				$.ajax({
					url : "${APP_PATH}/diary/delete/" + id,
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
		
		//根据日记标题搜索日记 模糊查询
	    function searchDiary(){
	    	var keywords = $("#search_words").val();
			 //alert("点击了搜索按钮,keywords为：" + keywords);
			$.ajax({
				url : "${APP_PATH}/diary/search/" + keywords,
				type : "GET",
				success : function(result) {
					//  console.log(result);  //打印后台返回的数据 
					//1.解析并显示日记数据
					build_diary_table(result);
					//2.解析并显示分页信息
					build_page_info(result);
					//3.解析并显示分页条
					build_page_nav(result);
				}

			}) 
		}
		
	  //根据日记发布日期搜索日记 模糊查询
	    function searchDiaryBydate(){
	    	 /*  var keywords = $("#search_time").val(); */
	    	var releaseDate = $("#search_time").val();
			 //alert("点击了搜索按钮,keywords为：" + keywords);
			$.ajax({
				url : "${APP_PATH}/diary/search2/" + releaseDate,
				type : "GET",
				success : function(result) {
					//  console.log(result);  //打印后台返回的数据 
					//1.解析并显示日记数据
				      build_diary_table(result);
					//2.解析并显示分页信息
					build_page_info(result);
					//3.解析并显示分页条
					build_page_nav(result); 
				}

			}) 
		}
		
		$("#search_btn").click(function(){
			searchDiary();
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
		/* $("#diary_delete_all_btn").click(
				function() {
					//要删除的所有日记id的组合
					var del_idstr = "";
					$.each($(".check_item:checked"), function() {
						//组装日记id字符串
						del_idstr += $(this).parents("tr").find("td:eq(1)")
								.text()
								+ "-";
					});
					//去除最后一个“-”符号
					del_idstr = del_idstr.substring(0, del_idstr.length - 1);
					if (confirm("确认删除所有选中的日记吗？")) {
						//发送ajax请求删除所有选中的日记
						$.ajax({
							url : "${APP_PATH}/diary/delete/" + del_idstr,
							type : "POST",
							success : function(result) {
								alert(result.msg);
								//回到当前页面
								to_page(currentPage);
							}
						})
					}
				}); */
		
	     //点击全部删除，实现删除选中的所有
		$("#diary_delete_all_btn").click(
				function() {
					//要删除的所有日记id的组合
					var del_idstr = "";
					$.each($(".check_item:checked"), function() {
						//组装日记id字符串
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
		                    title: "确认删除所有选中的日记吗？",
		                    text: "一旦删除，您将无法恢复！",
		                    icon: "warning",
		                    buttons: true,
		                    dangerMode: true,
		                   
		                }).then(function(willDelete){
		                    if (willDelete) {
		                    	$.ajax({
									url : "${APP_PATH}/diary/delete/" + del_idstr,
									type : "POST",
									success : function(result) {
										/* alert(result.msg); */
										swal(result.msg, {
				                            icon: "success",
				                        });
										//回到当前页面
										to_page(currentPage);
									}
								})
		                    } else {
		                        swal("你取消了此操作！");
		                    }
		                });
					/* if (confirm("确认删除所有选中的日记吗？")) {
						//发送ajax请求删除所有选中的日记
						$.ajax({
							url : "${APP_PATH}/diary/delete/" + del_idstr,
							type : "POST",
							success : function(result) {
								alert(result.msg);
								//回到当前页面
								to_page(currentPage);
							}
						})
					} */
				});

		//给编辑日记按钮绑定跳转到编辑页面的事件
		$(document).on("click", ".edit_btn", function() {
			
			//1.获取要修改日记的id
			var diaryId = $(this).attr("edit-id");
			
			window.location.href ="<%=request.getContextPath()%>/diary/modify?diaryId="+ diaryId
							//getDiary($(this).attr("edit-id"));
							//2.把日记id传给修改模态框的更新按钮
							//$("#diary_update_btn").attr("edit-id", $(this).attr("edit-id"));

		});

		//根据id查询日记信息
		function getDiary(id) {
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
		//点击更新 更新日记信息
		$('#diary_update_btn').click(function() {
			if (!valiFlag) {
				alert("校验不通过");
				return false;
			}
			//发送ajax请求  保存更新的管理员数据
			$.ajax({
				/* url:"${APP_PATH}/admin/edit", */
				url : "${APP_PATH}/user/edit/" + $(this).attr("edit-id"),
				type : "POST",
				data : $("#editUserModal .editForm").serialize(),
				success : function(result) {
					//alert(result.msg);
					//1.更新成功关闭修改模态框
					$("#editUserModal").modal('hide');
					//2.跳转到修改的数据所在的页面
					alert("currentPage:" + currentPage);
					to_page(currentPage);
				}
			})

		})

		//返回获取的该行的日记类型名称
		function formatDiaryType(val, row) {
			return val.typeName;
		};

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

		//截取固定长度的字符串
		function cutString(str, len) {
			//length属性读出来的汉字长度为1
			if (str.length * 2 <= len) {
				return str;
			}
			var strlen = 0;
			var s = "";
			for (var i = 0; i < str.length; i++) {
				s = s + str.charAt(i);
				if (str.charCodeAt(i) > 128) {
					strlen = strlen + 2;
					if (strlen >= len) {
						return s.substring(0, s.length - 1) + "...";
					}
				} else {
					strlen = strlen + 1;
					if (strlen >= len) {
						return s.substring(0, s.length - 2) + "...";
					}
				}
			}
			return s;
		}
		
	  
		function cutString2(text, length) {
			//全为中文
			if (text.replace(/[\u4e00-\u9fa5]/g, 'aa').length <= length) {
				return text
			} else {
				var _length = 0
				var outputText = ''
				for (var i = 0; i < text.length; i++) {
					if (/[\u4e00-\u9fa5]/.test(text[i])) {
						_length += 2
					} else {
						_length += 1
					}
					if (_length > length) {
						break
					} else {
						outputText += text[i]
					}
				}
				return outputText + '...'
			}
		}
	</script>

</body>

</html>