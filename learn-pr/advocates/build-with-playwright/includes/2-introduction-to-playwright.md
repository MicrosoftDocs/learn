[Playwright](https://playwright.dev/) is an open-source framework for *reliable* end-to-end testing for modern web apps. It's relatively new (released in 2020) but maintains an active [release schedule](https://playwright.dev/docs/release-notes), adding new features and fixing bugs at a rapid pace. The [2022 StateOfJS](https://2022.stateofjs.com/en-US/libraries/testing/) trends on testing show that Playwright is growing steadily in popularity and retention within the web development community.

:::image type="content" source="../media/playwright-ranking.png" alt-text="A screenshot showing Playwright's ratio over time.":::

## Why should we use Playwright?

There are many reasons for choosing Playwright as your test automation framework. Here are four key ones:

*Unified API*. Playwright works across all modern browser engines (Chromium, WebKit, Firefox) and supports device emulation for mobile coverage. It comprises both headed and headless browser options, allowing developers to prioritize between debugging convenience and CI/Cloud execution.

*Resilient Testing*. Playwright implements "auto-wait" (no artificial timeouts) and "auto-retry" (web assertions) - eliminating key causes for flaky tests. Rich tooling options (tracing, time-travel) make it easy to debug and fix issues if failures occur.

*Test Isolation*. Every test runs in its own *BrowserContext*, independent of other tests running at the same time. Tests are run in parallel (for optimization) and one test failure wouldn't affect others (for reliability).

*Powerful Tooling*. Playwright streamlines the developer experience from test authoring, to execution, debugging, reporting, and profiling - with options to use a CLI or the Visual Studio Code extension.

## Playwright Core Concepts

In the following exercises, let's learn how to perform test automation tasks using Playwright. To set the stage, here are a few core terms and concepts to keep in mind. Their purpose and usage becomes clearer when you work through the exercises.

| **Concept** | **Description** |
|---|---|
| [**TestConfig**](https://playwright.dev/docs/api/class-testconfig) | Configure Playwright Test Runner using File (static) or API (dynamic) |
| [**TestProject**](https://playwright.dev/docs/test-projects) | Logical group of tests running same TestConfig and can be defined using filter. |
| [**Test Timeout**](https://playwright.dev/docs/test-timeouts) | Global (per test run), Default (per test), Expect Timeouts, Fixture Timeouts |
| [**Fixtures**](https://playwright.dev/docs/test-fixtures) | Core to Playwright test isolation. Set environment - see [built-in](https://playwright.dev/docs/test-fixtures) options. |
| [**Navigation**](https://playwright.dev/docs/writing-tests) | Using page.goto() [options](https://playwright.dev/docs/api/class-page) to craft multi-page testing workflows |
| [**Locators**](https://playwright.dev/docs/locators) | Core to Playwright auto-wait and auto-retry. Action finds target elements. |
| [**Assertions**](https://playwright.dev/docs/test-assertions) | Core to Playwright validation of expected outcomes based on actions. |
| [**Annotations**](https://playwright.dev/docs/test-annotations) | Tag tests to provide added context to deal with failures, focus, flakiness. |
| [**use Options**](https://playwright.dev/docs/test-use-options) | Configure Browser (project) or BrowserContext (context) within scope. |
| [**Page Object Models**](https://playwright.dev/docs/pom) | Represent UI components by "Objects" and associate testing logic for reuse |

## Playwright Core Tools

Let's learn how to use a few Playwright tools - both from the command-line and from within Visual Studio Code. For reference, here are some key developer tools we would explore - with a description of the role they play in testing workflow.

| **Tool** | **Description** |
|---|---|
| [**Playwright Test**](https://playwright.dev/docs/test-cli) | The Playwright Test Runner and default CLI |
| [**Playwright Extension**](https://playwright.dev/docs/getting-started-vscode) | The Playwright Extension for Visual Studio Code |
| [**Codegen**](https://playwright.dev/docs/codegen-intro) | Playwright Test Generator (for automated authoring) |
| [**UI Mode**](https://playwright.dev/docs/test-ui-mode) | Playwright Time Travel Experience (with Watch Mode) |
| [**Trace Viewer**](https://playwright.dev/docs/trace-viewer-intro) | Graphical UI for exploring recorded Playwright traces. |
| [**VS Code Debugger**](https://playwright.dev/docs/debug) | Powerful debugging support using Visual Studio Code Extension. |
| [**Playwright Inspector**](https://playwright.dev/docs/debug) | Powerful debugging support from Playwright Command line. |
| [**Built-in Reporters**](https://playwright.dev/docs/test-reporters) | Flexible reporting options, with support for customization. |
| [**Continuous Integration**](https://playwright.dev/docs/ci) | Support for wide range of CI providers (with sample config). |

In many cases, the same functionality is available from both the CLI and the VS Code Extension. Let's explore the Playwright Test (CLI) option briefly but recommend making Visual Studio Code extension your preferred option, due to richer capabilities and a more streamlined developer experience.