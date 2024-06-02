In [Run functional tests in Azure Pipelines](/training/modules/run-functional-tests-azure-pipelines?azure-portal=true), you added Selenium UI tests to the pipeline. UI tests are a form of *functional testing*. In this part, you explore the kinds of *nonfunctional* tests you can run in a pipeline.

The team first defines nonfunctional tests. They talk about some types of these tests. Then they decide on a nonfunctional test to add to their pipeline.

## How do nonfunctional tests compare to functional tests?

In [Run functional tests in Azure Pipelines](/training/modules/run-functional-tests-azure-pipelines?azure-portal=true), we defined functional tests and nonfunctional tests.

In short, _functional tests_ verify that each function of the software does what it should. In other words, functional tests verify an application's functionality.

_Nonfunctional tests_ check nonfunctional aspects of an application, such as performance and reliability. You can also run nonfunctional tests on systems that aren't apps, such as infrastructure components. One example of a nonfunctional test is determining how many people can simultaneously sign in to an application without causing a problem, such as slower response times.

On the _Space Game_ website as an example, a functional test might verify that the leaderboard appears correctly and that it shows the correct records when the user selects a filter. A nonfunctional test might verify that leaderboard filtering finishes in less than one second, even when many users connect to the website at the same time.

Nonfunctional testing always tests something that's measurable. The goal is to improve the product. You might do that, for example, by improving how efficiently the application uses resources, or by improving response times when many customers use it simultaneously. Here are some of the questions that nonfunctional tests can answer:

* How does the application perform under normal circumstances?
* How does the application perform when many users sign in concurrently?
* How secure is the application?

## What kinds of nonfunctional tests can I run?

There are many kinds of nonfunctional tests. Many of them fit in the broad categories of performance testing and security testing.

### Performance testing

The goal of _performance testing_ is to improve an application's speed, scalability, and stability. Testing for speed determines how quickly an application responds. Testing for scalability determines the maximum user load an application can handle. Testing for stability determines whether the application remains stable under different loads. Two common types of performance tests are load tests and stress tests.

#### Load testing

_Load tests_ determine an application's performance under realistic loads. For example, load tests can determine how well an application performs at the upper limit of its service-level agreement (SLA). Basically, load testing determines the application's behaviors when multiple users need it at the same time.

Users aren't necessarily people. For example, a load test for printer software might send the application large amounts of data. A load test for a mail server might simulate thousands of concurrent users.

Load testing is also a good way to uncover problems that exist only when the application is operating at its limits. That's when issues such as buffer overflow and memory leaks can surface.

In this module, you'll use Apache JMeter to perform load tests. You'll use a set of simulated users that access the website simultaneously.

#### Stress testing

_Stress tests_ determine an application's stability and robustness under heavy loads. The loads go beyond what's specified for the application. The stress tests determine whether the application will crash under these loads. If the application fails, the stress test checks to ensure that it fails gracefully. A graceful failure might, for example, issue an appropriate, informative error message.  

Scenarios in which applications must operate under abnormally heavy loads are common. For example, in case your video goes viral, you'll want to know how well the servers can handle the extra load. Another typical scenario is high traffic on shopping websites during holiday seasons.

### Security testing

_Security testing_ ensures that applications are free from vulnerabilities, threats, and risks. Thorough security testing finds all the system's possible loopholes and weaknesses that might cause an information breach or a loss of revenue.

There are many types of security testing. Two of them are penetration testing and compliance testing.

#### Penetration testing

_Penetration testing_, or _pen testing_, is a type of security testing that tests the insecure areas of the application. In particular, it tests for vulnerabilities that an attacker could exploit. An authorized, simulated cyber attack is usually a part of penetration testing.

#### Compliance testing

_Compliance testing_ determines whether an application is compliant with some set of requirements, inside or outside the company. For example, healthcare organizations usually need to comply with HIPAA (Health Insurance Portability and Accountability Act of 1996), which provides data privacy and, security provisions for safeguarding medical information.

An organization might also have its own security requirements. Software must be tested to make sure that it follows these requirements. For example, on Linux systems, the default user mask must be *027* or more restrictive. A security test needs to prove that this requirement is met.

## The plan

In the rest of this module, you'll set up your Azure DevOps environment, learn about planning load tests by using Apache JMeter, and run load tests in Azure Pipelines.
