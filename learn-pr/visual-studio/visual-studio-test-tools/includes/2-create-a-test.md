In this unit, we'll cover a few basics:

* **Unit tests**: The most basic basic type of test.
* **The 3 A's**: Arrange, act, and assert make up the basic structure of tests.
* **Run a test**: Visual Studio provides a few helpful tools to run tests in context.
* **Red, green, refactor**: Every test you write should fail at least once!
* **Different assert statements**: Assert statements make test failures easier to track down.

## Unit tests

A unit test is the most basic type of test so it's a good place to start learning. A unit test specifically tests only one method or the smallest testable unit of code. Test methods are very much like regular methods. They are organized in to test classes that are all a part of a test project. You can also group test classes by namespace just like other classes. Tests can also accept parameters which you will learn more about in one of the later units.

Below is an example of a simple test class. It first imports the unit testing framework. In this case, the built in Microsoft testing framework `Microsoft.VisualStudio.TestTools.UnitTesting` also known as MSTest. The second using directive refers to the calculator app being tested called `LearnMyCalculatorApp`. Then the test class is declared and within that, a test method is declared.

```csharp
using Microsoft.VisualStudio.TestTools.UnitTesting;
using LearnMyCalculatorApp;

[TestClass]
public class CalculatorTests
{
    [TestMethod]
    public void CalculatorNullTest()
    {
        var calculator = new Calculator();
        Assert.IsNotNull(calculator);
    }
}
```

This test class is a part of a test project that references the the app that needs to be tested. In this case, the LearnMyCalculatorApp project.

:::image type="content" source="../media/test-solution-explorer.png" alt-text="Screen shot of a test project and a calculator project in the Visual Studio Solution Explorer":::

Tests reference and call your product code (another way of saying your non-test code). For example, let's say there is an `Add` method in my calculator app that I need to test.

```csharp
public class Calculator
{
    public int Add(int x, int y)
    {
        return x + y;
    }
}
```

A test for the `Add` method could look something like the code below.

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

## The 3 A's: assert, act, and arrange

Note the 3 A's in the comments: arrange, act, and assert. These are basic guidelines for your testing structure.

* **Arrange** is where you declare any variables that your test may need. In this example, we must declare a `calculator` object to call its `Add` method.
* **Act** is where you call the code you would like to test. This is where we can insert different parameters and exercise the code.
* **Assert** is where you check if the outcome of the action is expected. You can add multiple asserts to any given test. If one assert fails, then the test will fail.

## Run a test

Now that you understand the basic setup of a test and test project the next step is running your tests. Visual Studio provides a few helpful ways to run tests from whatever context you're working in.

* **Run tests with a right-click**: right-clicking allows you to run tests from the context menu. A helpful tip is it will always run tests according to the scope your cursor is in. For example, if you right-click in a test class and select `Run Test(s)` it will run all of the tests in that class. If you right-click in a test namespace it will run all the tests in the namespace.

:::image type="content" source="../media/test-right-click-run.png" alt-text="desc":::

* **Ctrl+R, T**: the keyboard shortcut **Ctrl+R, T** will also run the tests that are currently in the context of your cursor.

* **CodeLens Test icon**: You can also enable a small test icon to appear in your test methods by enabling CodeLens in your Tools > Options. This provides a helpful UI to run the tests and lets you know the test result from inside the code editor.

* **Test Explorer**: once you have multiple tests you may find yourself using the Test Explorer more for running, viewing, and organizing your test suite. We'll dive into the Test Explorer more later on.

:::image type="content" source="../media/test-explorer.png" alt-text="desc":::

## Red, green, refactor

Red, green, refactor is a recommended pattern for testing.

* **Red**: Write a failing "red" test
* **Green**: Add the necessary product code to make that test pass or turn "green"
* **Refactor**: "Refactor" now that you have the correct functionality.

This pattern provides an easy guide as you get into a programming flow. If you are interested in learning more about different testing schools of thought see [Introduction to software testing concepts](/learn/modules/visual-studio-test-concepts/5-testing-schools-of-thought) which covers more on TDD or Test Driven Development.

When you are writing a test, it's good to see it fail at least once so that you know that it *can* fail. A common issue is believing a test covers a certain scenario only to find a bug in production and realize your test was not making the right calls or never correctly asserted the expected outcome.

## Different assert statements

Assert statements are what decide if your test passes or fails.
