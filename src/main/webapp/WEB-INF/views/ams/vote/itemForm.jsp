<%@ page contentType="text/html;charset=UTF-8" %>
	<div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4>新增投票选项</h4>
    </div>
    <form action="/ams/vote/item/update" id="addItemForm" method="post" class="form-horizontal form-validate" enctype="multipart/form-data">
        <div class="modal-body">
        	<div class="control-group">
                <label class="control-label"><i class="red">*</i> 选项编号 :</label>
                <div class="controls">
                    <input type="text" name="code" value="${voteItem.code }" class="span3" data-rule-required="true" data-rule-maxlength="10" placeholder="最多10个字符">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label"><i class="red">*</i> 选项标题 :</label>
                    <input type="hidden" name="id" class="span3" value="${voteItem.id }" data-rule-required="true" data-rule-maxlength="10" >
                    <input type="hidden" name="voteItem.id" class="span3" value="${actId }" data-rule-required="true" data-rule-maxlength="10" >
                <div class="controls">
                    <input type="text" name="title" value="${voteItem.title }" class="span3" data-rule-required="true" data-rule-maxlength="10" placeholder="最多10个字符">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">选项封面 :</label>
                <div class="controls">
                    <div class="fileupload fileupload-new" data-provides="fileupload">
                        <div class="fileupload-new thumbnail" style="width: 200px; height: 150px;"><img src="${(null != voteItem && voteItem.coverPic != null && voteItem.coverPic != '') ? voteItem.coverPic : '/static/assets/img/noimage.gif'}" /></div>
                        <div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>
                        <div>
                            <span class="btn btn-file"><span class="fileupload-new">选择图片</span><span class="fileupload-exists">更换</span><input type="file" name='file' /></span>
                            <a href="#" class="btn btn-file fileupload-exists" data-dismiss="fileupload">删除</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">详细介绍 :</label>
                <div class="controls">
                	<!-- 加载编辑器的容器 -->
					<script id="tt" name="voteItemText.text" style="height:300px" type="text/plain">${voteItem.voteItemText.text }</script>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
            <button type="submit" id="save" class="btn btn-primary">保存</button>
        </div>
    </form>
<script type="text/javascript">  
</script>