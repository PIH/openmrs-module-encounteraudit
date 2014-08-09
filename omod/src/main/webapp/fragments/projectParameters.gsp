<%
    def id = config.id
%>


<h2>Project Parameters</h2>
<small>Choose project parameters for a new project or view saved project parameters.</small>
<br>
<br>

<table id="projectParametersTable" border="0">
    <input id="projectId" name="projectId" type="hidden">
    <tr>
        <td>Project Name</td>
        <td><input id="projectName"> </td>
    </tr>
    <tr>
        <td>Description</td>
        <td>
            <textarea id="projectDescription" name="projectDescription" rows="2" cols="30"></textarea>
        </td>
    </tr>
    <tr>
        <td>Start Date</td>
        <td>${ ui.includeFragment("uicommons", "field/datetimepicker", [ id: 'startDateField', label: '', formFieldName: 'fromDate', useTime: false ]) }</td>
    </tr>
    <tr>
        <td>End Date</td>
        <td>${ ui.includeFragment("uicommons", "field/datetimepicker", [ id: 'endDateField', label: '', formFieldName: 'toDate', useTime: false ]) }</td>
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
        <td>Creator</td>
        <td>${ ui.includeFragment("encounteraudit", "field/user", [
                "id": "users-filterByUser",
                "formFieldName": "filterByUserId",
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

