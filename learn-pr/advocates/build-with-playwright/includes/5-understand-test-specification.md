The default test runs on the *tests/example.spec.ts* specification. Let's unpack that to see what it contains:

```typescript
import { test, expect } from '@playwright/test';
test('has title', async ({ page }) => {
  await page.goto('https://playwright.dev/');

  // Expect a title "to contain" a substring.
  await expect(page).toHaveTitle(/Playwright/);
});

test('get started link', async ({ page }) => {
  await page.goto('https://playwright.dev/');

  // Click the get started link.
  await page.getByRole('link', { name: 'Get started' }).click();

  // Expects page to have a heading with the name of Installation.
  await expect(page.getByRole('heading', { name: 'Installation' })).toBeVisible();
});
```

If you did test-driven development or end-to-end testing, the structure and format of the tests should be familiar. But you might see a few new concepts too. Before we dive into those, let's talk about test structure.

## Understand test hierarchy

Here's how we organize our tests in Playwright.

- Every test() method in that specification is a [Test Case](https://playwright.dev/docs/api/class-testcase). When run in a configuration with multiple projects, each project instantiates a version of this Test Case and configures it to suit project requirements.
- A test contains actions, assertions, and supporting code. Playwright records supported API calls, assertions, fixture activity, and hooks as steps. To give a group of operations a named step in the report, wrap it in [`test.step()`](https://playwright.dev/docs/api/class-test#test-step). Ordinary JavaScript statements aren't automatically recorded as individual actions.
- Test cases can be grouped explicitly into [Test Suites](https://playwright.dev/docs/api/class-suite) using the `test.describe()` function. You'll group the starter tests into a suite in the following exercise.
- Test cases are grouped implicitly into Suites based on the project to which they belong and the file in which they're contained, which allows Playwright to target groups of tests in various ways for execution.
- Every test run has a *Root* suite, with a child *Project* suite for each configured project. Project suites have child *File* suites for each test specification identified for that run. The File suite can have Test Case objects (individual) and Test Suite objects (explicitly grouped using describe) as children.

### Create a test suite

The `test.describe()` function groups related tests in a file. You can use [test hooks](https://playwright.dev/docs/writing-tests#using-test-hooks), such as `test.beforeEach()`, to prepare the environment before each test in the group.

Replace the contents of `tests/example.spec.ts` with the following code. Don't append it to the existing tests. The suite groups the two starter tests and uses a `beforeEach` hook to open the website before each test.

```typescript
import { test, expect } from '@playwright/test';

test.describe('Playwright documentation', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('https://playwright.dev/');
  });

  test('has title', async ({ page }) => {
    await expect(page).toHaveTitle(/Playwright/);
  });

  test('get started link', async ({ page }) => {
    await page.getByRole('link', { name: 'Get started' }).click();
    await expect(
      page.getByRole('heading', { name: 'Installation' })
    ).toBeVisible();
  });
});
```

From your `learn-playwright` directory, run the grouped tests on Chromium:

```bash
npx playwright test tests/example.spec.ts --project=chromium
```

You should see two passing test executions. Grouping the existing tests into a suite doesn't add test cases. The `beforeEach` hook runs before each test, so both tests start at the website's home page.

## Understand test structure

The preceding snippets show the original starter tests and a grouped version of the same tests. Let's use the grouped version for this discussion because it also shows how a setup hook prepares each test.

Playwright tests generally follow the [Arrange-Act-Assert](https://automationpanda.com/2020/07/07/arrange-act-assert-a-pattern-for-writing-good-tests/) pattern:

- **Arrange**: Sets up the environment for the test. This can include providing the right fixtures, but also running `beforeEach`/`beforeAll` hooks that set up the initial state for that test.
- **Act**: These are the steps within the test that locate the right elements with which to interact, then act on them. For instance, the test might [locate a button](https://playwright.dev/docs/api/class-locator), then [select it](https://playwright.dev/docs/writing-tests). Other actions include check/uncheck (checkboxes), fill (forms), hover (mouseover), focus (on element), press (single key), and so on.
- **Assert**: Assertions check the expected outcome of an action. Playwright's [web-first matchers](https://playwright.dev/docs/test-assertions#auto-retrying-assertions), such as `await expect(locator).toBeVisible()`, repeatedly check the expected condition until it passes or times out. [Generic matchers](https://playwright.dev/docs/api/class-genericassertions), such as `expect(value).toEqual(expected)`, check an already available value and don't automatically retry.

> [!NOTE]
> Web-first assertions still retry their checks when the test configuration has `retries: 0`. Their [default timeout is five seconds](https://playwright.dev/docs/test-timeouts#expect-timeout) and can be changed through `expect.timeout` in the configuration or an individual assertion's options. Whole-test retries are a separate setting.

Once you understand this, it becomes easier to understand, author, and refine, your test specifications using Playwright tooling.

## Understand test components

Let's revisit the original, ungrouped starter tests to see how fixtures, locators, and assertions work together. The following code is for comparison only. Keep the grouped version in `tests/example.spec.ts` for the next unit.

```typescript
import { test, expect } from '@playwright/test';
test('has title', async ({ page }) => {
  await page.goto('https://playwright.dev/');

  // Expect a title "to contain" a substring.
  await expect(page).toHaveTitle(/Playwright/);
});

test('get started link', async ({ page }) => {
  await page.goto('https://playwright.dev/');

  // Click the get started link.
  await page.getByRole('link', { name: 'Get started' }).click();

  // Expects page to have a heading with the name of Installation.
  await expect(page.getByRole('heading', { name: 'Installation' })).toBeVisible();
});
```

1. **Arrange**: There aren't any explicit hooks in this test spec, however `page` is a [Fixture](https://playwright.dev/docs/test-fixtures) that also supports this goal.
1. **Act**: `page.goto` is an example of a [Navigation](https://playwright.dev/docs/writing-tests#navigation) action where the browser automates the user action of navigating to that URL.
1. **Assert**: `await expect(page.getByRole('heading', { name: 'Installation' })).toBeVisible()` is a [locator assertion](https://playwright.dev/docs/api/class-locatorassertions). Playwright repeatedly checks whether the matching heading is visible until the assertion passes or its timeout is reached.

With this simple example, you know three powerful concepts in Playwright Testing:

- [Fixtures](https://playwright.dev/docs/test-fixtures): For establishing environment and test isolation.
- [Locators](https://playwright.dev/docs/locators): For finding elements with auto-wait and auto-retry.
- [Assertions](https://playwright.dev/docs/test-assertions): For validating outcomes of automated actions web-assertions.

Take a few minutes to familiarize yourself with the documentation for those three features and APIs. Then, you should be all set to dive into designing and authoring an end-to-end specification for the sample application.

Excellent! Now let's talk about the core Developer Tools for Playwright!
