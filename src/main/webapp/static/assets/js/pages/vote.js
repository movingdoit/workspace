$(function(){
   /*
   * 新增自定义模块
   * */
    $('#J_addVoteModule').click(function(e){
        e.preventDefault();
        var moduleLen = $('.module-wrap').length;
        if (moduleLen == 2) {
            alert('最多只能增加两个自定义模块');
            return false;
        }
        var $step = $(this).parents('.step');
        var _html = '<div id="J_module_'+(moduleLen+1)+'" class="module-wrap" moduleid="'+(moduleLen+1)+'">'+
                        '<div class="control-group">'+
                            '<label class="control-label">模块名称 :</label>'+
                            '<div class="controls">'+
                                '<input type="text" class="span3" data-rule-required="true" data-rule-maxlength="5">'+
                            '</div>'+
                        '</div>'+
                        '<div class="control-group">'+
                            '<label class="control-label">模块指向 :</label>'+
                            '<div class="controls">'+
                                '<select name="type" class="input-medium J_directType">'+
                                    '<option value="">选择类型</option>'+
                                    '<option value="cms">文章</option>'+
                                    '<option value="link">链接</option>'+
                                '</select>'+
                                '<span class="help-inline hide J_chooseCms"><a href="javascript:void(0)" class="btn btn-mini red">请选择文章 <i class="icon-edit"></i></a></span>'+
                            '</div>'+
                        '</div>'+
                        '<div class="control-group r-module hide J_cms">'+
                            '<label class="control-label">已选文章 :</label>'+
                            '<div class="controls J_cmsResult">'+
                                '<input type="text" name="txt" class="wizard-ignore" value="" disabled>'+
                                '<input type="hidden" name="cat_id" value="">'+
                                '<input type="hidden" name="a_id" value="">'+
                            '</div>'+
                        '</div>'+
                        '<div class="control-group r-module hide J_link">'+
                            '<label class="control-label"><i class="red">*</i>  外链地址 :</label>'+
                            '<div class="controls">'+
                            '<input type="url" name="link" value="" class="input-xlarge" data-rule-required="true" data-rule-url="true">'+
                            '<span class="help-inline">（例如：http://www.duomi.me）</span>'+
                            '</div>'+
                        '</div>'+
                    '</div>';
        $step.append(_html);
    });

    /*
    * 模块指向
    * */
    $('.J_chooseCms').live('click',function(){
        var moduleid = $(this).parents('.module-wrap').attr('moduleid');
        $('#cmsCatChoose').attr('moduleid',moduleid).show();
    });
    $('.J_directType').live('change',function(){
        var $parent = $(this).parents('.module-wrap');
        var moduleid = $parent.attr('moduleid');
        var $directWrap = $parent.find('.J_'+this.value);
        if($directWrap[0]){
            $directWrap.slideDown().siblings('.r-module').hide();
        }else{
            $(this).parents('.control-group').siblings('.r-module').hide();
        }
        if(this.value == 'bbs') {
            $(this).siblings('span.J_chooseCms').show();
            $('#cmsCatChoose').attr('moduleid',moduleid).show();
        } else {
            $(this).siblings('span.J_chooseCms').hide();
            $('#cmsCatChoose').hide();
        }
    });

    /*
    * 弹窗选择文章分类
    * */

     $('#cmsCatChoose input[type=radio]').click(function(){
        var _value = '',_catId,_cmsId;
        _value += $(this).attr('title');
        _catId = $(this).val();
        var moduleid = $(this).parents('#cmsCatChoose').attr('moduleid');
        var cmsResult = $('#J_module_'+moduleid).find('.J_cmsResult');
        cmsResult.find('input[name="cat_id"]').val(_catId);
        $('#cmsChooseModal').modal('show');
        $('#chooseOK').one('click',function(){
            var $cmsChecked = $('#cmsChooseModal input[type="radio"][name="choose"]:checked');
            _cmsId = $cmsChecked.val();
            if(_cmsId) {
                _value += '--'+$cmsChecked.attr('title');
                alert(_value);
                cmsResult.find('input[name="a_id"]').val(_cmsId);
            } else {
                cmsResult.find('input[name="a_id"]').val('');
            }
            cmsResult.find('input[name="txt"]').val(_value);
            $('#cmsCatChoose').hide();
            $('#cmsChooseModal').modal('hide');
        });
    });

    /*
    * 伪删除
    * */
    $('.J_del').on('click',function(){
        $(this).parents('tr').remove();
    });
});

/*
 * 追加投票选项
 * */
$("#J_addVoteOptFrom").validate({
    submitHandler: function(form) {
        var formData = $(form).serialize();
        var xmlRequest = $.ajax({
            type: "POST",
            url: "assets/ajax/data.json",
            data: formData,
            dataType: "json"
        });
        xmlRequest.done(function(data){
            var html = '<tr>'+
                '<td>'+data.optid+'</td>'+
                '<td>'+data.opttit+'</td>'+
                '<td><img src="'+data.imgurl+'"></td>'+
                '<td><a href="#" class="btn btn-mini">编辑</a>  <a href="#" class="btn btn-mini J_del">删除</a></td>'+
                '</tr>';
            $('#J_voteOptList').append(html);
            $('#addVoteOptionModal').modal('hide');
        });
    }
});