[Playwright](https://playwright.dev/) is an open-source browser automation framework for testing modern web apps. It lets you control a browser through code to navigate pages, enter text, select buttons, and interact with other page elements. In end-to-end testing, you use these capabilities to check complete user workflows through the app's interface, rather than testing an individual function in isolation.

A Playwright test combines actions with assertions, which check whether the app behaves as expected. For example, a test for a task management app could add a task, mark it as complete, and check that it appears in the completed list. Repeating these checks after code changes helps you detect regressions, where functionality that previously worked stops working. The [writing tests guide](https://playwright.dev/docs/writing-tests) explains how to locate elements, perform actions, and verify results.

This module uses [Playwright Test](https://playwright.dev/docs/intro), the test framework for JavaScript and TypeScript built on Playwright. It includes a test runner, assertions, isolated browser environments, and reporting tools. You can write and run tests from the command line or Visual Studio Code, watch them execute in a visible browser window, or run them headlessly without displaying a browser window.

You can configure the same tests to run across Chromium, Firefox, and WebKit to help identify differences in browser behavior. Playwright supports Windows, Linux, and macOS, so you can use it during local development and in [continuous integration workflows](https://playwright.dev/docs/ci). For example, a GitHub Actions workflow can run your tests when you open a pull request, helping you catch problems before merging changes.

## Why use Playwright?

There are many reasons to choose Playwright as your test automation framework. Here are four key ones:

- **Unified API**: Playwright works across all modern browser engines (Chromium, WebKit, Firefox) and supports device emulation for mobile coverage. It comprises both headed and headless browser options, allowing developers to prioritize between debugging convenience and CI/Cloud execution.

- **Resilient Testing**: Playwright implements "auto-wait" (no artificial timeouts) and "auto-retry" (web assertions), eliminating key causes for flaky tests. Rich tooling options (tracing, time-travel) make it easy to debug and fix issues if failures occur.

- **Test Isolation**: Browser tests using the built-in fixtures get a fresh BrowserContext for each test, isolating browser state such as cookies and local storage. Keep tests independent and use separate application data when tests might otherwise modify the same records.

- **Powerful Tooling**: Playwright streamlines the developer experience from test authoring to execution, debugging, reporting, and profiling, with options to use a CLI or the Visual Studio Code extension.

> [!NOTE]
> By default, Playwright runs test files in parallel and tests within a file in order. The configuration used in this module enables `fullyParallel: true`, allowing independent tests in the same file to run in parallel too. Browser isolation doesn't isolate shared server-side data. A failure in a [serial group](https://playwright.dev/docs/test-retries#serial-mode) or a [prerequisite project](https://playwright.dev/docs/test-projects#dependencies) can cause later or dependent tests to be skipped.

## Playwright core concepts

In the following exercises, we'll learn how to perform test automation tasks using Playwright. To set the stage, here are a few core terms and concepts to keep in mind. Their purpose and usage becomes clearer when you work through the exercises.

| **Concept** | **Description** |
|---|---|
| [**TestConfig**](https://playwright.dev/docs/api/class-testconfig) | Describes the configuration object exported by `playwright.config.ts`, including test discovery, projects, retries, and reporting. The configuration file can compute values, for example from environment variables. |
| [**TestProject**](https://playwright.dev/docs/test-projects) | Logical group of tests running same TestConfig and can be defined using filter. |
| [**Test Timeout**](https://playwright.dev/docs/test-timeouts) | Global (per test run), Default (per test), Expect timeouts, Fixture timeouts |
| [**Fixtures**](https://playwright.dev/docs/test-fixtures) | Core to Playwright test isolation. Set environment; see [built-in](https://playwright.dev/docs/test-fixtures#built-in-fixtures) options. |
| [**Navigation**](https://playwright.dev/docs/writing-tests) | Using `page.goto()` [options](https://playwright.dev/docs/api/class-page#page-goto) to craft multi-page testing workflows |
| [**Locators**](https://playwright.dev/docs/locators) | Core to Playwright auto-wait and auto-retry. Action finds target elements. |
| [**Assertions**](https://playwright.dev/docs/test-assertions) | Core to Playwright validation of expected outcomes based on actions. |
| [**Annotations**](https://playwright.dev/docs/test-annotations) | Tag tests to provide added context to deal with failures, focus, flakiness. |
| [**use Options**](https://playwright.dev/docs/test-use-options) | Configure Browser (project) or BrowserContext (context) within scope. |
| [**Page Object Models**](https://playwright.dev/docs/pom) | Represent UI components by "Objects" and associate testing logic for reuse |

## Playwright core tools

We'll also learn how to use a few Playwright tools, both from the command line and from within Visual Studio Code. For reference, here are some key developer tools we'd explore, with a description of the role they play in testing workflow.

| **Tool** | **Description** |
|---|---|
| [**Playwright Test**](https://playwright.dev/docs/test-cli) | The Playwright Test Runner and default CLI. |
| [**Playwright Extension**](https://playwright.dev/docs/getting-started-vscode) | The Playwright Extension for Visual Studio Code. |
| [**Codegen**](https://playwright.dev/docs/codegen-intro) | Playwright Test Generator (for automated authoring). |
| [**UI Mode**](https://playwright.dev/docs/test-ui-mode) | Playwright Time Travel Experience (with Watch Mode). |
| [**Trace Viewer**](https://playwright.dev/docs/trace-viewer-intro) | Graphical UI for exploring recorded Playwright traces. |
| [**VS Code Debugger**](https://playwright.dev/docs/debug#vs-code-debugger) | Powerful debugging support using Visual Studio Code Extension. |
| [**Playwright Inspector**](https://playwright.dev/docs/debug#playwright-inspector) | Powerful debugging support from Playwright Command line. |
| [**Built-in Reporters**](https://playwright.dev/docs/test-reporters) | Flexible reporting options, with support for customization. |
| [**Continuous Integration**](https://playwright.dev/docs/ci) | Support for wide range of CI providers (with sample config). |

In many cases, the same functionality is available from both the CLI and the VS Code Extension. We'll explore the Playwright Test (CLI) option briefly, but we recommend making Visual Studio Code extension your preferred option due to richer capabilities and a more streamlined developer experience.
