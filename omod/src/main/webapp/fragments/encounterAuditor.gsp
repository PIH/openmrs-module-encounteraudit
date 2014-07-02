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
                            jq.getJSON('${ ui.actionLink("encounteraudit","encounterAuditor","getAuditEncounters") }',
                                    {
                                        'start': jqFormatStartDate,
                                        'end': jqFormatEndDate,
                                        'location' : encounterLocation,
                                        'encountertype' :encounterType,
                                        'numofrecords' :numofrecords,
                                        'properties': [ <%= props.collect { "'${it}'" }.join(",") %> ]
                                    })
                                    .success(function(data) {
                                        jq('#tabs').tabs('select', 1);
                                        jq('#${ id } > tbody > tr').remove();
                                        var tbody = jq('#${ id } > tbody');
                                        for (index in data) {
                                            var item = data[index];

                                                var row = jq(document.createElement('tr'));
                                                row.mouseover(function(){
                                                    jq(this).addClass('ex_highlight');
                                                    jq(this).css( 'cursor', 'pointer' );
                                                });
                                                row.mouseout(function(){
                                                    jq(this).removeClass('ex_highlight');
                                                    // jq(this).css("color","black");
                                                    jq(this).css("text-decoration","none");
                                                });
                                                if (index % 2 == 0) {
                                                    row.addClass('evenRow');
                                                } else {
                                                    row.addClass('oddRow');
                                                }
                                                var encounterFormUrl = 'http://localhost:8080/openmrs/module/htmlformentry/htmlFormEntry.form?inPopup=true&encounterId='  + item.encounterId;
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
                                            var myObs = item.obs;
                                            for (i = 0; i < myObs.length; i++) {
                                                var tempObs = myObs[i];
                                                console.log("tempObs.id = " + tempObs.id);
                                            }
                                            tbody.append(row);
                                        }
                                        // Table sorter - function
                                        jq(document).ready(function() {
                                            jq('#${ id }').tablesorter();
                                        });
                                        // Table sorter - label for css
                                        jq(document).ready(function() {
                                            jq('#${ id }').addClass('tablesorter');
                                        });
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
        <div id="encounterFormDiv" title="Encounter" style="display:none;">
            <iframe id="encounterDialog" width="1200" height="600"></iframe>
        </div>
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
    <table>
        <tr>
            <td valign="top">
                <h2>Choose Project</h2>
                <select>
                    <option value="a">New Project</option>
                    <option value="b">LQAS - NDH Fall 2014</option>
                    <option value="c">Neno 2014 District Evaluation</option>
                    <option value="d">Magaleta Checkup</option>
                    <option value="e">Rare Fields Evaluation</option>
                    <option value="f">Po-Chedley data quality</option>
                </select>
            </td>
            <td>
                <h2>Quick Reports</h2>
                <center>
                <!-- <img src="http://atmos.uw.edu/~pochedls/nobackup/deleteme/report_example.png"> -->
                </center>
            </td>
        </tr>
    </table>
</div>
</div>






