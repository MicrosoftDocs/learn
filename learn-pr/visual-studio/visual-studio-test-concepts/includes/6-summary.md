In this module, you've hopefully learned more about the purpose, concepts, and schools of thought behind testing, and how they can help you improve your code quality.

* **Explored concepts**: We explored the concept of testing and how it can help catch bugs before the release of your software.
* **Explained benefits of testing**: Testing helps validate code changes, improve architecture, and improve code health.
* **Learned about different types of testing**: Different types of testing can address different needs in a code base.
* **Discovered different schools of thought**: We explained various schools of thought in testing that help guide good practices across teams.

You saw how testing can both document and verify behavior in the phone number example. Tests enable you to automatically check functionality without needing to consciously walk through every supported scenario. Any app that is constantly growing can make use of tests to verify that new functionality doesn't break old behavior.

Learning about the different types of tests can open up new ways of verifying your code. Maybe your unit tests confirm the validity of some changes, but a performance test catches that a function is now taking twice as long to run. Maybe the unit tests and performance tests pass, but your UI tests catch strange UI rendering behavior. Testing from multiple different perspectives improves the quality of your app before it reaches customers.

The testing schools of thought recommend different styles of testing that can drive teams towards better architecture and higher code coverage. You don't have to follow each testing discipline perfectly. Just keep in mind, there's plenty of guidance out there for people wanting to evolve their testing practices.

## References

* [Unit testing C# with MSTest and .NET](/dotnet/core/testing/unit-testing-with-mstest)
* [Run tests in Azure DevOps](/learn/modules/run-functional-tests-azure-pipelines)
