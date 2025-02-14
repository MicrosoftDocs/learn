In the last exercise, we generated a test spec using Codegen. This time lets add another test spec to the same file and refine our test to use.

## Task 1: Create a new test spec
Your test file should now look like this:
```js
import { test, expect } from '@playwright/test';
test('active and completed filters', async ({ page }) => {
  await page.goto('https://demo.playwright.dev/todomvc/#/')
  await page.getByPlaceholder('What needs to be done?').fill('water the plants');
  await page.getByPlaceholder('What needs to be done?').press('Enter');
  await page.getByPlaceholder('What needs to be done?').fill('feed the dog');
  await page.getByPlaceholder('What needs to be done?').press('Enter');
  await page.locator('li').filter({hasText: 'water the plants' }).getByLabel('Toggle Todo').check();
  await page.getByRole('link', { name: 'Active' }).click();
  await expect(page.getByTestId('todo-title')).toContainText('feed the dog');
  await page.getByRole('link', { name: 'Completed' }).click();
  await expect(page.getByTestId('todo-title')).toContainText('water the plants');
});

test('text field is cleared when item is added', async ({ page}) => {
  await page.goto('https://demo.playwright.dev/todomvc/#/')
  await page.getByPlaceholder('What needs to be done?').fill('water the plants');
  await page.getByPlaceholder('What needs to be done?').press('Enter');
  await expect(page.getByPlaceholder('What needs to be done?')).toBeEmpty();
})
```

## Task 2: Add a describe block

Your test file should now look like this:

```js
import { test, expect } from '@playwright/test';
test.describe('New Todo', () => {
  test('active and completed filters', async ({ page }) => {
    await page.goto('https://demo.playwright.dev/todomvc/#/');
    await page.getByPlaceholder('What needs to be done?').fill('water the plants');
    await page.getByPlaceholder('What needs to be done?').press('Enter');
    await page.getByPlaceholder('What needs to be done?').fill('feed the dog');
    await page.getByPlaceholder('What needs to be done?').press('Enter');
    await page.locator('li').filter({ hasText: 'water the plants' }).getByLabel('Toggle Todo').check();
    await page.getByRole('link', { name: 'Active' }).click();
    await expect(page.getByTestId('todo-title')).toContainText('feed the dog');
    await page.getByRole('link', { name: 'Completed' }).click();
    await expect(page.getByTestId('todo-title')).toContainText('water the plants');
  });

  test('text field is cleared when item is added', async ({ page}) => {
    await page.goto('https://demo.playwright.dev/todomvc/#/');
    await page.getByPlaceholder('What needs to be done?').fill('water the plants');
    await page.getByPlaceholder('What needs to be done?').press('Enter');
    await expect(page.getByPlaceholder('What needs to be done?')).toBeEmpty();
  })
})
```

## Task 3: Add a beforeEach hook

Your test file should now look like this:

```js
import { test, expect } from '@playwright/test';
test.describe('New Todo', () => {
  test.beforeEach(async ({page}) => {
    await page.goto('https://demo.playwright.dev/todomvc/#/');
  })

  test('active and completed filters', async ({ page }) => {
    await page.getByPlaceholder('What needs to be done?').fill('water the plants');
    await page.getByPlaceholder('What needs to be done?').press('Enter');
    await page.getByPlaceholder('What needs to be done?').fill('feed the dog');
    await page.getByPlaceholder('What needs to be done?').press('Enter');
    await page.locator('li').filter({ hasText: 'water the plants' }).getByLabel('Toggle Todo').check();
    await page.getByRole('link', { name: 'Active' }).click();
    await expect(page.getByTestId('todo-title')).toContainText('feed the dog');
    await page.getByRole('link', { name: 'Completed' }).click();
    await expect(page.getByTestId('todo-title')).toContainText('water the plants');
  });

  test('text field is cleared when item is added', async ({ page}) => {
    await page.getByPlaceholder('What needs to be done?').fill('water the plants');
    await page.getByPlaceholder('What needs to be done?').press('Enter');
    await expect(page.getByPlaceholder('What needs to be done?')).toBeEmpty();
  })
})
```

## Use BaseURL

Your test file should now look like this:

```js
import { test, expect } from '@playwright/test';
test.describe('New Todo', () => {
  test.beforeEach(async ({page}) => {
    await page.goto('');
  })

  test('active and completed filters', async ({ page }) => {
    await page.getByPlaceholder('What needs to be done?').fill('water the plants');
    await page.getByPlaceholder('What needs to be done?').press('Enter');
    await page.getByPlaceholder('What needs to be done?').fill('feed the dog');
    await page.getByPlaceholder('What needs to be done?').press('Enter');
    await page.locator('li').filter({ hasText: 'water the plants' }).getByLabel('Toggle Todo').check();
    await page.getByRole('link', { name: 'Active' }).click();
    await expect(page.getByTestId('todo-title')).toContainText('feed the dog');
    await page.getByRole('link', { name: 'Completed' }).click();
    await expect(page.getByTestId('todo-title')).toContainText('water the plants');
  });

  test('text field is cleared when item is added', async ({ page}) => {
    await page.getByPlaceholder('What needs to be done?').fill('water the plants');
    await page.getByPlaceholder('What needs to be done?').press('Enter');
    await expect(page.getByPlaceholder('What needs to be done?')).toBeEmpty();
  })
})
```

Playwright Config file should look like this:

```js
...
use: {
    /* Base URL to use in actions like `await_ _page.goto('/')`. */
    baseURL: 'https://demo.playwright.dev/todomvc/#/',
  ...
}
```

## Create a reusable locator

Your test file should now look like this:

```js
import { test, expect } from '@playwright/test';
test.describe('New Todo', () => {
  test.beforeEach(async ({page}) => {
    await page.goto('');
  })

  test('active and completed filters', async ({ page }) => {
    const todoInput = page.getByPlaceholder('What needs to be done?')
    await todoInput.fill('water the plants');
    await todoInput.press('Enter');
    await todoInput.fill('feed the dog');
    await todoInput.press('Enter');
    await page.locator('li').filter({ hasText: 'water the plants' }).getByLabel('Toggle Todo').check();
    await page.getByRole('link', { name: 'Active' }).click();
    await expect(page.getByTestId('todo-title')).toContainText('feed the dog');
    await page.getByRole('link', { name: 'Completed' }).click();
    await expect(page.getByTestId('todo-title')).toContainText('water the plants');
  });

  test('text field is cleared when item is added', async ({ page}) => {
    const todoInput = page.getByPlaceholder('What needs to be done?')
    await todoInput.fill('water the plants');
    await todoInput.press('Enter');
    await expect(page.getByPlaceholder('What needs to be done?')).toBeEmpty();
  })
})
```
