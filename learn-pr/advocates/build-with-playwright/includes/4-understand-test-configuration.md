Let's now dive deeper into the Playwright Test Specification and Configuration. Open the project we created in the previous section in your favorite code editor (we recommend Visual Studio Code, which is what we're using in this module) and explore the files that Playwright installed.

## Understanding test configuration

Let's start by learning about Playwright test configuration.

- The `playwright.config.ts` file defines the default Test Runner configuration.
- The TestConfig API describes the available configuration properties for customization.
- The [Playwright Test CLI](https://playwright.dev/docs/test-cli) lets you override the config properties or file location at runtime.

Let's see what the default configuration file provided by Playwright (on first setup) looks like. The following `playwright.config.ts` snippet is simplified for clarity:

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

We can refer to the [Basic Configuration](https://playwright.dev/docs/test-configuration) documentation to understand what this code does:

- [`testDir`](https://playwright.dev/docs/api/class-testconfig#test-config-test-dir): Top-level directory to scan recursively for test files.
- [`fullyParallel`](https://playwright.dev/docs/api/class-testconfig#test-config-fully-parallel): Decide if all tests in all files should run in parallel.
- [`forbidOnly`](https://playwright.dev/docs/api/class-testconfig#test-config-forbid-only): Exit with error if `test.only` is used (for example, useful on CI).
- [`retries`](https://playwright.dev/docs/api/class-testconfig#test-config-retries): Maximum number of times to rerun a failed test. This setting doesn't control the automatic polling performed by web-first assertions.
- [`workers`](https://playwright.dev/docs/api/class-testconfig#test-config-workers): Max number of concurrent worker processes (for parallelizing tests).
- [`reporter`](https://playwright.dev/docs/api/class-testconfig#test-config-reporter): Select from available reporter options (built-in and custom).
- [`use`](https://playwright.dev/docs/api/class-testconfig#test-config-use): Set [global options](https://playwright.dev/docs/test-use-options) for all tests (can be overridden at project or test scope).
- [`projects`](https://playwright.dev/docs/api/class-testconfig#test-config-projects): Run tests in multiple configurations (browsers, device profiles, options).

## Configure projects

A project is a group of tests that run with the same configuration and can be used to run tests on different browsers and devices. In the last section, we learned how to run a test on the Chromium browser by adding the `--project` option after the test command in the CLI.

Projects are defined in the projects array in the configuration file. By default, Playwright comes with three projects already defined: chromium, firefox, and webkit. This is why our tests ran on all three browsers.

Each project has a `name` property and a `use` property. The `use` option defines what the project should use. For example, the Desktop Chrome device for the chromium project.

```typescript
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
  ],
```

In the *playwright.config.ts* file in your *learn-playwright* directory, comment out the other projects and leave only the chromium project, then run the tests.

```bash
npx playwright test
```

Excellent! We can see that we now have the two test cases running on a single browser project, giving us two test executions. The following output is one example:

```output
Running 2 tests using 2 workers
  2 passed (1.2s)

To open last HTML report run:
  npx playwright show-report
```

> [!NOTE]
> Compare the test cases and enabled projects, not the sample worker count or duration. These examples show one possible run. Your configured worker limit, available CPU resources, and test workload affect concurrency and timings.

Let's run the `show-report` command and note how the report now only shows us the two tests on the one browser.

:::image type="content" source="../media/run-report-one-project.png" alt-text="Screenshot of two passing test cases from example.spec.ts in the Chromium project.":::

## Explore Emulation

Playwright supports [Emulation](https://playwright.dev/docs/emulation) for mobile testing. You can select device profiles from the [supported emulation profiles](https://github.com/microsoft/playwright/blob/main/packages/isomorphic/deviceDescriptorsSource.json) and add it as a new project in the configuration file.

Enable or add the Mobile Safari project shown below in `playwright.config.ts`. Set its device profile explicitly to `devices['iPhone 17 Pro']` so it matches this exercise. Your generated configuration might initially use a different profile.

```typescript
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },

    {
      name: 'Mobile Safari',
      use: { ...devices['iPhone 17 Pro'] },
    },
  ],
```

From your `learn-playwright` project directory, inspect the iPhone 17 Pro descriptor supplied by your installed Playwright package:

```bash
node -e "console.log(require('@playwright/test').devices['iPhone 17 Pro'])"
```

The profile supplies the viewport, screen size, device scale factor, touch behavior, user agent, and default browser type. You can also explore the [device descriptor registry](https://github.com/microsoft/playwright/blob/main/packages/isomorphic/deviceDescriptorsSource.json).

> [!NOTE]
> Device descriptors are supplied by the installed Playwright package and can change between releases. Use the `devices` entry in your configuration instead of copying a user-agent string from a screenshot or older example. If the command prints `undefined`, your installed version doesn't include this profile. [Update Playwright and its browser binaries](https://playwright.dev/docs/intro#updating-playwright), then rerun the command before continuing.

Let's run our tests again.

```bash
npx playwright test
```

The code runs our two tests on the chromium and Mobile Safari projects. We can see that we now have four test executions. The following output is one example:

```output
Running 4 tests using 4 workers
  4 passed
```

To see what happened, lets's open the report:

```bash
npx playwright show-report
```

This serves the report on a local server and opens the browser to that URL.

```bash
Serving HTML report at http://localhost:9323. Press Ctrl+C to quit.
```

The two test cases now run in both the Chromium project and the Mobile Safari project. Mobile Safari uses WebKit with the selected device profile's browser settings. Compare the report details for each project. Their execution times can vary.

> [!NOTE]
> A device profile simulates selected browser behavior. It doesn't run an iPhone operating system or measure performance on physical phone hardware.

:::image type="content" source="../media/run-emulator.png" alt-text="Screenshot of Playwright test results for desktop and emulated mobile browser projects.":::

You can [customize the device profile](https://playwright.dev/docs/emulation) in a project's `use` settings, or override supported options for a test file or group with `test.use()`. Top-level `use` settings provide shared defaults, but a project's settings take precedence for the same property. Let's explore these scopes before changing the device defaults.

Before exploring recording options, enable all four projects: `chromium`, `firefox`, `webkit`, and `Mobile Safari`. Keep Mobile Safari enabled because you'll inspect its screenshot and trace later in this exercise.

## Explore `use` options

Playwright has a [`use` property](https://playwright.dev/docs/test-use-options) to configure the Test Runner for the following features:

- [Basic](https://playwright.dev/docs/test-use-options#basic-options): Set `baseURL` for resolving relative URLs and `storageState` for initializing browser-context storage, such as saved authentication state.
- [Emulation](https://playwright.dev/docs/test-use-options#emulation-options): Simulate device-related browser settings, such as viewport size, user agent, and touch support.
- [Network](https://playwright.dev/docs/test-use-options#network-options): Configure connections; for example, provide credentials for HTTP auth.
- [Recording](https://playwright.dev/docs/test-use-options#recording-options): Capture traces to help with debugging, or screenshots or video.

> [!NOTE]
> A leading slash resolves from the origin. With `baseURL: 'https://example.com/app/'`, `page.goto('/settings')` opens `https://example.com/settings`, while `page.goto('./settings')` opens `https://example.com/app/settings`.

Set shared defaults in the top-level `use` object, project-specific options in that project's `use` object, and file or group overrides with [`test.use()`](https://playwright.dev/docs/api/class-test#test-use) at file scope or inside `test.describe()`. Don't call `test.use()` inside a test body.

To turn on traces and take a screenshot for our projects, let's use the Recording feature. It allows us to get a visual and system level understanding of what happens in test execution. Replace the contents of `playwright.config.ts` with the following complete configuration. It preserves the test directory, retries, and reporting settings, enables all four projects, and turns on recording:

```typescript
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: 'html',
  use: {
    trace: 'on',
    screenshot: 'on',
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
    {
      name: 'Mobile Safari',
      use: { ...devices['iPhone 17 Pro'] },
    },
  ],
});
```

Let's run the test again.

```bash
npx playwright test
```

Recording traces and screenshots adds processing and storage overhead. The effect on elapsed time depends on the tests, machine, and configured projects. Enable recording when the diagnostic value justifies the overhead.

With two test cases and four enabled projects, the run contains eight test executions. If all tests pass, the report shows eight passed executions. The number of workers and the elapsed time depend on your environment and configuration.

To see what happened, let's open the HTML report.

```bash
npx playwright show-report
```

```output
Serving HTML report at http://localhost:9323. Press Ctrl+C to quit.
```

> [!NOTE]
> The report screenshots below use an older device profile and show four executions from a different configuration. Your four-project run contains eight executions, and the mobile viewport can look different. Use the screenshots to locate report features rather than to compare exact dimensions, totals, or timings.

Select a line to view that test in detail.

:::image type="content" source="../media/run-use-report.png" alt-text="Screenshot of Playwright test results with links to recorded traces.":::

Use recording options to collect diagnostic detail, for example when investigating test failures on CI.

Let's look at the detailed view of one of our tests using the `chromium` project as defined in our config file.

:::image type="content" source="../media/run-use-report-detail.png" alt-text="Screenshot of a Playwright test's HTML report with recorded steps and attachments.":::

1. The detail view includes a screenshot captured after the test because `screenshot: 'on'` is configured. This attachment helps you inspect the page's final state. Navigation with `page.goto()` doesn't automatically capture this screenshot.

   :::image type="content" source="../media/run-use-report-screenshot.png" alt-text="Screenshot of the automatic screenshot attachment in a Playwright test report.":::

   > [!NOTE]
   > Recording screenshots doesn't automatically test for visual regressions. [Visual comparisons](https://playwright.dev/docs/test-snapshots) require an assertion such as `await expect(page).toHaveScreenshot()` and a reviewed reference image. Keep the rendering environment consistent when creating and comparing those reference images.

1. Most importantly, we get a link to a trace for our test. To open the trace, select the **trace** link in the list view or the image of the trace in the detail view of the test.

   :::image type="content" source="../media/run-use-report-trace.png" alt-text="Screenshot of the trace link in a Playwright test report.":::

1. The trace gives us a detailed view of our test. From there, we can easily step through each action and explore the network requests, the console, and even pop out the DOM snapshot and inspect it (for example, when debugging).

   :::image type="content" source="../media/run-use-report-trace-detail.png" alt-text="Screenshot of Playwright Trace Viewer showing recorded test actions and a DOM snapshot.":::

Let's go back to the report and select one of the tests runs on our Mobile Safari project. The detail page for the mobile project reflects the emulated profile view where once again we can explore the trace for our emulated test.

:::image type="content" source="../media/run-use-report-screenshot-mobile.png" alt-text="Screenshot of a Playwright report with a screenshot attachment from the Mobile Safari project.":::

Turning on traces for every test run isn't recommended for production runs. Let's restore tracing on the first retry of a failed test.

In the existing `playwright.config.ts`, change `trace: 'on'` to `trace: 'on-first-retry'` and remove `screenshot: 'on'`. Keep the rest of the configuration, including `retries` and all four projects, unchanged.

> [!NOTE]
> `on-first-retry` records only the first retry of a failed test. This configuration enables retries on CI but not during an ordinary local run. To request a retry locally, run `npx playwright test --retries=1`. A passing test that doesn't need a retry won't produce a trace in this mode.

As an optional challenge, try a [custom viewport](https://playwright.dev/docs/emulation#viewport). Find the existing `chromium` project in `playwright.config.ts` and replace only its `use` property with the following property fragment. Don't replace the whole configuration file or the `projects` array. Keep Firefox, WebKit, Mobile Safari, and the retry and recording settings unchanged.

```typescript
use: {
  ...devices['Desktop Chrome'],
  viewport: { width: 1440, height: 900 },
},
```

> [!NOTE]
> Each project in this exercise already gets a `viewport` from its device descriptor. Adding `viewport` only to the top-level `use` object won't override those project values. Within a project's `use` object, put custom properties after `...devices[...]` so the device spread doesn't replace them. Top-level defaults still apply when a project or test hasn't supplied the same property.

Run the Chromium tests with the browser visible:

```bash
npx playwright test --project=chromium --headed
```

The tests now use the custom Chromium viewport. After exploring, remove the explicit `viewport` property to restore the device profile's default before continuing to the next unit.

You can also try [emulating](https://playwright.dev/docs/test-use-options#emulation-options) a `dark` color scheme as a separate experiment. Restore any experimental settings before continuing.

You learned a lot about Test Configuration. Now, let's explore Test Specification.
