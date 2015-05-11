<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>论坛列表</title>
	<script>
		$(document).ready(function() {
			$("#account-tab").addClass("active");
		});
	</script>
</head>
<body>
<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1>论坛列表</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid"> 
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <p><a class="btn" href="${ctx}/bbs/forum/create"><i class="icon-plus"></i>  新增论坛</a>
                <div class="pro-box">
                        <table class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th>论坛名称</th>
		                        <th>封面图片</th>
		                        <th>创建时间</th>
		                        <th>排序</th>
		                        <th>分类</th>
		                        <th>发帖权限</th>
		                        <th>状态</th>
		                        <th>操作</th>
                            </tr>
                            </thead>
                            <tbody id="proList">
                            <c:if test="${not empty forums && forums.size>0}">
	                            <c:forEach items="${forums.content}" var="Item">
									<tr>
										<td>${Item.title}</td>
										<td>
											<c:if test="${null != Item.forumPic && Item.forumPic != '' }">
												<img  alt="" src="${Item.forumPic}"/>
											</c:if>
										</td>
										<td><fmt:formatDate value="${Item.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<td>${Item.priority}</td>
										<td>
											<c:if test="${not empty Item.forumTypeList}">
												<c:forEach items="${Item.forumTypeList }" var="type">
													${type.typeName},
												</c:forEach>
											</c:if>
										</td>
		                                <td><c:if test="${Item.privilege}">会员权限<c:if test="${Item.memberGrade != null}">-${Item.memberGrade.gradeName}</c:if></c:if><c:if test="${!Item.privilege}">不限制</c:if></td>
		                                <td>
		                                	<c:if test="${Item.status }"><a href="${ctx}/bbs/forum/changeStatus?id=${Item.id }&status=false"  class="btn btn-mini">开启</a></c:if>
											<c:if test="${!Item.status }"><a href="${ctx}/bbs/forum/changeStatus?id=${Item.id }&status=true"  class="btn btn-mini">关闭</a></c:if>
		                                </td>
										<td>
											<shiro:hasPermission name="user:edit">
												<a href="${ctx}/bbs/forum/update/${Item.id}" class="btn btn-mini" >编辑</a>
											</shiro:hasPermission>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty forums || forums.totalPages == 0 }">
								<tr>
		                            <td colspan="8" class="text-center"><strong>没有任何信息 *_*</strong></td>
		                        </tr>
							</c:if>
                            </tbody>
                        </table>
                         <c:if test="${not empty forums && forums.totalPages >1 }">
                        	<tags:pagination page="${forums}" paginationSize="10"/>
                        </c:if>
                </div>
            </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>
<!-- // Main Container -->
<script>
 	
 	// 修改是否   封号  或  激活
	function changeStatus(id, status){
		$.ajax({
	        type: "GET",
	        url:'${ctx}/member/changeStatus/?id='+id+'&status='+status,
	        async: false,
	        success: function(data) {},
	        error: function(request) {
	            alert("网络连接超时，请重试！");
	        }
	    });
	}
 	
</script>
</body>
</html>
