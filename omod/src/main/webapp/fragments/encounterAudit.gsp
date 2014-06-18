<%
    def id = config.id
    def start = config.start
    def end = config.end
    def location = config.location
    def encountertype = config.encountertype
    def numofrecords = config.numofrecords
    def props = config.properties ?: ["encounterType", "encounterDatetime", "location", "provider"]
%>

<script>
    jq = jQuery;
    jq(function() {
        jq( "#tabs" ).tabs();
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
                    <h2>Projects</h2>
                    <small>Select a project to work on.</small>
                    <br>
                    <br>
                    <ul class="select" align="left">
                        <li>New Project</li>
                        <li>LQAS - NDH Fall 2014</li>
                        <li>Neno 2014 District Evaluation</li>
                        <li>Magaleta Checkup</li>
                        <li>Rare Fields Evaluation</li>
                        <li>Po-Chedley data quality</li>
                        <li>test</li>
                    </ul>

                </td>
                <td>
                    <h2>Project Parameters</h2>
                    <small>Choose project parameters for a new project or view saved project parameters.</small>
                    <br>
                    <br>
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

                                jq.getJSON('${ ui.actionLink("encounteraudit","encounterAudit","getAuditEncounters") }',
                                        {
                                            'start': jqFormatStartDate,
                                            'end': jqFormatEndDate,
                                            'location' : encounterLocation,
                                            'encountertype' :encounterType,
                                            'numofrecords' :numofrecords,
                                            'properties': [ <%= props.collect { "'${it}'" }.join(",") %> ]
                                        })
                                        .success(function(data) {
                                            jq('#${ id } > tbody > tr').remove();
                                            var tbody = jq('#${ id } > tbody');
                                            for (index in data) {
                                                var item = data[index];
                                                var row = '<tr>';
                                                <% props.each { %>
                                                row += '<td> <a href=\"http://www.google.com\">' + item.${ it } + '</a></td>';
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

                    <table border="0">
                        <tr>
                            <td>Project Name</td>
                            <td><input></td>
                        </tr>
                        <tr>
                            <td>Description</td>
                            <td>
                                <textarea rows="2" cols="30"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>Start Date</td>
                            <td>${ ui.includeFragment("uicommons", "field/datetimepicker", [ id: 'startDateField', label: '', formFieldName: 'fromDate', "defaultDate": fromDate, useTime: false ]) }</td>
                        </tr>
                        <tr>
                            <td>End Date</td>
                            <td>${ ui.includeFragment("uicommons", "field/datetimepicker", [ id: 'endDateField', label: '', formFieldName: 'toDate', "defaultDate": toDate, useTime: false ]) }</td>
                        </tr>
                        <tr>
                            <td>Location</td>
                            <td>${ ui.includeFragment("uicommons", "field/location", [
                                    "id": "encounters-filterByLocation",
                                    "formFieldName": "filterByLocationId",
                                    "label": ""
                            ] ) }</td>
                        </tr>
                        <tr>
                            <td>Encounter Type</td>
                            <td>${ ui.includeFragment("uicommons", "field/encounterType", [
                                    "id": "filterByEncounterType",
                                    "formFieldName": "filterByEncounterType",
                                    "label": ""
                            ] ) }</td>
                        </tr>
                        <tr>
                            <td>Number of Records</td>
                            <td><input id="numofrecords" name="Samples" size="4"></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <center>
                                    <a class="button arrow" id="${ id }_button" type="button">
                                        <span>Sample Records</span>
                                        <i class="icon-ok"></i>
                                        <span class="arrow-border-button"></span>
                                        <span class="arrow-button"></span>
                                    </a>
                                </center>
                            </td>
                        </tr>
                    </table>
                    <br>

                </td>
            </tr>
        </table>
    </div>
    <div id="tabs-2">
        <font size="5">Records for "Untitled Project"</font>
        <p align="right">
            <select>
                <option value="a">New Project</option>
                <option value="b">LQAS - NDH Fall 2014</option>
                <option value="c">Neno 2014 District Evaluation</option>
                <option value="d">Magaleta Checkup</option>
                <option value="e">Rare Fields Evaluation</option>
                <option value="f">Po-Chedley data quality</option>
            </select>
            <br>
        </p>
        <br>
        <table id="${ id }">
            <thead>
            <tr>
                <% props.each { %>
                <th>${ ui.message(it) }</th>
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
    </div>
    <div id="tabs-3">
        <p>Mauris eleifend est et turpis. Duis id erat. Suspendisse potenti. Aliquam vulputate, pede vel vehicula accumsan, mi neque rutrum erat, eu congue orci lorem eget lorem. Vestibulum non ante. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Fusce sodales. Quisque eu urna vel enim commodo pellentesque. Praesent eu risus hendrerit ligula tempus pretium. Curabitur lorem enim, pretium nec, feugiat nec, luctus a, lacus.</p>
        <p>Duis cursus. Maecenas ligula eros, blandit nec, pharetra at, semper at, magna. Nullam ac lacus. Nulla facilisi. Praesent viverra justo vitae neque. Praesent blandit adipiscing velit. Suspendisse potenti. Donec mattis, pede vel pharetra blandit, magna ligula faucibus eros, id euismod lacus dolor eget odio. Nam scelerisque. Donec non libero sed nulla mattis commodo. Ut sagittis. Donec nisi lectus, feugiat porttitor, tempor ac, tempor vitae, pede. Aenean vehicula velit eu tellus interdum rutrum. Maecenas commodo. Pellentesque nec elit. Fusce in lacus. Vivamus a libero vitae lectus hendrerit hendrerit.</p>
    </div>
</div>





