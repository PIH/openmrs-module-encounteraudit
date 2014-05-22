${ ui.includeFragment("uiframework", "helloUser") }
${ ui.includeFragment("encounteraudit", "encountersToday",
        [   start: "2011-02-16",
                end: "2011-02-16 23:59:59.999",
                properties: ["location", "encounterDatetime"],
                decoratorProvider: "encounteraudit",
                decorator: "widget",
                decoratorConfig: [title: "Arbitrary Encounters"]
        ]) }
