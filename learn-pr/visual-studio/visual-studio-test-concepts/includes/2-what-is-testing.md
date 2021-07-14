When you test, either by writing code or performing manual testing, you do so because you want to ensure that your software works as intended. This unit focuses on writing code that tests various parts of your application code. Your application code will not ship with the test code. Think of test code as scaffolding that supports the software development process throughout your program's lifetime.

Let's start by defining testing with some examples before we dive into the concepts.

## The testing process

Testing involves a series of test methods that run against your product code and return a pass or fail result based on certain criteria that is asserted. Test results appear in a list of red "x" to represent failing tests and green "✔" to represent passing tests that make it easy to assess what functionality is working or not at a glance.

![image](../media/test-intro-testlist.png)

## Test Method definition

Tests are very much like regular methods. They are organized within Test Classes, have method signatures, and accept parameters. They reference and call your product code (another way of saying your non-test code) and compare how it behaves to an expected outcome.

```csharp
[TestMethod]
public void AddTest()
{
    // Arrange
    var calculator = new Calculator();

    // Act
    var actual = calculator.Add(1, 1);

    // Assert
    Assert.AreEqual(2, actual);
}
```

Here is how this test would appear in Visual Studio:
![image](../media/test-intro-TestMethod.png)

One difference between tests and product code is they don't run as part of your app's normal function. So instead of using F5 (or the big green run button at the top of your development environment) to run as you would your app, you choose which tests to run either via a Test Explorer or a number of other helpful editor tools.
![image](../media/test-intro-runtests.png)
![image](../media/test-intro-runtests-testexplorer.png)

## How can tests help prevent regressions in functionality?

Remember the phone number bug from the intro scenario? As soon as new code was added to accept international phone numbers, the function for adding domestic phone numbers broke! A test using domestic phone numbers as input may have caught this behavior change sooner since it would have tested not only the new functionality for international numbers, but also the old functionality for domestic phone numbers.

As we implement new code, it may not always occur to us what old scenarios could be impacted by new changes. The phone numbers are a simple example, but imagine apps with hundreds of different input formats and needing to check that code every time. Tests make it easy for all several variations of the old behavior to be checked with a simple test run.

![image](../media/test-intro-phoneNum-example.png)

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->
