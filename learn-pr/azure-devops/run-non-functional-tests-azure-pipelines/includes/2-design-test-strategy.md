Talk about how at this point you have the shape of the pipeline (screenshot?), but more can be filled in.

TODO: This is a paste from the previous module. Refactor it to talk about release gates only.

### What are release approvals and release gates?

A *release approval* is a way to pause the pipeline until an approver accepts or rejects the release. A *release gate* is an automated way to query an external service before promoting from one stage to the next. You can combine approvals, gates, and triggers to define your release cadence.

Tim clears his throat.

**Tim:** What about me? I still need some way to deploy the app to my production environment and that depends on management signing off on new features. Those triggers won't work.

**Andy:** I see your point. I think what you're looking for is a *release approval* and maybe a *release gate*.

**Andy:** With a release approval attached to a stage, the pipeline deployment stops until someone signs off, like our management. We could enable a manual deployment approval to move from staging to production.

**Andy:** For quality control, we could use release gates. A gate would let us automatically collect health signals from external services and then promote the release only when all the signals are successful at the same time.

**Amita:** I'm interested in release gates as well. I'd like to automatically check whether we have any active bugs before I promote from test to staging.

**Mara:** Absolutely! Let's talk about it later.

---


The team is having their weekly meeting and Andy is demoing the CD pipeline. They watch as a successful build moves through the pipeline, from one stage to another, until the web app is finally deployed to staging. 

Amita say, "I'm so happy with the pipeline. It makes my life much easier. For one thing, I automatically get a release deployed to the test environment. That means I don't have to manually download and install build artifacts on my test servers. That's a big time saver.

"Also, the unit tests that Mara and Andy wrote eliminate all the regression bugs before I get the release. That's a major source of frustation gone and I don't spend time finding and documenting them. 

"But I'm worried that all the testing I do is still manual. It's slow and we can't show anything to management until I'm done. It's hard because the testing is important. It's how we make sure the users get the right experience. On the other hand, the pressure is on to do everything faster."

Andy says, "I'm sure we can help you. What kind of tests take up most of your time?"

"I think it's the UI tests," Amita says. I have to click through every step to make sure I get the correct result and I have to do it for every browser we support. It's very time consuming and, because the web site is getting more complicated, it's not practical in the long run."

Mara says, "UI tests are considered to be functional tests."

"As opposed to what--non-functional tests?" Tim asks.

"Exactly," Mara says, laughing. "And non-functional tests are something you, in particular, care about."

"Okay, I'm confused," Tim says.

##Functional and non-functional tests
"Functional tests," Mara says, "verify that each function of the software does what it should. How the software implements a function isn't important, only that the software does the right thing. You provide an input and check that the output is what you expected. That's how Mara tests the UI. For example, if she selects the top player on the leaderboard, she expects to see that player's profile.

"Non-functional tests check characteristics like performance and reliability. An example of a non-functional test is checking to see how many people can simultaneously log in to the app. Load testing would be another example. Those are things you care about, Tim."

"They are," Tim says. "I need to think about this for a bit. I might want to add some automation to the pipeline myself but I'm not sure yet what I want to do. Are there good and bad candidates for automated testing?"

## Good candidates for automated testing

***NOTE--the ILT page on this topic is a mess and I think some of it's wrong. Maybe we can talk it through but I'm skipping it for now.**

Andy looks at Amita. "It sounds like you might be ready for some functional testing."

"I am," Amita says. She looks at Andy and Mara. "We still have some time left. Want to help me plan an automated UI test?"

"Absolutely," Mara answers, but let's get a few preliminaries out of the way. What tool should we use and how do we run the test?"

##Tools for writing functional test
When it comes to writing functional tests, what are the options we know about?" Mara asks. She starts writing on the board. "Here's a few options."

* Selenium. 
* PowerShell
* SpecFlow


"That's a good list," Andy says. "Selenium is a portable open source software-testing framework for web applications. It runs on most operating systems and it supports all modern browsers and multiple languages. I've used it before.

"PowerShell is a general task automation and configuration management framework from Microsoft. There's a command line shell and an associated scripting language.

"I know a little about SpecFlow," Mara says. "It's for .NET projects. It lets you define application behavior using a simple language called Gherkin."

Andy looks at Amita. "I know this is new to you, so do you mind if I pick Selenium? I have some experience with it and it supports languages I already know. It also will give us automatic support for multiple browsers."

"Sure," says Amita. "It's better if one of us comes in with some experience."

## How to run a functional test

"One thing I'm excited about," says Mara, is that now we can test in a production-like environment, where the app is actually running. Functional tests like UI tests make a lot of sense in that context. We can run them in Amita's test stage. 

"We also have a choice about whether we run the tests on an agent, one of Microsoft's or one we host, or on test infrastructure, either on-prem or in the cloud."

"Again, let's stick with what we know," Andy says. Let's use a Microsoft-hosted Windows build agent.

## Functional test summary

"OK," Mara says. So here's what we're going to do:

* Run Selenium UI tests from a Microsoft-hosted Windows build agent.
* Have the tests fetch the web content from the app that's running on App service, in the test environment.
* Run the tests on all the browsers we support.




























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
