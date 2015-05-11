<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h4>${cmsChannel.channelTitle}</h4>
</div>
<div class="modal-body">
	<c:if test="${null == custom || 0 == custom }">
	    <h5>选择该分类</h5>
	    <label class="radio"><input type="radio" name="choose" value="" data-title="${cmsChannel.channelTitle}" checked>${cmsChannel.channelTitle}</label>
    </c:if>
    <h5>选择单篇文章</h5>
    <c:if test="${not empty cmsContents && cmsContents.size >0 }">
	     <c:forEach items="${cmsContents.content}" var="content">
	     	<label class="radio"><input type="radio" name="choose" value="${content.id}" data-title="${content.titel}">${content.titel}</label>
		 </c:forEach>
	</c:if>
	<c:if test="${empty cmsContents || cmsContents.size ==0 }">
		<strong>没有任何信息 *_*</strong></td>
	</c:if>
    <tags:pagination page="${cmsContents}" paginationSize="5" async="true" baseURl="${ctx}/cms/content/choosePage?search_EQ_cmsChannel.id=${cmsChannel.id}"/>
</div>
<div class="modal-footer">
    <span class="pull-left"><a class="blue" href="${ctx}/cms/channel/update/${cmsChannel.id}">管理该文章分类</a>(点击关闭浮层并新窗口打开至该文章分类)</span>
    <button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
    <button class="btn btn-primary" data-dismiss="modal" id="chooseOK">确定</button>
</div>