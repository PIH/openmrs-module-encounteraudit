$(document).ready(function() {
	// parse initial data
    datainitial = JSON.parse(JSON.stringify(jQuery('#htmlform').serializeArray()));

    // call function to clear fields 
    clear_form_elements('#htmlform');

    // audit function
    $('.submitButton').click(function() {
    	// parse audit data
    	auditdata = JSON.parse(JSON.stringify(jQuery('#htmlform').serializeArray()));
        compare_obs_array(datainitial,auditdata)
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
    function compare_obs_array(datainitial,auditdata) {
        // compare fields (nested loop - vectorize function?)
        add = []; // initialize results vector
        // loop through initial obs
        for (i = 0; i < datainitial.length; i++) {
            // compare to all audit obs
            for (j = 0; j < auditdata.length; j++) {
                if (isNaN(datainitial[i].value)) {
                    // not a number handling
                    if (datainitial[i].name == auditdata[j].name) {
                        // obs ids match
                        if (datainitial[i].value != auditdata[j].value) {
                            // values do not match
                            var add = add += '\n ' + datainitial[i].name + ' : ' + datainitial[i].value + '. ';
                            $('#' + datainitial[i].name).css({'background-color' : 'red', 'opacity' : '0.5'});
                        } else {
                            $('#' + datainitial[i].name).css({'background-color' : '#00FF33', 'opacity' : '0.5'});
                        }
                    }
                } else {
                    // number handling
                    if (datainitial[i].name == auditdata[j].name) {
                        if (+datainitial[i].value != +auditdata[j].value) {
                            $('#' + datainitial[i].name).css({'background-color' : 'red', 'opacity' : '0.5'});
                         add = add += '\n ' + datainitial[i].name + ' : ' + datainitial[i].value + '. ';
                        } else {
                            $('#' + datainitial[i].name).css({'background-color' : '#00FF33', 'opacity' : '0.5'});
                        }
                    }
                }
            }
        }
        if (add.length > 0) {
           alert('The following values are different: \n' + add);
           console.log(add);
        };
    }
})


// http://stackoverflow.com/questions/23287067/converting-serialized-forms-data-to-json-object