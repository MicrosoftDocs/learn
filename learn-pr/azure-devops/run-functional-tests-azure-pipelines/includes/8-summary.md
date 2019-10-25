Great work! In this module, we defined a _functional test_ as a test that verifies that a given function of the software does what it should. We also defined some of the more popular kinds of functional tests, including smoke tests, unit tests, and UI tests.

The Tailspin team chose one kind of functional test to automate first: UI tests. They chose UI tests that Amita needed to run manually, which were tedious and time-consuming. By automating these tests, Amita can now focus more on usability testing, which is usually best performed by humans.

When incorporating functional tests in your pipeline, focus on the kinds of tests that matter most. For example, if your application distributes work among other components, you might write integration tests that verify that all components work together to form a complete system.

In the next module, you'll switch to another kind of important testing: _non-functional testing_. There, the team defines non-functional testing and chooses one kind of performance test to focus on.

## Learn more

Here are some additional resources you can use to learn more.

### Learn more about NUnit

In this module, you worked with NUnit tests. If you're interested in unit testing .NET applications, here are some additional resources:

* [nunit.org](https://nunit.org?azure-portal=true)
* [Unit test your code](https://docs.microsoft.com/visualstudio/test/unit-test-your-code?view=vs-2019&azure-portal=true)
* [Unit testing C# with NUnit and .NET Core](https://docs.microsoft.com//dotnet/core/testing/unit-testing-with-nunit?azure-portal=true)

### Learn about parallel jobs

You set up UI tests that run on Windows. But you can also run your tests on other platforms, such as macOS and Linux. To speed up the process, you can run all of these jobs in parallel. See [Jobs](https://docs.microsoft.com/azure/devops/pipelines/process/phases?view=azure-devops&tabs=yaml&azure-portal=true) and [Parallel jobs
](https://docs.microsoft.com/azure/devops/pipelines/licensing/concurrent-jobs?view=azure-devops&azure-portal=true) to learn more.

### Learn more about Selenium tests

If you're interested in UI testing with Selenium, here are some resources to help you go further:

* [seleniumhq.org](https://www.seleniumhq.org?azure-portal=true)
* [Selenium IDE](https://www.seleniumhq.org/selenium-ide?azure-portal=true)
* [UI test with Selenium](https://docs.microsoft.com/azure/devops/pipelines/test/continuous-test-selenium?view=azure-devops&azure-portal=true)
* [UI testing considerations](https://docs.microsoft.com/azure/devops/pipelines/test/ui-testing-considerations?view=azure-devops&tabs=mstest&azure-portal=true)