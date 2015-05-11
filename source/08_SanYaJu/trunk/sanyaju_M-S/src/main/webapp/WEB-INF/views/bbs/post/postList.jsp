<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>帖子列表</title>
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
        <h1>帖子列表</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid"> 
        <hr>
        <div class="row-fluid">
            <div class="span12">
                	<form class="form-inline pt15 pb15" action="${ctx}/bbs/forum/list" method="get" style="position: relative;top: 0px;left: 700px;width:100%;height:100%;">
			        	<div class="form-group ml10">
				            <input type="text" name="search_EQ_keywords"  value="${(search.EQ_keywords!=null) ? search.EQ_keywords : '' }" class="form-control" placeholder="请输入关键字搜索" style="width: 190px;">
			       			<button type="submit" class="btn btn-success ml10">搜索</button>
			       		</div>
			        </form>
                    <div class="inner-main">
                        <table class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th>发帖人</th>
                                <th>发布时间</th>
                                <th>内容</th>
                                <th>分类</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody id="proList">
                            <c:if test="${not empty posts && posts.size >0 }">
	                            <c:forEach items="${posts.content}" var="post">
									<tr>
										<td>${post.createrMember.name}&nbsp;</td>
										<td><fmt:formatDate value="${post.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/> &nbsp;</td>
										<td>${post.postText.postContent}&nbsp;</td>
										<td>${post.forumType.typeName}&nbsp;</td>
										 <td>
		                                	<c:if test="${post.status==0 }"><a href="${ctx}/bbs/post/changeStatus?id=${post.id }&status=1&pId=${post.topic.id}"  class="btn btn-mini">关闭</a></c:if>
											<c:if test="${post.status==1 }"><a href="${ctx}/bbs/post/changeStatus?id=${post.id }&status=0&pId=${post.topic.id}"  class="btn btn-mini">开启</a></c:if>
		                                </td>
										<td>
											<a href="${ctx}/bbs/post/detail/${post.id}" id="editLink-${post.id}" class="btn btn-mini">查看</a>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty posts || posts.totalPages == 0 }">
								<tr>
		                            <td colspan="8" class="text-center"><strong>没有任何信息 *_*</strong></td>
		                        </tr>
							</c:if>
                            </tbody>
                        </table>
                        <c:if test="${not empty posts && posts.totalPages >1 }">
                        	<tags:pagination page="${posts}" paginationSize="5"/>
                        </c:if>
                    </div>
            </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>
<!-- // Main Container -->
</body>
</html>
