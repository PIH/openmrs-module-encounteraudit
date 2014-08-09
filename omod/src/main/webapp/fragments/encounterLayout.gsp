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
    jq(document).ready(function() {
        jq( "#tabs" ).tabs();
    });
</script>
<script>
    jq = jQuery;
    jq(document).ready(function() {
        jq("#projects li").click(function() {
            jq(".project_select").removeClass("project_select")
            jq( this ).toggleClass("project_select");
            var projectId = jq(this).attr("data-project-id");
            console.log("projectId=" + projectId);
            jq("#projectName").val(jq(this).attr("data-project-name"));
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
        console.log("sampling records");
        var projectId = jq("#projectId").val();
        var projectName = jq("#projectName").val();

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
                                        'properties': [ <%= props.collect { "'${it}'" }.join(",") %> ]
})
.success(function(data) {
    jq('#tabs').tabs('select', 1);
    jq('#${ id } > tbody > tr').remove();
var tbody = jq('#${ id } > tbody');
for (index in data) {
    item = data[index];

    var row = jq(document.createElement('tr'));

    //var encounterFormUrl = 'http://localhost:8080/openmrs/module/htmlformentry/htmlFormEntry.form?inPopup=true&encounterId='  + item.encounterId;
    var encounterFormUrl = 'http://localhost:8080/openmrs/module/htmlformentry/htmlFormEntry.form?inPopup=true&personId=' + item.patientId + '&formId=' + '65' + '&returnUrl=/openmrs/module/htmlformflowsheet/testChart.list%3FselectTab%3D0&closeAfterSubmission=closeEncounterChartPopup';
    //console.log(encounterFormUrl)
    row.click(function() {
    jq("#encounterDialog").attr('src', encounterFormUrl);
    jq("#encounterFormDiv").dialog({
    width: 1200,
    height: 600,
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
                                            // jq( "#${ id } th:nth-child(1)" ).text( "Encounter ID" );
                                            // jq( "#${ id } th:nth-child(2)" ).text( "Patient ID" );
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







