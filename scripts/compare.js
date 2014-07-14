$(document).ready(function() {
	// parse initial data
    datainitial = JSON.parse(JSON.stringify(jQuery('#htmlform').serializeArray()));

    // call function to clear fields 
    clear_form_elements('#htmlform');

    // audit function
    $('.submitButton').click(function() {
    	// parse audit data
    	auditdata = JSON.parse(JSON.stringify(jQuery('#htmlform').serializeArray()));

    	// compare fields (nested loop - vectorize function?)
        add = [];
    	for (i = 0; i < datainitial.length; i++) {
    		for (j = 0; j < auditdata.length; j++)
    			if (datainitial[i].name == auditdata[j].name) {
    				if (datainitial[i].value != auditdata[j].value) {
                        var add = add += '\n ' + datainitial[i].name + ' : ' + datainitial[i].value + '. ';
    				}
    			}
    	}
        if (add.length > 0) {
           alert('The following values are different: \n' + add);
            console.log(add);
        };
    })

    // clear the form here
    function clear_form_elements(ele) {

        $(ele).find(':input').each(function() {
            switch(this.type) {
                case 'password':
                case 'select-multiple':
                case 'select-one':
                case 'text':
                case 'textarea':
                    $(this).val('');
                    break;
                case 'checkbox':
                case 'radio':
                    this.checked = false;
            }
        });

    }
})


// http://stackoverflow.com/questions/23287067/converting-serialized-forms-data-to-json-object