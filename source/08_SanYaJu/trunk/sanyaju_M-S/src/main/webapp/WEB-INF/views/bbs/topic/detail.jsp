<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>详细内容</title>
</head>

<body>
<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1><i class="icon-edit"></i> 详细内容</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                        <h5>详细内容</h5>
                    </div>
                    <div class="widget-content nopadding" style="position: relative;left: 30px;font-size: 14px;">
                        <form id="J_addForm" action="#" method="post" class="form-horizontal form-validate" enctype="multipart/form-data">
                        	<br>
                            <div class="control-group">
	                                <div>
		                                <img alt="" src="${topic.createrMember.memberWeixin.headImgUrl }" width="80px" height="100px">
		                                <span style="position: relative;top: -18px;">作者名称:${topic.createrMember.name }</span>
		                                <span style="position: relative;top: 26px;left: -96px;">
		                                		<c:choose>
												       <c:when test="${not empty ss}">
												             	 ${ss }秒前
												       </c:when>
												       <c:when test="${not empty mm}">
												              	 ${mm }分钟前
												       </c:when>
												       <c:when test="${not empty hh}">
												              	 ${hh }小时前
												       </c:when>
												       <c:otherwise>
												             	 ${day }天前
												       </c:otherwise>
												</c:choose>
		                                </span>
		                                <span style="position: relative;top: 26px;left: -1px;">来自:${topic.title }</span>
		                                <c:if test="${!topic.top}"><a href="${ctx }/bbs/topic/changeTop?id=${topic.id }&top=true" type="button" class="btn btn-primary" style="position: relative;top: -15px;left: 30px;">置顶</a></c:if>
										<c:if test="${topic.top}"><a href="${ctx }/bbs/topic/changeTop?id=${topic.id }&top=false" type="button" class="btn btn-primary" style="position: relative;top: -15px;left: 30px;">取消置顶</a></c:if>
										<c:if test="${!topic.recommend}"><a href="${ctx }/bbs/topic/recommend?id=${topic.id }&recommend=true" type="button" class="btn btn-primary" style="position: relative;top: -15px;left: 30px;">推荐</a></c:if>
										<c:if test="${topic.recommend}"><a href="${ctx }/bbs/topic/recommend?id=${topic.id }&recommend=false" type="button" class="btn btn-primary" style="position: relative;top: -15px;left: 30px;">取消推荐</a></c:if>
									
	                                </div>
                            </div>
                            <br>
                            <div class="control-group">
	                                ${topic.content }
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
<script src="/static/assets/js/jquery.min.js"></script>
<script src="/static/assets/js/jquery.form.min.js"></script>
</body>
</html>
