<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>${(specialActivity.id != null) ? '编辑专题活动' : '新增专题活动' }</title>
	<script src="${ctx}/static/plug-in/KindEditor/kindeditor.js" type="text/javascript"></script>
	<script src="${ctx}/static/plug-in/KindEditor/lang/zh_CN.js" type="text/javascript"></script>
</head>
<body>

<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1><i class="icon-edit"></i> ${(specialActivity.id != null) ? '编辑专题活动' : '新增专题活动' }</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                        <h5>${(specialActivity.id != null) ? '编辑专题活动' : '新增专题活动' }</h5>
                        <p style="margin: 0px;">
                           <a class="btn" href="${ctx}/house/detail/create"><i class="icon-plus"></i>新增楼盘</a>
                        </p>
                    </div>
                    <div class="widget-content nopadding">
                        <form id="J_addForm" action="#" method="post" class="form-horizontal form-validate"  enctype="multipart/form-data">
							<input type="hidden" name="id" value="${specialActivity.id}" />
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i> 活动标题 :</label>
                                <div class="controls">
                                	<input type="text" id="title" name="activityTitle"  value="${specialActivity.activityTitle}" class="span2" required="required" data-rule-required="true" data-rule-maxlength="20" placeholder="最多20个字符"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i> 选择模板 :</label>
                                <div class="controls">
                                    <select id="modelType"  class="input-medium" onchange="chuange()" data-rule-required="true">
                                        <option value="1" ${specialActivity.specialModelOne!=null ? 'selected="selected"' : '' } >模板一</option>
                                        <option value="2" ${specialActivity.specialModelTwo!=null ? 'selected="selected"' : '' }>模板二</option>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i> 活动封面 :</label>
                                <div class="controls">
                                    <img src="${ctx}${specialActivity.activityImage}" class="default-slider" />
                                    <input type="file" name="activityImageFile" class="insertimage" />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"> 活动内容 :</label>
                                <div class="controls">
                                    <!-- 加载编辑器的容器 -->
							    	<script id="container" name="content" style="width:830px;height:200px" type="text/plain">${null != specialActivity.content && 'null' != specialActivity.content ? specialActivity.content : ''}</script>
                                </div>
                            </div>
                            <hr>
                            
                            <div id="modelOne">
                            	<h5 class="control-group">填充模版一信息</h5>
                            	<div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 顶部大图 :</label>
	                                <div class="controls">
	                                    <img src="${ctx}${specialActivity.specialModelOne.topImage}" class="default-slider" />
	                                    <input type="file" name="topImageFile" class="insertimage" />
	                                </div>
                                </div>
                                <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 导航一名称 :</label>
	                                <div class="controls">
	                                	<input type="text" name="specialModelOne.navOne"  value="${specialActivity.specialModelOne.navOne}" class="span2" required="required" data-rule-required="true" data-rule-maxlength="20" placeholder="最多20个字符"/>
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 导航一图片 :</label>
	                                <div class="controls">
	                                    <img src="${ctx}${specialActivity.specialModelOne.navOneImage}" class="default-slider" />
	                                    <input type="file" name="navOneImageFile" class="insertimage" />
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"> 轮播图 :</label>
	                                <div class="controls J_argList" id="argList" data-limit = "1">
	                                	<c:if test="${empty specialActivity.specialModelOne.slides}">
	                                    	<p>
	                                    		<input type="file" name="files">
		                                        <input type="url" id="link" name="attrList" value="" class="input-xlarge" data-rule-required="true" data-rule-url="true" placeholder="输入轮播图链接地址">
		                                        <span class="help-inline">
		                                            <a href="#" class="icon icon-plus green" title="增加字段"></a>
		                                            <a href="#" class="icon icon-minus green" title="删除字段"></a>
		                                            <a href="#" class="icon icon-arrow-up blue upbtn" title="向上移"></a>
		                                            <a href="#" class="icon icon-arrow-down blue downbtn" title="向下移"></a>
		                                        </span>
	                                    	</p>
	                                    </c:if>
	                                    <c:if test="${not empty specialActivity.specialModelOne.slides}">
					              	  		<c:forEach items="${specialActivity.specialModelOne.slides}" var="Item">
						              	  		<p>
						              	  			<img src="${ctx}${Item.slideImage}" class="default-slider" />
						              	  			<input type="file" name="files" value="${Item.slideImage}">
						              	  			<input type="url" id="link" name="attrList" value="${Item.slidePath }" class="input-xlarge" data-rule-required="true" data-rule-url="true" placeholder="输入轮播图链接地址">
						              	  			<span class="help-inline">
			                                            <a href="#" class="icon icon-plus green" title="增加字段"></a>
			                                            <a href="#" class="icon icon-minus green" title="删除字段"></a>
			                                            <a href="#" class="icon icon-arrow-up blue upbtn" title="向上移"></a>
			                                            <a href="#" class="icon icon-arrow-down blue downbtn" title="向下移"></a>
			                                        </span>
		                                        </p>
	                                    	</c:forEach>
										</c:if>
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"> 内容介绍  :</label>
	                                <div class="controls">
	                                    <!-- 加载编辑器的容器 -->
								    	<script id="container1" name="specialModelOne.contentInfo" style="width:830px;height:200px" type="text/plain">${null != specialActivity.specialModelOne.contentInfo && 'null' != specialActivity.specialModelOne.contentInfo ? specialActivity.specialModelOne.contentInfo : ''}</script>
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 导航二名称 :</label>
	                                <div class="controls">
	                                	<input type="text" name="specialModelOne.navTwo"  value="${specialActivity.specialModelOne.navTwo}" class="span2" required="required" data-rule-required="true" data-rule-maxlength="20" placeholder="最多20个字符"/>
	                                </div>
	                            </div>
	                             <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 导航二图片 :</label>
	                                <div class="controls">
	                                    <img src="${ctx}${specialActivity.specialModelOne.navTwoImage}" class="default-slider" />
	                                    <input type="file" name="navTwoImageFile" class="insertimage" />
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 户型图 :</label>
	                                <div class="controls">
	                                	<img src="${ctx}${specialActivity.specialModelOne.houseTypeImage}" class="default-slider" />
	                                    <input type="file" name="houseTypeImageFile" class="insertimage" />
	                                </div>
	                            </div>
	                             <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 户型图链接地址 :</label>
	                                <div class="controls">
	                                    <input type="url" id="link" name="specialModelOne.houseTypePath" value="${specialActivity.specialModelOne.houseTypePath}" class="input-xlarge" data-rule-required="true" data-rule-url="true">
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"> 户型介绍  :</label>
	                                <div class="controls">
	                                    <!-- 加载编辑器的容器 -->
								    	<script id="container2" name="specialModelOne.houseTypeInfo" style="width:830px;height:200px" type="text/plain">${null != specialActivity.specialModelOne.houseTypeInfo && 'null' != specialActivity.specialModelOne.houseTypeInfo ? specialActivity.specialModelOne.houseTypeInfo : ''}</script>
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 户型图片一 :</label>
	                                <div class="controls">
	                                    <img src="${ctx}${specialActivity.specialModelOne.houseImageOne}" class="default-slider" />
	                                    <input type="file" name="houseImageOneFile" class="insertimage" />
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 户型图片二 :</label>
	                                <div class="controls">
	                                    <img src="${ctx}${specialActivity.specialModelOne.houseImageTwo}" class="default-slider" />
	                                    <input type="file" name="houseImageTwoFile" class="insertimage" />
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 户型图片三 :</label>
	                                <div class="controls">
	                                    <img src="${ctx}${specialActivity.specialModelOne.houseImageThree}" class="default-slider" />
	                                    <input type="file" name="houseImageThreeFile" class="insertimage" />
	                                </div>
	                            </div>
                                <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 户型图片四 :</label>
	                                <div class="controls">
	                                    <img src="${ctx}${specialActivity.specialModelOne.houseImageFour}" class="default-slider" />
	                                    <input type="file" name="houseImageFourFile" class="insertimage" />
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 导航三名称 :</label>
	                                <div class="controls">
	                                	<input type="text" name="specialModelOne.navThree"  value="${specialActivity.specialModelOne.navThree}" class="span2" required="required" data-rule-required="true" data-rule-maxlength="20" placeholder="最多20个字符"/>
	                                </div>
	                            </div>
	                             <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 导航三图片 :</label>
	                                <div class="controls">
	                                    <img src="${ctx}${specialActivity.specialModelOne.navThreeImage}" class="default-slider" />
	                                    <input type="file" name="navThreeImageFile" class="insertimage" />
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 楼盘图片一 :</label>
	                                <div class="controls">
	                                    <img src="${ctx}${specialActivity.specialModelOne.housesImageOne}" class="default-slider" />
	                                    <input type="file" name="housesImageOneFile" class="insertimage" />
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 楼盘图片二 :</label>
	                                <div class="controls">
	                                    <img src="${ctx}${specialActivity.specialModelOne.housesImageTwo}" class="default-slider" />
	                                    <input type="file" name="housesImageTwoFile" class="insertimage" />
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 楼盘图片三 :</label>
	                                <div class="controls">
	                                    <img src="${ctx}${specialActivity.specialModelOne.housesImageThree}" class="default-slider" />
	                                    <input type="file" name="housesImageThreeFile" class="insertimage" />
	                                </div>
	                            </div>
                            </div>
                            
                            <!--模板二 页面  -->
                            <div id="modelTwo">
                            	<h5 class="control-group">填充模版二信息</h5>
                            	<div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 顶部大图 :</label>
	                                <div class="controls">
	                                    <img src="${ctx}${specialActivity.specialModelTwo.topImage}" class="default-slider" />
	                                    <input type="file" name="topImageFile" class="insertimage" />
	                                </div>
                                </div>
                                <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 楼盘封面 :</label>
	                                <div class="controls">
	                                    <img src="${ctx}${specialActivity.specialModelTwo.housesPic}" class="default-slider" />
	                                    <input type="file" name="housesPicFile" class="insertimage" />
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 项目名称 :</label>
	                                <div class="controls">
	                                	<input type="text" name="specialModelTwo.productName"  value="${specialActivity.specialModelTwo.productName}" class="span2" required="required" data-rule-required="true" data-rule-maxlength="20" placeholder="最多20个字符"/>
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 项目名称链接:</label>
	                                <div class="controls">
	                                	<input type="url" id="link" name="specialModelTwo.productNamePath" value="${specialActivity.specialModelTwo.productNamePath}" class="input-xlarge" data-rule-required="true" data-rule-url="true" placeholder="输入轮播图链接地址">
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 项目位置 :</label>
	                                <div class="controls">
	                                	<input type="text" name="specialModelTwo.peoductLocaltion"  value="${specialActivity.specialModelTwo.peoductLocaltion}" class="span2" required="required" data-rule-required="true" data-rule-maxlength="20" placeholder="最多20个字符"/>
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 项目位置链接:</label>
	                                <div class="controls">
	                                	<input type="url" id="link" name="specialModelTwo.productLocaltionPath" value="${specialActivity.specialModelTwo.productLocaltionPath}" class="input-xlarge" data-rule-required="true" data-rule-url="true" placeholder="输入轮播图链接地址">
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 起价 :</label>
	                                <div class="controls">
	                                	<input type="text" name="specialModelTwo.startingPrice"  value="${specialActivity.specialModelTwo.startingPrice}" class="span2" required="required" data-rule-required="true" data-rule-maxlength="20" placeholder="最多20个字符"/>
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 均价 :</label>
	                                <div class="controls">
	                                	<input type="text" name="specialModelTwo.averagePrice"  value="${specialActivity.specialModelTwo.averagePrice}" class="span2" required="required" data-rule-required="true" data-rule-maxlength="20" placeholder="最多20个字符"/>
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 装修情况 :</label>
	                                <div class="controls">
	                                	<input type="text" name="specialModelTwo.decorateStatus"  value="${specialActivity.specialModelTwo.decorateStatus}" class="span2" required="required" data-rule-required="true" data-rule-maxlength="20" placeholder="最多20个字符"/>
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"> 项目介绍  :</label>
	                                <div class="controls">
	                                    <!-- 加载编辑器的容器 -->
								    	<script id="container3" name="specialModelTwo.productInfo" style="width:830px;height:200px" type="text/plain">${null != specialActivity.specialModelTwo.productInfo && 'null' != specialActivity.specialModelTwo.productInfo ? specialActivity.specialModelTwo.productInfo : ''}</script>
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"> 位置优势 :</label>
	                                <div class="controls">
	                                    <!-- 加载编辑器的容器 -->
								    	<script id="container4" name="specialModelTwo.locationAdvantage" style="width:830px;height:200px" type="text/plain">${null != specialActivity.specialModelTwo.locationAdvantage && 'null' != specialActivity.specialModelTwo.locationAdvantage ? specialActivity.specialModelTwo.locationAdvantage : ''}</script>
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 户型图一 :</label>
	                                <div class="controls">
	                                    <img src="${ctx}${specialActivity.specialModelTwo.houseTypeImageOne}" class="default-slider" />
	                                    <input type="file" name="houseTypeImageOneFile" class="insertimage" />
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 户型一名称 :</label>
	                                <div class="controls">
	                                	<input type="text" name="specialModelTwo.houseTypeOneName"  value="${specialActivity.specialModelTwo.houseTypeOneName}" class="span2" required="required" data-rule-required="true" data-rule-maxlength="20" placeholder="最多20个字符"/>
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 户型一链接:</label>
	                                <div class="controls">
	                                	<input type="url" id="link" name="specialModelTwo.houseTypeOnePath" value="${specialActivity.specialModelTwo.houseTypeOnePath}" class="input-xlarge" data-rule-required="true" data-rule-url="true" placeholder="输入轮播图链接地址">
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 户型图二 :</label>
	                                <div class="controls">
	                                    <img src="${ctx}${specialActivity.specialModelTwo.houseTypeImageTwo}" class="default-slider" />
	                                    <input type="file" name="houseTypeImageTwoFile" class="insertimage" />
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 户型二名称 :</label>
	                                <div class="controls">
	                                	<input type="text" name="specialModelTwo.houseTypeTwoName"  value="${specialActivity.specialModelTwo.houseTypeTwoName}" class="span2" required="required" data-rule-required="true" data-rule-maxlength="20" placeholder="最多20个字符"/>
	                                </div>
	                            </div>
	                            <div class="control-group">
	                                <label class="control-label"><i class="red">*</i> 户型二链接:</label>
	                                <div class="controls">
	                                	<input type="url" id="link" name="specialModelTwo.houseTypeTwoPath" value="${specialActivity.specialModelTwo.houseTypeTwoPath}" class="input-xlarge" data-rule-required="true" data-rule-url="true" placeholder="输入轮播图链接地址">
	                                </div>
	                            </div>
                            </div>
                            
                            <div class="form-actions">
                                <button type="button" id="save" class="btn btn-primary">保存</button>
                                <button type="button" class="btn" onclick="window.history.go(-1);">取消</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>


<!-- Modal -->
<div id="articleChooseModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"></div>
<!-- // Modal -->

<script src="${ctx}/static/assets/js/jquery.form.min.js"></script>
<!-- 配置文件 -->
<script type="text/javascript" src="${ctx}/static/plug-in/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="${ctx}/static/plug-in/ueditor/ueditor.all.js"></script>
<script>

	var ue = UE.getEditor('container');
	var ue = UE.getEditor('container1');
	var ue = UE.getEditor('container2');
	var ue = UE.getEditor('container3');
	var ue = UE.getEditor('container4');
	
	$(document).ready(function() {  //初始化
		var id = ${specialActivity.specialModelTwo==null ? true : false};
		var action = "${action}";
		if(action == "update"){
			$('#modelType').attr("disabled","disabled");//将input元素设置为disabled
		}
		if(id){
			$('#modelTwo').hide();
			$('#modelTwo').attr("disabled","disabled");//将input元素设置为disabled
		}else {
			$('#modelOne').hide();
			$('#modelOne').attr("disabled","disabled");//将input元素设置为disabled
		}
		
		
	});
	
	function chuange(){
	    var obj = document.getElementById("modelType"); //定位id
	    var index = obj.selectedIndex; // 选中索引
	    var value = obj.options[index].value; // 选中值
	    if(value == 1){
	    	$('#modelTwo').hide();
	    	$('#modelTwo').attr("disabled","disabled");//将input元素设置为disabled
	    	$('#modelOne').show();
	     }
		if(value == 2 || value == 3 || value == 4){
			$('#modelOne').hide();
			$('#modelOne').attr("disabled","disabled");//将input元素设置为disabled
			$('#modelTwo').show();
	     }
	}
	
	// 保存
	$('#save').click(function(){
		var obj = document.getElementById("modelType"); //定位id
	    var index = obj.selectedIndex; // 选中索引
	    var value = obj.options[index].value; // 选中值
	    var action = "${action}";
	    if(action == "create"){
	    	if(value == 1){
		    	$("#J_addForm").attr("action","${ctx}/activity/specialActivity/createOne");   //根据选中的模板 提交到对应的控制器
		    }else if(value == 2){
		    	$("#J_addForm").attr("action","${ctx}/activity/specialActivity/createTwo");
		    }
	    }else if(action == "update"){
	    	if(value == 1){
		    	$("#J_addForm").attr("action","${ctx}/activity/specialActivity/updateOne");   //根据选中的模板 提交到对应的控制器
		    }else if(value == 2){
		    	$("#J_addForm").attr("action","${ctx}/activity/specialActivity/updateTwo");
		    }
	    }
		if(($("#J_addForm").valid())){
			$("#J_addForm").ajaxSubmit(
					function(data) {
			        	if(data){
			        		if('0000' == data.code){
			        			// $('#message').text("保存成功");
				            	alert(data.msg);
				            	location.href = "${ctx}/activity/specialActivity/list";
			        		}else if('1111' == data.code){
			        			// $('#message').text("您的操作超时，请重试！");
				            	alert(data.msg);
			        		}else {
			        			// $('#message').text(data.msg);
				            	alert(data.msg);
			        		}
			        	}else{
			            	alert("操作异常，请重试。");
			        	}
			        });
		}
	});
	
	
	/*
	    * uploadify  文件上传
	    */
	    $('#file_upload').uploadify({
	        'buttonClass': 'btn btn-file',
	        'buttonText': '选择图片',
	        'uploadLimit' : 5,
	        'fileSizeLimit' : '500KB',
	        'fileTypeDesc' : '图片文件',
	        'fileTypeExts' : '*.gif; *.jpg; *.jpeg; *.png',
	        'removeCompleted' : false,
	        'swf'      : '${ctx}/static/plug-in/uploadify/uploadify.swf',
	        'uploader' : '${ctx}/component/uploadifyServer/uploadImage',
	        'itemTemplate' : '<div id="\${fileID}" class="uploadify-queue-item">\
				              <div class="cancel">\
				              <a href="javascript:$(\'#\${instanceID}\').uploadify(\'cancel\', \'\${fileID}\')">X</a>\
				              </div>\
				              <div><img id="img_\${fileID}" src="\${fileName}" style="display:none;width: 50px;height: 50px;">\
				              <input type="hidden" id="pic_\${fileID}" name="pictures" value=""/></div>\
				              <span class="fileName">\${fileName} (\${fileSize})</span><span class="data"></span>\
				              </div>',
	        'onUploadSuccess' : function(file, data, response) {
	            if(response ){
		    		var JSONDate = $.parseJSON(data);
		    		if(JSONDate && JSONDate.code == '0000' && JSONDate.nameList && JSONDate.nameList.length >0){
		        		$(JSONDate.nameList).each(function(i){
			        		var obj = JSONDate.nameList[i];
			        		if(i==0){
					        	$('#pic_'+file.id).val(obj);
					        	$('#img_'+file.id).attr('src', obj);
					        	$('#img_'+file.id).show();
			        		}
		        		}); 
		    			
		    		}
		    	}
	            
	        }
	    });
    
</script>
	
</body>
</html>
