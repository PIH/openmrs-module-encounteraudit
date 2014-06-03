<%
    def id = config.id
    def start = config.start
    def end = config.end
    def props = config.properties ?: ["encounterType", "encounterDatetime", "location", "provider"]
%>
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


            jq.getJSON('${ ui.actionLink("encounteraudit","encountersToday","getEncounters") }',
                    {
                        'start': jqFormatStartDate,
                        'end': jqFormatEndDate,
                        'properties': [ <%= props.collect { "'${it}'" }.join(",") %> ]
                    })
                    .success(function(data) {
                        jq('#${ id } > tbody > tr').remove();
                        var tbody = jq('#${ id } > tbody');
                        for (index in data) {
                            var item = data[index];
                            var row = '<tr>';
                            <% props.each { %>
                            row += '<td>' + item.${ it } + '</td>';
                            <% } %>
                            row += '</tr>';
                            tbody.append(row);
                        }
                    })
                    .error(function(xhr, status, err) {
                        alert('AJAX error ' + err);
                    })
        });
    });
</script>

<p>
${ ui.includeFragment("uicommons", "field/datetimepicker", [ id: 'startDateField', label: 'Encounter Start Date', formFieldName: 'fromDate', "defaultDate": fromDate, useTime: false ]) }
</p>
<br>
<p>
${ ui.includeFragment("uicommons", "field/datetimepicker", [ id: 'endDateField', label: 'Encounter End Date', formFieldName: 'toDate', "defaultDate": toDate, useTime: false ]) }
</p>
<br>
<input id="${ id }_button" type="button" value="Refresh Table"/>
<br><br>
<table id="${ id }">
    <thead>
    <tr>
        <% props.each { %>
        <th>${ ui.message("Encounter." + it) }</th>
        <% } %>
    </tr>
    </thead>
    <tbody>
    <% if (encounters) { %>
    <% encounters.each { enc -> %>
    <tr>
        <% props.each { prop -> %>
        <td><%= ui.format(enc."${prop}") %></td>
        <% } %>
    </tr>
    <% } %>
    <% } else { %>
    <tr>
        <td colspan="4">${ ui.message("general.none") }</td>
    </tr>
    <% } %>
    </tbody>
</table>
${ ui.resourceLinks() }