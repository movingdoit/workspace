<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>${(house.id!=null)? '编辑楼盘' : '楼盘详情'}</title>

<link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${ctx}/static/assets/css/bootstrap-responsive.min.css">
<link rel="stylesheet" href="${ctx}/static/assets/css/matrix-style.css">
<link rel="stylesheet" href="${ctx}/static/assets/css/matrix-media.css">
<link rel="stylesheet"
	href="${ctx}/static/assets/font-awesome/css/font-awesome.css">
<link rel="stylesheet"
	href="${ctx}/static/assets/css/bootstrap-datetimepicker.min.css">
<link rel="stylesheet"
	href="${ctx}/static/assets/css/bootstrap-fileupload.css">

<script src="${ctx}/static/assets/js/bootstrap-datetimepicker.min.js"></script>
<script src="${ctx}/static/assets/js/bootstrap-datetimepicker.zh-CN.js"
	charset="UTF-8"></script>
<script src="${ctx}/static/assets/js/matrix.form_common.js"></script>

<script src="${ctx}/static/plug-in/KindEditor/kindeditor.js"
	type="text/javascript"></script>
<script src="${ctx}/static/plug-in/KindEditor/lang/zh_CN.js"
	type="text/javascript"></script>
</head>

<body>
	<!-- Main Container -->
	<div id="content">


		<!-- Breadcrumbs -->
		<div id="content-header">
			<h1>
				<i class="icon-edit"></i> ${(house.id!=null)? '编辑楼盘' : '楼盘详情'}
			</h1>
		</div>
		<!-- // Breadcrumbs -->
		<!-- Action Boxes -->
		<div class="container-fluid">
			<hr>
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-edit"></i>
							</span>
							<h5>${(house.id!=null)? '编辑楼盘' : '楼盘详情'}</h5>
							<p style="margin: 0px;">
								<a class="btn" href="${ctx}/house/detail/list"><i
									class="icon-plus"></i>房源列表</a>
								<c:choose>
									<c:when test="${action =='create'}">
										<a class="btn" href="#"><i class="icon-plus"></i>新增楼盘</a>
									</c:when>
									<c:otherwise>
										<a class="btn" href="${ctx}/house/detail/create"><i
											class="icon-plus"></i>新增楼盘</a>
									</c:otherwise>
								</c:choose>
							</p>
						</div>
						<div class="widget-content nopadding">
							<form id="J_addForm" modelAttribute="house" action="#"
								method="post" class="form-horizontal form-validate"
								enctype="multipart/form-data">
								<input type="hidden" name="id" value="${house.id}"> <input
									type="hidden" name="build.id" value="${build.id}"> <input
									type="hidden" name="property.id" value="${property.id}">
								<input type="hidden" name="houseRim.id" value="${houseRim.id}">
								<input type="hidden" name="houseMap.id" value="${houseMap.id}">
								<div class="control-group">
									<label class="control-label"><i class="red">*</i> 楼盘名称
										:</label>
									<div class="controls">
										<input type="text" id="title" name="name"
											value="${house.name}" class="span3" data-rule-required="true"
											data-rule-maxlength="50">
									</div>

									<label class="control-label"><i class="red">*</i> 楼盘特点:</label>
									<div class="controls">
										<input type="text" id="title" name="summary"
											value="${house.summary}" class="span3"
											data-rule-required="true" data-rule-maxlength="50">
									</div>
								</div>

								<div class="control-group">
									<label class="control-label">是否显示：</label>
									<div class="controls">
										<label class="radio inline"><input type="radio"
											name="isDisplay" value="true"
											${(null == house || house.isDisplay) ? 'checked' : ''}>显示</label>
										<label class="radio inline"><input type="radio"
											name="isDisplay" value="false"
											${(null != house && !house.isDisplay) ? 'checked' : ''}>隐藏</label>
									</div>
								</div>

								<%-- <div class="control-group">
						        <label class="control-label">上传封面</label>
						        <div class="controls">
						            <div class="fileupload fileupload-new" data-provides="fileupload">
						                <div class="fileupload-new thumbnail" style="width: 200px; height: 150px;"><img src="${(null != house && house.coversPic != null && house.coversPic != '') ? house.coversPic : '/static/assets/img/noimage.gif'}" /></div>
						                <div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>
						                <div>
						                    <span class="btn btn-file"><span class="fileupload-new">选择图片</span><span class="fileupload-exists">更换</span><input type="file" name='file' /></span>
						                    <a href="#" class="btn fileupload-exists" data-dismiss="fileupload">删除</a>
						                </div>
						            </div>
						        </div>
						    	</div> --%>


								<div class="control-group">
									<label class="control-label">楼盘介绍 :</label>
									<div class="controls">
										<!-- 加载编辑器的容器 -->
										<script id="container" name="introduce"
											style="width: 830px; height: 500px" type="text/plain">${null != introduce.content && 'null' != introduce.content ? introduce.content : ''}</script>
									</div>
								</div>

								<div class="control-group">
									<label class="control-label"><i class="red">*</i> 房屋类型
										:</label>
									<div class="controls">
										<select name="houseType" class="input-medium"
											id="cmsContent_channel" data-rule-required="true">
											<c:forEach items="${houseType}" var="type">
												<c:choose>
													<c:when test="${ house.houseType == type.key }">
														<option value="${type.key}" selected="selected">${type.value}</option>
													</c:when>
													<c:otherwise>
														<option value="${type.key}">${type.value}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</div>

									<label class="control-label"><i class="red">*</i>住宅类型 :</label>
									<div class="controls">
										<select name="homeType" class="input-medium"
											id="cmsContent_channel" data-rule-required="true">
											<c:forEach items="${homeType}" var="type">
												<c:choose>
													<c:when test="${ house.homeType == type.key }">
														<option value="${type.key}" selected="selected">${type.value}</option>
													</c:when>
													<c:otherwise>
														<option value="${type.key}">${type.value}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</div>
								</div>

								<div class="control-group">
									<label class="control-label"> 规划户数:</label>
									<div class="controls">
										<input type="text" id="priority" name="planHome"
											value="${house.planHome}" class="span3"
											data-rule-number="true" data-rule-maxlength="20">
									</div>

									<label class="control-label"><i class="red">*</i> 所属区域
										:</label>
									<div class="controls">
										<select name="areaType" class="input-medium" id="areaType"
											data-rule-required="true">
											<c:forEach items="${areaType}" var="type">
												<c:choose>
													<c:when test="${ house.areaType == type.key }">
														<option value="${type.key}" selected="selected">${type.value}</option>
													</c:when>
													<c:otherwise>
														<option value="${type.key}">${type.value}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</div>

								</div>

								<div class="control-group">
									<label class="control-label"> 开盘时间 :</label>
									<div class="controls">
										<div data-date="2012-12-02 12:00"
											class="input-append date datepicker">
											<input type="text"
												value="<fmt:formatDate value="${house.beginDate}" pattern="yyyy-MM-dd HH:mm"/>"
												name="startDate" id="beginDate"
												data-date-format="yyyy-mm-dd hh:mm" class="span11"
												data-rule-required="true"> <span class="add-on"><i
												class="icon-th"></i></span>
										</div>
									</div>

									<label class="control-label"> 交房时间 :</label>
									<div class="controls">
										<div data-date="2012-12-02 12:00"
											class="input-append date datepicker">
											<input type="text"
												value="<fmt:formatDate value="${house.getHomeDate}" pattern="yyyy-MM-dd HH:mm"/>"
												name="endDate" id="getHomeDate"
												data-date-format="yyyy-mm-dd hh:mm" class="span11"
												data-rule-required="true"> <span class="add-on"><i
												class="icon-th"></i></span>
										</div>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label"> 建筑面积 :</label>
									<div class="controls">
										<input type="text" id="priority" name="build.buildArea"
											value="${build.buildArea}" class="span3"
											data-rule-number="true" data-rule-maxlength="20">平方
									</div>

									<label class="control-label"> 规划面积 :</label>
									<div class="controls">
										<input type="text" id="priority" name="build.planArea"
											value="${build.planArea}" class="span3"
											data-rule-number="true" data-rule-maxlength="20">平方
									</div>
								</div>
								<div class="control-group">
									<label class="control-label"><i class="red">*</i> 装修情况:</label>
									<div class="controls">
										<select name="build.decorateType" class="input-medium"
											id="cmsContent_channel" data-rule-required="true">
											<c:forEach items="${decorateType}" var="type">
												<c:choose>
													<c:when test="${build.decorateType == type.key }">
														<option value="${type.key}" selected="selected">${type.value}</option>
													</c:when>
													<c:otherwise>
														<option value="${type.key}">${type.value}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</div>
									<label class="control-label"><i class="red">*</i>销售情况:</label>
									<div class="controls">
										<select name="saleStatus" class="input-medium"
											id="cmsContent_channel" data-rule-required="true">
											<c:forEach items="${saleStatus}" var="type">
												<c:choose>
													<c:when test="${house.saleStatus == type.key }">
														<option value="${type.key}" selected="selected">${type.value}</option>
													</c:when>
													<c:otherwise>
														<option value="${type.key}">${type.value}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</div>
								</div>
								<div id="chooseLevel" class="control-group">
									<label class="control-label"> 总栋数 :</label>
									<div class="controls">
										<input type="text" id="priority" name="build.sumHome"
											value="${build.sumHome}" class="span3"
											data-rule-number="true" data-rule-maxlength="20">栋
									</div>

									<label class="control-label"> 开发商 :</label>
									<div class="controls">
										<input type="text" id="priority" name="developer"
											value="${house.developer}" class="span3"
											data-rule-required="true" data-rule-maxlength="50">
									</div>
								</div>

								<div id="chooseLevel" class="control-group">
									<label class="control-label"> 容积率 :</label>
									<div class="controls">
										<input type="text" id="priority" name="property.plot"
											value="${property.plot}" class="span3"
											data-rule-number="true" data-rule-maxlength="20">
									</div>

									<label class="control-label"> 绿化率:</label>
									<div class="controls">
										<input type="text" id="priority" name="property.greenRate"
											value="${property.greenRate}" class="span3"
											data-rule-number="true" data-rule-maxlength="20">
									</div>
								</div>

								<div id="chooseLevel" class="control-group">
									<label class="control-label"> 产权:</label>
									<div class="controls">
										<input type="text" id="priority" name="build.propertyRight"
											value="${build.propertyRight}" class="span3"
											data-rule-required="true" data-rule-maxlength="20">
									</div>

									<label class="control-label"> 物业费:</label>
									<div class="controls">
										<input type="text" id="priority" name="property.managementFee"
											value="${property.managementFee}" class="span3"
											data-rule-number="true" data-rule-maxlength="20">
									</div>
								</div>

								<div id="chooseLevel" class="control-group">
									<label class="control-label"> 起价:</label>
									<div class="controls">
										<input type="text" id="priority" name="beginPrice"
											value="${house.beginPrice}" class="span3"
											data-rule-number="true" data-rule-maxlength="20">
									</div>

									<label class="control-label"> 均价:</label>
									<div class="controls">
										<input type="text" id="priority" name="avgPrice"
											value="${house.avgPrice}" class="span3"
											data-rule-number="true" data-rule-maxlength="20">
									</div>
								</div>

								<div id="chooseLevel" class="control-group">
									<label class="control-label">楼盘地址:</label>
									<div class="controls">
										<input type="text" id="priority" name="houseAddr"
											value="${house.houseAddr}" class="span3"
											data-rule-required="true" data-rule-maxlength="20">
									</div>
								</div>
								<div id="chooseLevel" class="control-group">
									<label class="control-label">售楼地址:</label>
									<div class="controls">
										<input type="text" id="priority" name="saleAddr"
											value="${house.saleAddr}" class="span3"
											data-rule-required="true" data-rule-maxlength="20">
									</div>
								</div>
								<div id="chooseLevel" class="control-group">
									<label class="control-label">物业公司:</label>
									<div class="controls">
										<input type="text" id="priority"
											name="property.propertyCompany"
											value="${property.propertyCompany}" class="span3"
											data-rule-required="true" data-rule-maxlength="20">
									</div>
								</div>

								<div class="widget-title">
									<span class="icon"> <i class="icon-edit"></i>
									</span>
									<h5>地图交通</h5>
								</div>

								<div id="chooseLevel" class="control-group">
									<label class="control-label">经度</label>
									<div class="controls">
										<input type="text" id="priority" name="houseMap.lng"
											value="${houseMap.lng}" class="span3" data-rule-number="true"
											data-rule-maxlength="100">
									</div>
								</div>
								<div id="chooseLevel" class="control-group">
									<label class="control-label">纬度</label>
									<div class="controls">
										<input type="text" id="priority" name="houseMap.lat"
											value="${houseMap.lat}" class="span3" data-rule-number="true"
											data-rule-maxlength="100">
									</div>
								</div>
								<div id="chooseLevel" class="control-group">
									<label class="control-label">附近公交</label>
									<div class="controls">
										<input type="text" id="priority" name="houseMap.bus"
											value="${houseMap.bus}" class="span3"
											data-rule-maxlength="100">
									</div>
								</div>
								<div id="chooseLevel" class="control-group">
									<label class="control-label">附近轻轨</label>
									<div class="controls">
										<input type="text" id="priority" name="houseMap.rail"
											value="${houseMap.rail}" class="span3"
											data-rule-maxlength="100">
									</div>
								</div>



								<div class="widget-title">
									<span class="icon"> <i class="icon-edit"></i>
									</span>
									<h5>周边配套</h5>
								</div>
								<div id="chooseLevel" class="control-group">
									<label class="control-label">学校：</label>
									<div class="controls">
										<input type="text" id="priority" name="houseRim.school"
											value="${houseRim.school}" class="span6"
											data-rule-maxlength="100">
									</div>
								</div>

								<div id="chooseLevel" class="control-group">
									<label class="control-label">购物：</label>
									<div class="controls">
										<input type="text" id="priority" name="houseRim.shopping"
											value="${houseRim.shopping}" class="span6"
											data-rule-maxlength="100">
									</div>
								</div>
								<div id="chooseLevel" class="control-group">
									<label class="control-label">医院：</label>
									<div class="controls">
										<input type="text" id="priority" name="houseRim.hospital"
											value="${houseRim.hospital}" class="span6"
											data-rule-maxlength="100">
									</div>
								</div>
								<div id="chooseLevel" class="control-group">
									<label class="control-label">生活：</label>
									<div class="controls">
										<input type="text" id="priority" name="houseRim.life"
											value="${houseRim.life}" class="span6"
											data-rule-maxlength="100">
									</div>
								</div>
								<div id="chooseLevel" class="control-group">
									<label class="control-label">餐饮：</label>
									<div class="controls">
										<input type="text" id="priority" name="houseRim.catering"
											value="${houseRim.catering}" class="span6"
											data-rule-maxlength="100">
									</div>
								</div>
								<div id="chooseLevel" class="control-group">
									<label class="control-label">娱乐：</label>
									<div class="controls">
										<input type="text" id="priority" name="houseRim.recreation"
											value="${houseRim.recreation}" class="span6"
											data-rule-maxlength="100">
									</div>
								</div>


								<div class="form-actions">
									<button type="button" id="save" class="btn btn-primary">保存</button>
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
	<script src="${ctx}/static/assets/js/jquery-ui-1.10.4.min.js"></script>
	<script src="${ctx}/static/assets/js/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript"
		src="${ctx}/static/assets/js/bootstrap-datetimepicker.zh-CN.js"
		charset="UTF-8"></script>
	<script src="${ctx}/static/assets/js/matrix.form_common.js"></script>
	<script src="${ctx}/static/assets/plugins/wizard/jquery.form.js"></script>
	<script src="${ctx}/static/assets/plugins/wizard/jquery.form.wizard.js"></script>
	<script
		src="${ctx}/static/assets/plugins/fileupload/bootstrap-fileupload.min.js"></script>
	<script src="${ctx}/static/assets/js/form-wizard.js"></script>


	<!-- 配置文件 -->
	<script type="text/javascript"
		src="${ctx}/static/plug-in/ueditor/ueditor.config.js"></script>
	<!-- 编辑器源码文件 -->
	<script type="text/javascript"
		src="${ctx}/static/plug-in/ueditor/ueditor.all.js"></script>

	<script type="text/javascript">  

	var ue = UE.getEditor('container');

</script>
	<script type="text/javascript">


	$(document).ready(function() {
		//聚焦第一个输入框
		$("#name").focus();
		//为inputForm注册validate函数
		//$("#inputForm").validate();
	});
	
	// ajax方式提交form
	$().ready(function() {
		$("#J_addForm").ajaxForm({
			dataType : "json"
		});
	});
	
	// 保存
	$('#save').click(function(){
		var action = "${action}";
		$("#J_addForm").attr("action","${ctx}/house/detail/${action}");
		if($("#J_addForm").valid()){
			$("#J_addForm").ajaxSubmit({
					type: "post",
					url: $("#J_addForm").attr("action"),
					dataType: "json",
					success:function(data) {
			        	if(data){
			        		if('0000' == data.code){
				            	alert(data.message);
				            	if(action=="create"){
				            		location.href = "${ctx}/house/detail/list";
				            	}else{
				            		location.href = "${ctx}/house/detail/list";
				            	}
			        		}else if('9999' == data.code){
				            	alert(data.message);
			        		}else {
				            	alert(data.message);
			        		}
			        	}else{
			            	alert("操作异常，请重试。");
			        	}
			        },
			        error:function(data){
			        	debugger;
			        	alert(data.message);
			        	location.href = "${ctx}/house/detail/list";
			        }
			});
			
		}
	});
</script>

</body>
</html>
