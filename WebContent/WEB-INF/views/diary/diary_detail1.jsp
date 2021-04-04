<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改日记</title>
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
.main {
	margin: 20px;
	width: 100%;
	height: 100%
}

.diaryTitle {
	padding: 10px 20px;
	height: 54px;
	background-color: #f1f9fc;
	border-top: 1px solid #e0eaef;
	border-bottom: 1px solid #dbe7ed;
}

.diaryTitle h2 {
	font-size: 24px;
	line-height: 25px;
}

.diary_container {
   background-color: #f1f9fc;
	margin-top: 20px;
	/* border: 1px solid red; */
	padding:20px 30px;
	width: 100%;
	height: 100%;
}


.save_container{
  margin-top:20px;
}
</style>
</head>
<body>
      
	<div> 
      	${param.id}    
      	askdfjlasdj faslgjlsa gjl
	</div>
	<script type="text/javascript" charset="gb2312">
		//  实例化编辑器 
		var ue = UE.getEditor("editor");
		var valiFlag = true;
		$(function() {
			/* 页面加载完成后，直接发送一个ajax请求 获取分页数据  显示数据列表的首页*/
			getDiary(${param.diaryId});
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
		
		$("#title_edit_input").blur(function(){
			var title = $("#title_edit_input").val();
			if(title == null || title == ''){
				valiFlag = false;
				show_validate_msg("#title_edit_input","error","日记标题不能为空");
			}else{
				valiFlag = true;
				show_validate_msg("#title_edit_input",
						"success", "");
				$("#title_edit_input").parent().addClass(
						"has-success");
				$("#title_edit_input").next("span").text("");
			}
			return valiFlag;
		})
		
		
		//清空表单样式和内容
		function reset_form(ele) {
			//重置表单内容
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
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
					console.log(diary);
					
					//将查询到的数据填充到对应位置
					$("#title_edit_input").val(diary.title);
					$("#diaryType").val(diary.diaryType.diaryTypeId);
					ue.ready(function(){
						 ue.setContent(diary.content);
					})
					$("#diaryContent").val(diary.content);
					
				}
			}); 
		}
		
		//提交修改日记的信息 保存日记信息
		$("#diary_save_btn").click(
				function() {
					alert("点击了完成修改日记按钮");
					var diaryType = $("#diaryType option:selected").val();
					//alert("日记类型："+diaryType);
					var title = $("#title_edit_input").val();
					if(title == null || title == ""){
						valiFlag = false;
						alert('日记标题不能为空');
						return false;
					}else if(!diaryType){
						valiFlag = false;
						show_validate_msg("#diaryType","error","日记类型不能为空");
						return false;
					}else if (!UE.getEditor('editor').hasContents()){
						valiFlag = false;
						alert('请先填写日记内容!');
						return false;
					}else{
						valiFlag = true;
					}
					if(!valiFlag){
						alert("校验不通过")
					    return false;
				    } 
					var diaryContent = UE.getEditor('editor').getContent();
					$("#diaryContent").val(diaryContent);

					//2.发送ajax请求保存日记类型
					
					//alert($("#edit_diary_form").serialize());
					 $.ajax({
						 url : "${APP_PATH}/diary/modify/"+${param.id},
						 type : "POST",
						 //序列表格内容为字符串
						 data : $("#edit_diary_form").serialize(),
						 success:function(result){
							 if(result.code == 100){
								 reset_form("#edit_diary_form");
								 //成功添加日记后将富文本编辑器中的内容清空·
								 //UE.getEditor('editor').setContent('', false);//清空内容
								 alert(result.msg);
								 window.location.href ="<%=request.getContextPath()%>/diary/list"
							 }else if(result.code == 200){
								 alert(result.msg);
							    
							 }
						 }
					 })
				});
	</script>
</body>
</html>