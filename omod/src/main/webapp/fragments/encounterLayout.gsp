<%
    def id = config.id
    def start = config.start
    def end = config.end
    def location = config.location
    def encountertype = config.encountertype
    def numofrecords = config.numofrecords
    def creatorId = config.creatorId
    def props = config.properties ?: ["encounterType", "encounterDatetime", "location", "provider"]
%>

<script>
    jq = jQuery;
    var jsProjects = [];
    var jsProjectParameters = [];

    <% if (projects) {
        projects.each { project ->
            def projectParameters = project.projectParameters
            if (projectParameters) { %>
                jsProjectParameters = [];
                <% projectParameters.each { projectParameter -> %>
                    jsProjectParameters.push({
                        parameterId:"${ projectParameter.parameter.id}",
                        parameterName:"${ projectParameter.parameter.name }",
                        parameterValue:"${ projectParameter.parameterValue }"
                    });
             <% }
            } %>
            jsProjects.push({
                projectId:"${ project.id}",
                projectName:"${ project.name }",
                projectDescription:"${ project.description }",
                projectParameters: jsProjectParameters});
     <% }
     } %>

    jq(document).ready(function() {
        jq( "#tabs" ).tabs();

        jq.findProject = function(projectId) {
            var project = null;
            if ( projectId.length > 0 ) {
                for (var i=0; i<jsProjects.length; i++) {
                    var projectItem = new Object();
                    projectItem = jsProjects[i];
                    if (projectItem.projectId == projectId) {
                        return projectItem;
                    }
                }
            }
            return project;
        }

        jq.parseDateFromString = function(dateString) {
            var d = new Date(dateString);
            var day = d.getDate();
            var month = parseInt(d.getMonth(), 10) + 1;
            var year = d.getFullYear();
            var displayDate = day + "-" + month + "-" + year;
            return displayDate;

        }
    });
</script>
<script>
    jq = jQuery;
    jq(document).ready(function() {
        jq("#projects li").click(function() {
            jq(".project_select").removeClass("project_select")

            jq("#projectName").val('');
            jq("#projectDescription").val('');
            jq("#startDateField-display").val('');
            jq("#endDateField-display").val('');
            jq('select#encounters-filterByLocation-field option').removeAttr("selected");
            jq('select#filterByEncounterType-field option').removeAttr("selected");
            jq('select#users-filterByUser-field option').removeAttr("selected");
            jq("#numofrecords").val('');
            jq( this ).toggleClass("project_select");
            var projectId = jq(this).attr("data-project-id");   

            var projectObject = new Object();
            projectObject = jq.findProject(projectId);
            if (projectObject != null ) {
                jq("#projectName").val(projectObject.projectName);
                jq("#projectId").val(projectObject.projectId);
                if (projectObject.projectDescription != 'null' &&  projectObject.projectDescription.length > 0) {
                    jq("#projectDescription").val(projectObject.projectDescription);
                }
                var projectParameters = projectObject.projectParameters;
                for (var i = 0; i < projectParameters.length; i++) {
                    var projectParameter = new Object();
                    projectParameter = projectParameters[i];
                    if (projectParameter.parameterName == 'start_date') {
                        parsedValue = projectParameter.parameterValue.substr(4, 6) + ' ' + projectParameter.parameterValue.substr(24, 28);
                        parsedDate = new Date(parsedValue);
                        day = parsedDate.getDate();
                        month = parsedDate.getMonth() + 1;
                        year = parsedDate.getFullYear().toString()
                        dateString = day.toString() + '-' + month.toString() + '-' + year.toString();;
                        jq("#startDateField-display").val(dateString);
                    } else if (projectParameter.parameterName == 'end_date') {
                        parsedValue = projectParameter.parameterValue.substr(4, 6) + ' ' + projectParameter.parameterValue.substr(24, 28);
                        parsedDate = new Date(parsedValue);
                        day = parsedDate.getDate();
                        month = parsedDate.getMonth() + 1;
                        year = parsedDate.getFullYear().toString()
                        dateString = day.toString() + '-' + month.toString() + '-' + year.toString();;
                        jq("#endDateField-display").val(dateString);
                    } else if (projectParameter.parameterName == 'location') {
                        jq("#encounters-filterByLocation-field option:contains(" + projectParameter.parameterValue + ")").attr("selected", "selected");
                    } else if (projectParameter.parameterName == 'encounter_type') {
                        jq("#filterByEncounterType-field option").filter(function() {
                            return jq(this).text() == projectParameter.parameterValue;
                        }).attr("selected", "selected");
                    } else if (projectParameter.parameterName == 'creator') {
                        jq("#users-filterByUser-field option[value=\"" + projectParameter.parameterValue + "\"]").attr("selected", "selected");
                    }
                    else if (projectParameter.parameterName == 'number_of_records') {
                        jq("#numofrecords").val(projectParameter.parameterValue);
                    }
                }
            }
        })
    })
</script>
<script>
jq = jQuery;

jq(function() {

    jq('#${ id }_button').click(function() {
        var encounterStartDate = jq("#startDateField-display").val();
        var encounterEndDate = jq("#endDateField-display").val();
        var jqStartDate = jq.datepicker.parseDate('dd-mm-yy', encounterStartDate);
        var jqEndDate = jq.datepicker.parseDate('dd-mm-yy', encounterEndDate);
        var jqFormatStartDate = jq.datepicker.formatDate('yy-mm-dd', jqStartDate);
        var jqFormatEndDate = jq.datepicker.formatDate('yy-mm-dd', jqEndDate);
        var encounterLocation = jq("#encounters-filterByLocation-field").val();
        var encounterType = jq("#filterByEncounterType-field").val();
        var numofrecords = jq("#numofrecords").val();
        var creatorId = jq("#users-filterByUser-field").val();

        var projectId = jq("#projectId").val();
        var projectName = jq("#projectName").val();
        var projectDescription = jq("#projectDescription").val();

        jq.getJSON('${ ui.actionLink("encounteraudit","encounterLayout","getAuditEncounters") }',
                                    {
                                        'start': jqFormatStartDate,
                                        'end': jqFormatEndDate,
                                        'location' : encounterLocation,
                                        'encountertype' :encounterType,
                                        'numofrecords' :numofrecords,
                                        'creatorId' :creatorId,
                                        'projectId' :projectId,
                                        'projectName' :projectName,
                                        'projectDescription' :projectDescription,
                                        'properties': [ <%= props.collect { "'${it}'" }.join(",") %> ]
})
.success(function(data) {
    jq('#tabs').tabs('select', 1);
    jq('#${ id } > tbody > tr').remove();
var tbody = jq('#${ id } > tbody');
for (index in data) {
    item = data[index];

    var row = jq(document.createElement('tr'));
    var encounterFormUrl = 'http://localhost:8080/openmrs/module/htmlformentry/htmlFormEntry.form?inPopup=true&personId=' + item.patientId + '&formId=' + '65' + '&returnUrl=/openmrs/module/htmlformflowsheet/testChart.list%3FselectTab%3D0&closeAfterSubmission=closeEncounterChartPopup';
    //console.log(encounterFormUrl)
    row.click(function() {
    jq("#encounterDialog").attr('src', encounterFormUrl);
    jq("#encounterFormDiv").dialog({
    width: 1200,
    height: 300,
    modal: true,
    close: function () {
    jq("#encounterDialog").attr('src', "about:blank");
    }
});
return false;
});
<% props.each { %>
var column = jq(document.createElement('td'));
column.append(item.${ it });
    row.append(column);
<% } %>
tbody.append(row);

}
// Table sorter - function
jq(document).ready(function() {
    jq('#${ id }').tablesorter();
    jq( "#${ id } th:nth-child(1)" ).text( "Encounter Date" );
    jq( "#${ id } th:nth-child(2)" ).text( "Location" );
    jq( "#${ id } th:nth-child(3)" ).text( "Encounter Type" );
    jq( "#${ id } th:nth-child(4)" ).text( "Creator" );
});
                    // Table sorter - label for css
                    jq(document).ready(function() {
                        jq('#${ id }').addClass('tablesorter');
                    });
                    jq(document).ready(function() {
                        jq('#${ id } tr').mouseover(function () {
                            jq(this).addClass('row_highlight');
                        }).mouseout(function () {
                                    jq(this).removeClass('row_highlight');
                                });
                    })
                })
                .error(function(xhr, status, err) {
                    alert('AJAX error ' + err);
                })
    });
});

</script>


<body>

<div id="tabs">
<ul>
    <li><a href="#tabs-1">Projects</a></li>
    <li><a href="#tabs-2">Records</a></li>
    <li><a href="#tabs-3">Reporting</a></li>
</ul>
<div id="tabs-1">
    <table>
        <tr>
            <td width="50" valign="top">
                <%=   ui.includeFragment("encounteraudit", "projects", [projects: projects]) %>

            </td>
            <td>
                <%=   ui.includeFragment("encounteraudit", "projectParameters", [id: config.id]) %>

            </td>
        </tr>
    </table>
</div>

    <div id="tabs-2">
        <%=   ui.includeFragment("encounteraudit", "encounterTable", [id: config.id]) %>
    </div>

<div id="tabs-3">
    <%=   ui.includeFragment("encounteraudit", "reports") %>
</div>

</div>







