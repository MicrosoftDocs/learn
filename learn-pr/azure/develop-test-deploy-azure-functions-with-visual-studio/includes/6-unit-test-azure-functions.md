Unit testing is a fundamental part of an Agile methodology. Visual Studio provides the Test project template. Use this template to create the unit tests for your applications, and you can apply the same technique to testing for Azure Functions.

In the luxury watch online website scenario, your development team has a policy to achieve at least 80% coverage of code in unit testing. You would like to implement the same policy for Azure Functions.

In this unit, you'll see how to use the `xUnit` test framework with Visual Studio to test Azure Functions.

## Create a unit test project

The first step is to create a project that contains your unit tests, and add it to the solution holding your Azure Function App. Use the following steps to create a unit test project for testing the *WatchInfo* function.

1. In Visual Studio, in the **Solution Explorer** window, right-click the **WatchPortalFunction** solution, select **Add**, and then select **New Project**.

    :::image type="content" source="../media/6-add-new-project-to-solution.png" alt-text="Screenshot of Solution Explorer, showing the Add new project to solution command." loc-scope="vs":::

1. In the **Add a new project** window, scroll down, select the **xUnit Test Project (.NET Core)** template, and then select **Next**.

    :::image type="content" source="../media/6-add-xunit-project.png" alt-text="Screenshot of Add New Project window. The user has selected the xUnit Test Project template." loc-scope="vs":::

1. The **Configure your new project** window appears. In the **Project name** field, enter **WatchFunctionsTests**. Aside the **Location** field, select the browse icon, and then select **WatchPortalFunction**. Select **Create.**

1. When the project has been added, right-click the **WatchFunctionTests** project in the **Solution Explorer** window, and then select **Manage NuGet Packages**.

1. In the **NuGet: WatchFunctionTests** window, select the **Browse** tab. In the **Search** box, enter **Microsoft.AspNetCore.Mvc**. Select the **Microsoft.AspNetCore.Mvc** package, and then select **Install**.

    :::image type="content" source="../media/6-nuget-install-aspnet-mvc.png" alt-text="Screenshot of the NuGet Package Manager window. The user is installing the Microsoft.AspNetCore.Mvc package." loc-scope="vs":::

    > [!NOTE]
    > The test project will create a mock HTTP environment. The classes required for doing this are in the **Microsoft.AspNetCore.Mvc** package.

1. Wait while the package in installed. If the **Preview Changes** message box appears, select **OK**. In the **License Acceptance** message box, select **I Accept**.

1. After the package has been added, in the **Solution Explorer** window, under the **WatchFunctionsTest** project, right-click the **UnitTest1.cs** file, and then select **Rename**. Change the name of the file to **WatchFunctionUnitTests.cs**. In the message box that appears, to rename all references of **UnitTest1** to **WatchFunctionUnitTests**, select **Yes**.

1. In the **Solution Explorer** window, under the **WatchFunctionsTest** project, right-click **Dependencies**, and then select **Add Reference**.

1. In the **Reference Manager** window, select the **WatchPortalFunction** project, and then select **OK**.

## Add unit tests for the WatchInfo function

You can now add unit tests to the test project. In the luxury watch scenario, you want to ensure the **WatchInfo** function always returns an *OK* response when a model is provided in the query string of a request, and a *Bad* response if the query string is empty or doesn't contain the `model` parameter.

To verify this behavior, you'll add a pair of *Fact* tests to the **WatchFunctionsTests**.

1. In the **Solution Explorer** window, to display it in the code window, double-click the **WatchFunctionUnitTests.cs** file.

1. At the top of the file, add the following `using` directives to the list.

    ```csharp
    using Microsoft.AspNetCore.Http;
    using Microsoft.AspNetCore.Http.Internal;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.Extensions.Primitives;
    using Microsoft.Extensions.Logging.Abstractions;
    ```

1. Change the name of the **Test1** method to **TestWatchFunctionSuccess**.

1. In the body of the **TestWatchFunctionSuccess** method, add the following code. This statement creates a mock HTTP context and an HTTP request. The request includes a query string that includes the `model` parameter, which is set to `abc`.

    ```csharp
    var queryStringValue = "abc";
    var request = new DefaultHttpRequest(new DefaultHttpContext())
    {
        Query = new QueryCollection
        (
            new System.Collections.Generic.Dictionary<string, StringValues>()
            {
                { "model", queryStringValue }
            }
        )
    };
    ```

1. Add the following statement to the method. This statement creates a dummy logger.

    ```csharp
    var logger = NullLoggerFactory.Instance.CreateLogger("Null Logger");
    ```

1. Add the following code to the method. These statements invoke the **WatchInfo** function, passing in the dummy request and logger as parameters.

    ```csharp
    var response = WatchPortalFunction.WatchInfo.Run(request, logger);
    response.Wait();
    ```

1. Add the following code to the method. This code checks that the response from the Azure Function is correct. In this case, the function should return an *OK* response, containing the expected body data.

    ```csharp
    // Check that the response is an "OK" response
    Assert.IsAssignableFrom<OkObjectResult>(response.Result);

    // Check that the contents of the response are the expected contents
    var result = (OkObjectResult)response.Result;
    dynamic watchinfo = new { Manufacturer = "abc", CaseType = "Solid", Bezel = "Titanium", Dial = "Roman", CaseFinish = "Silver", Jewels = 15 };
    string watchInfo = $"Watch Details: {watchinfo.Manufacturer}, {watchinfo.CaseType}, {watchinfo.Bezel}, {watchinfo.Dial}, {watchinfo.CaseFinish}, {watchinfo.Jewels}";
    Assert.Equal(watchInfo, result.Value);
    ```

    The complete method should look like the following.
  
    ```csharp
    [Fact]
    public void TestWatchFunctionSuccess()
    {
        var queryStringValue = "abc";
        var request = new DefaultHttpRequest(new DefaultHttpContext())
        {
            Query = new QueryCollection
            (
                new System.Collections.Generic.Dictionary<string, StringValues>()
                {
                    { "model", queryStringValue }
                }
            )
        };

        var logger = NullLoggerFactory.Instance.CreateLogger("Null Logger");

        var response = WatchPortalFunction.WatchInfo.Run(request, logger);
        response.Wait();

        // Check that the response is an "OK" response
        Assert.IsAssignableFrom<OkObjectResult>(response.Result);

        // Check that the contents of the response are the expected contents
        var result = (OkObjectResult)response.Result;
        dynamic watchinfo = new { Manufacturer = "abc", CaseType = "Solid", Bezel = "Titanium", Dial = "Roman", CaseFinish = "Silver", Jewels = 15 };
        string watchInfo = $"Watch Details: {watchinfo.Manufacturer}, {watchinfo.CaseType}, {watchinfo.Bezel}, {watchinfo.Dial}, {watchinfo.CaseFinish}, {watchinfo.Jewels}";
        Assert.Equal(watchInfo, result.Value);
    }
    ```
  
1. Add two more methods named **TestWatchFunctionFailureNoQueryString** and **TestWatchFunctionFailureNoModel**. The  **TestWatchFunctionFailureNoQueryString** verifies that the **WatchInfo** function fails gracefully if it isn't given a query string. The **TestWatchFunctionFailureNoModel** checks for the same failure if the function is passed a query string that doesn't contain a model parameter.

    ```csharp
    [Fact]
    public void TestWatchFunctionFailureNoQueryString()
    {
        var request = new DefaultHttpRequest(new DefaultHttpContext());
        var logger = NullLoggerFactory.Instance.CreateLogger("Null Logger");

        var response = WatchPortalFunction.WatchInfo.Run(request, logger);
        response.Wait();

        // Check that the response is an "Bad" response
        Assert.IsAssignableFrom<BadRequestObjectResult>(response.Result);

        // Check that the contents of the response are the expected contents
        var result = (BadRequestObjectResult)response.Result;
        Assert.Equal("Please provide a watch model in the query string", result.Value);
    }

    [Fact]
    public void TestWatchFunctionFailureNoModel()
    {
        var queryStringValue = "abc";
        var request = new DefaultHttpRequest(new DefaultHttpContext())
        {
            Query = new QueryCollection
            (
                new System.Collections.Generic.Dictionary<string, StringValues>()
                {
                    { "not-model", queryStringValue }
                }
            )
        };

        var logger = NullLoggerFactory.Instance.CreateLogger("Null Logger");

        var response = WatchPortalFunction.WatchInfo.Run(request, logger);
        response.Wait();

        // Check that the response is an "Bad" response
        Assert.IsAssignableFrom<BadRequestObjectResult>(response.Result);

        // Check that the contents of the response are the expected contents
        var result = (BadRequestObjectResult)response.Result;
        Assert.Equal("Please provide a watch model in the query string", result.Value);
    }
    ```

## Run the tests

1. On the **Test** menu, select **Run All Tests**.

    :::image type="content" source="../media/6-start-tests.png" alt-text="Screenshot of the Test menu in Visual Studio. The user has selected Run -> All Tests." loc-scope="vs":::

1. In the **Test Explorer** window, all three tests should complete successfully.

    :::image type="content" source="../media/6-test-success.png" alt-text="Screenshot of the Team Explorer window. All three tests ran successfully." loc-scope="vs":::

1. In the **Solution Explorer** window, under the **WatchPortalFunction** project, to display the file in the code editor, double-click **WatchInfo.cs**.

1. Find the following code.

    ```csharp
    // Retrieve the model id from the query string
    string model = req.Query["model"];
    ```

1. Change the statement that sets the `model` variable as follows. This change simulates the developer making a mistake in the code.

    ```csharp
    string model = req.Query["modelll"];
    ```

1. On the **Test** menu, select **Run**, and to repeat the tests, select **All Tests**. This time, the **TestWatchFunctionSuccess** test should fail. This failure occurs because the **WatchInfo** function hasn't found the parameter named `modelll` in the query string, and so the function has returned a *Bad* response.

    :::image type="content" source="../media/6-test-failure.png" alt-text="Screenshot of the Team Explorer window. The TestWatchFunctionSuccess test failed." loc-scope="vs":::

You've now seen how to create a unit test project, and implement unit tests for an Azure Function.
