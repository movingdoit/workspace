<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>新增婚礼邀请函</title>
<style type="text/css">
.map_content {
	width:250px;
	height:60px;
	font-family: Microsoft yahei;
	font-weight: bold;
	text-align: left;
	white-space: nowrap;
	margin:8px;
}
</style>
<link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap-datetimepicker.min.css">
<!-- 配置文件 -->
<script type="text/javascript" src="${ctx}/static/plug-in/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="${ctx}/static/plug-in/ueditor/ueditor.all.js"></script>
<!-- qq地图api -->
<script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp"></script>
<script type="text/javascript" src="/static/assets/js/datejs/WdatePicker.js">
<script src="${ctx}/static/assets/js/bootstrap-datetimepicker.min.js"></script>
<script src="${ctx}/static/assets/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>

<script type="text/javascript">
	var lat_db = '${invitation.mapLatitude}';
	var lng_db = '${invitation.mapLongitude}';
	var address = '${invitation.weddingAddress}';
	var msg = '<div class="map_content">请在地图上定位婚礼举办地点！</div>';
	if(address != null && address != ""){
		msg = '<div class="map_content"><b>主题：</b>'+'${invitation.subject}'+'<br/><b>举办时间：</b>'+'${invitation.weddingTime}'+'<br><b>举办地点：</b>' + address +'</div>';
	}
	//初始化地图信息
	var init = function() {
		//设置地图默认中心位置
		var center = new qq.maps.LatLng(20.031419, 110.331573);
		if(lat_db != "" && lng_db != ""){
			center = new qq.maps.LatLng(lat_db, lng_db);
		}
		
		//创建地图对象
		var map = new qq.maps.Map(document.getElementById("mapContainer"), {
			center : center,
			zoom : 13
		});
		setTimeout(function() {
			map.panTo(center);
		}, 2000);

		//创建标记
		var marker = new qq.maps.Marker({
			position : center,
			map : map
		});

		//设置Marker的可见性,默认属性为true
		marker.setVisible(true);
		//设置Marker的动画属性为从落下
		marker.setAnimation(qq.maps.MarkerAnimation.DOWN);
		//设置Marker是否可以被拖拽,默认属性为false
		marker.setDraggable(true);
		//设置Marker自定义图标的属性，size是图标尺寸，该尺寸为显示图标的实际尺寸，origin是切图坐标，该坐标是相对于图片左上角默认为（0,0）的相对像素坐标，anchor是锚点坐标，描述经纬度点对应图标中的位置
		var anchor = new qq.maps.Point(0, 30), size = new qq.maps.Size(42, 68), origin = new qq.maps.Point(
				0, 0), icon = new qq.maps.MarkerImage(
				"http://open.map.qq.com/doc/img/nilt.png", size, origin, anchor);
		marker.setIcon(icon);
		//设置标注的名称，当鼠标划过Marker时显示
		marker.setTitle("婚礼举行地址");

		//添加信息窗口
		var info = new qq.maps.InfoWindow({
			map : map
		});
		info.open();
		info.setContent(msg);
		info.setPosition(marker.getPosition());

		//标记Marker点击事件
		qq.maps.event.addListener(marker, 'click', function() {
			info.open();
			info.setContent(msg);
			info.setPosition(marker.getPosition());
		});
		//设置Marker停止拖动事件
		qq.maps.event.addListener(marker, 'dragend', function() {
			info.open();
			info.setContent(msg);
			//返回Marker的位置
			info.setPosition(marker.getPosition());
			map = marker.getMap();
			center = marker.getPosition();
			map.panTo(center)
			center = map.getCenter();
			//填充文本框经纬度
			fillLatLng2Box(map, "mapLongitude", "mapLatitude");
		});
	}

	//获取地图经纬度并填充到文本框
	var fillLatLng2Box = function(map, lng_id, lat_id) {
		if (map) {
			var latLng = map.getCenter();
			//获取经度
			var lng = latLng.getLng();
			//获取纬度
			var lat = latLng.getLat();
			$("#" + lng_id).attr("value", lng);
			$("#" + lat_id).attr("value", lat);
		} else {
			alert("请在地图上定位婚礼举行地点！")
		}
	}

	$(document).ready(function() {
		//地图加载
		init();
	});
</script>
</head>

<body onload="init()">
	<!-- Main Container -->
	<div id="content">
		<!-- Breadcrumbs -->
		<div id="content-header">
			<h1>
				<i class="icon-edit"></i>
			</h1>
		</div>
		<!-- // Breadcrumbs -->
		<!-- Action Boxes -->
		<div class="container-fluid">
			<hr>
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-content nopadding">
							<form id="inputForm" action="${ctx}/wedding/invitation/save" method="post"
								class="form-horizontal form-validate">
								<!-- 隐藏主键ID -->
								<input type="hidden" name="id" value="${invitation.id}" />

								<div class="control-group">
									<label class="control-label"><i class="red">*</i> 主题 :</label>
									<div class="controls">
										<input type="text" id="subject" name="subject"
											value="${invitation.subject}" class="span3"
											placeholder="请选择婚礼邀请函主题" data-rule-required="true" />
									</div>
								</div>

								<div class="control-group">
									<label class="control-label"><i class="red">*</i> 新郎:</label>
									<div class="controls">
										<input type="text" id="groom" name="groom"
											value="${invitation.groom}" class="span3"
											data-rule-required="true" placeholder="新郎姓名">
									</div>
								</div>

								<div class="control-group">
									<label class="control-label"><i class="red">*</i> 新娘:</label>
									<div class="controls">
										<input type="text" id="bride" name="bride"
											value="${invitation.bride}" class="span3"
											data-rule-required="true" placeholder="新娘姓名">
									</div>
								</div>

								<div class="control-group">
									<label class="control-label"><i class="red">*</i> 举办地点:</label>
									<div class="controls">
										<input type="text" id="weddingAddress" name="weddingAddress"
											value="${invitation.weddingAddress}" class="span3"
											data-rule-required="true" placeholder="请填写婚礼举办地点"
											style="width: 450px;">
									</div>
								</div>

								<div class="control-group">
                                    <label class="control-label"><i class="red">*</i>举行时间:</label>
                                    <div class="controls">
	                                    <input type="text" id="weddingTime" name="weddingTime" value="<fmt:formatDate value='${invitation.weddingTime}' pattern='yyyy-MM-dd HH:mm:ss'/>" placeholder="婚礼举行时间" class="Wdate" 
	                                    	onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d %H:%m:%s',maxDate:'2028-03-10 23:59:59'});" data-rule-required="true">
	                                </div>
                                </div>

								<div id="control-group">
									<div id="mapContainer"
										style="width: 800px; height: 300px; border: 1px solid #E6E6E6; margin-left: 198px; margin-top: 5px;">

									</div>
									<label class="control-label"> 选择地图经纬度:</label>
									<div class="controls">
										<input type="text" id="mapLongitude" name="mapLongitude"
											value="${invitation.mapLongitude}" class="span3"
											data-rule-required="true" placeholder="地图经度"
											style="width: 150px;" readonly> &nbsp;&nbsp; <input
											type="text" id="mapLatitude" name="mapLatitude"
											value="${invitation.mapLatitude}" class="span3"
											data-rule-required="true" placeholder="地图经度"
											style="width: 150px;" readonly>
									</div>
								</div>

								<div class="control-group">
									<label class="control-label">备注:</label>
									<div class="controls">
										<textarea id="remark" name="remark"
											style="margin: 0px; width: 830px; height: 88px;" rows="4"
											class="span10" data-rule-maxlength="100"
											placeholder="备注最多可输入500字">${invitation.remark}</textarea>
									</div>
								</div>

								<div class="form-actions">
									<button type="submit" class="btn btn-primary">保存</button>
									<button type="button" class="btn"
										onclick="window.history.go(-1);">取消</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- // Action Boxes -->
	</div>
	<!-- // Main Container -->
</body>
</html>
