Great work. In this module, you and the team added unit tests and code coverage to the build pipeline. You set up dashboard widgets so that others can easily track your improvements. You also fixed a build break before it could reach anyone else.

Defining build tasks locally first helps you understand and verify the process before you add build tasks to your pipeline.

Remember, the process you followed was specific to .NET applications. The tools and tasks that you use depend on the programming language and frameworks that you use to build your applications.

Let's check in with the team one last time. They're having their weekly team meeting, and Mara wants to show everyone the latest updates.

**Tim:** I'm glad to see you're making good progress in stabilizing our builds. But that sure looks like a lot of code!

**Andy:** Yes, it's a fair amount. But it's all things we do anyway. And now that parts are automated, we only need to define them one time. And because it's code, we have a common vocabulary for defining our build process and a consistent place to keep it all.

**Mara:** Thank you all for giving it a try. Now, what's next on the list?

## Learn more

In this module, you used the `DotNetCoreCLI@2` task to run unit tests through the `dotnet test` command. If you use [Visual Studio](/visualstudio/test/getting-started-with-unit-testing?azure-portal=true) to run your tests, you can use the [Visual Studio Test task](/azure/devops/pipelines/tasks/test/vstest?azure-portal=true) in your build pipeline.

If you're interested in unit testing .NET applications, here are some more resources:

* [Unit test your code](/visualstudio/test/unit-test-your-code?azure-portal=true)
* [Unit testing C# with NUnit and .NET Core](/dotnet/core/testing/unit-testing-with-nunit?azure-portal=true)
* [Build, test, and deploy .NET Core apps](/azure/devops/pipelines/ecosystems/dotnet-core?azure-portal=true)

Here's more information about how to analyze your test results:

* [Configure the Test Results Trend (Advanced) widget](/azure/devops/report/dashboards/configure-test-results-trend?azure-portal=true)
* [Analyze test results](/azure/devops/pipelines/test/test-analytics?azure-portal=true)