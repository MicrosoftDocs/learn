In software projects, testing can be complicated and feel overwhelming. When existing projects aren't built with many tests, the code tends to be complex and less robust. Grasping the problems and potential pitfalls with testing is crucial for a successful software project.

## Lack of testing

When software projects are built with no tests (or an inadequate number of tests), code can deteriorate, become brittle, and harder to understand. Tests make code accountable for its behavior, and when tests are introduced, it forces an engineer to make code easier to test.

There are a few positive side-effects of testing that you can recognize in your code. Functions and methods written with testing in mind, tend to:

* Be no longer than about a dozen lines long.
* Have a single responsibility instead of doing many different things.
* Have a single or minimal amount of input instead of many arguments and values.

Short, single-responsibility, and minimal input makes code easier to understand, maintain, and test. When testing isn't involved, it's common to see smaller functions grow into several hundred lines, doing many things. The code evolves this way because there's no accountability preventing the unnecessary complexity.

## Legacy code

One way to think about untested code is to label it as _legacy code_. It's common to find untested code in software projects. Code can go untested for several reasons, including A lack of experience with testing, or development practices that don't allow sufficient time to consider testing as part of producing software.

As already mentioned, one characteristic of untested code is that it's hard to grasp, and can often become complex for the same reason. A side-effect of all these problems is that it makes code even more difficult to deal with, causing functions (or methods) to keep growing with more logic and more intertwined code paths.

The smaller the function, the easier it will be to test.

## Slow and unreliable tests

Although an existing test suite is great to start with, it might be problematic when it contains slow or unreliable tests. A developer will be more inclined to run tests often if they provide fast feedback. If a test suite takes hours to run instead of minutes (or seconds), a developer can't afford to run it as often. When the feedback loop is slow, the development process gets compromised.

Similarly, you may find situations where a test can fail without an apparent reason. Unreliable tests are sometimes called _flaky_. The main responsibility of a test suite is to demonstrate that the code under test is meeting expectations set by the tests themselves. If tests are unreliable, you can't really tell if the code needs to be changed, or if a patch has introduced a regression.

Unreliable (or flaky) tests should be fixed or otherwise removed from the suite. Not every test can be fast, and some types of testing like integration tests can be slow. But having a solid test suite that provides fast feedback is essential.

## Lack of automation

When testing doesn't happen in an automated way, it's easy to forget what to test and testing can become error prone. Even on small software projects it's easy to forget if changing a condition in a function can have a (negative) side-effect somewhere else in the code base. When a software developer isn't tasked with remembering what and when to test because it all happens automatically, then confidence in the software, the tests, and the overall system increases.

Automation is all about removing repetitive tasks and reducing the steps necessary for an action to happen. Automated Testing can happen when code is pushed to a remote repository, or even before it gets merged. Preventing defective code from getting into production code without manual checks is critical for a robust application.

## Test tooling

Some of the challenges come from a lack of testing, while others are related to poor testing experiences and not knowing what techniques to apply. We've already mentioned _legacy code_ in this module, and how untested code can keep growing in size and complexity. Test coverage tools can accurately tell you which code paths are tested, and which aren't being covered by existing tests.

Relying on tooling and testing libraries is a great way to reduce the amount of effort it takes to produce good tests. Depending on the language and application being tested, you must find solutions that can make testing easier and more robust. 

Here are some examples of what those tools should be:

* A test coverage tool for reporting on tested and untested code paths.
* A test runner that can collect, execute, and rerun specific tests.
* A CI/CD environment that can automatically run tests and prevent defective code from getting merged or deployed.
