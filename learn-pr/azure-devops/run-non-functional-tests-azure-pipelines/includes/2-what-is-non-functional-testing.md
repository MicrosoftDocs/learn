In [Run functional tests in Azure Pipelines](/learn/modules/run-functional-tests-azure-pipelines?azure-portal=true), you and the Tailspin team added Selenium UI tests to the pipeline. UI tests are a form of *functional testing*. In this part, you explore the kinds of *non-functional* tests you can run in a pipeline.

The team first defines what a non-functional test is and talks about some types of non-functional tests. Then, they decide on a non-functional test to add to their pipeline.

## Daily standup meeting

The team is having their daily standup meeting and Mara and Amita are demoing the changes they made to the release pipeline. Amita shows the UI tests running on her laptop. The team watches how quickly each web browser comes up and runs through tests Amita would normally do manually.

**Amita:** I must admit, I initially resisted this form of automation. But now I see how it gives me the freedom to do so much more. I'm already beginning to write my own UI tests. And I still have plenty of time to do usability testing to verify that our websites are intuitive and meet the user's needs.

**Tim:** I'm happy this helps speed up things for you, Amita. This improvement should help us move changes from _Test_ to _Staging_ more quickly. Given that, is there anything we should do in _Staging_ to help improve the quality of our releases?

**Andy:** UI tests are a form of *functional testing*. I suspect, Tim, that you're more concerned about performance &mdash; or the *non-functional* parts of the application. What kinds of tests do you normally run?

**Tim:** Normally, once our sites are in production, I run performance, load, and stress tests. But I'd like to start running other kinds of tests as well, such as compliance and security tests. All those tests are difficult to run manually and, with automation, we could run them both earlier and more frequently.

**Mara:** Tim, you've really developed a DevOps mindset! I think we can help you. First, let's first compare non-functional tests to functional tests. Then we can talk about the kinds of non-functional tests we can run.

## How do non-functional tests compare to functional tests?

In [Run functional tests in Azure Pipelines](/learn/modules/run-functional-tests-azure-pipelines?azure-portal=true), we defined what functional and non-functional tests are.

In short, _functional tests_ verify that each function of the software does what it should. In other words, functional tests verify an application's functionality.

_Non-functional tests_ check non-functional aspects of an application, such as performance and reliability. (Of course, you can also perform non-functional tests on other systems besides apps, such as infrastructure components.) One example of a non-functional test is to determine how many people can simultaneously log into an application before there's a problem, such as slower response times.

Taking the _Space Game_ website as an example, a functional test might verify that the leaderboard displays correctly and that it shows the correct records when the user selects a filter. A non-functional test might verify that leaderboard filtering completes in less than one second when many users are connected to the website at the same time.

Non-functional testing always tests something that is measurable. The goal is to improve the product, such as by improving how efficiently the application uses resources or by improving response times when many customers use it simultaneously. Some of the questions non-functional tests can answer include:

* How does the application perform under normal circumstances?
* How does the application perform when many users log on concurrently?
* How secure is the application?

## What kinds of non-functional tests can I run?

There are a variety of non-functional tests, but many of them fit under the broad categories of performance testing and security testing.

### Performance testing 

The goal of _performance testing_ is to improve the speed, scalability, and stability of an application. Testing for speed determines how quickly an application responds. Testing for scalability determines the maximum user load an application can handle. Testing for stability determines if the application remains stable under different loads. Two common types of performance tests are load tests and stress tests.

#### Load testing

_Load tests_ determine the performance of an application under realistic loads. For example, load tests can determine how well an application performs at the upper limit of its Service Level Agreement (SLA). Basically, load testing determines the behavior of the application when multiple users use it at the same time. Users aren't necessarily people. A load test for printer software might send it large amounts of data. On the other hand, a load test for a mail server might simulate thousands of concurrent users.

Load testing is also a good way to uncover problems that only exist when the application is operating at its limits. That's when issues such as buffer overflows and memory leaks can surface.

In this module, you use Apache JMeter to perform load tests using a set of simulated users that access the website simultaneously.

#### Stress testing

_Stress tests_ determine the stability and robustness of an application under extremely heavy loads that go beyond what's specified for the application. They make sure that the application doesn't crash and, if it fails, it fails gracefully, such as by issuing an appropriate, informative error message.  

Examples of times when applications must operate under abnormally heavy loads are quite common. For example, if a video goes viral, then you'll want to know how well the servers can handle the extra load. Another typical example is the traffic on shopping web sites during holiday seasons.

### Security testing

_Security testing_ ensures that applications are free from any vulnerabilities, threats, and risks. Thorough security testing finds all the possible loopholes and weaknesses of the system that might cause an information breach or a loss of revenue.

There are many types of security testing. Two of them are penetration testing and compliance testing.

#### Penetration testing

_Penetration testing_, or _pen testing_, is a type of security testing that tests the insecure areas of the application, and, in particular, tests to see if there are vulnerabilities that an attacker could exploit. An authorized, simulated cyber attack is usually a part of penetration testing.

#### Compliance testing

_Compliance testing_ determines if an application is compliant with some set of requirements, whether external to the company or internal to it. For example, healthcare organizations usually need to comply with HIPAA (Health Insurance Portability and Accountability Act of 1996), which provides data privacy and security provisions for safeguarding medical information.

In addition, an organization can have its own security requirements and software must be tested to make sure it complies with them. For example, on Linux systems, there might be a requirement that the default user mask is *027* or more restrictive. A security test needs to exist to prove that this is true.

## What does the team choose?

**Andy:** Tim, this is your area. If you had to choose just one kind of testing to start with, which would you pick?

**Tim:** Like Amita, I want our users to have a great experience. From my perspective, that happens when the page loads quickly. This is especially true when we launch a new game. On launch day, our site is where gamers come to download the game. Load testing helps me simulate expected usage.

**Mara:** What tool do you use for load testing, and what do your load tests measure?

**Tim:** I use Apache JMeter. I mainly look at response time, or the time between the web browser's request to our servers and when it receives data back. Under typical load, I like to see average request times of less than one second. No more than 10% of requests should take more than one second.

**Mara:** I'm interested in learning more. Can we pair up sometime and we can try to add load testing to the pipeline?

**Tim:** Absolutely. Perhaps I can walk you through my process and then we can map that to tasks in Azure Pipelines.

**Mara:** That sounds great! Just as with our functional tests, we can decide exactly where this fits in the pipeline &mdash; whether we run the tests on a Microsoft-hosted agent, an agent we provide, or some other kind of test infrastructure.

## The plan

**Mara:** OK. So here's what we're going to do:

* Tim is going to show me how he runs load tests on his laptop with Apache JMeter.
* We'll map his steps to tasks in Azure Pipelines.
* We'll measure the load on the website and provide a report for you all to see.

**Tim:** Great! See you later.