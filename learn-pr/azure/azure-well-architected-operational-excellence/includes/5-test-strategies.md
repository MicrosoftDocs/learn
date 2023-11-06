Testing is one of the fundamental components of DevOps and agile development in general. If automation gives DevOps the required speed and agility to deploy software quickly, only through extensive testing can those deployments achieve the required reliability that customers demand.

A main tenet of a DevOps practice to achieve system reliability is the *shift left* principle. If you depict your process for developing and deploying an application as a series of steps moving from left to right. Then, your testing should be shifted as much as possible toward the beginning of your process (the left), and not placed at the very end of your process (the right). Errors are far cheaper to repair when they're caught early, and issues can be expensive or impossible to fix later in your application's lifecycle.

Testing should occur on both application code and infrastructure code, and they should both be subject to the same quality controls. The environment where applications are running should be version-controlled and deployed through the same mechanisms as application code. As a result, you can test and validate both application code and infrastructure code using DevOps testing paradigms.

You can use your favorite testing tool to run your tests, including Azure Pipelines for automated testing and Azure Testing Plans for manual testing.

There are multiple stages at which you can perform tests in the code's lifecycle, and each type of testing has several considerations that are important for you to understand. In this unit, you can find a summary from several of the different tests that you should consider when you're developing and deploying applications.

## Automated Testing

Automating tests is the best way to make sure that they're executed. Depending on how frequently your automated tests are performed, they're typically limited in duration and scope. The following descriptions list some of the things you need to consider when creating your test strategy.

### Unit Testing

Unit tests are tests typically run by each new version of code that's committed into your version-control system. Unit tests should be extensive (they should ideally cover 100% of the code), and quick (typically under 30 seconds, although this number isn't a rule set in stone). Unit testing can verify things like the syntax correctness of application code, Resource Manager templates, or Terraform configurations. It can also verify that your code is following best practices, or that the code produces the expected results when provided with certain inputs.

Unit tests should be applied both to application code and infrastructure code.

### Smoke Testing

Smoke tests are more exhaustive than unit tests, but still not as much as integration tests. Smoke tests normally run in less than 15 minutes. While smoke tests don't verify the interoperability of your different components with each other, they verify that each component can be correctly built, and each component meets your criteria for expected functionality and performance.

Smoke tests usually involve building the application code. If you're deploying infrastructure as part of your process, then smoke tests can possibly involve testing the deployment in a test environment.

### Integration Testing

After making sure that your different application components operate correctly individually, integration testing determines whether your components can interact with each other as they should. Integration tests usually take longer than smoke tests, so they're sometimes executed less frequently. For example, running integration tests every night still offers a good compromise between the different types of automated testing; your integration testing will detect interoperability issues between application components no later than one day after they were introduced.

## Manual Testing

Manual testing is much more expensive than automated testing, so it's used less frequently than automated testing. However, manual testing is fundamental for the correct functioning of the DevOps feedback loop; manual testing is used to correct errors before they become too expensive to repair, or before they cause customer dissatisfaction.

### Acceptance Testing

There are many different ways of confirming that the application is doing what it should.

- **Blue/Green deployments**: when deploying a new application version, you can deploy it in parallel to the existing one. This way, you can start redirecting your clients to the new version. If everything goes well, you decommission the old version. If there's any problem with the new deployment, you can always redirect your clients back to the older deployment.

- **Canary releases**: you can expose new functionality of your application (ideally using feature flags) to a select group of users. If these users are satisfied with the new functionality, you can extend it to the rest of your user community. In this scenario, we're talking about releasing functionality, and not necessarily about deploying a new version of the application.

- **A/B testing**: A/B testing is similar to canary release testing. Canary releases focus on mitigating risk, while A/B testing focuses on evaluating the effectiveness of two similar ways of achieving the same goal. For example, if you have two versions of a layout for a certain area of your application, you could send half of your users to version A, and the other half of your users to version B. Then, you could use some metrics to see which layout works better for your application goals.

An important aspect to consider is how to measure the effectiveness of new features in an application. One way to measure that is through the Application Insights User Behavior Analytic, which you can use to determine how people are using your application. By analyzing the results, you can decide whether a new feature has increased or decreased your application's usability.

Certain services in Azure offer functionality that can help you implement these kinds of tests. For example: the deployment slot functionality in the Azure App Service allows you to have two different versions of the same application running at the same time, and you can redirect your users to one version or the other.

### Stress tests

As other sections of this framework have explained, designing your application code and infrastructure for scalability is of paramount importance. With scalability in mind, it's critical that you test whether your application and infrastructure code are able to adapt to changing load conditions. For example, if there's a spike in user activity, you need to be confident that your application and infrastructure can scale automatically to meet the increased demand.

During your stress tests, it's critical that you monitor all the components of the system in order to identify whether there are any scale limitations. Every component of the system that's not able to scale out can turn into a bottleneck (such as active/passive network components or databases). It's important for you to know the limits for each of your components so you can mitigate their impact into your application scale. As you learn more about the performance characteristics for each of your components, the discoveries that you make along the way might motivate you to replace some of your components with more scalable counterparts.

After the stress test is concluded, it's equally important to verify that your infrastructure scales back down to its normal condition in order to keep your costs under control.

### Fault injection

Your application should be resilient to infrastructure failures, and introducing faults in the underlying infrastructure and observing how your application behaves is fundamental for increasing the trust in your redundancy mechanisms. Examples of fault injection tests include, ungracefully shutting down infrastructure components, or degrading the performance of certain elements such as network equipment. These tests give you a way to verify that your application is going to continue to behave or react as expected, if these situations occur in real life.

Most companies use a controlled way of injecting faults into the system, although if you're confident with your application resiliency, you could use automated frameworks. Chaos engineering is a practice adopted by some organizations to identify areas where faults may occur by purposefully making key pieces of infrastructure unavailable.

### Security tests

Another critical component of your test strategy should be routinely testing your application for security vulnerabilities. You should regularly perform security tests against your application to identify any application vulnerabilities that are introduced through code defects or through software dependencies. These tests can include automated security scans to test against common vulnerabilities, such as cross-site scripting or SQL injection. Your security tests can also include *red team* exercises, where security teams attempt to compromise your application.

Use the results from these tests to provide feedback through your entire development process and resolve any security issues that you find in your code or software dependencies.
