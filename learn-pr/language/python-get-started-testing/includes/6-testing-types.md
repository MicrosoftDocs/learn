When you're developing a testing strategy, the different types of testing can cause some confusion. Knowing what these types of testing are and how they're different from each other is a solid way to implement a robust testing strategy.

> [!NOTE]
> The difference between unit, integration, and functional testing can be controversial. These descriptions are meant as guidelines. The most important thing is to be consistent with the project and other developers.

## Unit testing

The primary focus of unit testing is testing the smallest piece of code logic possible. The side-effect of this type of testing is speed. Unit tests will usually run quickly since (ideally) no external resources like databases, websites, or network calls are needed.

Functions and methods that are long and complex, with multiple logical conditions will be difficult to unit test. Unit testing forces developers to think about complexity in code and keeping it to a minimum. In general, the shorter the function or method is, the easier it will be to test it.

There aren't any hard rules about unit testing, but in general the following are commonly accepted norms about unit tests:

- They test the smallest piece of logic possible.
- Functions, methods, or classes are tested as isolated as possible, avoiding the need to set up other functions, methods, or classes as a requirement.
- No external services like databases or network services are needed for them to run.

## Integration testing

Integration testing usually focuses on testing logic that will interact with other pieces of logic in a code project. Sometimes, these tests will require connecting to a database or other external service.

For example, a function that checks a username and password will probably need to connect to a database to verify existing data. A test for that function could require a database with existing information. These types of tests will require slightly more complex setups than unit tests and may take longer to execute.

Here are some accepted norms about integration testing:

- Not as fast as unit tests, and they tend to require more setup upfront before running.
- Functions, methods, or classes are tested with functionality in other functions, methods, or classes.
- An external service might be used, but not all the services for the application.

## Functional testing

Functional testing usually requires running an application as a whole. For a website, a functional test might need a web server, a database, and any other required service for the application to run. The idea is to replicate the application running in the production environment as closely as possible.

Since it's not always possible to accurately replicate a production environment, special care needs to be put into the drawbacks of the setup. For example, if a website has 1 terabyte of data in production, it's probably fine to test with a subset of the production data. However, it wouldn't be advisable to use an embedded database like SQLite instead of the same PostgreSQL database used in production. Version differences of external services like databases can cause a test to pass but fail in production.

Functional testing has some of the following aspects:

- Not as fast as unit tests, and they tend to require more setup upfront before running.
- Functions, methods, or classes are tested with functionality in other functions, methods, or classes.
- An external service might be used, but not all the services for the application.

Since functional tests require more services, a reproduction of the production environment, and the most complex setup of the test types, it will usually be time consuming and resource intensive.

A single functional test for an online retail store could involve the following steps to complete:

1. Sign up for a new user.
1. Select a given product and add it to the virtual shopping cart.
1. Complete the shipping and billing information.
1. Select the "buy" button to complete the purchase.
1. Verify that the new account exists, billing and shipping information is correct, and inventory was updated.

## Continuous Integration

Although CI (Continuous Integration) isn't a type of testing, it's an important piece that has to do with every type of testing. When a testing plan is put into place, it's essential to have _something_ that will run the tests in an automated way. A CI environment is the right place to automatically run tests. These tests can run on a schedule, be triggered by an event, or be manually executed. This environment will usually be consistent with where the code or project needs to run.

The foundation for a good CI process is automation. Automation is what will set a consistent (and well known) environment. Without a repetitive and known testing environment, debugging problems and failed tests would be time consuming or even impossible.

### Triggered by an event

For example, if a developer wants to merge changes to the main branch, it's ideal to ensure that the changes won't cause breakage. A CI system can automatically run tests from a developer's branch and alert them when there's a failure. Preventing code that has failed CI from being merged, is a good way to increase confidence and robustness in a project.

### Running on a schedule

As already mentioned, automation is a crucial part of a CI process. Usually, with the setup of any test type, dependencies must be installed in order for tests to work. Using a schedule for a test run (for example a nightly run) ensures that a project builds correctly even when dependencies change.

A recurrent scheduled test run can also be helpful when running tests that take a long time to complete. If a software project has functional tests that take a few hours to complete, it would be more efficient to run those tests at night. so the team can work on failures first thing in the morning.

### Manual triggering

Finally, even though scheduled and event-driven test runs are useful, it's good to be able to run a test suite manually. For example, when a test suite is known to have a problem, a developer can try a fix by rerunning a previously failed run. This feedback loop allows fixes to be tested without the need for a specific event or schedule. Further, a CI run might allow configuration changes for a test to run which can be altered ad-hoc to ensure certain conditions are met.
