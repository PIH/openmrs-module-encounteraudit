<%
    ui.decorateWith("uicommons", "html5")
    ui.includeCss("uicommons", "styleguide/index.css")
    ui.includeJavascript("uicommons", "jquery-1.8.3.min.js");
    ui.includeJavascript("uicommons", "jquery-ui-1.9.2.custom.min.js");
    ui.includeCss("uicommons", "styleguide/jquery-ui-1.9.2.custom.min.css")
    ui.includeJavascript("encounteraudit", "jquery.tablesorter.min.js");
    ui.includeCss("encounteraudit", "tablesorter/style.css")
%>

<style type="text/css">
.ex_highlight {
    background: antiquewhite !important;
    padding: 5px;
    margin: 5px
    text-decoration: none;
}
</style>

<br><br>
<script>
    var jq = jQuery;
</script>
<body data-spy="scroll" data-target="#menu">
<header id="style-guide-header">
    <h1><i class="icon-edit"></i>OpenMRS Encounter Audit Module</h1>
    <h2 align="right">$context.authenticatedUser.personName.fullName <i class="icon-user small"></i></h2>
    <nav>
        <ul>
            <li><a href="${ui.pageLink("uicommons", "styleGuide")}">Navigation:</a></li>
            <li><i class="icon-home small"></i><a href="/openmrs/">OpenMRS Home</a></li>
            <li><i class="icon-wrench small"></i><a href="/openmrs/module/encounteraudit/manage.form">Settings</a></li>
            <li><i class="icon-cog small"></i><a href="/openmrs/admin">Admin</a></li>
            <li align="right"><i class="icon-signout small"></i><a href="/openmrs/logout">Logout</a></li>
        </ul>
    </nav>
</header>
<div class="clear"></div>

<div id="body-wrapper">

    <article id="suggest">
        <h1>Encounter Data</h1>
        <%=   ui.includeFragment("encounteraudit", "encounterAudit",
                [ properties: ["encounterId","patientId","encounterDatetime", "location", "encounterType", "creator"]]) %>

</div>
</body>
<br><br>