<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>邀请函封面信息管理</title>
<script type="text/javascript">
		//删除
		var deleteByID = function(key){
			if(key != null){
				if(confirm("你确认要删除该信息吗？删除后该数据无法恢复！")){
					var url = "/wedding/attache/delete/"+key;
					$.post(url,function(data){
						data == true ? location.reload() : alert("删除信息失败！")
					})
				}else{}
			}
		}
		
		//更新
		var editById = function(key){
			if(key != null){
				var url = "/wedding/attache/edit?id="+key;
				window.location.href=url;
			}
		}
	</script>
</head>
<body>
	<!-- Main Container -->
	<div id="content">
		<div id="content-header">
			<h1>邀请函封面信息管理</h1>
		</div>
		<!-- Action Boxes -->
		<div class="container-fluid">
			<hr>
			<div class="row-fluid">
				<div class="span12">
					<p>
						<a class="btn" href="${ctx}/wedding/attache/edit">
						<i class="icon-plus"></i> 添加邀请函封面信息</a>
					</p>
					<table class="table table-bordered table-striped">
						<tr>
							<th>所属邀请函主题</th>
							<th>封面图片</th>
							<th>背景音乐地址</th>
							<th>创建时间</th>
							<th>备注</th>
							<th>操作</th>
						</tr>
						<c:choose>
							<c:when test="${not empty pageData && pageData.size>0}">
								<c:forEach var="item" items="${pageData.content}"
									varStatus="sta_">
									<tr>
										<td>${item.invitation.subject}</td>
										<td><img src="${ctx}${item.bgImg}" style="width:100px;height:80px;border-radius:4px;" alt="背景图片"/></td>
										<td>${item.bgMusic}</td>
										<td>
											<fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm:ss" />
										</td>
										<td>${item.remark}</td>
										<td>
											<a href="#" onclick="editById(${item.id});">修改</a> 
											<a href="#" onclick="deleteByID(${item.id});">删除</a>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="5" class="text-center"><strong>没有任何信息*_*</strong>
								</tr>
							</c:otherwise>
						</c:choose>
					</table>
					<tags:pagination paginationSize="10" page="${pageData}" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>