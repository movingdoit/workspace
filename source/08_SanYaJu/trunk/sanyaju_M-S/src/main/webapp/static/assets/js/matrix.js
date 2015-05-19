$(document).ready(function(){
	// === Sidebar navigation === //
	
	$('.submenu > a').click(function(e)
	{
		e.preventDefault();
		var submenu = $(this).siblings('ul');
		var li = $(this).parents('li');
		var submenus = $('#sidebar li.submenu ul');
		var submenus_parents = $('#sidebar li.submenu');
		if(li.hasClass('open'))
		{
			if(($(window).width() > 768) || ($(window).width() < 479)) {
				submenu.slideUp();
			} else {
				submenu.fadeOut(250);
			}
			li.removeClass('open');
		} else 
		{
			if(($(window).width() > 768) || ($(window).width() < 479)) {
				submenus.slideUp();			
				submenu.slideDown();
			} else {
				submenus.fadeOut(250);			
				submenu.fadeIn(250);
			}
			submenus_parents.removeClass('open');		
			li.addClass('open');	
		}
	});
	
	var ul = $('#sidebar > ul');
	
	$('#sidebar > a').click(function(e)
	{
		e.preventDefault();
		var sidebar = $('#sidebar');
		if(sidebar.hasClass('open'))
		{
			sidebar.removeClass('open');
			ul.slideUp(250);
		} else 
		{
			sidebar.addClass('open');
			ul.slideDown(250);
		}
	});
	
	// === Resize window related === //
	$(window).resize(function()
	{
		if($(window).width() > 479)
		{
			ul.css({'display':'block'});	
			$('#content-header .btn-group').css({width:'auto'});		
		}
		if($(window).width() < 479)
		{
			ul.css({'display':'none'});
			fix_position();
		}
		if($(window).width() > 768)
		{
			$('#user-nav > ul').css({width:'auto',margin:'0'});
            $('#content-header .btn-group').css({width:'auto'});
		}
	});
	
	if($(window).width() < 468)
	{
		ul.css({'display':'none'});
		fix_position();
	}
	
	if($(window).width() > 479)
	{
	   $('#content-header .btn-group').css({width:'auto'});
		ul.css({'display':'block'});
	}
	
	// === Tooltips === //
	$('.tip').tooltip();	
	$('.tip-left').tooltip({ placement: 'left' });	
	$('.tip-right').tooltip({ placement: 'right' });	
	$('.tip-top').tooltip({ placement: 'top' });	
	$('.tip-bottom').tooltip({ placement: 'bottom' });	
	
	// === Search input typeahead === //
	$('#search input[type=text]').typeahead({
		source: ['Dashboard','Form elements','Common Elements','Validation','Wizard','Buttons','Icons','Interface elements','Support','Calendar','Gallery','Reports','Charts','Graphs','Widgets'],
		items: 4
	});
	
	// === Fixes the position of buttons group in content header and top user navigation === //
	function fix_position()
	{
		var uwidth = $('#user-nav > ul').width();
		$('#user-nav > ul').css({width:uwidth,'margin-left':'-' + uwidth / 2 + 'px'});
        
        var cwidth = $('#content-header .btn-group').width();
        $('#content-header .btn-group').css({width:cwidth,'margin-left':'-' + uwidth / 2 + 'px'});
	}
	
	// === Style switcher === //
	$('#style-switcher i').click(function()
	{
		if($(this).hasClass('open'))
		{
			$(this).parent().animate({marginRight:'-=190'});
			$(this).removeClass('open');
		} else 
		{
			$(this).parent().animate({marginRight:'+=190'});
			$(this).addClass('open');
		}
		$(this).toggleClass('icon-arrow-left');
		$(this).toggleClass('icon-arrow-right');
	});
	
	$('#style-switcher a').click(function()
	{
		var style = $(this).attr('href').replace('#','');
		$('.skin-color').attr('href','css/maruti.'+style+'.css');
		$(this).siblings('a').css({'border-color':'transparent'});
		$(this).css({'border-color':'#aaaaaa'});
	});
	
	$('.lightbox_trigger').click(function(e) {
		
		e.preventDefault();
		
		var image_href = $(this).attr("href");
		
		if ($('#lightbox').length > 0) {
			
			$('#imgbox').html('<img src="' + image_href + '" /><p><i class="icon-remove icon-white"></i></p>');
		   	
			$('#lightbox').slideDown(500);
		}
		
		else { 
			var lightbox = 
			'<div id="lightbox" style="display:none;">' +
				'<div id="imgbox"><img src="' + image_href +'" />' + 
					'<p><i class="icon-remove icon-white"></i></p>' +
				'</div>' +	
			'</div>';
				
			$('body').append(lightbox);
			$('#lightbox').slideDown(500);
		}
		
	});
	

	$('#lightbox').live('click', function() { 
		$('#lightbox').hide(200);
	});

    $('#chooseCMS').click(function(){
        $('#cmsCatChoose').show();
    });
    $('#choosePRO').click(function(){
    	$('#proCatChoose').show();
    });
    
    $('#type').change(function(){
        if($('#r_'+this.value)[0]){
            $('#r_'+this.value).slideDown().siblings('.r-module').hide();
            if(this.value == 'bbs') {
            	$('#chooseCMS').show();
            	$('#cmsCatChoose').show();
            	$('#proCatChoose').hide();
                $('#choosePRO').hide();
            } else {
                $('#cmsCatChoose').hide();
                $('#proCatChoose').hide();
                $('#chooseCMS').hide();
                $('#choosePRO').hide();
            }
        }else{
            $(this).parents('.control-group').siblings('.r-module').hide();
            $('#cmsCatChoose').hide();
            $('#proCatChoose').hide();
            $('#chooseCMS').hide();
            $('#choosePRO').hide();
        }
    });

    $('#articleCatChoose label').click(function(){
        var _value = '',_catId,_articleId;
        var $catChecked = $(this).find('input[type="radio"]:checked');
        _value += $catChecked.attr('data-title');
        _catId = $catChecked.val();
        $('#articleResult input[name="cat_id"]').val(_catId);
        $('#articleChooseModal').modal();
        $('#chooseOK').click(function(){
            var $articleChecked = $('#articleChooseModal input[type="radio"][name="choose"]:checked');
            _articleId = $articleChecked.val();
            if(_articleId) {
                _value += '--'+$articleChecked.attr('data-title');
                $('#articleResult input[name="a_id"]').val(_articleId);
            } else {
                $('#articleResult input[name="a_id"]').val('');
            }
            $('#articleResult  input[name="txt"]').val(_value);
            $('#articleCatChoose').hide();
        });
    });

    /*
    * 增加参数
    * */
    $('#argList .icon-plus').live('click',function(e){
        e.preventDefault();
        var $this = $(this)
            ,$p = $this.parents('p');
        var $html = '<p><input type="file" name="files"><input type="url" id="link" name="attrList" value="" class="input-xlarge" data-rule-required="true" data-rule-url="true" placeholder="输入轮播图链接地址">'+
                        ' <span class="help-inline">'+
                            ' <a href="#" class="icon icon-plus green" title="增加字段"></a>'+
                            ' <a href="#" class="icon icon-minus green" title="删除字段"></a>'+
                            ' <a href="#" class="icon icon-arrow-up blue upbtn" title="向上移"></a>'+
                            ' <a href="#" class="icon icon-arrow-down blue downbtn" title="向下移"></a>'+
                        '</span>'+
                    '</p>';
        $p.after($html);
    });
    
    /*
     * 删除参数
     * */
    $('#argList .icon-minus').live('click',function(e){
        e.preventDefault();
        var $this = $(this)
            ,$p = $this.parents('p')
            ,$parent = $this.parents('#argList')
            ,$limit = $parent.data('limit')
            ,$pLength = $this.parents('#argList').find('p').length;
        if ($limit && $pLength < $limit+1) {
            alert('至少需要'+$limit+'项');
            return false;
        } else {
            $p.remove();
        }
    });
    
    /*
     * 参数上移
     * */
    $("#argList .upbtn").live('click',function (e) {
        e.preventDefault();
        var pLength = $("#argList p").length;
        var $p = $(this).parents("p");
        if ($p.index() != 0) {
            $p.prev().before($p);
        } else {
            $("#argList p").eq(pLength-1).after($p);
        }
    });
    
    /*
     * 参数下移
     * */
    $("#argList .downbtn").live('click',function (e) {
        e.preventDefault();
        var pLength = $("#argList p").length;
        var $p = $(this).parents("p");
        if ($p.index() != pLength - 1) {
            $p.next().after($p);
        } else {
            $("#argList p").eq(0).before($p);
        }
    });
    
    
    /*
     * 多选项操作
     * 增加参数
     * */
    $('.optList .icon-plus').live('click',function(e){
    	e.preventDefault();
    	var $this = $(this),$p = $this.parents('p'), $optValueSize = $this.parents('td').find('.optValueSize');
    	var $html = '<p><input type="text" name="optValue" value="">'+
    	' <span class="help-inline">'+
    	' <a href="#" class="icon icon-plus green" title="增加字段"></a>'+
    	' <a href="#" class="icon icon-minus green" title="删除字段"></a>'+
    	' <a href="#" class="icon icon-arrow-up blue upbtn" title="向上移"></a>'+
    	' <a href="#" class="icon icon-arrow-down blue downbtn" title="向下移"></a>'+
    	'</span>'+
    	'</p>';
    	$p.after($html);
    	$optValueSize.val(Number($optValueSize.val()) + 1);
    });
    
    /*
     * 多选项操作
     * 删除参数
     * */
    $('.optList .icon-minus').live('click',function(e){
    	e.preventDefault();
    	var $this = $(this)
    	,$p = $this.parents('p')
    	,$parent = $this.parents('.optList')
    	,$optValueSize = $this.parents('td').find('.optValueSize')
    	,$limit = $parent.data('limit')
    	,$pLength = $this.parents('.optList').find('p').length;
    	if ($limit && $pLength < $limit+1) {
    		alert('至少需要'+$limit+'项');
    		return false;
    	} else {
    		$p.remove();
    		$optValueSize.val(Number($optValueSize.val()) - 1);
    	}
    });
    
    /*
     * 多选项操作
     * 参数上移
     * */
    $(".optList .upbtn").live('click',function (e) {
        e.preventDefault();
        var $this = $(this)
            ,$parent = $this.parents('.optList')
            ,pLength = $parent.find("p").length
            ,$p = $this.parents("p");
        if (($p.index()-2) != 0) {
            $p.prev().before($p);
        } else {
            $parent.find("p").eq(pLength-1).after($p);
        }
    });
    
    /*
     * 多选项操作
     * 参数下移
     * */
    $(".optList .downbtn").live('click',function (e) {
        e.preventDefault();
        var $this = $(this)
            ,$parent = $this.parents('.optList')
            ,pLength = $parent.find("p").length
            ,$p = $this.parents("p");
        if (($p.index()-2) != pLength - 1) {
            $p.next().after($p);
        } else {
            $parent.find("p").eq(0).before($p);
        }
    });    
    
    
    
    
    $('#radioTab input[type="radio"]').change(function () {
        var $this = $(this)
            ,$eTarget = $this.data('target');
        window.location.href = $eTarget;
    });
    $('#chooseList a.icon-minus').live('click',function(e){
        e.preventDefault();
        var $this = $(this)
            ,$parent = $this.parents('p');
        if ( $('#chooseList p').length == 1 ) {
            $('#chooseList').slideUp('fast',function(){
                $(this).hide();
            });
        }
        $parent.slideUp('fast',function(){
            $(this).remove()
        });
    });
    $('#addPicArt').click(function(){
       $(this).parents('.control-group').next().slideDown('fast');
    });
    $("#file").change(function(){  // 当 id 为 file 的对象发生变化时
        $("#fileName").val($("#file").val().match(/.*\\(.*)/)[1]);  //将 #file 的值赋给 #a
    });
    $('#tplChoose input[type="radio"]').change(function(){
       var $this = $(this);
        if($this[0].checked) {
            $this.parents('li').addClass('active').siblings('li').removeClass('active');
        }
    });

    /*
    * 预约订单 -- 增加文本字段
    * */
    $('#addTxtField').click(function(e){
        var $this = $(this);
        e.preventDefault();
        var _html = '<tr>'+
	        '<td>文本<input type="hidden" name="dataType" value="1"><input type="hidden" name="isDefault" value="0"></td>'+
	        '<td><input type="text" name="label" value=""></td>'+
	        '<td><input type="text" name="defValue" value=""></td>'+
	        '+<td><label><input type="checkbox" onclick="checked_Y(this)" name="isDisplay" value="1" checked>显示  <input type="checkbox" class="checked_N" name="isDisplay" value="0" style="display: none"></label></td>'+
	        '<td><label><input type="checkbox" onclick="checked_Y(this)" name="isRequired" value="1" checked>必填 <input type="checkbox" class="checked_N" name="isRequired" value="0" style="display: none"></label></td>'+
            '<td><a href="#" class="btn btn-info btn-mini upbtn">上移</a>  <a href="#" class="btn btn-success btn-mini downbtn">下移</a>  <a href="#" class="btn btn-mini delbtn">删除</a></td>'+
            '</tr>';
        
        $this.parents('tr').before(_html);
    });

    /*
     * 预约订单 -- 增加下拉框字段
     * */
    $('#addSelectField').click(function(e){
        var $this = $(this);
        e.preventDefault();
        var _html = '<tr>'+
            '<td>下拉框<input type="hidden" name="dataType" value="6"><input type="hidden" name="isDefault" value="0"></td>'+
            '<td><input type="text" name="label" value=""></td>'+
            '<td class="optList" data-limit="2"><input type="hidden" name="defValue" value=""><input type="hidden" class="optValueSize" name="optValueSize" value="2">'+
	            '<p><input type="text" name="optValue" value=""> <span class="help-inline"><a href="#" class="icon icon-plus green"></a> <a href="#" class="icon icon-minus green"></a> <a href="#" class="icon icon-arrow-up blue upbtn"></a> <a href="#" class="icon icon-arrow-down blue downbtn"></a></span></p>'+
	            '<p><input type="text" name="optValue" value=""> <span class="help-inline"><a href="#" class="icon icon-plus green"></a> <a href="#" class="icon icon-minus green"></a> <a href="#" class="icon icon-arrow-up blue upbtn"></a> <a href="#" class="icon icon-arrow-down blue downbtn"></a></span></p>' +
            '</td>'+
            '<td><label><input type="checkbox" onclick="checked_Y(this)" name="isDisplay" value="1" checked>显示 <input type="checkbox" class="checked_N" name="isDisplay" value="0" style="display: none"></label></td>'+
            '<td><label><input type="checkbox" onclick="checked_Y(this)" name="isRequired" value="1" checked>必填 <input type="checkbox" class="checked_N" name="isRequired" value="0" style="display: none"></label></td>'+
            '<td><a href="#" class="btn btn-info btn-mini upbtn">上移</a>  <a href="#" class="btn btn-success btn-mini downbtn">下移</a>  <a href="#" class="btn btn-mini delbtn">删除</a></td>'+
            '</tr>';
        $this.parents('tr').before(_html);
    });

    /*
    * 预约订单 -- 上移字段位置
    * */
    $('#orderEditTable .btn.upbtn').live('click',function(e){
        e.preventDefault();
        var $this = $(this)
            ,$parentTr = $this.parents("tr")
            ,$btnGroup = $('#btnGroup');
        if ($parentTr.index() != 0) {
            $parentTr.prev().before($parentTr);
        } else {
            $btnGroup.before($parentTr);
        }
    });

    /*
    * 预约订单 -- 下移字段位置
    * */
    $('#orderEditTable .btn.downbtn').live('click',function(e){
        e.preventDefault();
        var $this = $(this)
            ,$parentTr = $this.parents("tr")
            ,$parentTable = $this.parents('tbody')
            ,$btnGroup = $('#btnGroup')
            ,trLength = $parentTable.find('tr').length;
        if ($parentTr.index() != trLength - 2) {
            $parentTr.next().after($parentTr);
        } else {
            $parentTable.prepend($parentTr);
        }
    });

    /*
     * 预约订单 -- 删除字段
     * */
    $('#orderEditTable .delbtn').live('click',function(e){
        e.preventDefault();
        var $this = $(this)
            ,$parentTr = $this.parents("tr");
        $parentTr.remove();
    });

    /*
    * 复选框全选
    * */
    $("#checkAll").change(function() {
        var checkedStatus = this.checked;
        var checkbox = $(this).parents('.controls').find('input:checkbox');
        checkbox.each(function() {
            this.checked = checkedStatus;
            if (checkedStatus == this.checked) {
                $(this).attr('unchecked');
            }
            if (this.checked) {
                $(this).attr('checked');
            }
        });
    });
    
    

     /*
     * tabs切换
     * */
     $('.tabs-wrap').find('input[type="radio"]').click(function(){
        var target = $.trim($(this).data('target'));
         if (target) {
             if (target == '#tab-1'|| target == '#tab-2') {
                 $(target).addClass('active inline-block').siblings('.tab-pane').removeClass('active inline-block');
                 if (target == '#tab-1') {
                	 $('#membershipCardDef_bgImage').val($('#tab-1').val()); 
	        		 $('#J_mcard').attr('src',$('#tab-1').val());
                 }else if (target == '#tab-2') {
                	 if('' == $('#membershipCardDef_bgImage_custom').val()){
                		 $('#membershipCardDef_bgImage_custom').val($('#membershipCardDef_bgImage').val());
                	 }
            		 $('#membershipCardDef_bgImage').val($('#membershipCardDef_bgImage_custom').val()); 
            		 $('#J_mcard').attr('src',$('#membershipCardDef_bgImage_custom').val());
                 }
             }else {
                 $(target).addClass('active').siblings('.tab-pane').removeClass('active');
             }
         }else {
             $(this).parents('.tabs-wrap').find('.tab-pane').removeClass('active');
         }
     });


     /*
     * 会员卡等级预览
     * */
     $('#J_mcardLevel').change(function(){
         $('#J_levelName').html($(this).find("option:selected").text());
     });

     /*
     * 会员卡背景模板切换预览
     * */
     $('#tab-1').change(function(){
    	$('#membershipCardDef_bgImage').val($(this).val());
        $('#J_mcard').attr('src',$(this).val());
     });
});

function countDown(secs,surl,urlname){
    var str = '';
    if ( secs ) {
        if ( surl && urlname != '' ) {
            str += '系统将在 <span class="red">'+ secs + '</span> 秒后自动会返回 <a class="blue" href="'+surl+'">'+urlname+'</a>';
            if(--secs>0){
                setTimeout("countDown("+secs+",'"+surl+"','"+urlname+"')",1000);
            }
            else{
                location.href=surl;
            }
        } else {
            str += '页面将在 <span class="red">'+ secs + '</span> 秒后自动关闭';
            if(--secs>0){
                setTimeout("countDown("+secs+")",1000);
            }
            else{
                $('.modal').modal('hide');
            }
        }
    }
    var autoDir = document.getElementById('autoDir');
    autoDir.innerHTML = str;
}



