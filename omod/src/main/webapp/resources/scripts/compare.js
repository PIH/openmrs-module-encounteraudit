$(document).ready(function() {
	// parse initial data (old method)
    // dataInitial = JSON.parse(JSON.stringify(jQuery('#htmlform').serializeArray()));

    $( ":button" ).replaceWith( '<input type="button" class="submitButton" value="Audit" onClick="auditHtmlForm()"/>' );

    // parse initial data (create objects)
        // constructor
    dataInitial = {};
    dataInitial.list = [];
    function formObsInitial(element, name, value, ans_concept_string, type) {
        this.element = element;
        this.name = name;
        this.value = value;
        this.ans_concept_string = ans_concept_string;
        this.type = type;
        dataInitial[element] = this;
        dataInitial.list[dataInitial.list.length] = element;
    }
        // individual obs
    //w5 = new formObsInitial('w5','Encounter Date','',[],'value_datetime');
    w8 = new formObsInitial('w8','Height',178,[],'value_numeric');
    w10 = new formObsInitial('w10','Weight',77,[],'value_numeric');
    w12 = new formObsInitial('w12','Regimen',8164,'5A: TDF + 3TC + EFV','value_coded');
    w14 = new formObsInitial('w14','Side Effects',1066,'No','value_coded');
    w26 = new formObsInitial('w26','TB Status',7454,'None','value_coded');
    w28 = new formObsInitial('w28','Pill Count',1,[],'value_numeric');
    w30 = new formObsInitial('w30','Missed Doses',0,[],'value_numeric');
    w32 = new formObsInitial('w32','ARVs Given',90,[],'value_numeric');
    w34 = new formObsInitial('w34','Guardian Present','false',[],'value_boolean');
    w36 = new formObsInitial('w36','CPT Given',90,[],'value_numeric');
    w38 = new formObsInitial('w38','Depo Provera Given',1065,[],'value_coded');
    w40 = new formObsInitial('w40','Condoms Given',[],[],'value_numeric');
    //w42 = new formObsInitial('w42','Appointment Date','',[],'value_datetime');

    // call function to clear fields 
    clear_form_elements('#htmlform');

    // submit actions
    $('.submitButton').click(function() {
    	// parse audit data
    	auditdata = JSON.parse(JSON.stringify(jQuery('#htmlform').serializeArray()));
        compare_obs_array(dataInitial,auditdata)
        if (add.length > 0) {
            $('#dialog p').remove(); // remove any text and repopulate
            $('#dialog ul').remove(); // remove any text and repopulate
            $('#dialog').append('<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span> The following values are different:</p><p><ul>' + add + '</ul></p>')
            $( '#dialog' ).dialog('open');
        };
    })

    // function to clear the form
    function clear_form_elements(ele) {
        $(ele).find(':input').each(function() {
            switch(this.type) {
                case 'password':
                case 'select-multiple':
                case 'select-one':
                case 'text':
                case 'textarea':
                    $(this).val('');
                    $(this).css({'background-color' : 'white'});
                    break;
                case 'checkbox':
                case 'radio':
                    this.checked = false;
            }
        });
    }

    // function to compare the data
    function compare_obs_array(dataInitial,auditdata) {
        // compare fields (nested loop - vectorize function?)
        add = []; // initialize results vector
        // loop through initial obs
        for (i = 0; i < dataInitial.list.length; i++) {
            // compare to all audit obs
            for (j = 0; j < auditdata.length; j++) {
                if (isNaN(dataInitial[dataInitial.list[i]].value)) { 
                    // not a number handling
                    if (dataInitial.list[i] == auditdata[j].name) {
                        // obs ids match
                        if (dataInitial[dataInitial.list[i]].value != auditdata[j].value) {
                            // values do not match
                            if (dataInitial[dataInitial.list[i]].ans_concept_string.length == 0) {
                                add = add += '<li> <b>' + dataInitial[dataInitial.list[i]].name + '</b> : ' + dataInitial[dataInitial.list[i]].value + '. ';
                            } else {
                                add = add += '<li> <b>' + dataInitial[dataInitial.list[i]].name + '</b> : ' + dataInitial[dataInitial.list[i]].ans_concept_string + '. ';
                            }
                            $('#' + dataInitial.list[i]).css({'background-color' : 'red', 'opacity' : '0.5'});
                        } else {
                            $('#' + dataInitial.list[i]).css({'background-color' : '#00FF33', 'opacity' : '0.5'});
                        }
                    }
                } else {
                    // number handling
                    if (dataInitial.list[i] == auditdata[j].name) {
                        if (+dataInitial[dataInitial.list[i]].value != +auditdata[j].value) {
                            $('#' + dataInitial.list[i]).css({'background-color' : 'red', 'opacity' : '0.5'});
                            if (dataInitial[dataInitial.list[i]].ans_concept_string.length == 0) {
                                add = add += '<li> <b>' + dataInitial[dataInitial.list[i]].name + '</b> : ' + dataInitial[dataInitial.list[i]].value + '.</li> ';
                            } else {
                                add = add += '<li> <b>' + dataInitial[dataInitial.list[i]].name + '</b> : ' + dataInitial[dataInitial.list[i]].ans_concept_string + '.</li> ';
                            }
                        } else {
                            $('#' + dataInitial.list[i]).css({'background-color' : '#00FF33', 'opacity' : '0.5'});
                        }
                    }
                }
            }
        }

        // dialog function
        $( '#dialog' ).dialog( { 
            autoOpen: false,
            position: { my: 'top', at: 'top+30' },
            buttons: {
                "Audit": function() {
                    $(this).dialog( "close" );
                    },
                "Edit": function() {
                    $(this).dialog("close");
                },
                "Cancel": function() {
                    $(this).dialog( "close" );
                    clear_form_elements('#htmlform');
                    }
                },
            // height: 140,
            width: 500    
        } );

    }
})


// http://stackoverflow.com/questions/23287067/converting-serialized-forms-data-to-json-object