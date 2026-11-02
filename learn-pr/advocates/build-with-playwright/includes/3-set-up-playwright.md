Let’s begin by installing Playwright, then let's explore the tool and validate that we can run the example tests that come when installing Playwright.

## Install Playwright

Start by opening the terminal and creating a new directory for your project. You can also install Playwright in an existing project, but for this exercise, let's create a new one and call it *learn-playwright*.

```bash
mkdir learn-playwright
```

Navigate into the new directory:

```bash
cd learn-playwright
```

In this new empty directory, install Playwright and explore what got installed.

```bash
npm init playwright@latest
```

When you run this command, you're asked a few questions to configure the Playwright project:

- Select the language you want to use for your tests. We recommend **TypeScript**.
- Select the name of the test directory. We recommend **tests**.
- Add a GitHub Action for automating tests. We recommend **Yes**.
- Install Playwright browsers. We recommend selecting the default of **True**.

> [!NOTE]
> On Linux, including a supported Linux distribution in WSL, the initializer can also ask whether to install Playwright's operating-system dependencies. Browser downloads and system-library installation are separate steps. If those dependencies aren't installed, select **Yes** when prompted, provided you're authorized to install system packages. This step requires root or sudo permissions. If you skipped it, run `npx playwright install-deps` from your project directory before running the tests. See [Install system dependencies](https://playwright.dev/docs/browsers#install-system-dependencies).

Your terminal output should look similar to the following example. Exact messages can vary by version:

```output
Initializing NPM project (npm init -y)…

Wrote to /learn-playwright/package.json:

{

  "name": "learn-playwright",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC"
}

Installing Playwright Test (npm install --save-dev @playwright/test)…

added 4 packages, and audited 5 packages in 2s

found 0 vulnerabilities
Installing Types (npm install --save-dev @types/node)…

added 2 packages, and audited 7 packages in 580ms

found 0 vulnerabilities
Writing playwright.config.ts.
Writing .github/workflows/playwright.yml.
Writing tests/example.spec.ts.
Writing package.json.
Downloading browsers (npx playwright install)…
✔ Success! Created a Playwright Test project at /learn-playwright

Inside that directory, you can run several commands:

  npx playwright test
    Runs the end-to-end tests.

  npx playwright test --ui
    Starts the interactive UI mode.

  npx playwright test --project=chromium
    Runs the tests only in the Chromium project.

  npx playwright test example
    Runs the tests in a specific file.

  npx playwright test --debug
    Runs the tests in debug mode.

  npx playwright codegen
    Auto generate tests with Codegen.

We suggest that you begin by typing:

    npx playwright test

And check out the following files:
  - ./tests/example.spec.ts - Example end-to-end test
  - ./playwright.config.ts - Playwright Test configuration

Visit https://playwright.dev/docs/intro for more information. ✨

Happy hacking! 🎭
```

The output tells us that a new npm project was created with a package.json file, and that Playwright Test was installed. It also tells us the files that were created:

- `playwright.config.ts`: The Playwright Test Configuration file.
- `.github/workflows/playwright.yml`: GitHub Action for automating tests
- `tests/`: Top-level folder that Playwright searches recursively for tests with an example test script.
- `package.json`: The npm project file.

> [!NOTE]
> Current Playwright project templates create a starter test in `tests/example.spec.ts`. They no longer generate a `tests-examples` folder. This module uses the starter tests to explore configuration and test suites. Installation messages and package counts can vary by version.

Playwright downloads the browser binaries required by the installed Playwright version. These managed binaries let you run the Chromium, Firefox, and WebKit projects without installing those browsers separately. When you update Playwright, install the browser binaries required by the new version as well.

On Linux, the required operating-system libraries must also be installed. If a browser fails to launch because host dependencies are missing, complete the dependency-installation step described above before rerunning the tests.

> [!NOTE]
> The `Desktop Chrome` device profile doesn't select branded Google Chrome. The example's `chromium` project uses Playwright's Chromium build. Testing installed Google Chrome or Microsoft Edge requires an appropriate [browser channel](https://playwright.dev/docs/browsers#google-chrome--microsoft-edge) and that browser to be available.

When finished, we get a success message and a list of commands we can run to interact with the Playwright Test project.

## Validate Playwright test runner

To run tests in Playwright, use the npx playwright test command. The command runs all the tests in the `tests/` folder, which is the folder name we defined in step 2 when installing.

```bash
npx playwright test
```

Your output should resemble the following example. The two starter test cases run in three projects, giving six test executions. Worker counts and elapsed time can differ.

```output
Running 6 tests using 5 workers
      6 passed (4.0s)

To open last HTML report run:

  npx playwright show-report
```

The example shows six test executions using five workers. The [`workers` setting](https://playwright.dev/docs/api/class-testconfig#test-config-workers) limits the number of concurrent worker processes. During an ordinary local run, the generated configuration uses Playwright's default limit of 50% of the logical CPU cores. The number of workers actually used also depends on the available work. When `CI` is set, the configuration shown in this module limits the run to one worker.

Let's open the HTML report to see more details about the test run.

```bash
npx playwright show-report
```

The following message tells us the report is being served locally, and a browser window opens with the report.

```output
Serving HTML report at http://localhost:9323. Press Ctrl+C to quit.
```

:::image type="content" source="../media/setup-show-report.png" alt-text="Screenshot of six passing Playwright test executions across Chromium, Firefox, and WebKit.":::

The report gives us the following insights:

- We've got two test cases (*has title* and *get started link*)
- We ran each across three browser engines (chromium, Firefox, webkit)
- The test cases were defined in the `example.spec.ts` file
- The test run took *5.2s* with all six tests passing (none skipped)

Selecting a particular row gives you the detailed run of that test case. For example, if we select the first row, we get the following details:

- The test is called *has title*.
- The file name is `example.spec.ts` and the line number is `3`.
- The test case was run on Chromium
- **Before Hooks** shows setup activity, including creation of the isolated context and page fixtures. The browser may already be running in the worker.
- The navigation step shows the call to `page.goto()`.
- The assertion step shows the check of the page title.
- **After Hooks** shows teardown activity, including fixture cleanup.
- The test case took *661ms* to complete.

These entries belong to one test execution. They aren't separate test cases.

:::image type="content" source="../media/run-report-detail.png" alt-text="Screenshot of a Playwright test report with setup hooks, navigation, an assertion, and teardown hooks.":::

To run our test only on the Chromium browser, we can use the `--project` option.

```bash
npx playwright test --project chromium
```

Run the command and confirm that the report contains two test executions in the Chromium project. The run can use fewer than two workers, depending on your machine and configuration.

Congratulations! You successfully installed Playwright and ran the example test. In the next section, we'll look at the test in more detail, as well as the Playwright configuration file.
