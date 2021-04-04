<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>    
<title>日记本系统</title>
<style type="text/css">
/* 设置固定的背景图像：    background-attachment: fixed;  	当页面的其余部分滚动时，背景图像不会移动。*/
html,body{
    background: url(../images/snap_1537698639290.png);
    background-repeat:no-repeat;
     background-size:100% 100%; 
     background-attachment: fixed; 
}

</style>
</head>
    <frameset rows="50,*,30" >
          <frame noresize="noresize" name="topFrame"  src="../system/top"  scrolling="no"  />
          <!--  <frameset  id="body"> -->
          <frameset  id="body" cols="250,*"  >
               <frame noresize="noresize" name="leftFrame" id ="leftFrame" src="../system/left" scrolling="no" />
               
               <c:if test="${userType == 1 }">
               <frame noresize="noresize" name="body" id="body"  src="../system/welcome1"  scrolling="yes"/>
               </c:if>
                <c:if test="${userType == 2 }">
               <frame noresize="noresize" name="body" id="body"  src="../system/welcome2"  scrolling="yes"/>
                </c:if>
              <!--   <frame name="rightFrame" src="rightFrame.html"/>  src="mainFrame.html"-->
          </frameset>
          <frame noresize="noresize" name="bottomFrame" id ="homebottom" src="../system/bottom" scrolling="no"/>
     </frameset>
     <noframes>
		<body>
		        该浏览器不支持框架集！
		</body>
     </noframes>

</html>