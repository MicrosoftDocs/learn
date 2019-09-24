In this section, you TODO.

In [Run functional tests in Azure Pipelines](/learn/modules/run-functional-tests-azure-pipelines?azure-portal=true), you and the Tailspin team added Selenium UI tests to the pipeline. UI tests are a form of *functional testing*. In this part, you explore the kinds of *non-functional* tests you can run in the pipeline.

## Daily standup meeting

The team is having their daily standup meeting and Mara and Amita are demoing the changes they made to the CI/CD pipeline. Amita shows the UI tests running on her laptop. The team watches how quickly each browser comes up and runs through tests Amita would normally perform manually.

**Amita:** I love this. But I must admit, I initially resisted this form of automation. But now I see how it gives me the freedom to do so much more. I'm already beginning to write my own UI tests. And I still have plenty of time to perform usability testing to verify that our websites are intuitive and meets the user's needs.

Tim raises his hand.

**Tim:** I'm happy this helps speed things up for you, Amita. This improvement should help us move changes from _Test_ to _Staging_ more quickly. Given that, is there anything we should do in _Staging_ to help improve the quality of our releases?

**Andy:** UI tests are a form of *functional testing*. I suspect, Tim, that you're more concerned about performance &mdash; or the *non-functional* parts of the application. What kinds of tests do you normally run?

**Tim:** Normally, once our sites are in production, I run performance, load, and stress tests. But I would like to start running other kinds of tests, such as compliance and security tests. Non-functional tests can be difficult to run manually, and I'd like to run these kinds of tests earlier and more frequently so that we can catch mistakes earlier in the process.

**Mara:** Tim, you've really developed a DevOps mindset! I think we can help you there. I think it might help if we first compared non-functional tests to functional tests. Then we can talk about the kinds of non-functional tests we can run.

## How do non-functional tests compare to functional tests?

In [Run functional tests in Azure Pipelines](/learn/modules/run-functional-tests-azure-pipelines?azure-portal=true), we defined what functional and non-functional tests are.

In short, _functional tests_ verify that each function of the software does what it should. In other words, functional tests verify an application's functionality.

_Non-functional tests_ check characteristics like performance and reliability. In other words, non-functional tests verify how the application performs under real-world conditions.

TODO: State more comparisons 

Make a concrete example (e.g. Login page shows text fields vs takes 5 seconds to load)

## What kinds of non-functional tests can I run?

Like functional tests, there are many kinds of non-functional tests you can run. Similarly, each kind varies by the functionality you need to test for and the time (or effort) that's typically required to run it.

Here are some of the more popular kinds of non-functional tests software teams commonly run.

### Performance testing

_Performance testing_ verifies the most basic functionality of your application or service. Smoke tests are often run before running more complete and exhaustive tests. Smoke tests are intended to run quickly.

For example, say you're developing a website. Your smoke test might use `curl` to verify that the site is reachable and that fetching the home page produces a 200 (OK) HTTP status. If fetching the home page produces another status code, such as 404 (Not Found) or 500 (Internal Server Error), then you know that the website is fundamentally not working and no further testing is required. From there, you would diagnose the error and restart your tests once the error is fixed.

### Load testing

You worked with unit tests in the [Run quality tests in your build pipeline using Azure Pipelines](/learn/modules/run-quality-tests-build-pipeline?azure-portal=true) module.

In short, _load testing_ verifies the most fundamental components of your program or library, such as an individual function or method. You specify one or more inputs along with the expected results. The test runner performs each test and checks to see whether the actual and expected results match.

As an example, let's say you have a function that performs an arithmetic operation that includes division. You might specify a few values that you expect your users to enter along with edge-case values such as 0 and -1. If a certain input produces an error or exception, you can verify that the function produces the same error.

The UI tests you'll run later in this module are a form of unit tests.

### Stress testing

_Integration testing_ verifies that multiple software components work together. For example, an e-commerce system might include the website, the products database, a payment system, and so on. You might write an integration test that adds items to the shopping cart verifies that the payment system fulfills the order. Such as test might use fictitious data to ensure that the test can be run repeatedly without making a real transaction.

Combining unit and integration tests enables you to create a layered approach to your testing strategy. For example, you might run unit tests on each of your components before running the integration tests. If all unit tests pass, you can move on to the integration test phase with greater confidence.

### Security testing

A _regression_ occurs when existing behavior changes or breaks when a feature is either added or changed. _Regression testing_ helps determine whether code, configuration, or other changes affect the software's overall behavior.

Regression testing is important because a change in one component can change the behavior of another. For example, say you tune a database to increase write performance. Read performance of that database from another component might drop in ways you did not expect.

There are various types of regression testing strategies. These strategies typically vary by the number of tests that are run to verify that a new feature or bug fix doesn't break existing functionality. However, when tests are automated, regression testing might simply involve running all unit and integration tests each time the software undergoes a change.

### Penetration testing

(OWASP ZAP)

_Sanity testing_ involves testing each major component of a piece of software to verify whether that software appears to be working and can undergo more thorough testing. You can think of sanity tests as being less thorough than regression or unit tests, but more thorough than smoke tests.

Although sanity testing can be automated, it's often done manually in response to a feature change or a bug fix. For example, when validating a bug fix, a software tester might also verify that other features are working by entering values that a user might enter. If the software appears to be working as expected, it can then go through a more thorough test pass.

### Compliance testing

_UI testing_ verifies the behavior of an application's user interface. UI tests help verify that the sequence, or order, of user interactions leads to the expected result. They also help verify that interaction methods, such as with the keyboard or mouse, affect the user interface properly. You can run UI tests to verify the behavior of a native Windows, macOS, or Linux application, or to verify that the UI behaves as expected across web browsers.

Although a unit or integration test might verify that the UI _receives_ data correctly, UI testing helps verify that the user interface _appears_ correctly and that the result functions as expected for the user.

For example, a UI test might verify that the correct animation appears in response to a button click. A second test might verify that the same animation appears correctly when the window is resized.

In this module, you work with UI tests that are coded by hand. But you can also use use a capture and replay system to automatically build your UI tests.

## What does the team choose?

**Andy:** Tim, this is your area. If you had to choose just one kind of testing to start with, which would you pick?

**Tim:** Like Amita, I want our users to have a great experience. From my perspective, that happens when the page loads quickly. This is especially true when we launch a new game. On launch date, our site is where gamers come to download the game. Load testing helps me simulate expected usage.

**Mara:** What tool do you use for load testing, and what do your load tests measure?

**Tim:** I use Apache JMeter. I mainly look at response time, or the time between the web browser's request to our servers and receiving data back. Under typical load, I like to see average request times of less than one second. No more than 10% of requests should take more than one second.

**Mara:** I'm interested in learning more. Can we pair up sometime and we can try to add load testing to the pipeline?

**Tim:** Absolutely. Perhaps I can walk you through my process and then we can map that to tasks in Azure Pipelines.

**Mara:** That sounds great! Just as with our functional tests, we can decide exactly where this fits in the pipeline &mdash; whether we run the tests on a Microsoft-hosted build agent, a build agent we provide, or some other kind of test infrastructure.

## The plan

**Mara:** OK. So here's what we're going to do:

* Tim is going to show me how he runs load tests on his laptop with Apache JMeter.
* We'll map his steps to tasks in Azure Pipelines.
* We'll measure the load on the website and provide a report for you all to see.

I'll work with Tim on this one.

**Andy:** Great! See you later.