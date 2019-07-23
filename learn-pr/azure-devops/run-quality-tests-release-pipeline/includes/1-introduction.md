What tests do you run once the service is operational? What are integration and functional tests? What quality tests will we run? Will Amita write them? If not, who will. Can we show her using Azure Test Plan for manual tests? Is there any way to show her starting to learn to write automated tests?

# SCENARIO

* The team meets to talk about their release workflow. Andy demos.
* Amita: This is great. I now have a consistent environment to automatically receive builds, test them, and then promote them to an environment where leadership can review and approve changes. I no longer need to manually download and install build artifacts on my test servers. Running unit tests also helps helping Andy and Mara catch regressions before they reach me. But is there anything else we can do to speed up the process? I don't want to be the one holding us up.
* Andy: I think so. There are a lot of things you need to take care of to help ensure a high-quality release. Let's talk more about what tasks you take care of and we can see if any of them can be automated.

# DESIGN A TEST STRATEGY

## What kinds of tests can I run?

References:
* Configure Automated Integration and Functional Test Automation > Configure Automated Integration and Functional Test Automation
* Configure Automated Integration and Functional Test Automation > Lab (Setting up and Running Load Tests)
* Configure Automated Integration and Functional Test Automation > Lab (Setting up and Running Functional Tests)
* Configure Automated Integration and Functional Test Automation > Setting up and Running Availability Tests

Talk about how you ran unit and code coverage tests earlier, during the build phase. Talk about why it was appropriate to run them there. Here are a few kinds of tests you might run during the deployment stages (discuss why you run them there and not earlier (it's because you now have infrastructure to test on)):

* Load tests
* Functional tests
* Availability tests

### Manual versus automated testing

References:
* Configure Automated Integration and Functional Test Automation > Configure Automated Integration and Functional Test Automation

## Where can my tests run?

References:
* Configure Automated Integration and Functional Test Automation > Setting up Test Infrastructure

Tests might run:
* On the agent (hosted or one you provide)
* On test infrastructure, either on-prem or in the cloud

## What kinds of tooling are available?

* Azure Test Plans
* Selenium
* OWASP ZAP
* SpecFlow
* Azure Availability or Load Tests (look these up)

# EXERCISE - SETUP

* Set up environment
  * Run template

# EXERCISE - DEPLOY THE APPLICATION

* Initialize sandbox and create web app (with 3 slots?) through the CLI
* Trigger pipelines to build the app (which branch?)

# EXERCISE - PLAN UI TESTS

# EXERCISE - RUN UI TESTS WITH SELENIUM

* Pull down branch
* Run Selenium tests locally (head vs headless)
* Modify pipeline to run tests on Windows agent
* Push and run through pipeline
* See results

* Fetch branch with starter build config
  * This branch will include an additional .csproj that contains Selenium tests
  * [Reference](https://docs.microsoft.com/azure/devops/pipelines/test/continuous-test-selenium?view=azure-devops)
* Change (or add) deployment stage to **Hosted VS2017**.
* `git commit && git push` - watch it build, deploy, & **run tests** in the pipeline.
* Verify the results in the pipeline.
* Manually promote the build to Preprod.

# EXERCISE - RUN MANUAL TESTS WITH AZURE TEST PLANS

TBD 

# EXERCISE - RUN LOAD TESTS USING AZURE TEST PLANS

(This wasn't working with the new pipeline structure - revisit or cut)

# EXERCISE - CLEANUP

# SUMMARY