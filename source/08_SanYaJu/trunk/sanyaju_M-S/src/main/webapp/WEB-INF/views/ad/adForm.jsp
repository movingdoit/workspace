<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>添加首页广告</title>
</head>
<body>

<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1><i class="icon-edit"></i> 添加首页广告</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                        <h5>添加首页广告</h5>
                    </div>
                    <div class="widget-content nopadding">
                        <form id="J_addForm" action="#" method="post" class="form-horizontal form-validate"  enctype="multipart/form-data">
							<input type="hidden" name="id" value="${ad.id}" />
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i> 广告名称 :</label>
                                <div class="controls">
                                	<input type="text" id="title" name="title"  value="${ad.title}" class="span2" required="required" data-rule-required="true" data-rule-maxlength="10" placeholder="最多10个字符"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">广告封面 :</label>
                                <div class="controls">
                                    <img src="${ctx}${ad.imageAddr}" class="default-slider" />
                                    <input type="file" name="file" class="insertimage"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="link"><i class="red">*</i> 外链地址:</label>
                                <div class="controls">
                                    <input type="url" id="link" name="forwardAddr" value="${ad.forwardAddr}" class="input-xlarge" data-rule-required="true" data-rule-url="true">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">是否显示 :</label>
                                <div class="controls">
                                    <label class="radio inline"><input type="radio" name="isDisplay" value="true" ${ad.isDisplay ? 'checked' : ''}>显示</label>
                                    <label class="radio inline"><input type="radio" name="isDisplay" value="false" ${!ad.isDisplay ? 'checked' : ''}>隐藏</label>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">广告类型 :</label>
                                <div class="controls">
                                    <select id="adType" name="adType" class="input-medium" onchange="chuangeAd()">
                                        <option value="1" ${(ad.adType == 1) ? 'selected' : ''}>首页广告</option>
                                        <option value="2" ${(ad.adType == 2) ? 'selected' : ''}>楼盘展示页广告</option>
                                        <option value="3" ${(ad.adType == 3) ? 'selected' : ''}>特价楼盘广告</option>
                                        <option value="4" ${(ad.adType == 4) ? 'selected' : ''}>搜索页广告</option>
                                        <option value="5" ${(ad.adType == 5) ? 'selected' : ''}>新闻资讯广告</option>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">广告位置 :</label>
                                <div class="controls">
                                    <select id="homeAd" name="position" class="input-medium" >
                                        <option value="1" ${(ad.position == 1) ? 'selected' : ''}>横条广告</option>
                                        <option value="2" ${(ad.position == 2) ? 'selected' : ''}>竖条广告</option>
                                        <option value="3" ${(ad.position == 3) ? 'selected' : ''}>左边轮播图广告</option>
                                    </select>
                                    <select id="searchAd" name="position" class="input-medium" >
                                        <option value="4" ${(ad.position == 4) ? 'selected' : ''}>顶部横条广告</option>
                                        <option value="5" ${(ad.position == 5) ? 'selected' : ''}>右边广告</option>
                                    </select>
                                    <select id="newsAd" name="position" class="input-medium">
                                        <option value="6" ${(ad.position == 6) ? 'selected' : ''}>顶部横条广告</option>
                                        <option value="7" ${(ad.position == 7) ? 'selected' : ''}>新闻列表页广告</option>
                                        <option value="8" ${(ad.position == 8) ? 'selected' : ''}>新闻详情页广告</option>
                                    </select>
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
<script>

	$(document).ready(function() {  //初始化
		var position = ${ad.position ? ad.position : '1'};
		if(position!=''){
			if(position==1 || position ==2 || position == 3){
				$('#searchAd').hide();
				$('#searchAd').attr("disabled","disabled");//将input元素设置为disabled
				$('#newsAd').hide();
				$('#newsAd').attr("disabled","disabled");//将input元素设置为disabled
			}else if (position==4 || position ==5) {
				$('#homeAd').hide();
				$('#homeAd').attr("disabled","disabled");//将input元素设置为disabled
				$('#newsAd').hide();
				$('#newsAd').attr("disabled","disabled");//将input元素设置为disabled
				$('#searchAd').show();
			}else if (position==6 || position ==7 || position == 8) {
				$('#searchAd').hide();
				$('#searchAd').attr("disabled","disabled");//将input元素设置为disabled
				$('#homeAd').hide();
				$('#homeAd').attr("disabled","disabled");//将input元素设置为disabled
				$('#newsAd').show();
			}
		}
		
		
	});


	function chuangeAd(){
	    var obj = document.getElementById("adType"); //定位id
	    var index = obj.selectedIndex; // 选中索引
	    var value = obj.options[index].value; // 选中值
	    if(value == 1){
	    	$('#searchAd').hide();
	    	$('#searchAd').attr("disabled","disabled");//将input元素设置为disabled
			$('#newsAd').hide();
	    	$('#newsAd').attr("disabled","disabled");//将input元素设置为disabled
	    	$('#homeAd').show();
	     }
		if(value == 2 || value == 3 || value == 4){
			$('#homeAd').hide();
			$('#homeAd').attr("disabled","disabled");//将input元素设置为disabled
			$('#newsAd').hide();
			$('#newsAd').attr("disabled","disabled");//将input元素设置为disabled
			$('#searchAd').show(); 	 
	     }
		if(value == 5){
			$('#searchAd').hide();
			$('#searchAd').attr("disabled","disabled");//将input元素设置为disabled
			$('#homeAd').hide();
			$('#homeAd').attr("disabled","disabled");//将input元素设置为disabled
			$('#newsAd').show(); 	
		}
	}

	
	// ajax方式提交form
	$().ready(function() {
		$("#J_addForm").ajaxForm({
			dataType : "json"
		});
	});
	
	// 保存
	$('#save').click(function(){
		$("#J_addForm").attr("action","${ctx}/ad/${action}");
		$("#J_addForm").ajaxSubmit(
				function(data) {
		        	if(data){
		        		if('0000' == data.code){
		        			// $('#message').text("保存成功");
			            	alert(data.msg);
			            	location.href = "${ctx}/ad/list";
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
	});
    
</script>
	
</body>
</html>
