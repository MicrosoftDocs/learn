There is much guidance out there when it comes to testing. We'll cover some of the common schools of thought that experienced developers often recommend. Learning these acronyms will help you keep up with popular concepts.

* **Test Driven Development (TDD)**: Let tests be the driving force behind your day-to-day coding.
* **Behavior Driven Development (BDD)**: Use behavior specification to formulate your tests.
* **DRY (Don't Repeat Yourself)**: Avoid any kind of code repetition and opt for reusable code instead.
* **Choose what works best for you!**: These are just guidelines anyway! Each team and developer should choose what makes them the most productive.

## Test driven development (TDD)

Test driven development, or TDD, is a method of directly coupling testing with every part of your daily development. Developers who use TDD typically start developing by first writing a test that fails and then writing the code that makes the test pass. This approach means product code is more likely to get high test coverage and the tests typically come first. Many developers find this pattern useful to help them prioritize good architecture from the start of development and stay laser focused on each part of the functionality they need to implement. This school of thought advocates for testing not being an after-thought of development, but rather a driving force.

For example, in the image below you can see the `AddTest` is written and failing while the `Add` method is still yet to be implemented. This test will fail until the method is implemented.
:::image type="content" source="../media/test-driven-development.png" alt-text="Screenshot of a test method in the Visual Studio editor named AddTest is implemented and failing. The Add method is also visible and throws a NotImplementedException.":::

There is a type of TDD called Red/Green/Refactor that gives further order to this process: (1) Write a failing "red" test (2) Add the necessary product code to make that test pass or turn "green" (3) "Refactor" now that you have the correct functionality. This pattern provides an easy guide as you get into a programming flow.

:::image type="content" source="../media/test-red-green-refactor.png" alt-text="A circular diagram with steps including Red (write a failing test), Green (write code until it passes), and Refactor (cleanup your implementation).":::

## Behavior driven development (BDD)

Behavior driven development (or BDD) is very similar to TDD, but with greater focus on using acceptance tests to guide development at a high level. You may work with your customers, business partners, or program managers to define a set of tests that list the needed criteria for the product. These tests are usually much higher-level descriptions of functionality than unit tests and are more business-oriented.

BDD can use many different tools, but they all tend to focus on documenting different stages of expectations for the functionality such as the comments do in the test below. They also likely list the scope of what is expected. In the basic example pictured below, the comments specify that this app is only expected to add two numbers.
:::image type="content" source="../media/test-behavior-driven-development.png" alt-text="A screenshot of an empty test method in Visual Studio with several comments describing business needs of the app's calculator function.":::

## Don't repeat yourself (DRY)

"Don't repeat yourself", also known as DRY, is another practice also referred to in testing. This is strong guidance to avoid repeating information and logic everywhere you can. You can do this by abstracting the information and remembering to honor one source of truth rather than maintaining multiple copies of the same logic. For example, let's say you are writing unit tests for different constructors, but you are reusing many of the parameters for multiple tests. You could choose to write a test helper method that keeps all the parameter inputs in one place so they can more easily be called and modified for all of your tests. This is an example reducing duplication so you Don't Repeat Yourself.

## Choose what works best for you

Ultimately, you should choose what practices work best for you and make you the most effective programmer. That may be different for everyone since we all think and solve problems in many different ways. Don't worry if TDD is too intense or it doesn't fit your particular project. Maybe the team you are working on has better guidance on practices that work best specifically for your code base. I would encourage you to do some research and find something that is a good fit for you!
