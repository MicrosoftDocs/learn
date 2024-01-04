Here, we'll go over the *testing pyramid* and the many types of tests. Knowing how different types of tests address different vulnerabilities in your code will ensure that you're spending your time in the most impactful way.

## The testing pyramid

The testing pyramid has been popularized over the past several years to explain the different types of testing and how common each of them are in software. You can find many different versions of the testing pyramid out there, and its use is still debated, but we'll try to provide a straightforward and uncontroversial explanation.

The base of the pyramid is made up of *unit tests*. Unit tests are typically the easiest tests to write, the easiest to maintain as code changes, and the fastest to run. For many users, unit tests are the first introduction to testing. As you climb the pyramid, the tests usually become more expensive to write, maintain, and run. The tests at the top of the pyramid still provide high value, though there are fewer of these types. For example, users usually have more unit tests than integration tests, and more integration tests than UI tests.

:::image type="content" source="../media/testing-pyramid.png" alt-text="A graphic showing a pyramid divided into sections, labeled with different types of tests. Beginning from the bottom and going up, the types of tests are unit, integration, performance, load, acceptance, and UI.":::

## Types of tests

The industry is always evolving better ways to ensure code quality with tests. There are more types of tests than the ones listed here, but these tests are the major ones. The testing pyramid itself might need to be rewritten or reshaped as better software practices and development technologies evolve how we think and test.

### Unit tests

Unit tests are the most basic types of tests and make up the base of the testing pyramid. They should be specific to one method or the smallest testable unit of code. A method can have many unit tests to cover all its functionality, given a range of parameters. These tests are the easiest to write and also the easiest to debug because they should be the simplest way to exercise the piece of code that they test.

For example, let's say you have a method that parses a postal address from a string of input. Good unit tests for this method would insert many kinds of different postal addresses to make sure they were parsed correctly by the method, and matched the expected result. One unit test might insert a postal address from a different country/region as a string. Another might insert a string that had special characters to make sure it doesn't break your parser. Unit tests should be testing small aspects of the functionality of your app so that, if the test fails, it's easy to determine what functionality failed.

### Integration tests

Integration tests are the next step up from unit tests in the testing pyramid. They might cover multiple methods or a broader set of behavior than unit tests.
In our postal address example, an integration test could test both the postal address parser and a method for calculating a shipping rate for that location. The two combined help summarize if multiple parts of your app are working together as expected.

### Performance tests

Performance tests usually capture the time it takes certain parts of your program to run. Performance tests are a great way to catch a code change that slows down your app. You can set timers at the beginning of tests that only complete when the test is finished, and report a test failure if the timer exceeds a certain threshold.

### Load tests

Load tests can be similar to performance testing, but focus more on using your app at scale. How does the app hold up with 1,000 users using it? 10,000 users? Load tests help determine if your app is slowing down or throwing exceptions when under stress.

### Acceptance tests

Acceptance tests can guide towards the business desired outcome. If your customer gave you a list of criteria for the app, you can write acceptance tests that only pass after all of those criteria are met. Acceptance tests are another way of integrating your spec with your code.

### UI tests

UI tests can directly test the user interface interactions of an app. UI tests are meant to mimic an actual user clicking and interacting with your app, and to test if the UI response is correct. UI tests are at the top of the testing pyramid. There are many frameworks that can automate UI interactions. For example, [Playwright](https://playwright.dev/dotnet/) can automate the browser to mimic a user using your website.

Another type of UI testing is manual testing, when an actual person uses your app. Having a user test out your app before it's released has some advantages and disadvantages. It can be a slower type of testing because it can take a while to describe how to use the app to a new user, and it might be difficult to repeat the exact same steps every time. The major advantage is higher confidence that the app is ready for real human customers and nothing was missed because the app was used by more than just automation.

This testing method deserves careful consideration before you commit to it. It's easy to invest in UI tests, because they can seem like the most direct representation of what users are experiencing when they're using your app. The industry rapidly embraced UI tests when they first appeared on the scene for this very reason. The disadvantage is that UI also rapidly changes, so all the tests you write might need consistent updates, even for a small change. Be wary of writing too many UI tests that will need a high investment to keep up-to-date as your app grows.

> [!TIP]
> Many modern UI testing frameworks specifically address this ability to keep UI tests up-to-date, so it's good to look for platforms that also enable easier maintainability as you test.
