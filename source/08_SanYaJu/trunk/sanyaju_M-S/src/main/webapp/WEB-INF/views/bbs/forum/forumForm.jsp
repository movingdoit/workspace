<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>${(forum.id!=null)? '编辑论坛' : '新增论坛'}</title>
</head>

<body>
<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1><i class="icon-edit"></i> ${(forum.id!=null)? '编辑论坛' : '新增论坛'}</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                        <h5>${(forum.id!=null)? '编辑论坛' : '新增论坛'}</h5>
                    </div>
                    <div class="widget-content nopadding">
                        <form id="J_addForm" modelAttribute="forum" action="#" method="post" class="form-horizontal form-validate" enctype="multipart/form-data">
							<input type="hidden" name="id" value="${forum.id}"/>
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i> 论坛名称 :</label>
                                <div class="controls">
                                    <input type="text" id="title" name="forumTitle" value="${forum.title}" class="span3" data-rule-required="true" data-rule-maxlength="20" placeholder="最多15个字符">
                                </div>
                            </div>
                            <div class="control-group"> 
                                <label class="control-label">封面 :</label>
                                <div class="controls">
                                    <img class="default-slider" src="${ctx}${(forum.forumPic) }">
                                	<input type="file" name="file"/>
                                    <!-- <a class="btn insertimage">上传</a> -->
                                    <span class="help-inline">建议尺寸：宽360像素，高200像素</span>
                                </div>
                           	</div>
                            <div class="control-group">
                                <label class="control-label">分类 :</label>
                                <div class="controls J_argList" id="argList" data-limit = "1">
                                	<c:if test="${empty forum.forumTypeList}">
                                    	<p>
	                                        <input type="text" name="attrList" value="">
	                                        <span class="help-inline">
	                                            <a href="#" class="icon icon-plus green" title="增加字段"></a>
	                                            <a href="#" class="icon icon-minus green" title="删除字段"></a>
	                                            <a href="#" class="icon icon-arrow-up blue upbtn" title="向上移"></a>
	                                            <a href="#" class="icon icon-arrow-down blue downbtn" title="向下移"></a>
	                                        </span>
                                    	</p>
                                    </c:if>
                                    <c:if test="${not empty forum.forumTypeList}">
				              	  		<c:forEach items="${forum.forumTypeList}" var="Item">
					              	  		<p>
					              	  			<input type="text" name="attrList" value="${Item.typeName }">
					              	  			<span class="help-inline">
		                                            <a href="#" class="icon icon-plus green" title="增加字段"></a>
		                                            <a href="#" class="icon icon-minus green" title="删除字段"></a>
		                                            <a href="#" class="icon icon-arrow-up blue upbtn" title="向上移"></a>
		                                            <a href="#" class="icon icon-arrow-down blue downbtn" title="向下移"></a>
		                                        </span>
	                                        </p>
                                    	</c:forEach>
									</c:if>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"> 显示顺序 :</label>
                                <div class="controls">
                                    <input type="text" id="priority" name="paixu" value="${forum.priority}" class="span3" data-rule-required="true" data-rule-maxlength="20" placeholder="最多11个字符">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"> 发帖权限 :</label>
                                <div class="controls">
                                    <label class="radio inline"><input type="radio" id="privilege" name="privilege" value="0" ${(forum == null || forum.privilege == null || forum.privilege == false) ? 'checked' : ''}>不限制</label>
                                    <label class="radio inline"><input type="radio" id="privilege" name="privilege" value="1" ${forum.privilege == true  ? 'checked' : ''} >会员权限</label>
                                </div>
                            </div>
                            <div id="chooseLevel" class="control-group" >
                                <label class="control-label"> 会员等级 :</label>
                                <div class="controls">
                                   <select name="memberGrade.id" class="input-medium" id="memberGradeId" data-rule-required="true" >
                                        <option value="">选择会员等级</option>
                                        <c:if test="${not empty memberGradeList }">
						            		<c:forEach items="${memberGradeList}" var="Item">
								         		<option value="${Item.id }" ${forum.memberGrade.id == Item.id ?  'selected' :'' }>${Item.gradeName }</option>
							            	</c:forEach>
						            	</c:if>
						           </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"> 状态 :</label>
                                <div class="controls">
                                    <label class="radio inline"><input type="radio" name="status" value="true"  ${forum.status ? 'checked' : ''}>开启</label>
                                    <label class="radio inline"><input type="radio" name="status" value="false" ${!forum.status ? 'checked' : ''}>关闭</label>
                                </div>
                            </div>
                            <div class="form-actions">
                                <button type="button" id="save" class="btn btn-primary" >保存</button>
                                <button type="button" class="btn" onclick="window.history.go(-1);">取消</button>
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
<script src="${ctx}/static/assets/js/jquery.form.min.js"></script>
<script type="text/javascript">


	$("#privilege :radio").change(function(){
	        if(this.value == '0') {
	        	$('#chooseCMS').hide();
	        } else if(this.value == '1') {
	        	$('#chooseCMS').show();
	        }
	   
	});

	$(document).ready(function() {
		//聚焦第一个输入框
		$("#title").focus();
		//为inputForm注册validate函数
		//$("#inputForm").validate();
	});
	
	// ajax方式提交form
	$().ready(function() {
		$("#J_addForm").ajaxForm({
			dataType : "json"
		});
	});
	
	// 保存
	$('#save').click(function(){
		var action = "${action}";
		$("#J_addForm").attr("action","${ctx}/bbs/forum/${action}");
		$("#J_addForm").ajaxSubmit(
				function(data) {
		        	if(data){
		        		if('0000' == data.code){
		        			// $('#message').text("保存成功");
			            	alert(data.msg);
			            	if(action=="create"){
			            		location.href = "${ctx}/bbs/forum/list";
			            	}else{
			            		location.href = "${ctx}/bbs/forum/list";
			            		//window.history.go(-1);
			            		//window.location.reload(true);
			            	}
		        		}else if('1111' == data.code){
		        			// $('#message').text("您的操作超时，请重试！");
			            	alert(data.msg);
		        		}else {
		        			// $('#message').text(data.msg);
			            	alert(data.msg);
		        		}
		        	}else{
		            	alert("操作异常，请重试。");
		        	}
		        });
	});
</script>
</body>
</html>
