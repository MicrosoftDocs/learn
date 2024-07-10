In the last exercise, we generated a test spec using Codegen. This time lets add another test spec to the same file and refine our test.

## Create a new test spec

1. Manually add a new test block under the test block we created in the last exercise
1. Add the test name "text field is cleared when item is added"
1. Navigate to the Todo Application: `https://demo.playwright.dev/todomvc/#/`
1. Add a new todo item "water the plants"
1. Assert that the placeholder text is empty using `toBeEmpty()`
1. Run the test to see if it passes

## Add a describe block

1. Add a describe block called `New Todo`
1. Move both tests into the describe block
1. Run both tests in your describe block and make sure they're passing

## Add a beforeEach hook

1. Use a beforeEach hook to navigate to the Todo Application before each test
1. Remove the `page.goto` from each test
1. Run both tests in your describe block and make sure they're passing

## Use BaseURL

1. In the config file, uncomment the baseURL and set it to `https://demo.playwright.dev/todomvc/#`
1. In the test file, replace the URL with an empty string `‘ ’`
1. Run both tests in your describe block and make sure they're passing

## Create a reusable locator

1. In both tests, create a locator called todoInput and pass it the value `page.getByPlaceholder('What needs to be done?')`
1. Replace all instances of `page.getByPlaceholder('What needs to be done?')` with todoInput
1. Run your tests again and make sure they're passing