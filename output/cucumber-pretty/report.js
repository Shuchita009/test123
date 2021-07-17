$(document).ready(function() {var formatter = new CucumberHTML.DOMFormatter($('.cucumber-report'));formatter.uri("features/search.feature");
formatter.feature({
  "line": 1,
  "name": "Range Url",
  "description": "",
  "id": "range-url",
  "keyword": "Feature"
});
formatter.before({
  "duration": 881822200,
  "status": "passed"
});
formatter.scenario({
  "line": 4,
  "name": "I want to goto Google",
  "description": "",
  "id": "range-url;i-want-to-goto-google",
  "type": "scenario",
  "keyword": "Scenario",
  "tags": [
    {
      "line": 3,
      "name": "@smoke"
    }
  ]
});
formatter.step({
  "line": 5,
  "name": "I am on the website",
  "keyword": "Given "
});
formatter.step({
  "line": 6,
  "name": "I should get title as \"Google\"",
  "keyword": "Then "
});
formatter.match({
  "location": "SearchSteps.i_am_on_the_website()"
});
formatter.result({
  "duration": 1732134100,
  "status": "passed"
});
formatter.match({
  "arguments": [
    {
      "val": "Google",
      "offset": 23
    }
  ],
  "location": "SearchSteps.i_should_get_title_as_Google(String)"
});
formatter.result({
  "duration": 31237400,
  "status": "passed"
});
formatter.after({
  "duration": 60666300,
  "status": "passed"
});
});