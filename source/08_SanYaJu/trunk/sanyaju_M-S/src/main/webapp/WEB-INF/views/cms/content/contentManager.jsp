<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>文章管理</title>
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
        <h1>文章管理</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid"> 
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <p><a class="btn" href="${ctx}/cms/content/create?custom=${custom }${null != cmsChannel.id ? '&channelId=' : '' }${null != cmsChannel.id ? cmsChannel.id : '' }"><i class="icon-plus"></i>  新增文章</a>  <a class="btn" href="${ctx}/cms/channel"><i class="icon-plus"></i>  分类管理</a></p>
                <div class="pro-box">
                    <dl class="inner-side" id="proCatList">
                        <dt class="active"><a href="#" data-catid="0">全部分类 ()</a></dt>
                        <c:if test="${not empty cmsChannelList}">
                            <c:forEach items="${cmsChannelList}" var="channel">
		                        <dd ${(channel.id == cmsChannel.id) ? 'class="active"' : ''}><a href="${ctx}/cms/content/manager?search_EQ_cmsChannel.id=${channel.id}" data-catid="1">${channel.channelTitle} ()</a></dd>
                            </c:forEach>
	                   	</c:if>
                        <dd><a href="${ctx}/cms/channel/create?pid=${pid}" class="green"><i class="icon-plus"></i> 新增分类</a></dd>
                    </dl>
                    <div class="inner-main">
                        <table class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th>文章标题</th>
                                <th>所属分类</th>
                                <th>发布时间</th>
                                <th>排序</th>
                                <th>显示</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody id="proList">
                            <c:if test="${not empty cmsContents && cmsContents.size >0 }">
	                            <c:forEach items="${cmsContents.content}" var="content">
									<tr>
										<td>${content.titel}&nbsp;</td>
										<td>${content.cmsChannel.channelTitle}&nbsp;</td>
										<td><fmt:formatDate value="${content.addTime}" pattern="yyyy-MM-dd HH:mm:ss"/> &nbsp;</td>
										<td>${content.priority}&nbsp;</td>
										<td>${content.isDisplay ? '<span class="label label-success">显示</span>' : '<span class="label">隐藏</span>'}&nbsp;</td>
										<td>
											<a href="${ctx}/cms/content/update/${content.id}/${custom }" id="editLink-${content.id}" class="btn btn-mini">编辑</a>
											<a href="${ctx}/cms/content/delete/${content.id}" class="btn btn-mini">删除</a>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty cmsContents || cmsContents.size ==0 }">
								<tr>
		                            <td colspan="8" class="text-center"><strong>没有任何信息 *_*</strong></td>
		                        </tr>
							</c:if>
                            </tbody>
                        </table>
                        <c:if test="${not empty cmsContents && cmsContents.totalPages >1 }">
                        	<tags:pagination page="${cmsContents}" paginationSize="5"/>
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
