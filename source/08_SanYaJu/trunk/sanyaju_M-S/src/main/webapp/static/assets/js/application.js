/**
 * Created by Ann on 2014/7/24 0024.
 */
var DM = {};
DM.form = {
    validate: function () {
        var $from = $("form.form-validate");
        if ($from.length > 0) {
            $from.each(function () {
                $(this).validate({
                    errorPlacement: function(error, element) {
                        wrap = element.parent();
                        if (wrap.hasClass('date')) {
                            error.insertAfter(wrap);
                        } else {
                            error.insertAfter(element);
                        }
                    },
                    errorClass: "help-block",
                    errorElement: "span",
                    highlight:function(element, errorClass, validClass) {
                        $(element).parents('.control-group').removeClass('success error').addClass('error');
                    },
                    unhighlight: function(element, errorClass, validClass) {
                        $(element).parents('.control-group').removeClass('error');
                        $(element).parents('.control-group').addClass('success');
                    },
                    submitHandler: function(form) {
                        form.submit();
                    }
                })
            })
        }
    },
    init: function () {
        this.validate();
    }
};
$(function () {
    DM.form.init()
});
if (!String.prototype.format) {
    String.prototype.format = function () {
        var args = arguments;
        return this.replace(/{(\d+)}/g, function (match, number) {
            return typeof args[number] != 'undefined' ? args[number] : match
        })
    }
};
if (!Date.prototype.format) {
    Date.prototype.format = function (format) {
        var o = {
            "M+": this.getMonth() + 1,
            "d+": this.getDate(),
            "h+": this.getHours(),
            "m+": this.getMinutes(),
            "s+": this.getSeconds(),
            "q+": Math.floor((this.getMonth() + 3) / 3),
            "S": this.getMilliseconds()
        };
        if (/(y+)/.test(format)) format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o) if (new RegExp("(" + k + ")").test(format)) format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
        return format
    }
};
