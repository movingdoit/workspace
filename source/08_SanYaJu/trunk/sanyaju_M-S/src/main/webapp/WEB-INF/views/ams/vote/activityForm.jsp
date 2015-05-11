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
	
	<script src="${ctx}/static/plug-in/KindEditor/kindeditor.js" type="text/javascript"></script>
	<script src="${ctx}/static/plug-in/KindEditor/lang/zh_CN.js" type="text/javascript"></script>
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
                            <li class="active"><a data-toggle="tab" href="#tab1">基础内容设置</a></li>
                            <li><a href="${action =='update' ? '/ams/vote/item/' : ''}${action =='update' ? voteActivity.id : ''}">选项设置</a></li>
                            <li><a href="${action =='update' ? '/ams/vote/rule/' : ''}${action =='update' ? voteActivity.id : ''}">规则设置</a></li>
                            <li><a href="${action =='update' ? '/ams/vote/module/' : ''}${action =='update' ? voteActivity.id : ''}">自定义模块</a></li>
                        </ul>
                    </div>
                    <div class="widget-content tab-content nopadding">
                        <div id="tab1" class="tab-pane active">
                            <form action="${ctx}/ams/vote/activity/${action}" method="post" class="form-horizontal form-validate" novalidate="novalidate" enctype="multipart/form-data">
                                <div class="control-group">
                                    <label class="control-label"><i class="red">*</i>  投票标题 :</label>
                                    <div class="controls">
                                        <input type="hidden" name="id" value="${voteActivity.id }" class="span3" data-rule-maxlength="20">
                                        <input type="text" name="title" value="${voteActivity.title }" class="span3" data-rule-required="true" data-rule-maxlength="100" placeholder="最多100个字符">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">投票描述(选填) :</label>
                                    <div class="controls">
                                        <input type="text" name="description" value="${voteActivity.description }" class="span3" data-rule-maxlength="20" placeholder="最多20个字符">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">投票封面 :</label>
                                    <div class="controls">
                                        <div class="fileupload fileupload-new" data-provides="fileupload">
                                            <div class="fileupload-new thumbnail" style="width: 200px; height: 150px;"><img src="${(null != voteActivity && voteActivity.coverPic != null && voteActivity.coverPic != '') ? voteActivity.coverPic : '/static/assets/img/noimage.gif'}" /></div>
                                            <div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>
                                            <div>
                                                <span class="btn btn-file"><span class="fileupload-new">选择图片</span><span class="fileupload-exists">更换</span><input type="file" name='file' /></span>
                                                <a href="#" class="btn btn-file fileupload-exists" data-dismiss="fileupload">删除</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">开始时间 :</label>
                                    <div class="controls">
                                        <div data-date="2012-12-02 12:00" class="input-append date datepicker">
                                            <input type="text" value="<fmt:formatDate value="${voteActivity.startTime}" pattern="yyyy-MM-dd HH:mm"/>" name="startTimes" id="timeStart" data-date-format="yyyy-mm-dd hh:mm" class="span11" data-rule-required="true">
                                            <span class="add-on"><i class="icon-th"></i></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">结束时间 :</label>
                                    <div class="controls">
                                        <div data-date="2012-12-02 12:00" class="input-append date datepicker">
                                            <input type="text" value="<fmt:formatDate value="${voteActivity.endTime}" pattern="yyyy-MM-dd HH:mm"/>" name="endTimes" id="timeEnd" data-date-format="yyyy-mm-dd hh:mm" class="span11" data-rule-required="true" data-rule-compareDate="#timeStart">
                                            <span class="add-on"><i class="icon-th"></i></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">投票详细介绍 :</label>
                                    <div class="controls">
                                    	<!-- 加载编辑器的容器 -->
								    	<script id="container" name="voteActivityText.text" style="width:830px;height:500px" type="text/plain">${null != voteActivity.voteActivityText.text && 'null' != voteActivity.voteActivityText.text ? voteActivity.voteActivityText.text : ''}</script>
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <button type="reset" class="btn">取消</button>
                                    <button type="submit" class="btn btn-success">保存</button>
                                </div>
                            </form>
                        </div>
                        <div id="tab2" class="tab-pane p20">
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

<script src="${ctx}/static/assets/js/jquery-ui-1.10.4.min.js"></script>
<script src="${ctx}/static/assets/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="${ctx}/static/assets/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="${ctx}/static/assets/js/matrix.form_common.js"></script>
<script src="${ctx}/static/assets/plugins/wizard/jquery.form.js"></script>
<script src="${ctx}/static/assets/plugins/wizard/jquery.form.wizard.js"></script>
<script src="${ctx}/static/assets/plugins/fileupload/bootstrap-fileupload.min.js"></script>
<script src="${ctx}/static/assets/js/form-wizard.js"></script>
<script src="${ctx}/static/assets/js/pages/vote.js"></script>


<!-- 配置文件 -->
<script type="text/javascript" src="${ctx}/static/plug-in/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="${ctx}/static/plug-in/ueditor/ueditor.all.js"></script>
    
<script type="text/javascript">  

	var ue = UE.getEditor('container');

</script>
</body>
</html>
