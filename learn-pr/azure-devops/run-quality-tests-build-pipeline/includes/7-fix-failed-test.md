At this point, you have a way to run unit tests as changes move through the build pipeline. You also have a way to measure the amount of code that's covered by your tests.

It's always a good idea to run your tests locally before you submit changes to the pipeline. But what happens when someone forgets and submits a change that breaks the build?

In this unit, you'll fix a broken build that's caused by a failing unit test. Here, you will:

> [!div class="checklist"]
> * Get starter code from GitHub.
> * Add code coverage tools to your project.
> * Push the code up to your repository.
> * Watch the pipeline automatically run and the unit tests fail.
> * Reproduce the failure locally.
> * Analyze and fix the failure.
> * Push up a fix and watch the build succeed.

## Review the new unit test

The team's latest feature involves the leaderboard. We need to get the number of scores from the database, so we can write a unit test to verify the `IDocumentDBRepository<T>.GetItemsAsync` method.

Here's what the test looks like. You don't need to add any code yet.

```csharp
[TestCase(0, ExpectedResult=0)]
[TestCase(1, ExpectedResult=1)]
[TestCase(10, ExpectedResult=10)]
public int ReturnRequestedCount(int count)
{
    const int PAGE = 0; // take the first page of results

    // Fetch the scores.
    Task<IEnumerable<Score>> scoresTask = _scoreRepository.GetItemsAsync(
        score => true, // return all scores
        score => 1, // we don't care about the order
        PAGE,
        count // fetch this number of results
    );
    IEnumerable<Score> scores = scoresTask.Result;

    // Verify that we received the specified number of items.
    return scores.Count();
}
```

Recall that in an NUnit test, `TestCase` provides inline data to use to test that method. NUnit calls the `ReturnRequestedCount` unit test method like this:

```csharp
ReturnRequestedCount(0);
ReturnRequestedCount(1);
ReturnRequestedCount(10);
```

This test also uses the `ExpectedResult` property to simplify the test code and help make its intention clear. NUnit automatically compares the return value against the value of this property, removing the need to explicitly call the assertion.

We'll choose a few values that represent typical queries. We'll also include 0 to cover that edge case.

## Fetch the branch from GitHub

As you did earlier, fetch the `failed-test` branch from GitHub and check out (or switch to) that branch.

1. In Visual Studio Code, open the integrated terminal.
1. Run the following `git fetch` and `git checkout` commands to download a branch named `failed-test` from the Microsoft repository and switch to that branch:

    ```bash
    git fetch upstream failed-test
    git checkout -B failed-test upstream/failed-test
    ```

    We named the branch `failed-test` for learning purposes. In practice, you'd name a branch after its purpose or feature.

1. Run these commands to create a local tool manifest file, install the `ReportGenerator` tool, and add the `coverlet.msbuild` package to your tests project:

    ```dotnetcli
    dotnet new tool-manifest
    dotnet tool install dotnet-reportgenerator-globaltool
    dotnet add Tailspin.SpaceGame.Web.Tests package coverlet.msbuild
    ```

    You need this step because the `failed-test` branch doesn't contain the work you added to the `unit-tests` branch.

1. Add your test project file and your tool manifest file to the staging index and commit your changes.

    ```bash
    git add Tailspin.SpaceGame.Web.Tests/Tailspin.SpaceGame.Web.Tests.csproj
    git add .config/dotnet-tools.json
    git commit -m "Configure code coverage tests"
    ```

1. Run the following `git push` command to upload the `failed-test` branch to your GitHub repository:

    ```bash
    git push origin failed-test
    ```

## See the test failure in the pipeline

Let's say that you were in a hurry and pushed up your work without running the tests one final time. Luckily, the pipeline can help you catch issues early when there are unit tests. You can see that here.

1. In Azure Pipelines, trace the build as it runs through the pipeline.
1. Expand the **Run unit tests - Release** task as it runs.

    You see that the `ReturnRequestedCount` test method fails.

    :::image type="content" source="../media/7-pipeline-test-failure.png" alt-text="A screenshot of Azure Pipelines dashboard showing output log of an assertion failure on the unit test, expecting 10 but was 9.":::

    The test passes when the input value is 0, but it fails when the input value is 1 or 10.

    The build is published to the pipeline only when the previous task succeeds. Here, the build wasn't published because the unit tests failed. This prevents others from accidentally obtaining a broken build.

In practice, you won't always manually trace the build as it runs. Here are a few ways you might discover the failure:

* **An email notification from Azure DevOps**

    You can configure Azure DevOps to send you an email notification when the build is complete. The subject line starts with "[Build failed]" when the build fails.

    :::image type="content" source="../media/7-email-notification.png" alt-text="A screenshot of a portion of a build failed email notification.":::
* **Azure Test Plans**

    In Azure DevOps, select **Test Plans**, and then select **Runs**. You see the recent test runs, including the one that just ran. Select the latest completed test. You see that two of the eight tests failed.

    :::image type="content" source="../media/7-test-run-outcome.png" alt-text="A screenshot of Azure DevOps test run outcome showing two of eight failed tests as a ring chart.":::
* **The dashboard**

    In Azure DevOps, select **Overview**, and then select **Dashboards**. You see the failure appear in the **Test Results Trend** widget. The **Code Coverage** widget is blank, which indicates that code coverage wasn't run.

    :::image type="content" source="../media/7-dashboard-failed-test.png" alt-text="A screenshot of Azure DevOps dashboard trend chart widget showing two failed test in the last test run.":::
* **The build badge**

    Although the `failed-test` branch doesn't include the build badge in the *README.md* file, here's what you would see on GitHub when the build fails:

    :::image type="content" source="../media/7-badge-failed.png" alt-text="A screenshot of Azure Pipelines build badge on GitHub indicating a failure.":::

## Analyze the test failure

When unit tests fail, you ordinarily have two choices, depending on the nature of the failure:

* If the test reveals a defect in the code, fix the code and rerun the tests.
* If the functionality changes, adjust the test to match the new requirements.

### Reproduce the failure locally

In this section, you'll reproduce the failure locally.

1. In Visual Studio Code, open the integrated terminal.
1. In the terminal, run this `dotnet build` command to build the application:

    ```dotnetcli
    dotnet build --configuration Release
    ```

1. In the terminal, run this `dotnet test` command to run the unit tests:

    ```dotnetcli
    dotnet test --no-build --configuration Release
    ```

    You should see the same errors that you saw in the pipeline. Here's part of the output:

    ```output
    Starting test execution, please wait...
    A total of 1 test files matched the specified pattern.
      Failed ReturnRequestedCount(1) [33 ms]
      Error Message:
         Expected: 1
      But was:  0
    
      Stack Trace:
         at NUnit.Framework.Internal.Commands.TestMethodCommand.Execute(TestExecutionContext context)
       at NUnit.Framework.Internal.Commands.BeforeAndAfterTestCommand.<>c__DisplayClass1_0.<Execute>b__0()
       at NUnit.Framework.Internal.Commands.BeforeAndAfterTestCommand.RunTestMethodInThreadAbortSafeZone(TestExecutionContext context, Action action)
    
      Failed ReturnRequestedCount(10) [1 ms]
      Error Message:
         Expected: 10
      But was:  9
    
      Stack Trace:
         at NUnit.Framework.Internal.Commands.TestMethodCommand.Execute(TestExecutionContext context)
       at NUnit.Framework.Internal.Commands.BeforeAndAfterTestCommand.<>c__DisplayClass1_0.<Execute>b__0()
       at NUnit.Framework.Internal.Commands.BeforeAndAfterTestCommand.RunTestMethodInThreadAbortSafeZone(TestExecutionContext context, Action action)
    
    
    Failed!  - Failed:     2, Passed:     6, Skipped:     0, Total:     8, Duration: 98 ms
    ```

### Find the cause of the error

You notice that each failed test produces a result that's off by one. For example, when 10 is expected, the test returns 9.

Take a look at the source code for the method that's being tested, `LocalDocumentDBRepository<T>.GetItemsAsync`. You should see this:

```csharp
public Task<IEnumerable<T>> GetItemsAsync(
    Func<T, bool> queryPredicate,
    Func<T, int> orderDescendingPredicate,
    int page = 1, int pageSize = 10
)
{
    var result = _items
        .Where(queryPredicate) // filter
        .OrderByDescending(orderDescendingPredicate) // sort
        .Skip(page * pageSize) // find page
        .Take(pageSize - 1); // take items

    return Task<IEnumerable<T>>.FromResult(result);
}
```

In this scenario, you could check GitHub to see if the file was recently changed.

:::image type="content" source="../media/7-github-diff.png" alt-text="A screenshot of GitHub showing a file diff where a minus one operation was added.":::

You suspect that `pageSize - 1` is returning one fewer result and that this should be just `pageSize`. In our scenario, this is an error you made when you pushed work without testing, but in a real-world scenario, you could check with the developer who changed the file on GitHub to determine the reason for the change.

> [!TIP]
> Discussion and collaboration can also happen on GitHub. You can comment on a pull request or open an issue.

## Fix the error

In this section, you'll fix the error by changing the code back to its original state and running the tests to verify the fix.

1. In Visual Studio Code, open *Tailspin.SpaceGame.Web/LocalDocumentDBRepository.cs* from the file explorer.
1. Modify the `GetItemsAsync` method as shown here:

    ```csharp
    public Task<IEnumerable<T>> GetItemsAsync(
        Func<T, bool> queryPredicate,
        Func<T, int> orderDescendingPredicate,
        int page = 1, int pageSize = 10
    )
    {
        var result = _items
            .Where(queryPredicate) // filter
            .OrderByDescending(orderDescendingPredicate) // sort
            .Skip(page * pageSize) // find page
            .Take(pageSize); // take items

        return Task<IEnumerable<T>>.FromResult(result);
    }
    ```

    This version changes `pageSize - 1` to `pageSize`.

1. Save the file.
1. In the integrated terminal, build the application.

    ```dotnetcli
    dotnet build --configuration Release
    ```

    You should see that the build succeeds.

    In practice, you might run the app and briefly try it out. For learning purposes, we'll skip that for now.

1. In the terminal, run the unit tests.

    ```dotnetcli
    dotnet test --no-build --configuration Release
    ```

    You see that the tests pass.

    ```output
    Starting test execution, please wait...
    A total of 1 test files matched the specified pattern.
    
    Passed!  - Failed:     0, Passed:     8, Skipped:     0, Total:     8, Duration: 69 ms
    ```

1. In the integrated terminal, add each modified file to the index, commit the changes, and push the branch up to GitHub.

    ```bash
    git add .
    git commit -m "Return correct number of items"
    git push origin failed-test
    ```

    > [!TIP]
    > The dot (`.`) in this `git add` example is a wildcard character. It matches all unstaged files in the current directory and all subdirectories.
    >
    > Before you use this wildcard character, it's a good practice to run `git status` before you commit to ensure that you're staging the files you intend to stage.

1. Return to Azure Pipelines. Watch the change move through the pipeline. The tests pass, and the overall build succeeds.

    Optionally, to verify the test results, you can select the **Tests** and **Code Coverage** tabs when the build completes.

    You can also check out the dashboard to view the updated results trend.

    :::image type="content" source="../media/7-dashboard-passing-test.png" alt-text="A screenshot of Azure DevOps dashboard trend chart widget showing a return to all tests passing.":::

Great! You've fixed the build. Next, you'll learn how to clean up your Azure DevOps environment.
