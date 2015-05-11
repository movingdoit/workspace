$(document).ready(function(){
	// Form Validation
	$("#password_validate").validate({
		rules:{
			pwd:{
				required: true,
				minlength:6,
				maxlength:20,
                remote: {
                    url: "check.php",
                    type: "post",
                    data: {
                        pwd: function() {
                            return $( "#pwd" ).val();
                        }
                    }
                }
			},
            pwd1:{
                required: true,
                minlength:6,
                maxlength:20
            },
			pwd2:{
				required:true,
				minlength:6,
				maxlength:20,
				equalTo:"#pwd1"
			}
		},
		errorClass: "help-inline",
		errorElement: "span",
		highlight:function(element, errorClass, validClass) {
            $(element).parents('.control-group').addClass('success');
			$(element).parents('.control-group').addClass('error');
		},
		unhighlight: function(element, errorClass, validClass) {
			$(element).parents('.control-group').removeClass('error');
			$(element).parents('.control-group').addClass('success');
		}
	});
});
