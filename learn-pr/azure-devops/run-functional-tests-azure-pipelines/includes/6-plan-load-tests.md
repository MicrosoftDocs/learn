Before Andy and Amita run their tests in the pipeline, they want to verify that their tests accomplish their goals by first running them locally. In this section, you follow along by running the Selenium UI tests locally and then in the pipeline.

Writing automated tests is an iterative process, just like writing any other kind of code. In practice, you'll likely need to try a few different approaches, refer to reference documentation and other example code, and fix build errors.

## Run the UI tests locally

TODO: Sigh -

* EXPORT ENV VAR
* RUN TESTS
* TALK ABOUT SECURITY ISSUE AND HOW IN PRACTICE YOU MIGHT DEAL WITH THAT.

1. In Visual Studio Code, open the integrated terminal.
1. From the terminal, ensure you're in your project's root directory. The location of this directory depends on where you cloned it locally. Here's an example:

    ```bash
    cd ~/mslearn-tailspin-spacegame-web-deploy
    ```
1. Build the application code.

    ```bash
    dotnet build --configuration Release
    ```

    For brevity, here we build only the **Release** configuration.
1. Run the UI tests.

    ```bash
    dotnet test --configuration Release Tailspin.SpaceGame.Web.UITests
    ```

    This runs the tests that are located in the *Tailspin.SpaceGame.Web.UITests* project.

    As the tests run, you see one or more browsers appear. Selenium controls each browser and performs the test steps that you defined.

    > [!NOTE]
    > Don't worry if you don't see all three browsers appear. For example, you won't see the tests run on Chrome if you don't have Chrome installed. You also won't see Internet Explorer tests run on macOS or Linux. Seeing just one browser will help give you confidence that your tests are working. In practice, you might set up all browsers you want to test on in your local development environment so that you can verify that your tests behave as expected in each configuration before you run your tests in the pipeline.
1. From the terminal, trace the output of each test. Also note the test run summary at the end.

    Here's an example that shows how out of the nine total tests, six succeeded and three were skipped.

    ```output
    Test Run Successful.
    Total tests: 9
         Passed: 6
        Skipped: 3
     Total time: 17.3051 Seconds
    ```

## Modify the build configuration

In this section, you modify the build configuration to run your Selenium UI tests during the _Test_ stage.

1. In Visual Studio Code, open the *azure-pipelines.yml* file. Then modify the file like this:

    > [!TIP]
    > You can replace the entire file or just update the part that's highlighted.

    ```yml
    TODO
    ```

    TODO: Talk more about the changes.
    TODO: Talk about why we use Windows Build agent

    * It's what Amita uses to test where her users come from most.
    * The build agent is already set up with Selenium for UI testing.

1. In the integrated terminal, add **azure-pipelines.yml** to the index, commit the changes, and push the branch up to GitHub.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Run Selenium UI tests"
    git push origin selenium-tests
    ```

## Watch Azure Pipelines run the tests

Here you watch the pipeline run, including the Selenium UI tests during the _Test_ stage.

1. In Azure DevOps, go to the **Space Game - web - UI Tests** project.
1. On the project page or in the left pane, select **Pipelines**.
1. Select **Builds**, and then select the running build.
1. Trace the build through each of the steps.
1. TALK ABOUT TEST TAB; YOU SEE ...; THEN SHOW SCREENSHOT