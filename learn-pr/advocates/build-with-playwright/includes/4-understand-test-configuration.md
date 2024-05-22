Let’s now dive deeper into the Playwright Test Specification and Configuration. Let’s open the project we created in the previous section in our favorite code editor and explore the files that Playwright installed. We're using Visual Studio Code for the workshop. 

## Understanding TestConfig

Let’s start by learning about Playwright Test Configuration.

- The playwright.config.ts file defines the default Test Runner configuration.
- The TestConfig API describes the available configuration properties for customization.
- The [Playwright Test CLI](https://playwright.dev/docs/test-cli) lets you override config properties or file location at runtime.

Let's see what the default configuration file provided by Playwright (on first setup) looks like. The `playwright.config.ts` snippet is simplified for clarity.

```js
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: 'html',
  
  use: {
    trace: 'on-first-retry',
  },

  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },

    {
      name: 'firefox',
      use: { ...devices['Desktop Firefox'] },
    },

    {
      name: 'webkit',
      use: { ...devices['Desktop Safari'] },
    },
  ],
});
```

We can refer to the [Basic Configuration](https://playwright.dev/docs/test-configuration) documentation to understand what this does:
- [`testDir`](https://playwright.dev/docs/api/class-testconfig) = top-level directory to scan recursively for test files.
- [`fullyParallel`](https://playwright.dev/docs/api/class-testconfig) = decide if all tests in all files should run in parallel
- [`forbidOnly`](https://playwright.dev/docs/api/class-testconfig) = exit with error if test.only is used (for example, useful on CI)
- [`retries`](https://playwright.dev/docs/api/class-testconfig) = max #retries per test (useful for web-first assertions)
- [`workers`](https://playwright.dev/docs/api/class-testconfig) = max # of concurrent worker processes (for parallelizing tests)
- [`reporter`](https://playwright.dev/docs/api/class-testconfig) = select from available reporter options (built-in and custom)
- [`use`](https://playwright.dev/docs/api/class-testconfig) = set _[global options](https://playwright.dev/docs/test-use-options)_ for all tests (can be overridden at project or test scope)
- [`projects`](https://playwright.dev/docs/api/class-testconfig) = run tests in multiple configurations (think browsers, emulators, options)

## Configure Test Dir

The `testDir` property tells Playwright where to look for test files. By default, it's set to `./tests`, which means that Playwright looks for test files in the `tests` folder. If you have your test files in a different folder, you can change this property to point to that folder.

Let's change the testDir property so that Playwright looks for test files in the root of the project.

```js
export default defineConfig({
  testDir: '.',
  ..
});
```

Now that we updated the testDir property, let's run the tests again and see what happens.

```bash
npx playwright test
```

This time, Playwright would look for test files in the root of the project and run the tests.

```bash
Running 78 tests using 5 workers
  78 passed (15.4s)

To open last HTML report run:
  npx playwright show-report
```

Wow, that's many tests. To see what happened, let's open the HTML report.

```bash
npx playwright show-report
```

:::image type="content" source="../media/run-report.png" alt-text="A screenshot of an HTML report showing 2 test files.":::

The report tells us that tests were run in tests/example.spec.ts and tests-examples/demo-todo-app.spec.ts and on the three different browser engines - `Chromium`, `Firefox`, and `Webkit`. As we set the testDir to the root of the project, Playwright found all the test files in the project and ran them.

Let's set the `testDir` back to `./tests` so we can move on to the next exercise.

```js
export default defineConfig({
  testDir:* *'./tests',
  ..
});
```

## Configure Projects

A project is a group of tests that run with the same configuration and can be used to run tests on different browsers and devices. In the last section, we saw how we can run a test on the Chromium browser by adding the `-- project` option after the test command in the CLI.

Projects are defined in the projects array in the configuration file. By default, Playwright comes with three projects already defined, chromium, firefox, and webkit. This is why our tests ran on all three browsers.

Each project has a name property and a use property. The use option defines what the project should use. For example, the Desktop Chrome device for the chromium project.

```bash
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
  ],
```

Comment out the other projects and leave only the chromium project. Then run the tests.

```bash
npx playwright test
```

Excellent! We can see that we now have the two test cases running on a single browser project, giving us two test executions.

```bash
Running 2 tests using 2 workers
  2 passed (1.2s)

To open last HTML report run:
  npx playwright show-report
```

Let's run the `show-report` command and note how the report now only shows us the two tests on the one browser.

:::image type="content" source="../media/run-report-one-project.png" alt-text="A screenshot of an HTML report showing 2 test files from Playwright.":::

## Explore Emulation

Playwright supports [Emulation](https://playwright.dev/docs/emulation) for mobile testing. You can select device profiles from the [supported emulation profiles](https://github.com/microsoft/playwright/blob/main/packages/playwright-core/src/server/deviceDescriptorsSource.json) and add it as a new project in the configuration file.

You might notice that the default configuration file has a commented-out section for testing against mobile viewports. Let's uncomment out the project for Mobile Safari.

```bash
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },

    {
      name: 'Mobile Safari',
      use: { ...devices['iPhone 12 Pro'] },
    },
  ],
```

Here's what the [profile description](https://github.com/microsoft/playwright/blob/main/packages/playwright-core/src/server/deviceDescriptorsSource.json) for the iPhone 12 Pro looks like:

```json
  "iPhone 12 Pro": {
    "userAgent": "Mozilla/5.0 (iPhone; CPU iPhone OS 14_4 like macOS X)* *AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1",
    "screen": {
      "width": 390,
      "height": 844
    },

    "viewport": {
      "width": 390,
      "height": 664
    },

    "deviceScaleFactor": 3,
    "isMobile": true,
    "hasTouch": true,
    "defaultBrowserType": "webkit"
  },
```

Let's run our tests again.
```bash
npx playwright test
```

The code runs our two tests on the chromium and Mobile Safari projects. We can see that we now have two test executions.

```bash
Running 4 tests using 4 workers
  4 passed
```

To see what happened, lets's open the report.

```bash
npx playwright show-report
```

This serves the report on a local server and opens the browser to that URL.

```bash
Serving HTML report at http://localhost:9323. Press Ctrl+C to quit.
```

Note how the same two test cases are executed, now with the `chromium` browser and the `iPhone 12 Pro` device emulator. We can see that the emulator takes a little longer to run each test compared to the browser engines.

:::image type="content" source="../media/run-emulator.png" alt-text="A screenshot of an emulated test.":::

We can [override the default profile properties](https://playwright.dev/docs/emulation) via the Playwright configuration file (global) or within a Test Specification file (local override) - but to try that out, we first need to understand the `use` directive.

Before we do that let's reset our `playwright.config.ts` file to run tests on the chromium, Firefox and webkit projects and comment-out the Mobile Safari project.

## Explore `use` Options

Playwright has a [`use` property](https://playwright.dev/docs/test-use-options) to configure the Test Runner for the following features:

- [Basic](https://playwright.dev/docs/test-use-options) - set `baseURL` (maps to "/" route) and `storageState` (for example, load auth).
- [Emulation](https://playwright.dev/docs/test-use-options) - emulates a real device,  for example, mobile or tablet
- [Network](https://playwright.dev/docs/test-use-options) - configure connections, for example, provide credentials for HTTP auth
- [Recording](https://playwright.dev/docs/test-use-options) - capture traces to help with debugging, or screenshots or video

These options can be set globally, in the config file (for all tests) or locally for a specific test or group of tests only.

To turn on traces and take a screenshot for our projects, let's try to `use` the Recording feature. It allows us to get a visual and system level understanding of what happens in test execution. Update the top-level `use` object in your `playwright.config.ts` as follows:

```js
export default defineConfig({
  testDir: './tests',
  ..
  use: {
    trace: 'on',
    screenshot: 'on',
  },
  ..
});
```

Let's run the test again.

```bash
npx playwright test
```

Note how the total time taken to run the tests increased drastically. Turning on traces and recording media are time-intensive actions and should be used with discretion - typically to help debug issues.

```bash
Running 4 tests using 3 workers
  4 passed
```

To see what happened, let's open the HTML report.

```bash
npx playwright show-report
```

```bash
Serving HTML report at http://localhost:9323. Press Ctrl+C to quit.
```

:::image type="content" source="../media/run-use-report.png" alt-text="A screenshot showing reports of each test.":::

Turning on options like recording are expensive, so use with discretion - for example, for debugging on CI.

Let's look at the detailed view of one of our tests using the `chromium` project as defined in our config file.

:::image type="content" source="../media/run-use-report-detail.png" alt-text="A screenshot showing the detailed view of an HTML report.":::

1. The detail view includes a screenshot (from page.goto). This is useful for visual regression testing.

   :::image type="content" source="../media/run-use-report-screenshot.png" alt-text="A screenshot of a detailed view from page.goto.":::

1. Most importantly, we get a link to a trace of our test. To open the trace, select on the trace icon in the list view or the image of the trace when in the detail view of the test. 

   :::image type="content" source="../media/run-use-report-trace.png" alt-text="A screenshot showing the link to the trace of our test from the report.":::

1. The trace gives us a detailed view of our test. From there, we can easily step through each action and explore the network requests, console and even pop out the DOM snapshot and inspect it (think debugging). Let's explore in more detail in the next section.

   :::image type="content" source="../media/run-use-report-trace-detail.png" alt-text="A screenshot of the trace of our test.":::

Let's go back to the report and select one of the tests runs on our Mobile Safari project. The detail page for the mobile project reflects the emulated profile view where once again we can explore the trace for our emulated test. 

:::image type="content" source="../media/run-use-report-screenshot-mobile.png" alt-text="A screenshot of a report showing screenshot of mobile safari.":::

Turning on traces for every test run isn't recommended for production runs. Let's change the config back to run traces on the first retry of a failed test. That way if our test fails on CI, we have a trace to help debug the issue.

Let's also remove the screenshot option as we don't need that for now.

```js
export default defineConfig({
  testDir: './tests',
  ..
  use: {
    trace: 'on-first-retry',
  },
  ..
});
```

We covered a lot here and need to move on. But as a challenge to yourself - try out some of the other `use` options and run tests to see how execution and reporting change. For example, try [emulating](https://playwright.dev/docs/test-use-options) a `dark` color scheme or changing the `viewport` to override the device profile defaults.

🚀 | You learned a lot about Test Configuration. Now let's explore Test Specification.
