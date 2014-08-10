<%
    def id = config.id
    def encounters = config.encounters
    def props = config.properties ?: ["encounterType", "encounterDatetime", "location", "provider"]
    def projects = config.projects
%>

<table id="noborder">
    <tr>
        <td><font size="5" id="pname"></font></td>
        <td align="right">
            <select id="projects" class="select">
                <option>Select...</option>
                <% projects.each { proj ->
                    def projectId = proj.id
                %>
                <option data-project-id="${ projectId }" data-project-name="${ proj.name }" value="<%= ui.format(proj.name) %>"><%= ui.format(proj.name) %></option>
                <% } %>
            </select>

        </td>
    </tr>
</table>

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