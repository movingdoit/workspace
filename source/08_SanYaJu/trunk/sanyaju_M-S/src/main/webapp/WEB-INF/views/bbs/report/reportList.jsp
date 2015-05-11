<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>处理举报页面</title>
<link href="${ctx}/static/assets/css/jquery-webox.css" type="text/css" rel="stylesheet"/>
	<script type="text/javascript" src="${ctx}/static/assets/js/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/static/assets/js/jquery-webox.js"></script>
	<script type="text/javascript">
	function handle(reportId){
		$("#reportId").val(reportId);
		$.webox({
			height:330,
			width:600,
			bgvisibel:true,
			title:'处理举报信息',
			html:$("#box").html()
		});
	}
	</script>
</head>

<body>

<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1>举报列表</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid"> 
        <hr>
        <div class="row-fluid">
            <div class="span12">
            	<div class="widget-box">
                    <div class="widget-title">
                        <ul class="nav nav-tabs">
                            <li ${notReports!=null ? 'class="active"' : '' }><a href="${ctx}${handle =='handle' ? '/bbs/report/untreated' : ''}">待处理</a></li>
                            <li ${reports!=null ? 'class="active"' : '' }><a href="${ctx}${handle =='handle' ? '/bbs/report/handle' : ''}">已处理</a></li>
                        </ul>
                    </div>
                    <div class="widget-content tab-content nopadding">
                        <div id="tab1" ${notReports!=null ? 'class="tab-pane active"' : 'class="tab-pane p20"' }>
                            <div class="pro-box">
		                        <table class="table table-bordered table-striped">
		                            <thead>
		                            <tr>
		                                <th class="per10">举报人</th>
				                        <th class="per10">举报时间</th>
				                        <th class="per5">被举报的话题</th>
				                        <th class="per30">被举报人</th>
				                        <th class="per5">举报原因</th>
				                        <th class="per30">操作</th>
		                            </tr>
		                            </thead>
		                            <tbody id="proList">
		                            <c:if test="${not empty notReports && notReports.size >0 }">
			                            <c:forEach items="${notReports.content}" var="Item">
											<tr>
												<td>${Item.reportUser.name}</td>
												<td><fmt:formatDate value="${Item.reportTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
												<td>${Item.topic.title}</td>
												<td>${Item.topic.createrMember.name}</td>
												<td>${Item.reportReason}</td>
												<td>
													<shiro:hasPermission name="user:edit">
														<a href="${ctx}/bbs/topic/detail/${Item.id}" class="btn btn-mini"  >查看话题</a>
														<a onclick="handle(${Item.id})" href="javascript:void(0);" class="btn btn-mini" >处理</a>
													</shiro:hasPermission>
												</td>
											</tr>
										</c:forEach>
									</c:if>
									<c:if test="${empty notReports || notReports.totalPages ==0 }">
										<tr>
				                            <td colspan="6" class="text-center"><strong>没有任何信息 *_*</strong></td>
				                        </tr>
									</c:if>
		                            </tbody>
		                        </table>
		                        <c:if test="${not empty notReports && notReports.totalPages >1 }">
		                        	<tags:pagination page="${notReports}" paginationSize="10"/>
		                        </c:if>
		                	</div>
                        </div>
                        <div id="tab2" ${reports!=null ? 'class="tab-pane active"' : 'class="tab-pane p20"' }>
                        	<div class="pro-box">
		                        <table class="table table-bordered table-striped">
		                            <thead>
		                            <tr>
		                                <th class="per10">举报人</th>
				                        <th class="per10">举报时间</th>
				                        <th class="per10">处理时间</th>
				                        <th class="per5">被举报的话题</th>
				                        <th class="per15">被举报人</th>
				                        <th class="per5">举报原因</th>
				                        <th class="per30">操作</th>
		                            </tr>
		                            </thead>
		                            <tbody id="proList">
		                            <c:if test="${not empty reports && reports.size >0 }">
			                            <c:forEach items="${reports.content}" var="handleItem">
											<tr>
												<td>${handleItem.reportUser.name}</td>
												<td><fmt:formatDate value="${handleItem.reportTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
												<td><fmt:formatDate value="${handleItem.processTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
												<td>${handleItem.topic.title}</td>
												<td>${handleItem.topic.createrMember.name}</td>
												<td>${handleItem.reportReason}</td>
												<td>
													<shiro:hasPermission name="user:edit">
														<a href="${ctx}/bbs/topic/detail/${handleItem.id}" class="btn btn-mini">查看话题</a>
													</shiro:hasPermission>
												</td>
											</tr>
										</c:forEach>
									</c:if>
									<c:if test="${empty reports || reports.totalPages ==0 }">
										<tr>
				                            <td colspan="7" class="text-center"><strong>没有任何信息 *_*</strong></td>
				                        </tr>
									</c:if>
		                            </tbody>
		                        </table>
		                        <c:if test="${not empty reports && reports.totalPages >1 }">
		                        	<tags:pagination page="${reports}" paginationSize="5"/>
		                        </c:if>
		                	</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>
<!-- // Main Container -->

<!-- 弹框表单代码 -->
<div id="box" hidden="">
	<div class="mainlist">
		<br>
		<form id="J_addForm" action="${ctx}/bbs/report/doHandle" method="post" class="form-horizontal form-validate" >
                <input type="hidden" id="reportId" name="id" value=""/>
                <div class="control-group" >
                    <label class="control-label"> 是否同过申请:</label>
                    <div class="controls" >
                      <label class="radio inline"><input type="radio" name="status" value="1" checked>通过申请</label>
                      <label class="radio inline"><input type="radio" name="status" value="2">拒绝申请</label>
                  	 </div>
                </div>
                <div class="control-group">
                   <label class="control-label"> 备注 :</label>
                   <div class="controls">
                        <textarea id="remark" name="processResult" rows="6" style="width: 300px;"></textarea>
                   </div>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary" >保存</button>
                    <button type="button" class="btn" >取消</button>
                </div>
        </form>
	</div>
</div>

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
