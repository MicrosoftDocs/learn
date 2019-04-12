Andy is going to work with Mara and add unit tests to the automated build that Mara created with Azure Pipelines. Regression bugs are creeping into their code and breaking the leaderboard's filtering functionality. Specifically, the wrong game mode keeps appearing.

The following image illustrates Amita's problem. When she selects "Milky Way" to show only scores from that game map, she gets results from other game maps such as Andromeda.

![The leaderboard showing incorrect results](../media/4-leaderboard-bug.png)

Both Andy and Mara want to catch the error before it reaches Amita, the tester. Unit tests are a great way to automatically test for regression bugs. 

Andy also thinks that adding the unit tests now will give them a head start as they improve the _Space Game_ web app. The application uses a document database to store high scores and player profiles. Right now, it uses local test data. Later, they plan to connect the app to a live database. 

There are a number of unit test frameworks available for C# applications. Mara chooses NUnit because it's popular with the community and she's used it before.

Here's the unit test you'll work with, along with Mara and Andy.

<!-- TODO: Should be game map in the test? -->

```csharp
[TestCase("Milky Way")]
[TestCase("Andromeda")]
[TestCase("Pinwheel")]
[TestCase("NGC 1300")]
[TestCase("Messier 82")]
public void ReturnRequestedGameMode(string gameMode)
{
    const int PAGE = 0; // take the first page of results
    const int MAX_RESULTS = 10; // sample up to 10 results

    // Form the query predicate.
    // This expression selects all scores for the provided game mode.
    Expression<Func<Score, bool>> queryPredicate = score => (score.GameMode == gameMode);

    // Fetch the scores.
    Task<IEnumerable<Score>> scoresTask = _scoreRepository.GetItemsAsync(
        queryPredicate, // the predicate defined above
        score => 1, // we don't care about the order
        PAGE,
        MAX_RESULTS
    );
    IEnumerable<Score> scores = scoresTask.Result;

    // Verify that each score's game mode matches the provided game mode.
    Assert.That(scores, Is.All.Matches<Score>(score => score.GameMode == gameMode));
}
```

You can filter the leaderboard by any combination of game type and game map.

This test queries the leaderboard for high scores and verifies that each result matches the provided game map.

In an NUnit test method, `TestCase` provides inline data to use to test that method. Here, NUnit calls the `ReturnRequestedGameMode` unit test method like this:

```csharp
ReturnRequestedGameMode("Milky Way");
ReturnRequestedGameMode("Andromeda");
ReturnRequestedGameMode("Pinwheel");
ReturnRequestedGameMode("NGC 1300");
ReturnRequestedGameMode("Messier 82");
```

Notice the call to the `Assert.That` method at the end of the test. An _assertion_ is a condition or statement that you declare to be true. If the condition turns out to be false, that could indicate a bug in your code. NUnit runs each test method using the inline data you specify and records the result as a passing or failing test.

Many unit test frameworks provide verification methods that resemble natural language. This helps make tests easy to read and maps the test to the application's requirements.

Consider the assertion made in this example.

```csharp
Assert.That(scores, Is.All.Matches<Score>(score => score.GameMode == gameMode));
```

You might read this line as:

> _Assert that the game mode of each returned score matches the provided game mode._

Here's the process you'll follow.

1. Fetch a branch from Microsoft's GitHub repository that contains the unit tests.
1. Run the tests locally to verify that they pass.
1. Add tasks to your pipeline configuration to run the tests and collect the results.
1. Push the branch to your GitHub repository.
1. Watch your Azure Pipelines project automatically build the application and run the tests.

-----

## Fetch the branch from GitHub

Here you'll fetch the `unit-tests` branch from GitHub and checkout, or switch to, that branch.

This branch contains the _Space Game_ project you worked with in the previous modules and an Azure Pipelines configuration to start with.

1. From Visual Studio Code, open the integrated terminal.
1. Run the following `git fetch` command to download the `unit-tests` branch from Microsoft's repository.

    ```bash
    git fetch upstream unit-tests
    ```

    The `git fetch` command downloads a branch from a given repository. The repository name is known as a _tracked repository_ or _remote_. Here, `upstream` refers to Microsoft's GitHub repository. Shortly, you'll push this branch up to your GitHub repository, known as `origin`.

    Your project's Git configuration understands the `upstream` remote because that relationship is set up when you fork the project from Microsoft's repository.

1. Run the following `git checkout` command to switch to the `unit-tests` branch.

    ```bash
    git checkout unit-tests
    ```

## Run the tests locally

It's a good idea to run all tests locally before you submit any tests to the pipeline. Here you'll do that.

1. Run `dotnet build` to build each project in the solution.

    ```bash
    dotnet build
    ```

1. Run the following `dotnet test` command to run the unit tests.

    ```bash
    dotnet test Tailspin.SpaceGame.Web.Tests --no-build
    ```

    The "Tailspin.SpaceGame.Web.Tests" part specifies to run the unit tests in the **Tailspin.SpaceGame.Web.Tests** project.

    The `--no-build` flag specifies not to build the project before running it. You don't need to build the project because you built it in the previous step.

    You see that all five tests pass.

    ```output
    Starting test execution, please wait...

    Total tests: 5. Passed: 5. Failed: 0. Skipped: 0.
    Test Run Successful.
    Test execution time: 1.0939 Seconds
    ```

    In this example, the tests took about one second to run.

1. Run the tests a second time. This time, provide the `--logger` option to write the results to a log file.

    ```bash
    dotnet test Tailspin.SpaceGame.Web.Tests --no-build --logger trx
    ```

    A .trx file is an XML document that contains the results of a test run. It's a popular format for NUnit tests because Visual Studio and other tools can help you visualize the results.

    Later, you'll see how Azure Pipelines can help you visualize and track your tests results as they run through the pipeline.

## Add tasks to your pipeline configuration

Recall that when you set up the pipeline, you used a template to define repeatable build tasks.

Here, you'll repeat a similar process to run the unit tests tests and collect the results.

1. From the integrated terminal, create a file named **test.yml** in the **templates** directory.

    **PowerShell**

    ```powershell
    TBD
    ```

    **Bash**

    ```bash
    touch templates/test.yml
    ```

    <!-- TODO: Add PowerShell equivalent -->

1. From Visual Studio Code, add this to **test.yml**.

    ```yml
    parameters:
      buildConfiguration: 'Release'

    steps:
    - task: DotNetCoreCLI@2
      displayName: 'dotnet test ${{ parameters.buildConfiguration }}'
      inputs:
        command: 'test'
        arguments: '--no-build --configuration ${{ parameters.buildConfiguration }}'
        publishTestResults: true
        projects: '**/*.Tests.csproj'
    ```

    This task uses the `DotNetCoreCLI@2` build task and resembles the task you used to build the application (you can compare this task to what's in **templates/build.yml**.)

    Notice that this task does not specify the `--logger trx` argument that you used when you ran the tests manually. The `publishTestResults` argument adds that for you. This argument tells the pipeline to generate the TRX file to a temporary directory, accessible through the `$(Agent.TempDirectory)` built-in variable, where the pipeline can pick it up later.

    The `projects` argument specifies all C# projects that match "**/*.Tests.csproj". The "\*\*" part matches all directories and the "\*.Tests.csproj" part matches all projects whose file name ends with ".Tests.csproj". The `unit-tests` branch contains one unit test project, Tailspin.SpaceGame.Web.Tests.csproj. But specifying a pattern enables you to run additional test projects without the need to modify your build configuration.

1. From Visual Studio Code, modify **azure-pipelines.yml** like this to run the unit tests.

    ```yml
    pool:
      vmImage: 'Ubuntu-16.04'
      demands:
        - npm

    variables:
      wwwrootDir: 'Tailspin.SpaceGame.Web/wwwroot'
      dotnetSdkVersion: '2.1.505'

    steps:
    - task: DotNetCoreInstaller@0
      displayName: 'Use .NET Core SDK $(dotnetSdkVersion)'
      inputs:
        version: '$(dotnetSdkVersion)'

    - task: Npm@1
      displayName: 'npm install'
      inputs:
        verbose: false

    - script: './node_modules/.bin/node-sass $(wwwrootDir) --output $(wwwrootDir)'
      displayName: 'node-sass $(wwwrootDir)'

    - task: gulp@1
      displayName: 'gulp'

    - script: 'echo "$(Build.DefinitionName), $(Build.BuildId), $(Build.BuildNumber)" > buildinfo.txt'
      workingDirectory: $(wwwrootDir)
      displayName: 'output build info'

    - task: DotNetCoreCLI@2
      inputs:
        command: 'restore'
        projects: '**/*.csproj'

    - template: templates/build.yml
      parameters:
        buildConfiguration: 'Debug'

    - template: templates/build.yml
      parameters:
        buildConfiguration: 'Release'

    - template: templates/test.yml
      parameters:
        buildConfiguration: 'Debug'

    - task: PublishTestResults@2
      condition: succeeded()
      inputs:
        testRunner: 'NUnit'
        testResultsFiles: '**/*.trx'

    - task: PublishBuildArtifacts@1
      condition: succeeded()
      displayName: 'Publish Artifact: drop'
    ```

    This version adds these build tasks.

    ```yml
    - template: templates/test.yml
      parameters:
        buildConfiguration: 'Debug'

    - task: PublishTestResults@2
      condition: succeeded()
      inputs:
        testRunner: 'NUnit'
        testResultsFiles: '**/*.trx'
    ```

    The first task calls the tasks you just defined in **templates/test.yml**. Here, we run the tests only using the Debug build configuration. You could also call the template a second time using the Release configuration.

    The second task uses the `PublishTestResults@2` build task to publish the test results to the pipeline. Similar to the `PublishBuildArtifacts@1` build task you used earlier, this task copies all .trx files from the build server to the pipeline so you can access them later. You'll see how to understand and analyze test results in just a bit.

## Push the branch to GitHub

Here you'll push your changes to GitHub and see the pipeline run. Recall that you're currently on the `unit-tests` branch.

1. From the integrated terminal, add **azure-pipelines.yml** and **templates/test.yml** to the index, commit the changes, and push the branch up to GitHub.

    ```bash
    git add azure-pipelines.yml templates/test.yml
    git commit -m "Run and publish unit tests"
    git push origin unit-tests
    ```

## Watch Azure Pipelines run the tests

Here you'll see the tests run in the pipeline and then visualize the results from Azure Test Plans. Azure Test Plan provides all the tools you need to successfully test your applications. You can create and run manual test plans, generate automated tests and collect feedback from users. 

<!-- TODO: We really haven't talked about Azure Test Plans yet. Add it to the knowledge unit? -->

1. From Azure DevOps, trace the build through each of the steps.
    **TODO**: Say something more here. Perhaps show a screenshot showing our new tasks.

1. From Azure DevOps, select **Test Plans**. Then select **Runs**.

    <!-- TODO: Screenshot to orient the learner where to find it? -->

    You see the most recent test runs, including the one you just ran.

1. Double click the most recent test run.

    You see a summary of the results.

    ![Test results summary in Azure Test Plans](../media/4-test-run-results.png)

    In this example, all five tests have passed. If any tests failed, you could navigate to the build task to get additional details.

    You can also download the .trx file so you can examine it through Visual Studio or another visualization tool.

<!-- TODO: When/if do we create a PR and merge the `unit-tests` branch? -->
<!-- TODO: Later: I think we should do this now so the learner can git checkout -b from master -->

Although Mara and Andy have only added one test, it's a good start and fixes the immediate problem. Now, the team has a place to add more tests and run them as they improve their process.