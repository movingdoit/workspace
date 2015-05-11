
$(document).ready(function(){
	$("th input:checkbox").change(function() {
		var checkedStatus = this.checked;
		var checkbox = $(this).parents('.table').find('tr td:first-child input:checkbox');
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
});
