erhaps add a feature or change something in the app that causes a test to fail.

Maybe we forgot to run tests before submitting to the pipeline.

See the build fail and the GitHub badge go red.

Review and analyze the failure in Azure Test Plans.

Remediate the failure, starting locally (e.g. Cloud Shell). The remediation might be to fix a bug in the code or to adjust the tests (which may be valid if behavior has changed.)

Push up the change and watch the build go green again.

-----

Notes from spike:

Let's say a test got checked in (or a feature added) that causes a test to fail.

- Get the unit tests.

    ```bash
    git fetch upstream failed-test
    ```

    ```bash
    git checkout failed-test
    ```

- Push up the change

    ```bash
    git push origin failed-test
    ```

- Create a Pull Request

    Watch the build. Trace the tasks as they run. Notice the `CmdLine` task fails. (Show screenshot?)

- From Azure DevOps, select **Test Plans**, **Runs**. You see the recent test runs, including the one that just ran.
- Select the latest completed test. You see that one tests failed. (Show screenshot?)
- Also note the failure in the PR.

### Fix the error

At this point, you have two choices, depending on ...

- If the test revealed a defect in the code, fix the code.
- If functionality changed, adjust the test to match the new requirements.

(TBD on which path we take.)

- Verify failure locally.

    ```bash
    dotnet test src/Xamarin.Web.DevConnect.Tests
    ```

- In blah.cs, add this code:

    ```csharp
    # TBD based on what we discover
    ```

- Verify fix locally.

    ```bash
    dotnet test src/Xamarin.Web.DevConnect.Tests
    ```

- Add, commit, push

    ```bash
    git add blah.cs
    ```

    ```bash
    git commit -m "Fix failing test"
    ```

    ```bash
    git push origin failed-test
    ```

- Return to Azure Pipelines. Watch the change move through the pipeline. You see the tests pass.