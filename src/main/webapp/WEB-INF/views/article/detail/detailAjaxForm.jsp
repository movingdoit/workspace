<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<title>${custom != 1 ? '新增文章' : ''}${(custom == 1 && null != articleCategory && articleCategory.id > 1) ?  articleCategory.name : '' }${(custom == 1 && null != article.articleCategory && article.articleCategory.id >1) ?  article.articleCategory.name : '' }</title>

<form id="articleForm" modelAttribute="article" action="#" method="post" class="form-horizontal form-validate" enctype="multipart/form-data">
    <input type="hidden" name="id" value="${article.id}"/>
	<input type="hidden" name="custom" value="${custom}"/>
	<input type="hidden" name="manager" value="${manager}"/>
	<input type="hidden" name="status" value="${article.status != null ? article.status : 1}"/>
	<div class="modal-header">
	    <button type="button" class="close" data-dismiss="modal" onclick="location.reload();" aria-hidden="true">×</button>
	    <h4 id="myModalLabel">${custom != 1 ? '新增文章' : ''}${(custom == 1 && null != articleCategory && articleCategory.id > 1) ?  articleCategory.name : '' }${(custom == 1 && null != article.articleCategory && article.articleCategory.id >1) ?  article.articleCategory.name : '' }</h4>
	</div>
	<div class="modal-body">
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
                               <span class="help-inline"><a href="${ctx}/cms/channel/create?pid=${pid}" data-toggle="modal" class="add-cat"><i class="icon-plus"></i> 新增分类</a></span>
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
            <label class="control-label">显示顺序：</label>
            <div class="controls">
                <input type="text" class="input-small" id="article_priority" name="priority" value="${article.priority}" data-rule-required="true" data-rule-number="true">
                <span class="help-inline">数值越大，位置越靠前</span>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">是否显示：</label>
            <div class="controls">
                <label class="radio inline"><input type="radio" name="isDisplay" value="true" ${article.isDisplay ? 'checked' : ''}>显示</label>
                <label class="radio inline"><input type="radio" name="isDisplay" value="false"  ${!article.isDisplay ? 'checked' : ''}>隐藏</label>
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
    </div>
    <div class="modal-footer">
        <button class="btn" data-dismiss="modal" aria-hidden="true" onclick="location.reload();" >关闭</button>
        <button type="button" id="save" class="btn btn-primary">保存</button>
    </div>
</form>

<script src="/static/plug-in/KindEditor/kindeditor.js" type="text/javascript"></script>
<script src="/static/plug-in/KindEditor/lang/zh_CN.js" type="text/javascript"></script>

<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#article_title").focus();
		
		// ajax方式提交form
		$("#articleForm").ajaxForm({
			dataType : "json"
		});
	});
	
	var editor;
	var editorItems = ['source', '|', 'justifyleft', 'justifycenter', 'justifyright',
	                      'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'clearhtml', '|',
	                      'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
	                      'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image',
	                      'table', 'hr', 'emoticons', 'link', 'unlink'
	                  ];
	KindEditor.ready(function(K) {
		editor = K.create('textarea[name="articleContent.content"]', {
			allowFileManager : true,
			items : editorItems,
			imageUploadJson:'${ctx}/component/kindeditor/uploadImage'
		});
	});
	
	// 保存
	$('#save').click(function(){
		$("#articleForm").attr("action","/article/detail/${action}");

		$("#articleForm").ajaxSubmit(
			function(data) {
	        	if(data){
	        		if('0000' == data.code){
	        			// $('#message').text("保存成功");
		            	alert("保存成功");
	        		}else if('0001' == data.code){
	        			// $('#message').text("您的操作超时，请重试！");
		            	alert("您的操作超时，请重试！");
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
