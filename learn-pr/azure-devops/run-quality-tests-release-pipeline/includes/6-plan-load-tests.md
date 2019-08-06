
The load tests will use Apache JMeter to access the web application from many simulated users at the same time. Again, the tests will fetch the web content from the app running on App Service, in the test environment.

Mara drops in to see Tim. "Hi there, I was wondering if you'd thought more about what kind of non-functional test you want to automate?"

"I have. I want to do a load test. I want to test the app under normal and peak conditions."

"That's great," says Mara. "Can I work with you? I've never written a load test. What tool do you use now?"

"I use Apache JMeter. It's an open-source load testing tool for analyzing and measuring performance. I'm hoping we can integrate it into the pipeline. I think the output is XML."

"I think we can," Mara answers. "We may need to convert the output to something Azure Pipelines understands, but that shouldn't be too hard. So we'll use a Microsoft-hosted agent to run the tests, just like we did with Amita. Instead of running it in the test environment though, we can run it in staging.

"I think it's a great idea to start with tools and tests you're familiar with. Do you have any kind of script that you normally use for load testing? We could convert it to an automated test."

Tim points to his computer screen. "There you go."

Rough steps:

* Install Apache JMeter on Ubuntu. (we'll show screenshots throughout)
* Using the JMeter GUI, plan out a load test. It will make requests against the test environment. Simulate 100 users each performing 10 requests concurrently.
* Save the configuration as a test plan.
* From the command line, run the test plan and observe the results. Think about what perf characteristics Tim might want.
  * (The average request time should be less than 1 second.)
  * (No more than 10% of requests should take more than 1 second.)
* Later, perhaps when they add this to the pipeline, they realize they can visualize the results from Azure Pipelines if they provide a results file in a supported format (we can list them, but the list includes JUnit.)
* So they write an XLST transform to translate the JMeter output (using its own XML schema) to JUnit's schema.
* They incorporate the XLST transform in the CD pipeline.