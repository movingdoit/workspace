//------------- blank.js -------------//
$(document).ready(function() {

	//------------- Create success msg if form is submit -------------//
 	function createSuccessMsg (loc, msg) {
		loc.append(
			'<div class="alert alert-success"><button type="button" class="close" data-dismiss="alert">&times;</button><strong><i class="im-checkmark3 s24"></i> Well done!</strong> '+ msg + ' </div>'
		);
	}

	//------------- Wizard with validation -------------//
 	$("#wizard").formwizard({
	 	formPluginEnabled: true,
	 	validationEnabled: true,
	 	validationOptions: {
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
	 		rules: {
	 			firstname: {
	 				required: true
	 			},
	 			email: {
	 				required: true,
	 				email: true
	 			},
	 			username: {
	 				required: true
	 			},
	 			password: {
	 				required: true,
	 				minlength: 5
	 			},
	 			password_2: {
	 				required: true,
					minlength: 5,
					equalTo: "#password"
	 			}

	 		}, 
	 		messages: {
	 			firstname: {
	 				required: "I need to know your first name Sir"
	 			},
	 			email: {
	 				required: "You email is required Sir"
	 			}
	 		},
            highlight:function(element, errorClass, validClass) {
                $(element).parents('.control-group').removeClass('success error').addClass('error');
            },
            unhighlight: function(element, errorClass, validClass) {
                $(element).parents('.control-group').removeClass('error');
                $(element).parents('.control-group').addClass('success');
            }
	 	},
	 	focusFirstInput : true,
	 	formOptions :{
			success: function(data){
				//produce success message
				createSuccessMsg($("#wizard .msg"), "You successfully submit this form");
			},
			resetForm: false
	 	},
	 	disableUIStyles: true,
	 	showSteps: true //show the step
	});	
 	
});