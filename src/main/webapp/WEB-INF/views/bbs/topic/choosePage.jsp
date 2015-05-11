<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h4>${forum.title}</h4>
</div>
<div class="modal-body">
	    <h5>选择该板块</h5>
	    <label class="radio"><input type="radio" name="choose" value="" data-title="${forum.title}" checked>${forum.title}</label>
    	<h5>选择话题</h5>
	    <c:if test="${not empty topics && topics.size >0 }">
		     <c:forEach items="${topics.content}" var="Item">
		     	<label class="radio"><input type="radio" name="choose" value="${Item.id}" data-title="${Item.title}">${Item.title}</label>
			 </c:forEach>
		</c:if>
		<c:if test="${empty topics || topics.totalPages == 0 }">
			<strong>没有任何信息 *_*</strong>
		</c:if>
		<br>
		<p>
	    <tags:pagination page="${topics}" paginationSize="5" async="true" baseURl="${ctx}/bbs/topic/choosePage?search_EQ_forum.id=${forum.id}"/>
</div>
<div class="modal-footer">
    <span class="pull-left"><a class="blue" href="${ctx}/forum/list">管理该板块</a>(点击关闭浮层并新窗口打开至该板块管理)</span>
    <button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
    <button class="btn btn-primary" data-dismiss="modal" id="chooseOK">确定</button>
</div>