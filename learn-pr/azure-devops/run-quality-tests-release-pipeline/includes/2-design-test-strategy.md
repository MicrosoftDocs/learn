Note: Rough notes throughout -- feel free to move, reorder, and change things.
Overall, I want to tee up a discussion about making Amita's life better and the test stage more robust. I want to drive towards a decision to add at least one functional (UI test w/ Selenium) test and one non-functional test (load testing with Apache JMeter) to the test stage. Both are forms of automated testing. Amita will still focus on the user experience by running a few quick tests before promoting to pre-production.

* The team meets to talk about their release workflow (think: the previous module about workflow). Andy demos.
* Amita: This is great. I now have a consistent environment to automatically receive builds, test them, and then promote them to an environment where leadership can review and approve changes. I no longer need to manually download and install build artifacts on my test servers. Running unit tests also helps helping Andy and Mara catch regressions before they reach me. But is there anything else we can do to speed up the process? I don't want to be the one holding us up.
* Andy: I think so. There are a lot of things you need to take care of to help ensure a high-quality release. Let's talk more about what tasks you take care of and we can see if any of them can be automated.

Things to weave in in this unit:

* Amita talking about all the manual testing she needs to do, and how she feels it slows the entire process down. The team identifies her tests as UI tests, a form of functional testing. They agree to help her set that up.
* Later, Tim mentions his requirements, which are less about whether the app works and more on how the app performs. The team identifies his needs as non-functional testing, and they make a plan to run one of those as well.
  * (Something to call out somewhere in this module - these days, many teams are preferring realtime monitoring to things like load testing. But we don't have a live site or users yet - so perhaps we frame it that way - run tests Tim is familiar with for now and have some value as they make their way to the release.)

## What kinds of tests can I run?

Note: I want to quickly divide between functional and non-functional testing here. I don't want to include [this link](https://www.guru99.com/functional-testing-vs-non-functional-testing.html), but I like the tables and how the differentiate things.

Talk about how you ran unit and code coverage tests earlier, during the build phase. Talk about why it was appropriate to run them there. Here are a few kinds of tests you might run during the deployment stages (discuss why you run them there and not earlier (it's because you now have infrastructure to test on)):

References:
* Configure Automated Integration and Functional Test Automation > Configure Automated Integration and Functional Test Automation
* Configure Automated Integration and Functional Test Automation > Lab (Setting up and Running Load Tests)
* Configure Automated Integration and Functional Test Automation > Lab (Setting up and Running Functional Tests)
* Configure Automated Integration and Functional Test Automation > Setting up and Running Availability Tests

### Manual versus automated testing

I was thinking here we break down what's easy to automate versus what you'd likely still do manually.

References:
* Configure Automated Integration and Functional Test Automation > Configure Automated Integration and Functional Test Automation

## Where can my tests run?

Note: It's important to distinguish _where_ your tests can run.

Tests might run:

* On the agent (hosted or one you provide)
* On test infrastructure, either on-prem or in the cloud

In [Run quality tests in your build pipeline using Azure Pipelines](/learn/modules/run-quality-tests-build-pipeline?azure-portal=true), your unit and code coverage tests ran on the build agent. (Because that's all you had.) But here, you have the chance to run additional tests on a production-like environment, where the app is running.

Note: In this module, you'll run Selenium UI tests from a Microsoft-hosted Windows build agent. The UI tests will run from a number of web browsers (Chrome, Firefox, IE) on the agent. The tests will fetch the web content from the app running on App Service, in the test environment.

Note: Also in this module, you'll run load tests from a Microsoft-hosted Ubuntu build agent. The load tests will use Apache JMeter to access the web application from many simulated users at the same time. Again, the tests will fetch the web content from the app running on App Service, in the test environment.

References:
* Configure Automated Integration and Functional Test Automation > Setting up Test Infrastructure

## What kinds of tooling are available?

Note: Let's round things out (or move this up?) with a quick survey of some of the more popular testing tools you can use.

Perhaps go back to the kinds of testing we introduced earlier and map each to a few popular tools you can use. We can expand briefly on each tool, or be more terse and provide a table (columns being the tool name, what kinds of testing it applies to, and perhaps whether it relates to automated or manual testing.)

Here are a few the JTA calls out:

* Azure Test Plans
* Selenium
* OWASP ZAP
* SpecFlow
* Azure Availability or Load Tests (look these up)
