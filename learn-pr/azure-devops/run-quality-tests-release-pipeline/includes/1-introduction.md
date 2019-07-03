## Notes - 7/2

ILT references:

* Configure Automated Integration and Functional Test Automation > Configure Automated Integration and Functional Test Automation
* Configure Automated Integration and Functional Test Automation > Setting up Test Infrastructure
* Configure Automated Integration and Functional Test Automation > Lab
* Configure Automated Integration and Functional Test Automation > Lab
* Configure Automated Integration and Functional Test Automation > Setting up and Running Availability Tests

## Exercises

* Set up environment
  * Run template
* Initialize sandbox and create web app (with 3 slots?) through the CLI
* Fetch branch with starter build config
  * This branch will include an additional .csproj that contains Selenium tests
  * [Reference](https://docs.microsoft.com/azure/devops/pipelines/test/continuous-test-selenium?view=azure-devops)
* Change (or add) deployment stage to **Hosted VS2017**.
* `git commit && git push` - watch it build, deploy, & **run tests** in the pipeline.
* Verify the results in the pipeline.
* Manually promote the build to Preprod.
* (Idea) Exercise 2 - load test by URL from Test Plans.