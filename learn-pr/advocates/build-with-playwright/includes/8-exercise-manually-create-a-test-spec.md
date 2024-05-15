In the last exercise, we generated a test spec using Codegen. This time lets add another test spec to the same file and refine our test.

## Create a new test spec
- Manually add a new test block under the test block we created in the last exercise
- Add the test name "text field is cleared when item is added"
- Navigate to the Todo Application: `https://demo.playwright.dev/todomvc/#/`
- Add a new todo item "water the plants"
- Assert that the placeholder text is empty using `toBeEmpty()`
- Run the test to see if it passes

## Add a describe block
- Add a describe block called `New Todo`
- Move both tests into the describe block
- Run both tests in your describe block and make sure they're passing

## Add a beforeEach hook
- Use a beforeEach hook to navigate to the Todo Application before each test
- Remove the `page.goto` from each test
- Run both tests in your describe block and make sure they're passing

## Use BaseURL
- In the config file, uncomment the baseURL and set it to `https://demo.playwright.dev/todomvc/#`
- In the test file, replace the URL with an empty string `‘ ’`
- Run both tests in your describe block and make sure they're passing

## Create a reusable locator
- In both tests, create a locator called todoInput and pass it the value `page.getByPlaceholder('What needs to be done?')`
- Replace all instances of `page.getByPlaceholder('What needs to be done?')` with todoInput
- Run your tests again and make sure they're passing