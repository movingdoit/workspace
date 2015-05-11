<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>编辑婚礼祝福信息</title>
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
        <h1><i class="icon-edit"></i>编辑婚礼祝福信息</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> 编辑婚纱照信息</span>
                        <h5></h5>
                    </div>
                    <div class="widget-content nopadding">
                        <form id="inputForm" action="${ctx}/wedding/bless/save" method="post" class="form-horizontal form-validate">
							<input type="hidden" name="id" value="${bless.id}"/>
							<input type="hidden" name="invitationId" value="${bless.invitation.id}" />
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i>  所属邀请函 :</label>
                                <div class="controls">
                                   <select class="input-medium" id="fk_invitation_id" name="invitation.id" data-rule-required="true" style="width:260px;">
                                        <option value="">=== 选择所属邀请函信息  ===</option>
					            		<c:forEach items="${invitations}" var="item" varStatus="sta_">
							         		<option value="${item.id}" ${item.id eq bless.invitation.id ? "selected" : ""}>${item.subject }</option>
						            	</c:forEach>
						           </select>
                                </div>
                            </div>
                            
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i>  昵称 :</label>
                                <div class="controls">
                                	<input id="nickname" name="nickname" value="${bless.nickname}" data-rule-required="true" />
                                </div>
                            </div>
                            
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i>留言内容 :</label>
                                <div class="controls">
                                    <!-- 加载编辑器的容器 -->
								    <script id="container" name="messageContent" style="width:830px;height:200px" type="text/plain" data-rule-required="true">${null != bless.messageContent && 'null' != bless.messageContent ? bless.messageContent : ''}</script>
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
<script type="text/javascript">
	var ue = UE.getEditor("container");
</script>
</body>
</html>
