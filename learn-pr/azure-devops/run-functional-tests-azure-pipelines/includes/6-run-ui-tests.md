Before Andy and Amita run their tests in the pipeline, they want to verify that their new UI tests do what they should. In this section, you'll follow along by running the Selenium UI tests first locally and then in the pipeline.

Writing automated tests is an iterative process, just like writing any other type of code. For your own apps, you'll likely need to try a few approaches, refer to reference documentation and example code, and fix build errors.

## Optional: Install the Selenium driver for Microsoft Edge

Follow this section if you want to see the tests run locally on Microsoft Edge.

The NuGet package for Chrome and Firefox installs driver software under the *bin* directory, alongside the compiled test code. For Edge, you need to manually install the driver. To do so:

1. Install [Microsoft Edge](https://www.microsoft.com/edge?azure-portal=true).
1. Open Edge and navigate to `edge://settings/help`. Note the version number. Here's an example:

    :::image type="content" source="../media/6-edge-version.png" alt-text="A screenshot of the Microsoft Edge setting page, showing the version number.":::

1. Navigate to the [Microsoft Edge Driver downloads](https://developer.microsoft.com/microsoft-edge/tools/webdriver/#downloads?azure-portal=true) page and download the driver that matches the Edge version number. Here's an example:

    :::image type="content" source="../media/6-edge-driver-install.png" alt-text="A screenshot of the Downloads section of the Microsoft Edge Driver page showing the matching driver version.":::

1. Extract the *.zip* file to the *bin/Release/net6.0* directory under your project's *Tailspin.SpaceGame.Web.UITests* directory. Create these directories if they don't exist.

On macOS, you might need to update your system policy to allow **msedgedriver** to run. To do so, in Visual Studio Code, run the following `spctl` command from the terminal:

```bash
spctl --add Tailspin.SpaceGame.Web.UITests/bin/Release/net6.0/msedgedriver
```

## Export environment variables

Later in this module, you'll run Selenium tests on Windows Server 2019. The 
[documentation](https://github.com/actions/virtual-environments/blob/main/images/win/Windows2019-Readme.md?azure-portal=true) lists the software that's preinstalled for you.

The section **Selenium Web Drivers** lists the Selenium driver versions that are available for Chrome, Firefox, and Edge. Here's an example:

:::image type="content" source="../media/6-readme-selenium-drivers.png" alt-text="A screenshot showing the documentation for the installed Selenium drivers on the build agent.":::

For each driver, you have the environment variable that maps to the location of that driver. For example, `ChromeWebDriver` maps to the location of the Chrome driver.

The unit tests code is already set up to read these environment variables. These variables tell Selenium where to find the driver executable files. To run the unit tests locally, you need to export these same environment variables.

From Visual Studio Code, go to the terminal. Then run these commands. Replace the path shown with the full path to your **mslearn-tailspin-spacegame-web-deploy** project.

> [!IMPORTANT]
> Make sure to run these commands and set the environment variables in the same terminal window that you use to run the tests.

# [Windows](#tab/export-windows)

```bash
driverDir="C:\Users\user\mslearn-tailspin-spacegame-web-deploy\Tailspin.SpaceGame.Web.UITests\bin\Release\net6.0"
```

```bash
export ChromeWebDriver=$driverDir
export EdgeWebDriver=$driverDir
export GeckoWebDriver=$driverDir
```

# [macOS](#tab/export-macos)

```bash
driverDir="/Users/user/mslearn-tailspin-spacegame-web-deploy/Tailspin.SpaceGame.Web.UITests/bin/Release/net6.0"
```

```bash
export ChromeWebDriver=$driverDir
export EdgeWebDriver=$driverDir
export GeckoWebDriver=$driverDir
```

---

## Run the UI tests locally

The `Setup` method in *HomePageTest.cs* navigates to the _Space Game_ home page after it sets the `driver` member variable.

Although you could hard-code the site URL, here we read the URL from an environment variable named `SITE_URL`. This way, you can run the tests multiple times against different URLs.

```cs
// Navigate to the site.
// The site name is stored in the SITE_URL environment variable to make 
// the tests more flexible.
string url = Environment.GetEnvironmentVariable("SITE_URL");
driver.Navigate().GoToUrl(url + "/");
```

Because you haven't yet deployed the _Space Game_ website to your App Service environment, you'll use the site that Microsoft hosts to run the tests locally.

To run the tests locally:

1. In Visual Studio Code, go to the integrated terminal and open a new terminal window.
1. Run the following commands in the new terminal window.
    ```dotnetcli
    dotnet build --configuration Release
    dotnet run --configuration Release --no-build --project Tailspin.SpaceGame.Web
    ```
1. Make a note of the local website link, in this example it is `http://localhost:5000`.
1. Switch back to the terminal window where you set the environment variables in the previous step, and ensure that you're in your project's root directory. Here's an example:

    ```bash
    cd ~/mslearn-tailspin-spacegame-web-deploy
    ```

1. Export the `SITE_URL` environment variable. Use the locally running link that you got from the previous step.

    ```bash
    export SITE_URL="http://localhost:5000"
    ```

    This variable points to the _Space Game_ website that Microsoft hosts.

1. Run the UI tests.

    ```bash
    dotnet test --configuration Release Tailspin.SpaceGame.Web.UITests
    ```

    This code runs the tests that are located in the *Tailspin.SpaceGame.Web.UITests* project.

    As the tests run, one or more browsers appear. Selenium controls each browser and follows the test steps that you defined.

    > [!NOTE]
    > Don't worry if all three browsers don't appear. For example, you won't see the tests run on Chrome if you don't have Chrome installed or have an incompatible version. Seeing just one browser will help give you confidence that your tests are working. In practice, in your local development environment, you might want to set up all browsers that you want to test against. This setup will allow you to verify that your tests behave as expected in each configuration before you run your tests in the pipeline.

1. From the terminal, trace the output of each test. Also note the test-run summary at the end.

    This example shows that out of nine tests, all nine tests succeeded and zero tests were skipped:

    ```output
    Passed!  - Failed:     0, Passed:     9, Skipped:     0, Total:     9, Duration: 5 s 
    ```

## Add the SITE_URL variable to Azure Pipelines

Earlier, you set the `SITE_URL` environment variable locally so that your tests know where to point each browser. You can add this variable to Azure Pipelines. The process is similar to how you added variables for your App Service instances. When the agent runs, this variable is automatically exported to the agent as an environment variable.

Let's add the pipeline variable now, before you update your pipeline configuration. To do so:

1. In Azure DevOps, go to your **Space Game - web - Functional tests** project.
1. Under **Pipelines**, select **Library**.
1. Select the **Release** variable group.
1. Under **Variables**, select **+ Add**.
1. For the name of your variable, enter *SITE_URL*. As its value, enter the URL of the App Service instance that corresponds to your **test** environment, such as **http:\//tailspin-space-game-web-test-10529.azurewebsites.net**.
1. Near the top of the page, select **Save** to save your variable to the pipeline.

    Your variable group should resemble this one:

    :::image type="content" source="../media/6-library-variable-group.png" alt-text="A screenshot of Azure Pipelines, showing the variable group. The group contains four variables.":::

## Modify the pipeline configuration

In this section, you modify the pipeline configuration to run your Selenium UI tests during the _Test_ stage.

1. In Visual Studio Code, open the *azure-pipelines.yml* file. Then modify the file like this:

    > [!TIP]
    > This file contains a few changes, so we recommend that you replace the entire file with what you see here.

    [!code-yml[](code/6-azure-pipelines.yml?highlight=6,61,114-138)]

    The file includes these three changes:

    * The `dotnetSdkVersion` variable is moved to the top of the file so that multiple stages can access it. Here the _Build_ stage and _Test_ stage require this version of .NET Core.
    * The _Build_ stage publishes only the _Space Game_ website package as the build artifact. Previously, you published the artifacts like this:

        [!code-yml[](code/6-azure-pipelines-publish.yml?highlight=5)]

        This task generates two build artifacts: the _Space Game_ website package and the compiled UI tests. We build the UI tests during the _Build_ stage to ensure that they'll compile during the _Test_ stage, but we don't need to publish the compiled test code. We build it again during the _Test_ stage when the tests run.
    * The _Test_ stage includes a second job that builds and runs the tests. This job resembles the one that you used in the [Run quality tests in your build pipeline by using Azure Pipelines](/training/modules/run-quality-tests-build-pipeline/4-add-unit-tests?azure-portal=true) module. In that module, you ran NUnit tests that verified the leaderboard's filtering functionality.

        Recall that a _deployment job_ is a special type of job that plays an important role in your deployment stages. The second job is a normal job that runs the Selenium tests on a Windows Server 2019 agent. Although we use a Linux agent to build the application, here we use a Windows agent to run the UI tests. We use a Windows agent because Amita runs manual tests on Windows, and that's what most customers use.

        The `RunUITests` job depends on the `Deploy` job to ensure that the jobs run in the correct order. You'll deploy the website to App Service before you run the UI tests. If you don't specify this dependency, jobs within the stage can run in any order or run in parallel.

1. In the integrated terminal, add *azure-pipelines.yml* to the index, commit the changes, and push the branch up to GitHub.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Run Selenium UI tests"
    git push origin selenium
    ```

## Watch Azure Pipelines run the tests

Here, you watch the pipeline run. The pipeline runs the Selenium UI tests during the _Test_ stage.

1. In Azure Pipelines, go to the build and trace it as it runs.

    During the build, you see the automated tests run after the website is deployed.

    :::image type="content" source="../media/6-stages-test-running.png" alt-text="A screenshot of Azure Pipelines, showing the running stages.":::

1. After the build finishes, go to the summary page.

    :::image type="content" source="../media/6-stages-complete.png" alt-text="A screenshot of Azure Pipelines, showing the completed stages.":::

    You note that the deployment and the UI tests finished successfully.
1. Near the top of the page, note the summary.

    You note that the build artifact for the _Space Game_ website is published just like always. Also note the **Tests and coverage** section, which shows that the Selenium tests have passed.

    :::image type="content" source="../../shared/media/azure-pipelines-build-summary-tests.png" alt-text="A screenshot of Azure Pipelines, showing the test summary.":::

1. Select the test summary to see the full report.

    The report shows that all nine tests have passed. These tests include three tests across three browsers.

    :::image type="content" source="../media/6-test-summary.png" alt-text="A screenshot of Azure Pipelines, showing the full test report.":::

    If any test fails, you get detailed results of the failure. From there, you can investigate the source of the failure, fix it locally, and then push up the necessary changes to make the tests pass in the pipeline.

**Amita:** This automation is exciting! I now have UI tests that I can run in the pipeline. The tests will really save us time in the long run. I also have a pattern to follow to add more tests. Best of all, the UI tests give us added confidence in our code quality.

**Andy:** All true. Remember, tests that you repeatedly run manually are good candidates for automation. Good luck adding more. If you get stuck or need a code reviewer, you know where to find me.
