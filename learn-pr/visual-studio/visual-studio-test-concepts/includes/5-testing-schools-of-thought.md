There is a lot of guidance out there when it comes to testing. We'll cover some of the common schools of thought that experienced developers often recommend.

## Test driven development (TDD)

*Test driven development*, or *TDD*, is a method of directly coupling testing with every part of your daily development. Developers who use TDD typically start developing by first writing a test that fails, and then writing the code that makes the test pass. This approach means that product code is more likely to get high test coverage, and the tests typically come first.

Many developers find this pattern useful to help them prioritize good architecture from the start of development, and to stay laser-focused on each part of the functionality they need to implement. This school of thought advocates for testing not being an after-thought of development, but rather a driving force.

For example, in the following image, you can see that `AddTest` is written and failing while the `Add` method has yet to be implemented. This test will fail until the method is implemented.
:::image type="content" source="../media/test-driven-development.png" alt-text="Screenshot of a test method in the Visual Studio editor named AddTest that is implemented and failing. The Add method is also visible and throws an exception.":::

There's a type of TDD called *Red/Green/Refactor*. It's a good one to know about because it provides further order to this process. Here's how it works:

1. Write a failing "red" test.
1. Add the necessary product code to make sure that your test passes or turns "green."
1. "Refactor" now that you have the correct functionality.

The following diagram provides a visual of this type of TDD.

:::image type="content" source="../media/test-red-green-refactor.png" alt-text="A circular diagram with steps including Red (write a failing test), Green (write code until it passes), and Refactor (clean up your implementation).":::

## Behavior driven development (BDD)

*Behavior driven development* (or *BDD*) is similar to TDD, but with greater focus on using acceptance tests to guide development at a high level. You might work with your customers, business partners, or program managers to define a set of tests that list the needed criteria for the product. These tests are higher-level descriptions of functionality than unit tests, and are more business-oriented.

BDD can use many different tools, but they all tend to focus on documenting different stages of expectations for the functionality (for example, see the comments in the following screenshot of a test). BDD tests also likely list the scope of what's expected. In the following basic example, the comments specify that this app is only expected to add two numbers.
:::image type="content" source="../media/test-behavior-driven-development.png" alt-text="A screenshot of an empty test method in Visual Studio, with several comments describing the business needs of the app's calculator function.":::

## Don't repeat yourself (DRY)

*Don't repeat yourself*, also known as *DRY*, is another practice in the field of testing. DRY posits that you should avoid repeating information and logic everywhere you can. You can avoid repetition by abstracting the information and honoring one "source of truth," rather than maintaining multiple copies of the same logic.

For example, let's say you're writing unit tests for different constructors, but you're reusing many of the parameters for multiple tests. You can write a test helper method that keeps all the parameter inputs in one place, so they can more easily be called and modified for all of your tests. This is an example of reducing duplication, so you don't repeat yourself.

## Choose what works best for you

Ultimately, you should choose the practices that work best for you and make you the most effective programmer. It can be different for everyone, because we all think and solve problems in different ways. Don't worry if TDD is too intense or it doesn't fit your particular project. Maybe the team you're working on has better guidance on practices that work best specifically for your code base. Do some research and find something that's a good fit for you!
