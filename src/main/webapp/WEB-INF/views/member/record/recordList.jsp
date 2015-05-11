<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>处理申请页面</title>
<link href="${ctx}/static/assets/css/jquery-webox.css" type="text/css" rel="stylesheet"/>
	<script type="text/javascript" src="${ctx}/static/assets/js/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/static/assets/js/jquery-webox.js"></script>
	<script type="text/javascript">
	function handle(memberId){
		$("#memberId").val(memberId);
		$.webox({
			height:330,
			width:600,
			bgvisibel:true,
			title:'处理申请会员',
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
        <h1>会员申请记录</h1>
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
                            <li ${members!=null ? 'class="active"' : '' }><a href="${ctx}${handle =='handle' ? '/member/record/untreated' : ''}">待处理</a></li>
                            <li ${handleMembers!=null ? 'class="active"' : '' }><a href="${ctx}${handle =='handle' ? '/member/handle/record' : ''}">已处理</a></li>
                        </ul>
                    </div>
                    <div class="widget-content tab-content nopadding">
                        <div id="tab1" ${members!=null ? 'class="tab-pane active"' : 'class="tab-pane p20"' }>
                            <div class="pro-box">
		                        <table class="table table-bordered table-striped">
		                            <thead>
		                            <tr>
		                                <th class="per10">用户名</th>
				                        <th class="per10">申请时间</th>
				                        <th class="per5">申请内容</th>
				                        <th class="per30">操作</th>
		                            </tr>
		                            </thead>
		                            <tbody id="proList">
		                            <c:if test="${not empty members && members.size >0 }">
			                            <c:forEach items="${members.content}" var="Item">
											<tr>
												<td>${Item.name}</td>
												<td><fmt:formatDate value="${Item.requestTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
												<td>${Item.requestContent}</td>
												<td>
													<shiro:hasPermission name="user:edit">
														<a href="${ctx}/member/data/${Item.id}" class="btn btn-mini"  >查看用户</a>
														<a onclick="handle(${Item.id})" href="javascript:void(0);" class="btn btn-mini" >处理</a>
													</shiro:hasPermission>
												</td>
											</tr>
										</c:forEach>
									</c:if>
									<c:if test="${empty members || members.totalPages ==0 }">
										<tr>
				                            <td colspan="4" class="text-center"><strong>没有任何信息 *_*</strong></td>
				                        </tr>
									</c:if>
		                            </tbody>
		                        </table>
		                        <c:if test="${not empty members && members.totalPages >1 }">
		                        	<tags:pagination page="${members}" paginationSize="5"/>
		                        </c:if>
		                	</div>
                        </div>
                        <div id="tab2" ${handleMembers!=null ? 'class="tab-pane active"' : 'class="tab-pane p20"' }>
                        	<div class="pro-box">
		                        <table class="table table-bordered table-striped">
		                            <thead>
		                            <tr>
		                                <th class="per10">用户名</th>
				                        <th class="per10">申请时间</th>
				                        <th class="per5">申请内容</th>
				                        <th class="per10">处理时间</th>
				                        <th class="per5">处理结果</th>
				                        <th class="per15">备注</th>
				                        <th class="per30">操作</th>
		                            </tr>
		                            </thead>
		                            <tbody id="proList">
		                            <c:if test="${not empty handleMembers && handleMembers.size >0 }">
			                            <c:forEach items="${handleMembers.content}" var="notItem">
											<tr>
												<td>${notItem.name}</td>
												<td><fmt:formatDate value="${notItem.requestTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
												<td>${notItem.requestContent}</td>
												<td><fmt:formatDate value="${notItem.handleTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
												<td>
													<c:if test="${notItem.handleResult}">同意申请</c:if>
													<c:if test="${!notItem.handleResult}">拒绝申请</c:if>
												</td>
												<td>${notItem.remark}</td>
												<td>
													<shiro:hasPermission name="user:edit">
														<a href="${ctx}/member/data/${notItem.id}" class="btn btn-mini"  >查看用户</a>
													</shiro:hasPermission>
												</td>
											</tr>
										</c:forEach>
									</c:if>
									<c:if test="${empty handleMembers || handleMembers.totalPages ==0 }">
										<tr>
				                            <td colspan="7" class="text-center"><strong>没有任何信息 *_*</strong></td>
				                        </tr>
									</c:if>
		                            </tbody>
		                        </table>
		                        <c:if test="${not empty handleMembers && handleMembers.totalPages >1 }">
		                        	<tags:pagination page="${handleMembers}" paginationSize="5"/>
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

//弹框表单代码
<div id="box" >
	<div class="mainlist">
			<br>
			<form id="J_addForm" action="${ctx}/member/handle" method="post" class="form-horizontal form-validate" >
                 <input type="hidden" id="memberId" name="id" value="${member.id}"/>
                 <div class="control-group" >
                     <label class="control-label"> 是否通过申请:</label>
                     <div class="controls" >
	                      <label class="radio inline"><input type="radio" name="handleResult" value="true" checked>通过申请</label>
	                      <label class="radio inline"><input type="radio" name="handleResult" value="false">拒绝申请</label>
                   	 </div>
                 </div>
                 <div class="control-group">
                    <label class="control-label"> 备注 :</label>
                    <div class="controls">
                         <textarea id="remark" name="remark" rows="6" style="width: 300px;"></textarea>
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
