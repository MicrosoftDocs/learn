In this unit, we'll cover a few basics:

* **Unit tests**: The most basic basic type of test.
* **The 3 A's**: Arrange, act, and assert make up the basic structure of tests.
* **Run a test**: Visual Studio provides a few helpful tools to run tests in context.
* **Red, green, refactor**: Every test you write should fail at least once!
* **Different assert statements**: Assert statements make test failures easier to track down.

## Unit tests

A unit test is the most basic type of test so we'll start there. A unit test is specific to one method or the smallest testable unit of code. Test methods are very much like regular methods. They are organized in to test classes that are all a part of a test project. You can also group test classes by namespace just like other classes. Tests can also accept parameters which you will learn more about in one of the later units.

Below is an example of a simple test class. It first imports the unit testing framework. In this case, the built in Microsoft testing framework `Microsoft.VisualStudio.TestTools.UnitTesting` also known as MSTest. The second using directive refers to the calculator app being tested called `LearnMyCalculatorApp`. It also declares a test class and within that, a test method.

```csharp
using Microsoft.VisualStudio.TestTools.UnitTesting;
using LearnMyCalculatorApp;

[TestClass]
public class CalculatorTests
{
    [TestMethod]
    public void AddTest()
    {
        var calculator = new Calculator();
        Assert.IsNotNull(calculator);
    }
}
```

This test class is a part of a test project that references the the app that needs to be tested. In this case, the Calculator project.

:::image type="content" source="../media/test-solution-explorer.png" alt-text="Screen shot of a Test project and Calculator project in the Visual Studio Solution Explorer":::

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

* **Arrange** is where you declare any variables you test may need. In this example, we must declare a `calculator` object to access it's `Add` method.
* **Act** is where you call the code you would like to test. This is where we can insert different parameters and exercise the code.
* **Assert** is where you check if the outcome of the action is expected. You can add multiple asserts to any given test. If one assert fails, then the test will fail.

## Run a test

:::image type="content" source="../media/test-right-click-run.png" alt-text="desc":::

## Red, green, refactor

## Different assert statements
