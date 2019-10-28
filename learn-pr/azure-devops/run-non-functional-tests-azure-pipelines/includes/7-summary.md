Nice job! In this module, we defined a _non-functional test_ as a test that checks characteristics like performance and reliability. Compare this to a _functional test_, which verifies that a given function of the software does what it should. We also defined some of the more popular kinds of non-functional tests, including load testing, stress testing, and penetration testing.

The Tailspin team chose one kind of non-functional test to automate first: load tests. With a few commands, they were able to take a test plan that was created with Apache JMeter and run it in the pipeline. Now, with each code change, the team can track the performance of the site under normal load. If performance begins to drop, they know which change caused it.

Just as you did when you incorporated functional tests into your pipeline, focus on the kinds of non-functional tests that matter most. For example, if your team must adhere to certain compliance requirements, consider adding automated tests that provide you with a detailed status report.

## Learn more

If you're interested in performance testing with Apache JMeter, here are some resources to help you go further:

* [jmeter.apache.org](https://jmeter.apache.org?azure-portal=true)
* [Apache JMeter - User's Manual: Best Practices](https://jmeter.apache.org/usermanual/best-practices.html?azure-portal=true)