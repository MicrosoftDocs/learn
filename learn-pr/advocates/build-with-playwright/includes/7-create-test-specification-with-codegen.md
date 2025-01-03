In this exercise, let's create a test spec for a Todo Application using Playwright's code generator, Codegen.

1. Navigate to the Todo Application: [https://demo.playwright.dev/todomvc/#/](https://demo.playwright.dev/todomvc/)
1. Add a new todo item with the text *water the plants*.
1. Add another todo item with the text *feed the dog*.
1. Toggle the "water the plants" todo item as **Completed**.
1. Select the **Active** button.
1. Assert that the todo field contains the text *feed the dog*.
1. Select the **Completed** filter.
1. Assert that the todo field contains the text *water the plants*.
1. Change the test name to *active and completed filters*.
1. Save the test file as `todo.spec.ts`.
1. Run the test with **Trace viewer** selected and make sure it passes.
