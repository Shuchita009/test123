
:: =========================================
::  This .bat file demonstrates how to create or update an automation task in Zephyr for Jira Cloud, run this task, and publish test results to Zephyr.
::  Author: SmartBear Software
:: =========================================

:: =========================================
::  Zephyr base URL.
::   DON'T CHANGE THE CONSTANT BELOW. KEEP IT AS IT IS.
:: =========================================
set "$zephyrBaseUrl=https://prod-api.zephyr4jiracloud.com/connect" 

:: =========================================
::  Access and secret keys, and user id needed for connection to Zephyr for Jira. 
::  Replace the constants below with values relevant to your project and account.
:: =========================================
:: The accessKey and secretKey to access your project. You can find them in your Jira project: Zephyr > API Keys.
set "$accessKey=amlyYTpkOTIyOTEwYi0yMjJlLTQxNDYtOGVmNS05ZTdhYmRlMTliYWEgNWZjNzI3ZDVmOGIwMTIwMDY5ZWNiYWYzIFVTRVJfREVGQVVMVF9OQU1F"
set "$secretKey=nCAKjdCSPSVDmNxqGHhYpq7s4FcwjRqaJ-f6dZu2i9c"
:: Id of the user who will create the automation task. You can find it in Jira.
set "$accountId=5fc727d5f8b0120069ecbaf3"

:: =========================================
::  Create a JSON Web Token  (required to access Zephyr for Jira).
::  Keep this section as it is.
:: =========================================
echo "Generating a JSON Web Token ..."
for /F "tokens=*" %%i in (' curl -s -X POST -H "Content-Type: application/json" --data "{ \"accessKey\":\"%$accessKey%\", \"secretKey\":\"%$secretKey%\",\"accountId\":\"%$accountId%\",\"zephyrBaseUrl\": \"%$zephyrBaseUrl%\",\"expirationTime\":360000}" "https://prod-vortexapi.zephyr4jiracloud.com/api/v1/jwt/generate" ')  do set jwtgenerated=%%i
set "$finaljwt=%jwtgenerated%"
echo %$finaljwt%

:: =========================================
::  Define properties of the automation task.
::  Replace the values below with data relevant to your project.
:: =========================================

:: Task info
set "$taskName=My task"
set "$taskDescription=Task description"
set "$automationFramework=Cucumber"
set "$projectKey=RANGE"
set "$versionName=Unscheduled"

:: Cycle info
set "$cycleName=sample"
set "$createNewCycle=true"
set "$appendDateTimeInCycleName=false"

:: Folder info
set "$folderName=Windows"
set "$createNewFolder=true"
set "$appendDateTimeInFolderName=true"
set "$assigneeUser=5fc727d5f8b0120069ecbaf3"

:: Fully-qualitified name of the test result file
set "$resultPath=@\"C:/Users/spare/.jenkins/workspace/JavaFreeStyleGoogle/target/cucumber-reports/json-reports/CucumberTestReport.json""

:: =========================================
::  Create an automation task, run it, send test results to Zephyr.
::  Keep this section as it is.
:: =========================================
echo "Creating and running an automation task ..."
curl -v -X POST  https://prod-vortexapi.zephyr4jiracloud.com/api/v1/automation/job/saveAndExecute  -H "Content-Type: multipart/form-data" -H "Content-Type: application/json" -H "accessKey: %$accessKey%" -H "jwt: %$finaljwt%" -F "jobName=%$taskName%" -F "jobDescription=%$taskDescription%" -F "automationFramework=%$automationFramework%" -F "projectKey=%$projectKey%" -F "versionName=%$versionName%" -F "cycleName=%$cycleName%" -F "createNewCycle=%$createNewCycle%" -F "appendDateTimeInCycleName=%$appendDateTimeInCycleName%" -F "folderName=%$folderName%" -F "createNewFolder=%$createNewFolder%" -F "appendDateTimeInFolderName=%$appendDateTimeInFolderName%" -F "assigneeUser=%$assigneeUser%" -F "file=%$resultPath%"


