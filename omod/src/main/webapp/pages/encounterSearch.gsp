<%
    ui.decorateWith("uicommons", "html5")

    ui.includeCss("uicommons", "styleguide/index.css")
    ui.includeJavascript("uicommons", "jquery-1.8.3.min.js");
    ui.includeJavascript("uicommons", "typeahead.js");
    ui.includeJavascript("uicommons", "script.js");
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

<div id="body-wrapper" class="style-guide">
    <div id="content">
        <article id="suggest">
            <h1>Select Encounter Criteria</h1>
            <form>
                <p>
                 Encounter Type
                 <input id="typeahead" data-provide="typeahead" placeholder="Auto Suggest" type="text"></input>
                 ${ ui.includeFragment("uicommons", "field/datetimepicker", [ id: 'datetime', label: 'Encounter Date', formFieldName: 'date picker', useTime: false ]) }
                 </p>
            </form>
        </article>
        <h1>Encounter Data</h1>
            ${ ui.includeFragment("encounteraudit", "encountersToday",
                [   start: "2011-02-16",
                    end: "2011-02-16 23:59:59.999",
                    properties: ["location", "encounterDatetime", "location"]
            ]) }
    </div>
</div>
</body>
<br><br>

