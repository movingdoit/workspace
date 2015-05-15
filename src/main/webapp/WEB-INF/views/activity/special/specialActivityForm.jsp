<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>添加专题活动</title>
	<script src="${ctx}/static/plug-in/KindEditor/kindeditor.js" type="text/javascript"></script>
	<script src="${ctx}/static/plug-in/KindEditor/lang/zh_CN.js" type="text/javascript"></script>
</head>
<body>

<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1><i class="icon-edit"></i> 添加专题活动</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                        <h5>添加专题活动</h5>
                    </div>
                    <div class="widget-content nopadding">
                        <form id="J_addForm" action="#" method="post" class="form-horizontal form-validate"  enctype="multipart/form-data">
							<input type="hidden" name="id" value="${specialActivity.id}" />
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i> 活动标题 :</label>
                                <div class="controls">
                                	<input type="text" id="title" name="activityTitle"  value="${specialActivity.activityTitle}" class="span2" required="required" data-rule-required="true" data-rule-maxlength="10" placeholder="最多10个字符"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i> 选择模板 :</label>
                                <div class="controls">
                                    <select id="adType"  class="input-medium" onchange="chuangeAd()">
                                        <option value="1" >模板一</option>
                                        <option value="2" >模板二</option>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"> 活动封面 :</label>
                                <div class="controls">
                                    <img src="${ctx}${specialActivity.activityImage}" class="default-slider" />
                                    <input type="file" name="file" class="insertimage"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"> 活动内容 :</label>
                                <div class="controls">
                                    <!-- 加载编辑器的容器 -->
							    	<script id="container" name="content" style="width:830px;height:300px" type="text/plain">${null != specialActivity.content && 'null' != specialActivity.content ? specialActivity.content : ''}</script>
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
	
	// ajax方式提交form
	$().ready(function() {
		$("#J_addForm").ajaxForm({
			dataType : "json"
		});
	});
	
	// 保存
	$('#save').click(function(){
		$("#J_addForm").attr("action","${ctx}/activity/specialActivity/${action}");
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
	});
    
</script>
	
</body>
</html>
