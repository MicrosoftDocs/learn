Note: Just like the prior two modules, this one will prep for the next unit, setting up load testing.

Typically, you run load tests in more of a pre-production environment that more closely resembles the production environment. For now, you'll run it in the test environment, just like the Selenium UI tests.

Because of that, perhaps this is where Tim can get involved, given he has experience running load tests. But just like Amita, Tim's less of a coder (although he has experience running batch scripts and working with different kinds of configuration files, but he's really an ops guy.)

Perhaps Andy does a similar exercise with Tim - map out what Tim currently does and then automate it.

Roberta: I can come back and flesh this out more. I have this proven out; just need to write it up.

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