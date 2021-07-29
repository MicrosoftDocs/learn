Here, we'll go over the testing pyramid and the many types of tests. Knowing how different types of tests address different vulnerabilities in your code will make sure you're spending your time in the most impactful way.

* **The Testing pyramid**: The testing pyramid helps us organize the types of tests by how expensive they're to write, maintain, and run as well as the rarity of those types of tests.
* **Unit Tests**: Unit tests test the smallest testable unit of code, make up the base of the testing pyramid, are the most common, and are the least expensive tests to write, maintain, and run.
* **Integration Tests**: Integration tests are the next level up and test more than the smallest testable unit of code and often test how multiple behaviors integrate with each other.
* **Performance Tests**: Performance tests measure how long it takes certain parts of your program to execute.
* **Load Tests**: Load tests stress your app to its limits by mimicking multiple users and processes using your app at once.
* **Acceptance Tests**: Acceptance tests define the business desired outcome and test if your app has the customer criteria it needs.
* **UI Tests**: UI Tests mimic actual users using the app and interacting with the UI as an end customer would in order to complete an action.

## The testing pyramid

The testing pyramid has been popularized over the past several years to explain the different types of testing and how common each of them are in software. You can find many different versions of the testing pyramid out there and its use is still debated, but we'll try to provide a straight forward and uncontroversial explanation. The base of the pyramid is made up of unit tests. Unit tests are typically the easiest tests to write, maintain as code changes, and run the fastest. For many users, unit tests are the first introduction to testing. As you climb the pyramid, the tests usually become more expensive to write, maintain, and run. The tests at the top of the pyramid still provide high value though there are usually fewer of these types. For example, users usually have more unit tests than integration tests and more integration tests than UI tests.

:::image type="content" source="../media/testing-pyramid.png" alt-text="A pyramid divided into sections labeled with different types of tests. Starting from the bottom and ascending the pyramid the types of tests are unit, integration, performance, load, acceptance, and UI.":::

## Types of tests

The industry is ever evolving better ways to ensure code quality with tests. There are likely many more types of tests not listed here, but these are the major ones. The testing pyramid itself may need to be rewritten or reshaped as better software practices and development technologies evolve how we think and test.

### Unit tests

:::image type="content" source="../media/test-pyramid-unit.png" alt-text="The testing pyramid with the 'unit' layer highlighted at the base of the pyramid.":::

Unit tests are the most basic types of tests and make up the base of the testing pyramid. They should be specific to one method or the smallest testable unit of code. A method can have many unit tests to cover all its functionality given a range of parameters. These are the easiest to write and also the easiest to debug because they should be the simplest way to exercise the piece of code that they test.
For example, let's say you have a method that parses a postal address from a string of input. Good unit tests for this method would insert many kinds of different postal addresses to make sure they were parsed correctly by the method and matched the expected result. One unit test may insert a postal address from a different country as a string. Another may insert a string that had special characters to make sure it doesn't break your parser. Unit tests should be testing small aspects of the functionality of your app so that, if the test fails, it's easy to determine what functionality failed.

### Integration tests

:::image type="content" source="../media/test-pyramid-integration.png" alt-text="The testing pyramid with the 'integration' layer highlighted second from the bottom of the pyramid.":::

Integration tests are the next step up from unit tests in the testing pyramid. They may cover multiple methods or a broader set of behavior than unit tests.
Going back to our postal address example, an integration test could test both the postal address parser and a method for calculating a shipping rate for that location. The two combined help summarize if multiple parts of your app are working together as expected.

### Performance tests

:::image type="content" source="../media/test-pyramid-performance.png" alt-text="The testing pyramid with the 'performance' layer highlighted third from the bottom of the pyramid.":::

Performance tests usually capture the time it takes certain parts of your program to execute. Performance tests are a great way to catch a code change that slows down your app. You can set timers at the beginning of tests that only complete when the test is finished executing and report a test failure if the timer was above a certain threshold.

### Load tests

:::image type="content" source="../media/test-pyramid-load.png" alt-text="The testing pyramid with the 'load' layer highlighted fourth from the bottom and third from the top of the pyramid..":::

Load tests can be similar to performance testing, but focuses more on using your app at scale. How does the app hold up with 1,000 users using it? 10,000 users? Load tests help determine if your app is slowing down or throwing exceptions when under stress.

### Acceptance tests

:::image type="content" source="../media/test-pyramid-acceptance.png" alt-text="The testing pyramid with the 'acceptance' layer highlighted second from the top of the pyramid.":::

Acceptance tests can guide towards the business desired outcome. If your customer gave you a list of criteria for the app, you can write acceptance tests that only pass once all of those criteria are met. Acceptance tests are another way of integrating your spec with your code.

### UI tests

:::image type="content" source="../media/test-pyramid-user-interface.png" alt-text="The testing pyramid with the 'UI' layer highlighted at the top of the pyramid.":::

UI tests can directly test the user interface interactions of an app. This is meant to mimic an actual user clicking and interacting with your app and testing if the UI response is correct. UI tests are at the top of the testing pyramid. There are many frameworks that can automate UI interactions. For example, [Playwright](https://playwright.dev/dotnet/docs/why-playwright) can automate the browser to mimic a user using your website.

Another type of UI testing is manual testing. Manual testing is when an actual person uses your app. Having a user test out your app before it's released has some advantages and disadvantages. It can be a slower type of testing because it can take a while to describe how to use the app to a new user and it may be difficult to repeat the exact same steps every time. The major advantage is higher confidence that the app is ready for real human customers and nothing was missed because the app was used by more than just automation.
> [!IMPORTANT]
> A word of caution, it's easy to invest in UI tests because they can seem like the most direct representation of what users are experiencing when using your app. The industry rapidly embraced UI Tests when they first appeared on the scene for this very reason. The disadvantage was that UI also rapidly changes so all the tests you write may need consistent updates even for a small change. Be wary of writing too many UI tests that will need a high investment to keep up-to-date as your app grows. Many modern UI testing frameworks specifically address this ability to keep UI tests up-to-date, so it's good to look for platforms that also enable easier maintainability as you test.
