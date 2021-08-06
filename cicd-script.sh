######################################################################
#  This .sh file demonstrates how to create or update an automation task in Zephyr for Jira Cloud, run this task, and publish test results to Zephyr.
#  Author: SmartBear Software
######################################################################

######################################################################
#  Zephyr base URL.
#  DON'T CHANGE THE CONSTANT BELOW. KEEP IT AS IT IS.
######################################################################
zephyrBaseUrl="https://prod-api.zephyr4jiracloud.com/connect"

#######################################################################
#  Access and secret keys, and user id needed for connection to Zephyr for Jira. 
#  Replace the constants below with values relevant to your project and account.
#######################################################################

# The accessKey and secretKey to access your project. You can find them in your Jira project: Zephyr > API Keys.
accessKey="ODhmNjZkNjQtZjM4NS0zYjM0LWI0OWYtMjU3ZTdlMjQyN2EzIDYwZjRmNDFiZjAyNmFiMDA3MDBhYjUyYyBVU0VSX0RFRkFVTFRfTkFNRQ"
secretKey="7-HKGkBijaA4yaMdW6bG40XRVC11FN1u5CiCNah46z4"
# Id of the user who will create the automation task. You can find it in Jira.
accountId="557058:60f4f41bf026ab00700ab52c"   

#######################################################################
#  Create a JSON Web Token  (required to access Zephyr for Jira).
#  Keep this section as it is.
#######################################################################
echo "Generating a JSOM Web Token ... \n"
curl -o headers -s -d '{  "accessKey": "'"$accessKey"'"  , "secretKey": "'"$secretKey"'" ,"accountId": "'"$accountId"'","zephyrBaseUrl": "'"$zephyrBaseUrl"'","expirationTime":360000}' -H "Content-Type: application/json" -X POST https://prod-vortexapi.zephyr4jiracloud.com/api/v1/jwt/generate
jwt="$(cat  headers | head -n 1)"
echo "The generated token: \n"
echo $jwt

#######################################################################
#  Define properties of the automation task.
#  Replace the values below with data relevant to your project.
#######################################################################

# Task info
taskName="Test"                     
taskDescription="Test"
automationFramework="CUCUMBER"  
projectKey="TEST"
versionName="UNSCHEDULED"

# Cycle info
cycleName="Regression"
createNewCycle="true"
appendDateTimeInCycleName="true"

# Folder info
folderName="RegressionTests"
createNewFolder="true"
appendDateTimeInFolderName="true"
assigneeUser="557058:60f4f41bf026ab00700ab52c"

#Set Mandatory
mandatoryFields={"reporter":{"label":"shuchitapare","name":"shuchitapare","id":"557058:60f4f41bf026ab00700ab52c"}}

echo "curr dir: $pwd"
# Name of the test result file
resultPath="$/Users/jprakash/.jenkins/workspace/jira/target/cucumber-reports/json-reports/CucumberTestReport.json"
echo $resultPath
#######################################################################
#  Create an automation task, run it, send test results to Zephyr.
#  Keep this section as it is.
#######################################################################
echo "Creating and running an automation task ..."
curl -o headers -s -v -H "accessKey: $accessKey" -H "jwt: $jwt" \
 -H "Content-Type: multipart/form-data" -H "Content-Type: application/json"  \
 -F "jobName=$taskName" -F "jobDescription=$taskDescription" -F "automationFramework=$automationFramework" \
 -F "projectKey=$projectKey" -F "versionName=$versionName" -F "cycleName=$cycleName" -F "createNewCycle=$createNewCycle" \
 -F "appendDateTimeInCycleName=$appendDateTimeInCycleName" -F "folderName=$folderName" -F "createNewFolder=$createNewFolder" \
 -F "appendDateTimeInFolderName=$appendDateTimeInFolderName" -F "assigneeUser=$assigneeUser" -F "mandatoryFields=$mandatoryFields" \
 -F "file=$resultPath" -XPOST https://prod-vortexapi.zephyr4jiracloud.com/api/v1/automation/job/saveAndExecute
result="$(cat  headers | head -n 1)"
echo "Test results: \n"
echo $result
# END of the "Create task" code

#######################################################################
#  Update the properties of automation task and  run it, send test results to Zephyr.
#  
#  The code below uses "task properties" values defined in lines 40-58.
#  Update them to change task properties.
#
#  To run the code below, first comment out the code lines 64-68 that create your automation task, 
#  and then uncomment in the lines below.
#######################################################################

# Id of your automation task. You get it after the task is created.
# taskId="XXXXXXXXXXXXXXXXXXXX42E96E8863BF7EEE44BDB95FF763DA3E9C3BC4776886"

#echo "Update and run the automation task... "

#curl -o headers -s -v -H "accessKey: $accessKey" -H "jwt: $jwt" -H "Content-Type: multipart/form-data" -H "Content-Type: application/json" -F "jobId=$taskId" -F "jobName=$taskName" -F "jobDescription=$taskDescription" -F "automationFramework=$automationFramework" -F "versionName=$versionName" -F "cycleName=$cycleName" -F "createNewCycle=$createNewCycle" -F "appendDateTimeInCycleName=$appendDateTimeInCycleName" -F "folderName=$folderName" -F "createNewFolder=$createNewFolder" -F "appendDateTimeInFolderName=$appendDateTimeInFolderName" -F "assigneeUser=$assigneeUser" -F "file=$resultPath" -XPUT https://prod-vortexapi.zephyr4jiracloud.com/api/v1/automation/job/updateAndExecute

#result="$(cat  headers | head -n 1)"
#echo $result

# END of the "Update task" code
