<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>${custom != 1 ? '新增文章' : ''}${(custom == 1 && null != articleCategory && articleCategory.id > 1) ?  articleCategory.name : '' }${(custom == 1 && null != article.articleCategory && article.articleCategory.id >1) ?  article.articleCategory.name : '' }</title>

	
	<link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap-responsive.min.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/matrix-style.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/matrix-media.css">
    <link rel="stylesheet" href="${ctx}/static/assets/font-awesome/css/font-awesome.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap-fileupload.css">
    
	<script src="${ctx}/static/assets/js/bootstrap-datetimepicker.min.js"></script>
	<script src="${ctx}/static/assets/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
	<script src="${ctx}/static/assets/js/matrix.form_common.js"></script>
	
	<script src="${ctx}/static/plug-in/KindEditor/kindeditor.js" type="text/javascript"></script>
	<script src="${ctx}/static/plug-in/KindEditor/lang/zh_CN.js" type="text/javascript"></script>
</head>

<body>
<!-- Main Container -->
<div id="content">

    
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1><i class="icon-edit"></i>  ${custom != 1 ? '新增文章' : ''}${(custom == 1 && null != articleCategory && articleCategory.id > 1) ?  articleCategory.name : '' }${(custom == 1 && null != article.articleCategory && article.articleCategory.id >1) ?  article.articleCategory.name : '' }
        </h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                        <h5>${custom != 1 ? '新增文章' : ''}${(custom == 1 && null != articleCategory && articleCategory.id > 1) ?  articleCategory.name : '' }${(custom == 1 && null != article.articleCategory && article.articleCategory.id >1) ?  article.articleCategory.name : '' }</h5>
                        
                    </div>
                    <div class="widget-content nopadding">
                        <form id="inputForm" modelAttribute="article" action="${ctx}/article/detail/${action}" method="post" class="form-horizontal form-validate" enctype="multipart/form-data">
                            <input type="hidden" name="id" value="${article.id}"/>
							<input type="hidden" name="custom" value="${custom}"/>
							<input type="hidden" name="manager" value="${manager}"/>
							<input type="hidden" name="status" value="${article.status != null ? article.status : 1}"/>
                            <div class="control-group">
							    <c:if test="${custom == 1 && ((null != articleCategory && articleCategory.id > 1) || (null != article.articleCategory && article.articleCategory.id >1)) }">
									<input type="hidden" name="articleCategory.id" value="${articleCategory.id}${article.articleCategory.id}"/>
								</c:if>
								<c:if test="${custom != 1}">
							    <label class="control-label"><i class="red">*</i>  所属分类 :</label>
                                
                                <div class="controls">
                                    <select name="articleCategory.id" class="input-medium" id="article_channel" data-rule-required="true" >
                                        <option value="">选择文章类别</option>
					            		<c:forEach items="${articleCategorys}" var="articleCategory">
							         		<option value="${articleCategory.id }" ${article.articleCategory.id == articleCategory.id ?  'selected' :'' }>${articleCategory.name }</option>
						            	</c:forEach>
						           </select>
                                    <span class="help-inline"><a href="/article/category" data-toggle="modal" class="add-cat"><i class="icon-plus"></i> 新增分类</a></span>
                                
                                </div>
								</c:if>
                            </div>
                           
                            <div class="control-group"> 
                                <label class="control-label">文章标题：</label>
                                <div class="controls">
                                    <input type="text" id="article_title" name="title" value="${article.title}" placeholder="最多可输入20字" class="input-xlarge" data-rule-required="true" data-rule-maxlength="20">
                                    <span class="maroon">*</span>
                                </div>
                           	</div> 
                           	
                            <div class="control-group">
                                <label class="control-label">作者：</label>
                                <div class="controls">
                                    <input type="text" id="article_source" name="source" value="${article.source}" placeholder="最多可输入20字" class="input-xlarge" data-rule-maxlength="20">
                                </div>
                            </div>
                            
                            <div class="control-group">
                                <label class="control-label">链接：</label>
                                <div class="controls">
                                    <input type="text" id="article_source" name="sourceUrl" value="${article.sourceUrl}" placeholder="最多可输入20字" class="input-xlarge" data-rule-url="true" data-rule-maxlength="20">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">显示顺序：</label>
                                <div class="controls">
                                    <input type="text" class="input-small" id="article_priority" name="priority" value="${article.priority}" data-rule-required="true" data-rule-number="true">
                                    <span class="help-inline">数值越大，位置越靠前</span>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">是否显示：</label>
                                <div class="controls">
                                    <label class="radio inline"><input type="radio" name="isDisplay" value="true" ${(null == article || article.isDisplay) ? 'checked' : ''}>显示</label>
                                    <label class="radio inline"><input type="radio" name="isDisplay" value="false"  ${(null != article && !article.isDisplay) ? 'checked' : ''}>隐藏</label>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">上传封面</label>
                                <div class="controls">
                                    <div class="fileupload fileupload-new" data-provides="fileupload">
                                        <div class="fileupload-new thumbnail" style="width: 200px; height: 150px;"><img src="${(null != article && article.coversPic != null && article.coversPic != '') ? article.coversPic : '/static/assets/img/noimage.gif'}" /></div>
                                        <div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>
                                        <div>
                                            <span class="btn btn-file"><span class="fileupload-new">选择图片</span><span class="fileupload-exists">更换</span><input type="file" name='file' /></span>
                                            <a href="#" class="btn fileupload-exists" data-dismiss="fileupload">删除</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">摘要：</label>
                                <div class="controls">
                                    <textarea id="article_summary" name="summary" rows="5" class="input-block-level">${article.summary}</textarea>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">正文：</label>
                                <div class="controls">
                                    <textarea id="article_content" name="articleContent.content" rows="15"class="input-block-level" data-rule-required="true">${null != article.articleContent.content && 'null' != article.articleContent.content ? article.articleContent.content : ''}</textarea>
                                    <span class="maroon">*</span>
                                </div>
                            </div>
                            <div class="form-actions">
                                <button type="submit" class="btn btn-primary" onclick="$('#article_content').val(editor.html());">保存</button>
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
<script src="${ctx}/static/assets/js/jquery-ui-1.10.4.min.js"></script>
<script src="${ctx}/static/assets/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="${ctx}/static/assets/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="${ctx}/static/assets/js/matrix.form_common.js"></script>
<script src="${ctx}/static/assets/plugins/wizard/jquery.form.js"></script>
<script src="${ctx}/static/assets/plugins/wizard/jquery.form.wizard.js"></script>
<script src="${ctx}/static/assets/plugins/fileupload/bootstrap-fileupload.min.js"></script>
<script src="${ctx}/static/assets/js/form-wizard.js"></script>


<!-- 配置文件 -->
<script type="text/javascript" src="${ctx}/static/plug-in/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="${ctx}/static/plug-in/ueditor/ueditor.all.js"></script>
    
<script type="text/javascript">


	$(document).ready(function() {
		//聚焦第一个输入框
		$("#name").focus();
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
		$("#J_addForm").attr("action","${ctx}/house/detail/${action}");
		$("#J_addForm").ajaxSubmit(
				function(data) {
		        	if(data){
		        		if('0000' == data.code){
		        			// $('#message').text("保存成功");
			            	alert(data.message);
			            	if(action=="create"){
			            		location.href = "${ctx}/house/detail/list";
			            	}else{
			            		location.href = "${ctx}/house/detail/list";
			            		//window.history.go(-1);
			            		//window.location.reload(true);
			            	}
		        		}else if('9999' == data.code){
		        			// $('#message').text("您的操作超时，请重试！");
			            	alert(data.message);
		        		}else {
		        			// $('#message').text(data.msg);
			            	alert(data.message);
		        		}
		        	}else{
		            	alert("操作异常，请重试。");
		        	}
		        });
	});
</script>

</body>
</html>
