# Different Types of Testing and the Testing Pyramid

<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: state what's in this unit and how it aligns to the 'evaluate' learning objective.

    Pattern:
        One paragraph of 2 sentences:
            Sentence 1: State that this unit addresses ("when to use it").
            Sentence 2: State that this unit targets this learning objective: "Evaluate whether (product) is appropriate to (general product use case)."
        Decision criteria as a bulleted list.

    Heading: none

    Example: "Here, we'll discuss how you can decide whether Logic Apps is the right choice for a workflow. We'll list some criteria that indicate whether Logic Apps will meet your performance and functional goals.
        * Integration
        * Performance
        * Conditionals
        * Connectors"
-->
Here, we'll go over the testing pyramid and the many types of tests. Knowing how different types of tests can help address different vulnerabilities in your code will make sure you are spending your test investment in the most impactful way.

* The Testing pyramid
* Unit Tests
* Integration Tests
* Performance Tests
* Load Tests
* Acceptance Tests
* UI Tests

<!-- 2. Decision criteria introduction --------------------------------------------------------------------------------

    Goal: Lead-in to the criteria discussion.

    Pattern:
        1 paragraph consisting of 3 sentences
            Sentence 1: summarizing the criteria from a positive view ("when to use").
            Sentence 2: describing the negative ("when not to use") at a high level.
            Sentence 3: transition/lead-in to the detailed discussion.

    Heading: "## Decision criteria"

    Example:
        "Decision criteria"
         "Logic Apps helps you coordinate the flow of data through disparate systems. The cases where Logic Apps might not be the best option typically involve real-time requirements, complex business rules, or use of non-standard services. Here's some discussion of each of these factors."
-->

## The Testing pyramid

The testing pyramid has been popularized over the past several years to explain the different types of testing and how common each of them are in software. You can find many different versions of the testing pyramid out there and it's use is still debated, but we'll try to provide a simple and uncontroversial explanation. The base of the pyramid is made up of unit tests. These are typically the easiest tests to write, maintain as code changes, and run the fastest. For many users, unit tests are the first introduction to testing. As you climb the pyramid, the tests usually become more expensive to write, maintain, and run, but they can still provide high value though there are usually fewer of these types.

![image](../media/testing-pyramid.png)

## Types of Tests

The industry is ever evolving better ways to ensure code quality with tests there are likely many more types of tests not listed here, but these are the major ones. The testing pyramid itself may need to be re-written or re-shaped as better software practices and development technologies evolve how we think and test.

### Unit Tests

Unit tests are the most basic types of tests. They should be specific to one method or one function. A method can have many unit tests to cover all it's functionality given a range of parameters. These are the easiest to write and also the easiest to debug because they should be the simplest way to exercise the piece of code that they test.
For example, let's say you have a method that parses a postal address from a string of input. Good unit tests for this method would insert many kinds of different postal addresses to make sure they were parsed correctly by the method and matched the expected result. One unit test may insert a postal address from a different country as a string. Another may insert a string that had special characters to make sure it doesn't break your parser. Unit tests should be testing small aspects of the behavior of your app so that, if the test fails, it's easy to determine what behavior failed.

### Integration Tests

Integration tests are the next step up from unit tests. They may cover multiple methods or a broader set of behavior than unit tests.
Going back to our postal address example, an integration test could test both the postal addresser parse and a method for calculating a shipping rate for that location. The two combined help summarize if multiple parts of your app are working together as expected.

### Performance Tests

Performance tests usually capture the time it takes certain parts of your program to execute. Performance tests are a great way to catch a code change that slows down your app. You can set timers at the beginning of tests that only complete when the test is finished executing and report a test failure if the timer was above a certain threshold.

### Load Tests

Load tests can be similar to performance testing, but focuses more on using your app at scale. How does the app hold up with 1000 users are using it? 10,000 users? Load tests help determine if your app is slowing down or throwing exceptions when under stress.

### Acceptance Tests

Acceptance tests can be tests that guide the business desired outcome. If your customer gave you a list of criteria for the app, you can write acceptance tests that only pass once all of those criteria are met. Acceptance tests are another way of integrating your spec with your code.

### UI Tests

UI tests can directly test the UI interactions of an app. This is meant to mimic an actual user clicking and interacting with your app and testing if the UI response is correct. There are many frameworks that can automate UI interactions. For example, [Playwright](https://playwright.dev/dotnet/docs/why-playwright) can automate the browser to mimic a user using your website.

Another type of UI testing is manual testing. Manual testing is when an actual person uses your app. Having a user test out your app before it is released has some advantages and disadvantages. It can be a slower type of testing because it can take a while to describe how to use the app to a new user and it may be difficult to repeat the exact same steps every time. The major advantage is higher confidence that the app is ready for real human customers and nothing was missed because the app was used by more than just automation.
> [!IMPORTANT] 
> A word of caution, it's easy to invest in UI tests because they can seem like the most direct representation of what users are experiencing when using your app. The industry rapidly embraced UI Tests when they first appeared on the scene for this very reason. The disadvantage was that UI also rapidly changes so all the tests you write may need consistent updates even for a small change. Be wary of writing too many UI tests that will need a high investment to keep up-to-date as your app grows. Many modern UI testing frameworks specifically address this ability to keep UI tests up-to-date, so it's good to look for platforms that also enable easier maintainability as you test.

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->
