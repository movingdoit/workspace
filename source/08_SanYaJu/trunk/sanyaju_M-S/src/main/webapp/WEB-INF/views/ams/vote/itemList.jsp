<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>投票管理</title>
	
	<link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap-responsive.min.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/matrix-style.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/matrix-media.css">
    <link rel="stylesheet" href="${ctx}/static/assets/font-awesome/css/font-awesome.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap-fileupload.css">
    
	<script src="${ctx}/static/assets/js/bootstrap-datetimepicker.min.js"></script>
	<script src="${ctx}/static/assets/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
	<script src="${ctx}/static/assets/js/matrix.form_common.js"></script>
	
<!-- 配置文件 -->
<script type="text/javascript" src="${ctx}/static/plug-in/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="${ctx}/static/plug-in/ueditor/ueditor.all.js"></script>
	
</head>

<body>
<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1><i class="icon-edit"></i> 投票管理</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title">
                        <ul class="nav nav-tabs">
                            <li><a href="/ams/vote/activity/update/${actId}"">基础内容设置</a></li>
                            <li class="active"><a href="/ams/vote/item/${actId}">选项设置</a></li>
                            <li><a href="/ams/vote/rule/${actId}">规则设置</a></li>
                            <li><a href="/ams/vote/module/${actId}">自定义模块</a></li>
                        </ul>
                    </div>
                    <div class="widget-content tab-content nopadding">
                        <div id="tab1" class="tab-pane">
                        </div>
                        <div id="tab2" class="tab-pane p20 active">
                            <div class="span8 mb10">
                                <a href="#addVoteOptionModal" onclick="$('#addVoteOptionModal').html($('#newModal').html());" data-toggle="modal" class="btn btn-warning mb10">新增选项</a>
                                <table class="table table-bordered table-striped" id="J_voteOptList">
                                    <thead>
                                    <tr>
                                        <th>编号</th>
                                        <th>选项标题</th>
                                        <th>选项封面</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:if test="${not empty voteItems && fn:length(voteItems) > 0}">
				                    <c:forEach items="${voteItems}" var="item" varStatus="status">
										<tr>
											<td>${item.code}&nbsp;</td>
											<td>${item.title}&nbsp;</td>
											<td><img src="${(null != item && item.coverPic != null && item.coverPic != '') ? item.coverPic : '/static/assets/img/noimage.gif'}" />&nbsp;</td>
											<td>
												<%-- <shiro:hasPermission name="vote:edit"> --%>
													<a href="#" onclick="javescript:update(${item.id});" id="editLink-${activity.id}" class="btn btn-mini">编辑</a>
													<a href="${ctx}/ams/vote/item/delete/${actId}-${item.id}" class="btn btn-mini">删除</a>
												<%-- </shiro:hasPermission> --%>
											</td>
										</tr>
									</c:forEach>
									</c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div id="tab3" class="tab-pane">
                        </div>
                        <div id="tab4" class="tab-pane p20">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>
<!-- // Main Container -->

<!-- Add Vote Option Modal -->
<div id="addVoteOptionModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"  style="width: 1000px;margin-left: -400px;z-index:1000 !important;"></div>

<div id="newModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"  style="width: 1000px;margin-left: -400px;z-index:1000 !important;">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4>新增投票选项</h4>
    </div>
    <form action="create" method="post" class="form-horizontal form-validate" enctype="multipart/form-data">
        <div class="modal-body">
        	<div class="control-group">
                <label class="control-label"><i class="red">*</i> 选项编号 :</label>
                <div class="controls">
                    <input type="text" name="code" value="" class="span3" data-rule-required="true" data-rule-maxlength="10" placeholder="最多10个字符">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label"><i class="red">*</i> 选项标题 :</label>
                    <input type="hidden" name="voteActivity.id" class="span3" value="${actId }" data-rule-required="true" data-rule-maxlength="10" >
                <div class="controls">
                    <input type="text" name="title" class="span3" data-rule-required="true" data-rule-maxlength="10" placeholder="最多10个字符">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">选项封面 :</label>
                <div class="controls">
                    <div class="fileupload fileupload-new" data-provides="fileupload">
                        <div class="fileupload-new thumbnail" style="width: 200px; height: 150px;"><img src="${ctx}/static/assets/img/noimage.gif" /></div>
                        <div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>
                        <div>
                            <span class="btn btn-file"><span class="fileupload-new">选择图片</span><span class="fileupload-exists">更换</span><input type="file" name='file' /></span>
                            <a href="#" class="btn btn-file fileupload-exists" data-dismiss="fileupload">删除</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">详细介绍 :</label>
                <div class="controls">
                    <!-- 加载编辑器的容器 -->
					<script id="container" name="voteItemText.text" style="height:300px" type="text/plain"></script>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
            <button type="submit" class="btn btn-primary">保存</button>
        </div>
    </form>
</div>
<!-- // Add Vote Option Modal -->

<script src="${ctx}/static/assets/js/jquery-ui-1.10.4.min.js"></script>
<script src="${ctx}/static/assets/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="${ctx}/static/assets/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="${ctx}/static/assets/js/matrix.form_common.js"></script>
<script src="${ctx}/static/assets/plugins/wizard/jquery.form.js"></script>
<script src="${ctx}/static/assets/plugins/wizard/jquery.form.wizard.js"></script>
<script src="${ctx}/static/assets/plugins/fileupload/bootstrap-fileupload.min.js"></script>
<script src="${ctx}/static/assets/js/form-wizard.js"></script>

<script type="text/javascript">  
	var ue = UE.getEditor('container');
	
	function update(id){
		$.ajax({
	        type: "GET",
	        url:'/ams/vote/item/update4Ajax/'+id,
	        async: false,
	        success: function(data) {
	        	if(data){
	        		$('#addVoteOptionModal').html(data);
	       			var editor = new UE.ui.Editor();  
	       	        editor.render("tt");  
	       	        //var voteItemText = $('#voteItemText').val();
	       	     	//editor.setContent(voteItemText);
	       			$('#addVoteOptionModal').modal();
	        	}else{
	            	alert("操作异常，请重试。");
	        	}
	        },
	        error: function(request) {
	            alert("网络连接超时，请重试！");
	        }
	    });
	}
</script>
</body>
</html>
