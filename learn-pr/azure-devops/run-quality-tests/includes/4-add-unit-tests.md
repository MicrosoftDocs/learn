We'll continue to work with the same sample app as from the previous module.

[**DISCUSSION:** When working with the same app over multiple modules, is it better to use a clean repo for each module or have the user switch to a specific branch? There are pros/cons to each approach.]

1. Get the tests (`git clone` or `git checkout`)
1. Run the tests locally. See them pass.
1. Set up Azure Test Plans to run them.
1. Push up your branch with the tests and run them. See them pass.

----- 

Notes from spike:

TODO: Use VSTest@2 instead?

- Get the unit tests.

    ```bash
    git fetch upstream unit-tests
    ```

    ```bash
    git checkout unit-tests
    ```

- Run them locally

    ```bash
    dotnet test src/Xamarin.Web.DevConnect.Tests
    ```

    You see

    ```bash
    Build started, please wait...
    Build completed.

    Test run for /Users/thpetche/Dev/ceapex/DevConnectWeb0207/src/Xamarin.Web.DevConnect.Tests/bin/Debug/netcoreapp2.0/Xamarin.Web.DevConnect.Tests.dll(.NETCoreApp,Version=v2.0)
    Microsoft (R) Test Execution Command Line Tool Version 15.7.0
    Copyright (c) Microsoft Corporation.  All rights reserved.

    Starting test execution, please wait...

    Total tests: 3. Passed: 3. Failed: 0. Skipped: 0.
    Test Run Successful.
    Test execution time: 1.1635 Seconds
    ```

- Run tests with a logger.

    ```bash
    dotnet test src/Xamarin.Web.DevConnect.Tests --logger trx
    ```

- Add this to azure-pipelines.yml after the `VSBuild@1` task:

    ```yml
    # Run tests
    - script: dotnet test src/Xamarin.Web.DevConnect.Tests --logger trx
    - task: PublishTestResults@2
      condition: succeeded()
      inputs:
        testRunner: VSTest
        testResultsFiles: '**/*.trx'
    ```

- Add, commit, & push up the change

    ```bash
    git add azure-pipelines.yml
    ```

    ```bash
    git commit -m "Run and publish unit tests"
    ```

    ```bash
    git push origin unit-tests
    ```

- Create a Pull Request

    Watch the build. Trace the tasks as they run. Notice the `PublishTestResults` task. (Show screenshot?)

- From Azure DevOps, select **Test Plans**, **Runs**. You see the recent test runs, including the one that just ran.
-  Select the completed test. You see that all tests passed. (Show screenshot?)

- Merge the PR.