<%
    def projects = config.projects
%>
<style type="text/css">
.project_select {
    background-color: #007fff !important;
    color: white !important;
    padding: 5px;
    margin: 5px
}
</style>
<h2>Projects</h2>
<small>Select a project to work on.</small>
<br>
<br>
<!-- <ul class="select" align="left">
    <li>New Project</li>
    <li>LQAS - NDH Fall 2014</li>
    <li>Neno 2014 District Evaluation</li>
    <li>Magaleta Checkup</li>
    <li>Rare Fields Evaluation</li>
    <li>Po-Chedley data quality</li>
    <li>test</li>
</ul> -->

<ul id="projects" class="select" align="left">
    <li value="New Project" class="removeme">New Project</li>
    <% projects.each { proj -> %>
    <li value="<%= ui.format(proj.name) %>"><%= ui.format(proj.name) %></li>
    <% } %>
</ul>



${ ui.resourceLinks() }