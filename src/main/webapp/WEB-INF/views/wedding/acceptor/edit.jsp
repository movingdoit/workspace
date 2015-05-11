<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>编辑出席婚礼活动人信息</title>
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
        <h1><i class="icon-edit"></i>编辑出席婚礼活动人信息</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> 编辑出席婚礼活动人信息</span>
                        <h5></h5>
                    </div>
                    <div class="widget-content nopadding">
                        <form id="inputForm"  action="${ctx}/wedding/acceptor/save" method="post" class="form-horizontal form-validate" enctype="multipart/form-data">
							<input type="hidden" name="id" value="${acceptor.id}" />
							<input type="hidden" name="invitationId" value="${acceptor.invitation.id}" />
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i>  所属邀请函 :</label>
                                <div class="controls">
                                   <select class="input-medium" id="fk_invitation_id" name="invitation.id" data-rule-required="true" style="width:260px;">
                                        <option value="">=== 选择所属邀请函信息  ===</option>
					            		<c:forEach items="${invitations}" var="item" varStatus="sta_">
							         		<option value="${item.id}" ${item.id eq acceptor.invitation.id ? "selected" : ""}>${item.subject }</option>
						            	</c:forEach>
						           </select>
                                </div>
                            </div>
                            
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i>  出席人姓名 :</label>
                                <div class="controls">
                                	<input type="text" id="attendeeName" name="attendeeName" value="${acceptor.attendeeName}" data-rule-required="true"/>
                                </div>
                            </div>
                            
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i>  亲友类别 :</label>
                                <div class="controls">
                                	<select id="friendsType" name="friendsType">
                                		<option value="">==== 请选择亲友类别？ ====</option>
                                		<c:forTokens var="type_" items="男方亲友,女方亲友" varStatus="var_" delims=",">
                                			<option value="${type_}" ${type_ eq acceptor.friendsType ? "selected" : ""}>${type_}</option>
                                		</c:forTokens>
                                	</select>
                                </div>
                            </div>
                            
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i>  出席人数 :</label>
                                <div class="controls">
                                	<input id="attendeeNum" name="attendeeNum" value="${acceptor.attendeeNum}" data-rule-required="true" data-rule-number="true" />
                                </div>
                            </div>
                            
                            <div class="control-group">
                                <label class="control-label">摘要 :</label>
                                <div class="controls">
                                    <textarea id="remark" name="remark" style="margin: 0px; width: 830px; height: 88px;" rows="4" class="span10" data-rule-maxlength="100" placeholder="摘要最多可输入200字">${acceptor.remark}</textarea>
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
