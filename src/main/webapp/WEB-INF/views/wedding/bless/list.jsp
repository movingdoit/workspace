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
<title>福留言信息管理</title>
<script type="text/javascript">
		var deleteByID = function(key){
			if(key != null){
				if(confirm("你确认要删除该信息吗？删除后该数据无法恢复！")){
					var url = "/wedding/bless/delete/"+key;
					$.post(url,function(data){
						data == true ? location.reload() : alert("删除信息失败,请与管理员联系！")
					})
				}else{}
			}
		}
		
		var editById = function(key){
			if(key != null){
				var url = "/wedding/bless/edit?id="+key;
				window.location.href=url;
			}
		}
	</script>
</head>
<body>
	<!-- Main Container -->
	<div id="content">
		<div id="content-header"><h1>福留言信息管理</h1></div>
		<!-- Action Boxes -->
		<div class="container-fluid">
			<hr>
			<div class="row-fluid">
				<div class="span12">
					<p>
						<a class="btn" href="${ctx}/wedding/bless/edit"><i class="icon-plus"></i> 添加祝福留言信息</a>
					</p>
					<table class="table table-bordered table-striped">
						<tr>
							<th width="30px">序号</th>
							<th width="150px">所属邀请函主题</th>
							<th width="100px">昵称</th>
							<th>留言内容</th>
							<th width="120px">留言时间</th>
							<th width="100px">操作</th>
						</tr>
						<c:choose>
							<c:when test="${not empty pageData && pageData.size>0}">
								<c:forEach var="item" items="${pageData.content}"
									varStatus="sta_">
									<tr>
										<td width="20px">
											${sta_.index+1+(pageData.number*pageData.size)}
										</td>
										<td>${item.invitation.subject}</td>
										<td>${item.nickname}</td>
										<td>${item.messageContent}</td>
										<td><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
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