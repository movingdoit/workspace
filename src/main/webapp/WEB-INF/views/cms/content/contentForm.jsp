<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>${custom != 1 ? '新增文章' : ''}${(custom == 1 && null != cmsChannel && cmsChannel.id > 1) ?  cmsChannel.channelTitle : '' }${(custom == 1 && null != cmsContent.cmsChannel && cmsContent.cmsChannel.id >1) ?  cmsContent.cmsChannel.channelTitle : '' }</title>
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
        <h1><i class="icon-edit"></i> ${custom != 1 ? '新增文章' : ''}${(custom == 1 && null != cmsChannel && cmsChannel.id > 1) ?  cmsChannel.channelTitle : '' }${(custom == 1 && null != cmsContent.cmsChannel && cmsContent.cmsChannel.id >1) ?  cmsContent.cmsChannel.channelTitle : '' }</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                        <h5>${custom != 1 ? '新增文章' : ''}${(custom == 1 && null != cmsChannel && cmsChannel.id > 1) ?  cmsChannel.channelTitle : '' }${(custom == 1 && null != cmsContent.cmsChannel && cmsContent.cmsChannel.id >1) ?  cmsContent.cmsChannel.channelTitle : '' }</h5>
                    </div>
                    <div class="widget-content nopadding">
                        <form id="inputForm" modelAttribute="cmsContent" action="${ctx}/cms/content/${action}" method="post" class="form-horizontal form-validate" enctype="multipart/form-data">
							<input type="hidden" name="id" value="${cmsContent.id}"/>
							<input type="hidden" name="custom" value="${custom}"/>
							<input type="hidden" name="manager" value="${manager}"/>
							<input type="hidden" name="status" value="${cmsContent.status != null ? cmsContent.status : 1}"/>
							
                            <div class="control-group">
                                <c:if test="${custom == 1 && ((null != cmsChannel && cmsChannel.id > 1) || (null != cmsContent.cmsChannel && cmsContent.cmsChannel.id >1)) }">
									<input type="hidden" name="cmsChannel.id" value="${cmsChannel.id}${cmsContent.cmsChannel.id}"/>
								</c:if>
								<c:if test="${custom != 1}">
                                <label class="control-label"><i class="red">*</i>  所属分类 :</label>
                                <div class="controls">
                                   <select name="cmsChannel.id" class="input-medium" id="cmsContent_channel" data-rule-required="true" >
                                        <option value="">选择文章类别</option>
					            		<c:forEach items="${cmsChannels}" var="cmsChannel">
							         		<option value="${cmsChannel.id }" ${cmsContent.cmsChannel.id == cmsChannel.id ?  'selected' :'' }>${cmsChannel.channelTitle }</option>
						            	</c:forEach>
						           </select>
                                    <span class="help-inline"><a href="${ctx}/cms/channel/create?pid=${pid}" data-toggle="modal" class="add-cat"><i class="icon-plus"></i> 新增分类</a></span>
                                </div>
								</c:if>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i>  文章标题 :</label>
                                <div class="controls">
                                    <input type="text" id="cmsContent_titel" name="titel" value="${cmsContent.titel}" class="span3" data-rule-required="true" data-rule-maxlength="20" placeholder="最多20个字符">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">显示顺序 :</label>
                                <div class="controls">
                                    <input type="text" class="span1" id="cmsContent_priority" name="priority" value="${cmsContent.priority}" data-rule-required="true" data-rule-number="true">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">是否显示 :</label>
                                <div class="controls">
                                    <label class="radio inline"><input type="radio" name="isDisplay" value="true" ${cmsContent.isDisplay ? 'checked' : ''}>显示</label>
                                    <label class="radio inline"><input type="radio" name="isDisplay" value="false"  ${!cmsContent.isDisplay ? 'checked' : ''}>隐藏</label>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">封面 :</label>
                                <div class="controls">
					
                                    <img class="default-slider" src="${ctx}${cmsContent.coversPic}">
                                	<input type="file" name="file"/>
                                    <!-- <a class="btn insertimage">上传</a> -->
                                    <span class="help-inline">建议尺寸：宽360像素，高200像素</span>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">摘要 :</label>
                                <div class="controls">
                                    <textarea id="summary" name="summary" style="margin: 0px; width: 830px; height: 88px;" rows="4" class="span10" data-rule-maxlength="100" placeholder="摘要最多可输入100字">${cmsContent.summary}</textarea>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">正文 :</label>
                                <div class="controls">
                                	<!-- 加载编辑器的容器 -->
								    <script id="container" name="content" style="width:830px;height:500px" type="text/plain">${null != cmsContent.content && 'null' != cmsContent.content ? cmsContent.content : ''}</script>
                                </div>
                            </div>
                            <div class="form-actions">
                                <button type="submit" class="btn btn-primary" >保存</button>
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
<!-- // Main Container -->

<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#cmsContent_titel").focus();
		//为inputForm注册validate函数
		//$("#inputForm").validate();
	});
	var ue = UE.getEditor('container');
</script>
</body>
</html>
