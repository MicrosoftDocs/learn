Great work! In this module, we defined a _functional test_ as a test that verifies that a given function of the software does what it should. We also defined some popular kinds of functional tests, including smoke tests, unit tests, and UI tests.

The Tailspin team chose one type of functional test to automate first: UI tests. Amita had been running these tests manually. The manual tests were tedious and time-consuming. By automating the tests, Amita can now focus more on usability testing, which is usually best done by humans.

When you incorporate functional tests in your pipeline, focus on the kinds of tests that matter most. For example, if your application distributes work among various components, you can write integration tests that verify that all components work together to form a complete system.

In the next module, you'll switch to another type of important testing: _nonfunctional testing_. The team will define nonfunctional testing and focus on one type of performance test.

## Learn more

Use the following resources to learn more.

### Learn more about NUnit

In this module, you worked with NUnit tests. If you're interested in unit-testing .NET applications, consider these additional resources:

* [NUnit.org](https://nunit.org?azure-portal=true)
* [Unit testing your code](https://docs.microsoft.com/visualstudio/test/unit-test-your-code?view=vs-2019&azure-portal=true)
* [Unit testing C# by using NUnit and .NET Core](https://docs.microsoft.com//dotnet/core/testing/unit-testing-with-nunit?azure-portal=true)

### Learn about parallel jobs

You have set up UI tests that run on Windows. But you can also run your tests on other platforms, such as macOS and Linux. To speed up the testing process, you can run all of these jobs in parallel. For more information, see [Jobs](https://docs.microsoft.com/azure/devops/pipelines/process/phases?view=azure-devops&tabs=yaml&azure-portal=true) and [Parallel jobs
](https://docs.microsoft.com/azure/devops/pipelines/licensing/concurrent-jobs?view=azure-devops&azure-portal=true).

### Learn more about Selenium tests

If you're interested in testing UI by using Selenium, check out these resources to help you go further:

* [SeleniumHQ.org](https://www.seleniumhq.org?azure-portal=true)
* [Selenium IDE](https://www.seleniumhq.org/selenium-ide?azure-portal=true)
* [Test UI by using Selenium](https://docs.microsoft.com/azure/devops/pipelines/test/continuous-test-selenium?view=azure-devops&azure-portal=true)
* [UI testing considerations](https://docs.microsoft.com/azure/devops/pipelines/test/ui-testing-considerations?view=azure-devops&tabs=mstest&azure-portal=true)