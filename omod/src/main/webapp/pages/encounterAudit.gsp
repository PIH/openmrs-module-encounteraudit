<%
    ui.decorateWith("uicommons", "html5")
    ui.includeCss("uicommons", "styleguide/index.css")
    ui.includeJavascript("uicommons", "jquery-1.8.3.min.js");
    ui.includeJavascript("uicommons", "jquery-ui-1.9.2.custom.min.js");
    ui.includeCss("uicommons", "styleguide/jquery-ui-1.9.2.custom.min.css")
    ui.includeJavascript("uicommons", "typeahead.js");
%>

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
            <li><a href="${ui.pageLink("uicommons", "styleGuide")}">Base Style</a></li>
            <li><a class="active" href="${ui.pageLink("uicommons", "javascript")}">Javascript</a></li>
            <li><a href="${ui.pageLink("uicommons", "testPage")}">Test Pages</a></li>
            <li><i class="icon-cog small"></i><a href="/openmrs/module/encounteraudit/manage.form">EA Admin</a></li>
        </ul>
    </nav>
</header>
<div class="clear"></div>

<div id="body-wrapper">
    <div id="content">
        <article id="suggest">
            <h1>Encounter Data</h1>
            <%=   ui.includeFragment("encounteraudit", "encounterAudit",
                    [   start: "2013-03-01",
                            end: "2013-03-16 23:59:59.999",
                            location: "2",
                            encountertype: "9",
                            properties: ["encounterDatetime", "location", "encounterType", "creator"]
                    ]) %>
    </div>
</div>
</body>
<br><br>

