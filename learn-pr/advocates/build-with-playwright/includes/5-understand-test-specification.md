The default test runs on the tests/example.spec.ts specification. Let's unpack that to see what it contains:

```js
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

If you did test-driven development or end-to-end testing, the structure and format of the tests should be familiar. But you may see a few new concepts too. Before we dive into those, let's talk about test structure.

## Understand Test Hierarchy
Here's how we organize our tests in Playwright.
- Every test() method in that specification is a [Test Case](https://playwright.dev/docs/api/class-testcase). When run in a configuration with multiple projects, each project instantiates a version of this Test Case and configure it to suit project requirements.
- Every executable statement within the Test Case is a test action that can be tracked in the reporter, trace-viewer, or UI mode tooling flows.
- Test cases can be grouped explicitly into [Test Suites](https://playwright.dev/docs/api/class-suite) using the `test.describe()` function. You can see an example of this in our test-examples/demo-todo-app-spec.ts. We revisit the test cases later.
- Test cases are grouped implicitly into Suites based on the project they belong to, and the file they're contained in, which allows Playwright to target groups of tests in various ways for execution.
- Every test run has a Root suite, with a child Project suite for each configured project. Project suites have child File suites for each test specification identified for that run. The File suite can have Test Case objects (individual) and Test Suite objects (explicitly grouped using describe) as children.

The test.describe directive allows us to group Test Case objects logically in a file so we can do things like apply beforeEach and afterEach hooks to all tests within a group. See the snippet from test-examples/demo-todo-app.spec.ts below for reference.

```js
test.describe('Mark all as completed', () => {
  test.beforeEach(async ({ page }) => {
    await createDefaultTodos(page);
    await checkNumberOfTodosInLocalStorage(page, 3);
  });

  test.afterEach(async ({ page }) => {
    await checkNumberOfTodosInLocalStorage(page, 3);
  });

  test('should allow me to mark all items as completed', async ({ page }) => {
    // test actions details omitted for clarity
  });

  test('should allow me to clear the complete state of all items', async ({ page }) => {
    // test actions details omitted for clarity
  });

  test('complete all checkbox should update state when items are completed / cleared', async ({ page }) => {
    // test actions details omitted for clarity
  });
});
```

## Understand Test Structure
We can look at either of the two Test Specification snippets above (the first from example.spec.ts, the second from demo-todo-app.spec.ts) for this discussion. Let's use the second one since it has a bit more detail that is relevant.

Playwright tests generally follow the [Arrange-Act-Assert](https://automationpanda.com/2020/07/07/arrange-act-assert-a-pattern-for-writing-good-tests/) pattern:
- Arrange - sets up the environment for the test. This can include providing the right fixtures, but also running beforeEach/beforeAll hooks that set up the initial state for that test.
- Act - these are the steps within the test that locate the right elements to interact with, and then act on them. For instance, the test may [locate a button](https://playwright.dev/docs/api/class-locator) and then [select it](https://playwright.dev/docs/writing-tests). Other actions include check/uncheck (checkboxes), fill (forms), hover (mouseover), focus (on element), press (single key) etc.
- Assert - these statements validate expected outcomes from the actions. Playwright supports [web-first assertions,](https://playwright.dev/docs/test-assertions) where [generic assertions](https://playwright.dev/docs/api/class-genericassertions) (using expect) can be coupled with [async matchers](https://playwright.dev/docs/api/class-locatorassertions)(for the Locator) to make sure that the target element is ready before evaluating the asserted condition.

Once you understand this, it becomes easier to understand, author, and refine, your test specifications using Playwright tooling.

## Understand Test Components
Let's see these concepts in action by reviewing the example spec from section 4.2.

```js
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

1. (Arrange) - there are no explicit hooks in this test spec, however page is a [Fixture](https://playwright.dev/docs/test-fixtures) that also supports this goal.
2. (Act) - the page.goto is an example of a [Navigation](https://playwright.dev/docs/writing-tests) action where the browser automates the user action of navigating to that URL.
3. (Assert) - the expect.(\<locator>).toBeVisible() is an example of a LocatorAssertion where Playwright will wait for the located element to be ready (using retries) before evaluating the assertion (is it visible?).

With this simple example, you know three powerful concepts in Playwright Testing:
- [Fixtures](https://playwright.dev/docs/test-fixtures) - for establishing environment and test isolation.
- [Locators](https://playwright.dev/docs/locators) - for finding elements with auto-wait and auto-retry.
- [Assertions](https://playwright.dev/docs/test-assertions) - for validating outcomes of automated actions web-assertions.

Take a few minutes to familiarize yourself with the documentation for those three features and APIs - and you should be all set to dive into designing and authoring an end-to-end specification for the sample application.

🚀 | Excellent! Now let's talk about the core Developer Tools for Playwright!