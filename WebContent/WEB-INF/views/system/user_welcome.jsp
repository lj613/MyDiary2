<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理员用户欢迎页</title>
<link rel="stylesheet" type="text/css"
	href="../static/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="../static/iconfont/iconfont.css">
<link rel="stylesheet" type="text/css"
	href="../static/js/bootstrap.min.js">

<script src="../static/js/jquery-3.4.1.min.js"></script>
<script src="../static/js/echarts.min.js"></script>
<script src="../static/iconfont/iconfont.js"></script>
<style type="text/css">
body {
	background-color: #eee;
}

.main {
	padding: 30px;
}

.title-box {
	/* padding: 20px;
	overflow: hidden;
	color: red; */
	height: 54px;
	background-color: #f1f9fc;
	border-top: 1px solid #e0eaef;
	border-bottom: 1px solid #dbe7ed;
	margin-bottom: 20px;
}

.title {
	font-size: 25px;
	line-height: 30px;
	height: 30px;
	/* color: red; */
	margin: 21px 0 0 22px;
	color: #333333;
}

.statistics {
	margin-top: 40px;
	display: flex;
	width: 100%;
	/* align-items: center; */
	justify-content: space-between;
	box-sizing: border-box;
}

.statistics .panel {
    min-width:340px;
	width: 42%;
}

#diary-ategory {
	width: 400px;
	height: 350px;
}

.weather-left {
	flex: 1;
	margin-left: -15px;
	text-align: center;
}

.weather-img-box {
	width: 125px;
	height: 130px;
	margin: 0 auto;
}

.weather-img-box img {
	width: 100%;
	height: 100%;
}

.type {
	font-size: 16px;
	text-align: center;
	font-weight: bold;
}

.weather {
	display: flex;
}

.weather-right {
	flex: 1;
	margin-top: 26px;
}

.weather-bottom {
	margin-top: 10px;
	margin-bottom: 5px;
}

.date {
	background-color: #9d9d9d;
	color: #fff;
	width: 160px;
	margin-left: 30px;
}

.icon {
	width: 125px;
	height: 130px;
	vertical-align: -0.15em;
	fill: currentColor;
	overflow: hidden;
}

.tags {
	margin-top: 20px;
	display: flex;
	width: 100%;
	height: 100px;
	align-items: center;
	justify-content: space-between;
	box-sizing: border-box;
}

.tags .tag-info {
	flex: 1;
	color: white;
	/* padding: 20px 20px; */
	padding: 20px 20px 20px 20px;
	box-sizing: border-box;
}

.tags .tag-info .text {
	font-size: 16px;
	font-weight: 400;
}

.tags .tag-info .num {
	font-size: 30px;
	font-weight: 700;
}

.tags .tag-info .num span {
	font-size: 14px;
}

.tag-item {
	display: flex;
	width: 42%;
	height: 100%;
	min-width: 220px; align-items : center;
	background: #fec006;
	align-items: center;
}

.green {
	background: #8ac249;
}

.tags .tag-icon-userbox {
	background: #f1b606;
	width: 100px;
	height: 100%;
	box-sizing: border-box;
}

.tags .tag-icon-diarybox {
	background: #83b845;
	width: 100px;
	height: 100%;
	box-sizing: border-box;
}

.tags .tag-icon {
	margin-top: 27px;
	margin-left: 32px;
}

.iconfont {
	color: white;
	font-size: 30px;
}


</style>
</head>
<body>
	<div class="main">
		<!--   标题部分 -->
		<div class="title-box" title="欢迎使用">
			<p class="title">欢迎使用日记本系统</p>
		</div>
		<div class="content">
			<!-- tags部分 -->
			<div class="tags">
				<div class="tag-item">
					<div class="tag-info">
						<h3 class="text">日记类别数</h3>
						<div class="num">
							${diaryTypeNum}
							<span>类</span>
						</div>
					</div>
					<div class="tag-icon-userbox">
						<div class="tag-icon">
							<span class="iconfont icon-category"></span>
						</div>
					</div>
				</div>
				<div class="tag-item green">
					<div class="tag-info">
						<h3 class="text">日记总数</h3>
						<div class="num">
							${diaryNum} <span>篇</span>
						</div>
					</div>
					<div class="tag-icon-diarybox">
						<div class="tag-icon">
							<span class="iconfont icon-diary"></span>
						</div>
					</div>
				</div>
			</div>

			<!-- 图表部分 -->
			<div class="statistics">
				<!--  日记类型统计 -->
				<div class="panel panel-default chart-box">
					<div class="panel-heading">
						<h3 class="panel-title">日记类型分布图</h3>
					</div>
					<div class="panel-body">
						<div id="diary-ategory"></div>
					</div>
				</div>

				<!-- 天气情况 -->
				<div class="panel panel-default weather-box">
					<div class="panel-heading" style="background-color: skyblue">
						<h3 class="panel-title">
							今日天气(<span class="city"></span>)
						</h3>
					</div>
					<div class="panel-body">
						<div class="weather">
							<div class="weather-left">
								<div class="weather-img-box">
									<svg class="icon" aria-hidden="true"> <use id="use1"
										xlink:href="#icon-sunny"></use> </svg>
								</div>
							</div>
							<div class="weather-right ">
								<p class="low">
									<span>低温 -6℃</span>
								</p>
								<p class="high">
									<span>高温 4℃</span>
								</p>
								<p class="wind">
									风向：<span>北风 3级</span>
								</p>
							</div>
						</div>
						<div class="weather-bottom row">
							<div class="type col-md-6">多云</div>
							<div class="date col-md-6">2020年2月1日</div>
						</div>
					</div>
				</div>
			</div>



		</div>
	</div>


	<script type="text/javascript">
	 $(function () {
	        /* 页面加载完成后，直接发送一个ajax请求 获取分页数据  显示数据列表的首页*/
	        weather();
	        //设置时间
	        var time = new Date().Format("yyyy-MM-dd hh:mm:ss");
	        $(".date").html(time);
	    });
	   
	    //每个1秒修改时间
	    setInterval(function(){
	        var time = new Date().Format("yyyy-MM-dd hh:mm:ss");
	        $(".date").html(time);
	    },1000);

	    //获取天气
	    function  weather(){
	        $.ajax({
	            url: "http://wthrcdn.etouch.cn/weather_mini?city=重庆",
	            type: "get",
	            success: function (result) {
	                result = JSON.parse(result);
	                console.log(result); //打印后台返回的数据 */
	                $(".city").html(result.data.city);
	                $(".type").html(result.data.forecast[0].type);
	                $(".low span").html(result.data.forecast[0].low);
	                $(".high span").html(result.data.forecast[0].high);
	                $(".wind span").html(result.data.forecast[0].fengxiang);
	                if (result.data.forecast[0].type == "晴") {
	                    $(".weather-img-box svg use").attr("xlink:href", "#icon-sunny");
	                } else if (result.data.forecast[0].type == "多云") {
	                    $(".weather-img-box svg use").attr("xlink:href", "#icon-cloud");
	                } else if (result.data.forecast[0].type == "霾") {
	                    $(".weather-img-box svg use").attr("xlink:href", "#icon-haze");
	                } else if (result.data.forecast[0].type == "小雨") {
	                    $(".weather-img-box svg use").attr("xlink:href", "#icon-rain");
	                } else if (result.data.forecast[0].type == "阴") {
	                    $(".weather-img-box svg use").attr("xlink:href", "#icon-cloudy");
	                } else if (result.data.forecast[0].type == "小雪") {
	                    $(".weather-img-box svg use").attr("xlink:href", "#icon-snow");
	                } else {
	                    $(".weather-img-box svg use").attr("xlink:href", "#icon-cloudy");
	                }

	            }
	        })
	    }
	    
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
	  
        
	  /*随机色生成函数  16进制 */
	  function generateColor(){
		  let res = '#';
	        const len =Math.random()<0.5?3:6;
	        const hash =[0,1,2,3,4,5,6,7,8,9,'a','b','c','d','e','f'];
	        for(let i=0;i<len;i++){
	            res += hash[Math.floor(Math.random()*16)];
	        }
	        return res;
	  }
	  
	  
	     // 日记类别分布图
	    var diaryChart = echarts.init(document.getElementById('diary-ategory'));
	    var diaryTypeList = ${diaryTypeList2}; //日记类别列表
	    var colorList = []; //日记类别统计图的颜色列表
	    var typeNameList = [] ; //日记类别名称列表
	    var diaryTypeData = ${diaryTypeData}; //日记类别名称和对应日记数量
	    for(var i=0;i< diaryTypeList.length;i++){
	    	//构建类别名称数组
	    	diaryType = diaryTypeList[i];
	    	typeNameList.push( diaryType.typeName); 
	    } 
	    
	    /*构造日记类别统计图的颜色列表*/
	    for(var i=0;i<diaryTypeData.length;i++){
	    	colorList[i] = generateColor();
	    }
	    //console.log("颜色列表："+ colorList);
	   //console.log(typeNameList);
	   /*  var diarytype1Num = ${diarytype1Num};
	    var diarytype2Num = ${diarytype2Num};
	    var diarytype3Num = ${diarytype3Num};
	    var diarytype4Num = ${diarytype4Num}; */
	    

	    
	    option = {
	        title : {
	            text: '日记类别分布图',       //大标题
	            x:'center',               //标题位置   底部居中
	            y:'bottom'
	        },
	        tooltip : {
	            trigger: 'item',           //数据项图形触发，主要在散点图，饼图等无类目轴的图表中使用。
	            formatter: "{a} <br/>{b} : {c} ({d}%)"   //{a}（系列名称），{b}（数据项名称），{c}（数值）, {d}（百分比）用于鼠标悬浮时对应的显示格式和内容
	        },
	        legend: {                           //图例组件。
	            // orient: 'vercentertical',             //图例列表的布局朝向
	            left: 'center',
	            //data: ['工作','生活',"学习","人生感叹"]
	            data: typeNameList
	        },
	        color:colorList,
	        series : [              //系列列表。每个系列通过 type 决定自己的图表类型
	            {
	                name: '访问来源',
	                type: 'pie',
	                radius : '55%',
	                center: ['50%', '45%'],
	                /*data:[
	                    {value:diarytype1Num, name:'工作类'},
	                    {value:diarytype2Num, name:'生活类'},
	                    {value:diarytype3Num, name:'学习类'},
	                    {value:diarytype4Num, name:'人生感叹'},
	                ], */
	                data:diaryTypeData,
	                itemStyle: {
	                    emphasis: {
	                        shadowBlur: 10,
	                        shadowOffsetX: 0,
	                        shadowColor: 'rgba(0, 0, 0, 0.5)'
	                    },
	             
	                }
	            }
	        ]
	    };
	    diaryChart.setOption(option);
	</script>
</body>
</html>