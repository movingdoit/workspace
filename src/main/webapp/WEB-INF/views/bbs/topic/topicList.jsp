<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>话题列表</title>
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
        <h1>话题列表</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid"> 
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="pro-box">
                	<br>
                	<form class="form-inline pt15 pb15" action="${ctx}/forum/list" method="get" style="position: relative;top: 0px;left: 700px;width:100%;height:100%;">
			        	<div class="form-group ml10">
				            <input type="text" name="search_EQ_keywords"  value="${(search.EQ_keywords!=null) ? search.EQ_keywords : '' }" class="form-control" placeholder="请输入关键字搜索" style="width: 190px;">
			       			<button type="submit" class="btn btn-success ml10">搜索</button>
			       		</div>
			        </form>
                    <dl class="inner-side" id="proCatList">
                        <dt style="text-align: center;" class="active"><a href="${ctx}/bbs/topic/list" data-catid="0">论坛 ()</a></dt>
                        <c:if test="${not empty forumList}">
                            <c:forEach items="${forumList}" var="Item">
		                        <dd style="text-align: center;" ${(Item.id == forum.id) ? 'class="active"' : ''}><a href="${ctx}/bbs/topic/list?search_EQ_forum.id=${Item.id}" data-catid="1">${Item.title} ()</a></dd>
                            </c:forEach>
	                   	</c:if>
                    </dl>
                    <div class="inner-main">
                        <table class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th>创建话题人</th>
                                <th>创建话题时间</th>
                                <th>话题标题</th>
                                <th>话题内容</th>
                                <th>分类</th>
                                <th>状态</th>
                                <th>浏览量</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody id="proList">
                            <c:if test="${not empty topics && topics.size >0 }">
	                            <c:forEach items="${topics.content}" var="topic">
									<tr>
										<td>${topic.createrMember.name}</td>
										<td><fmt:formatDate value="${topic.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/> &nbsp;</td>
										<td><a href="${ctx }/post/list?search_EQ_topic.id=${topic.id }">${topic.title}</a></td>
										<td>${topic.content}</td>
										<td>${topic.forumType.typeName}</td>
										<td>
		                                	<c:if test="${topic.status==0 }"><a href="${ctx}/bbs/topic/changeStatus?id=${topic.id }&status=1"  class="btn btn-mini">关闭</a></c:if>
											<c:if test="${topic.status==1 }"><a href="${ctx}/bbs/topic/changeStatus?id=${topic.id }&status=0"  class="btn btn-mini">开启</a></c:if>
		                                </td>
										<td>${topic.viewCount }</td>
										<td>
											<a href="${ctx}/bbs/topic/detail/${topic.id}" id="editLink-${topic.id}" class="btn btn-mini">查看</a>
											<c:if test="${!topic.top}"><a href="${ctx}/bbs/topic/changeTop?id=${topic.id }&top=true" id="editLink-${topic.id}" class="btn btn-mini">置顶</a></c:if>
											<c:if test="${topic.top}"><a href="${ctx}/bbs/topic/changeTop?id=${topic.id }&top=false" id="editLink-${topic.id}" class="btn btn-mini">取消置顶</a></c:if>
											<c:if test="${!topic.recommend}"><a href="${ctx}/bbs/topic/recommend?id=${topic.id }&recommend=true" id="editLink-${topic.id}" class="btn btn-mini">推荐</a></c:if>
											<c:if test="${topic.recommend}"><a href="${ctx}/bbs/topic/recommend?id=${topic.id }&recommend=false" id="editLink-${topic.id}" class="btn btn-mini">取消推荐</a></c:if>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty topics || topics.totalPages == 0 }">
								<tr>
		                            <td colspan="8" class="text-center"><strong>没有任何信息 *_*</strong></td>
		                        </tr>
							</c:if>
                            </tbody>
                        </table>
                        <c:if test="${not empty topics && topics.totalPages >1 }">
                        	<tags:pagination page="${topics}" paginationSize="5"/>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>
<!-- // Main Container -->
</body>
</html>
