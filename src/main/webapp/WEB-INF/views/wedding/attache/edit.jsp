<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>编辑邀请函封面信息</title>
	<style>
		.sign_photo{margin:5px 32px;}
		.removeFile{margin:15px 5px;font-size:14px}
	</style>
	<!-- 配置文件 -->
    <script type="text/javascript" src="${ctx}/static/plug-in/ueditor/ueditor.config.js"></script>
    <!-- 编辑器源码文件 -->
    <script type="text/javascript" src="${ctx}/static/plug-in/ueditor/ueditor.all.js"></script>
    <script type="text/javascript">
    	
	</script>
</head>
<body>
<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1><i class="icon-edit"></i>编辑邀请函封面信息</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> 编辑邀请函封面信息</span>
                        <h5></h5>
                    </div>
                    <div class="widget-content nopadding">
                    	<!-- 如果新增用save方法否则用update方法 -->
                        <form id="inputForm"  action="${ctx}/wedding/attache/save" method="post" class="form-horizontal form-validate" enctype="multipart/form-data">
							<input type="hidden" name="id" value="${weddingAttache.id}" />
							<input type="hidden" name="invitationId" value="${weddingAttache.invitation.id}" />
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i>  所属邀请函 :</label>
                                <div class="controls">
                                   <select class="input-medium" id="fk_invitation_id" name="invitation.id" data-rule-required="true" style="width:260px;">
                                        <option value="">=== 选择所属邀请函信息  ===</option>
					            		<c:forEach items="${invitations}" var="item" varStatus="sta_">
							         		<option value="${item.id}" ${item.id eq weddingAttache.invitation.id ? "selected" : ""}>${item.subject }</option>
						            	</c:forEach>
						           </select>
                                </div>
                            </div>
                            
                            <div class="control-group">
                                <label class="control-label">封面图片上传 :</label>
                                <div id="multi_photo" class="controls">
                                    <img class="default-slider" src="${ctx}${weddingAttache.bgImg}">
                                	<input type="file" name="bgimg" data-rule-required="true"/>
                                </div>
                            </div>
                            
                            <div class="control-group">
                                <label class="control-label">封面音乐上传 :</label>
                                <div id="multi_photo" class="controls">
                                	<input type="file" name="bgmusic" data-rule-required="true" />
                                </div>
                            </div>
                            
                            <div class="control-group">
                                <label class="control-label">摘要 :</label>
                                <div class="controls">
                                    <textarea id="remark" name="remark" style="margin: 0px; width: 830px; height: 88px;" rows="4" class="span10" data-rule-maxlength="100" placeholder="摘要最多可输入200字">${weddingPhoto.remark}</textarea>
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
</body>
</html>
