In [Run functional tests in Azure Pipelines](/training/modules/run-functional-tests-azure-pipelines?azure-portal=true), you and the Tailspin team added Selenium UI tests to the pipeline. UI tests are a form of *functional testing*. In this part, you explore the kinds of *nonfunctional* tests you can run in a pipeline.

The team first defines nonfunctional tests. They talk about some types of these tests. Then they decide on a nonfunctional test to add to their pipeline.

## Daily standup meeting

The team is having their daily standup meeting. Mara and Amita are demoing the changes they made to the release pipeline. Amita shows the UI tests running on a laptop. The team watches how quickly each web browser comes up and runs through the tests that Amita would normally do manually.

**Amita:** I must admit, I initially resisted this form of automation. But now I see how it gives me the freedom to do so much more. I'm already beginning to write my own UI tests. And I still have plenty of time to do usability testing to verify that our websites are intuitive and meet the user's needs.

**Tim:** I'm happy this automation helps speed up things for you, Amita. This improvement should help us move changes from _Test_ to _Staging_ more quickly. Given that improvement, is there anything we should do in _Staging_ to help increase the quality of our releases?

**Andy:** UI tests are a form of *functional testing*. I suspect, Tim, that you're more concerned about performance or the *nonfunctional* parts of the application. What kinds of tests do you normally run?

**Tim:** Normally, after our sites are in production, I run performance, load, and stress tests. But I'd like to start running other kinds of tests as well, such as compliance tests and security tests. All of those tests are difficult to run manually. By using automation, we can run them both earlier and more frequently.

**Mara:** Tim, you've developed a DevOps mindset! I think we can help you. First let's discuss how nonfunctional tests compare to functional tests. Then let's talk about the kinds of nonfunctional tests we can run.

## How do nonfunctional tests compare to functional tests?

In [Run functional tests in Azure Pipelines](/training/modules/run-functional-tests-azure-pipelines?azure-portal=true), we defined functional tests and nonfunctional tests.

In short, _functional tests_ verify that each function of the software does what it should. In other words, functional tests verify an application's functionality.

_Nonfunctional tests_ check nonfunctional aspects of an application, such as performance and reliability. You can also run nonfunctional tests on systems that aren't apps, such as infrastructure components. One example of a nonfunctional test is to determine how many people can simultaneously sign in to an application without causing a problem, such as slower response times.

On the _Space Game_ website as an example, a functional test might verify that the leaderboard appears correctly and that it shows the correct records when the user selects a filter. A nonfunctional test might verify that leaderboard filtering finishes in less than one second, even when many users connect to the website at the same time.

Nonfunctional testing always tests something that's measurable. The goal is to improve the product. You might do that, for example, by improving how efficiently the application uses resources or by improving response times when many customers use it simultaneously. Here are some of the questions that nonfunctional tests can answer:

* How does the application perform under normal circumstances?
* How does the application perform when many users sign in concurrently?
* How secure is the application?

## What kinds of nonfunctional tests can I run?

There are many kinds of nonfunctional tests. Many of them fit in the broad categories of performance testing and security testing.

### Performance testing 

The goal of _performance testing_ is to improve the speed, scalability, and stability of an application. Testing for speed determines how quickly an application responds. Testing for scalability determines the maximum user load an application can handle. Testing for stability determines whether the application remains stable under different loads. Two common types of performance tests are load tests and stress tests.

#### Load testing

_Load tests_ determine the performance of an application under realistic loads. For example, load tests can determine how well an application performs at the upper limit of its service-level agreement (SLA). Basically, load testing determines the behavior of the application when multiple users need it at the same time.

Users aren't necessarily people. For example, a load test for printer software might send the application large amounts of data. A load test for a mail server might simulate thousands of concurrent users.

Load testing is also a good way to uncover problems that exist only when the application is operating at its limits. That's when issues such as buffer overflow and memory leaks can surface.

In this module, you use Apache JMeter to perform load tests. You use a set of simulated users that access the website simultaneously.

#### Stress testing

_Stress tests_ determine the stability and robustness of an application under heavy loads. The loads go beyond what's specified for the application. The stress tests determine whether the application will crash under these loads. If the application fails, the stress test checks to ensure that it fails gracefully. A graceful failure might, for example, issue an appropriate, informative error message.  

Scenarios in which applications must operate under abnormally heavy loads are common. For example, in case your video goes viral, you'll want to know how well the servers can handle the extra load. Another typical scenario is high traffic on shopping websites during holiday seasons.

### Security testing

_Security testing_ ensures that applications are free from vulnerabilities, threats, and risks. Thorough security testing finds all the possible loopholes and weaknesses of the system that might cause an information breach or a loss of revenue.

There are many types of security testing. Two of them are penetration testing and compliance testing.

#### Penetration testing

_Penetration testing_, or _pen testing_, is a type of security testing that tests the insecure areas of the application. In particular, it tests for vulnerabilities that an attacker could exploit. An authorized, simulated cyber attack is usually a part of penetration testing.

#### Compliance testing

_Compliance testing_ determines whether an application is compliant with some set of requirements, inside or outside the company. For example, healthcare organizations usually need to comply with HIPAA (Health Insurance Portability and Accountability Act of 1996), which provides data privacy and, security provisions for safeguarding medical information.

An organization might also have its own security requirements. Software must be tested to make sure that it follows these requirements. For example, on Linux systems, the default user mask must be *027* or more restrictive. A security test needs to prove that this requirement is met.

## What does the team choose?

**Andy:** Tim, nonfunctional testing is your area of expertise. If you had to choose just one type of testing to start with, which would you pick?

**Tim:** Like Amita, I want our users to have a great experience. From my perspective, that happens when the page loads quickly. Load time is especially important when we launch a new game. On launch day, gamers come to our site to download the game. Load testing helps me simulate expected usage.

**Mara:** What tool do you use for load testing, and what do your load tests measure?

**Tim:** I use Apache JMeter. I mainly look at response time or the time between the web browser's request to our servers and when it receives data back. Under a typical load, I like to see average request times of less than one second. No more than 10 percent of requests should take more than one second.

**Mara:** I'm interested in learning more. Can we pair up sometime and try to add load testing to the pipeline?

**Tim:** Absolutely! Perhaps I can walk you through my process. Then we can map that to tasks in Azure Pipelines.

**Mara:** That sounds great! As with our functional tests, we can decide exactly where these tests fit in the pipeline. We might decide to run the tests on a Microsoft-hosted agent, an agent we provide, or some other type of test infrastructure.

## The plan

**Mara:** OK. So here's what we're going to do:

* Tim is going to show me how he runs load tests by using Apache JMeter.
* We'll map the test steps to tasks in Azure Pipelines.
* We'll measure the load on the website and provide a report for all of you.

**Tim:** Great! See you later.
