<%
    def id = config.id
    def encounters = config.encounters
    def props = config.properties ?: ["encounterType", "encounterDatetime", "location", "provider"]
%>

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