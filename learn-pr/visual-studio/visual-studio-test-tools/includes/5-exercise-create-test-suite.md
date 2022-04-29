In the last exercise, you added product code for the calculator app and a first test method. Now you'll keep building out your test project with a test suite.

## Add more tests

Add more tests to ensure that you test all the functionality of your calculator product code.

1. Add the following test method to your test class:

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

   The preceding code demonstrates a simple test for entering two numbers into the `Add` method and asserting a result.

   **Challenge**: Can you create similar tests for the `Subtract`, `Multiply`, and `Divide` methods?
   
   > [!NOTE]
   > If you want to check your code, see the section about [expected examples](#expected-examples-for-subtract-multiply-and-divide-tests) later in this unit.

1. Add another test for the `Divide` method that fails. The `Divide` method in your calculator can't yet handle dividing by zero. Create a test method that enters zero as the divisor. Run the new test to confirm that it fails.

   It doesn't matter what's in your assert statement, because an uncaught exception fails the test. For now, let's say the `Divide` method should return null when dividing by zero. What assertion should you use?
   
   > [!NOTE]
   > If you want to check your code, see the [expected divide-by-zero test](#expected-divide-by-zero-test) later in this unit.

Now that you're accumulating a test suite, let's learn more about managing multiple tests by using Visual Studio Test Explorer.

## Filter to failing tests

In a larger project, you might have hundreds of tests running in Test Explorer. To quickly identify which tests failed, you can use the filter functionality.

1. On the Test Explorer toolbar, select the button for failed tests (the one that has a red X). This button also summarizes how many tests are failing in the current view. In the following example, this button has the number 2 on it to indicate that two failed tests are in the current view.

   :::image type="content" source="../media/test-explorer-filter.png" alt-text="Screenshot that shows the button for failed tests in Test Explorer.":::

   The test view is filtered to show only the failing tests. In the following example, only two tests appear in the list of tests because the other four tests (the passing ones) are now filtered out.

   :::image type="content" source="../media/test-explorer-filter-fail.png" alt-text="Screenshot that shows a list of tests filtered to include only failed tests.":::

1. Select the flask button to go back to viewing tests with all outcomes. This button also lists the total number of tests and how many tests are visible in the current view as a fraction. With the current filtering, only two tests are visible out of a total of six tests.

   :::image type="content" source="../media/test-explorer-total-summary.png" alt-text="Screenshot that shows the flask button with a fraction that indicates two out of six."

## Use the Group By options

Using grouping makes it easier to work with a large number of tests. Let's explore some of the settings for grouping.

1. Select **Group By**.
1. Try a new grouping by clearing the presets and grouping only by state (such as passed, failed, or not run) and then class.

   :::image type="content" source="../media/test-explorer-groupby-state.png" alt-text="Screenshot that shows Group By button in Test Explorer, with hierarchy levels selected.":::

1. Click outside the menu. The new **Group By** selection is applied to the test view. 

   In the following example, the first group consists of failed tests that are organized by class. The second group consists of passed tests that are also organized by class.

   :::image type="content" source="../media/test-explorer-groupby-state-class.png" alt-text="Screenshot that shows the tests in Test Explorer organized into a hierarchy of state grouping and then class grouping.":::

## Debug a test

Sometimes, it's not obvious why a test fails. You might need to do a closer inspection by setting a breakpoint and debug the test while it's running.

1. Set a breakpoint in `DivideByZeroTest` at the `Assert` line by clicking in the margin of the code editor.
1. Right-click the test method in the code editor and select **Debug Test(s)**.

   :::image type="content" source="../media/debug-divide-zero.png" alt-text="Screenshot of the editor window with a breakpoint set on the Assert statement, and with Debug Tests selected on the right-click menu.":::

   The debugger doesn't reach your breakpoint because it fails on `System.DivideByZeroException`, as expected. The following screenshot shows a divide-by-zero system exception in the midst of debugging. The exception appears in a callout above the `Divide` method on the return statement.

   :::image type="content" source="../media/debug-exception.png" alt-text="Screenshot of Visual Studio throwing a divide-by-zero system exception.":::

## Apply the red, green, refactor pattern

Red, green, refactor is all about starting with a failing test, to see that the test can fail but also that the product code might not be written yet. Let's adapt this mindset in the upcoming steps.

`DivideByZeroTest` will fail until you update the `Divide` method in *Calculator.cs* to gracefully handle when the divisor is zero. So this test is on "red," because it's waiting for you to write missing product code.

1. Write some code to catch the exception if the divisor is zero, and notify the user with a console message such as "Cannot divide by zero." After catching the exception, the `Divide` method can return `null`. Edit the `Divide` method signature to allow a nullable `int` return type.

    Your `Divide` method should now look similar to the following code.

    ```csharp
    public int? Divide(int x, int y)
    {
        try
        {
            return x / y;
        }
        catch (DivideByZeroException)
        {
            Console.WriteLine("Cannot divide by zero.");
            return null;
        }
    }
    ```

1. Rerun your `DivideByZero` test to confirm that it now passes. The `Divide` method now returns `null` when the divisor is zero. Note that the output that warns the user they can't divide by zero appears in the test detail summary in Test Explorer. The test details include the `Console.Writeline` output.

   :::image type="content" source="../media/test-explorer-output.png" alt-text="Screenshot of Test Explorer that shows a passing divide-by-zero test and the test details.":::

   Your test went from red to green because you added product code to get the test to pass.

1. Now that you have working product code and a test, refactor your product code to create an even better and more robust solution, if possible.

   > [!TIP]
   > Consider scenarios that might need to be updated because of your recent changes. Feel free to add comments to describe new functionality.

Congratulations! You've added more tests and learned to use a red, green, refactor pattern. You started with the failing `DivideByZeroTest` and modified the product code until it got to green. The last step before moving on was refactoring.

## Expected examples for subtract, multiply, and divide tests

```csharp
[TestMethod]
public void SubtractTest()
{
    // Arrange
    var calculator = new Calculator();

    // Act
    var actual = calculator.Subtract(1, 1);

    // Assert
    Assert.AreEqual(0, actual);
}

[TestMethod]
public void MultiplyTest()
{
    // Arrange
    var calculator = new Calculator();

    // Act
    var actual = calculator.Multiply(1, 1);

    // Assert
    Assert.AreEqual(1, actual);
}

[TestMethod]
public void DivideTest()
{
    // Arrange
    var calculator = new Calculator();

    // Act
    var actual = calculator.Divide(1, 1);

    // Assert
    Assert.AreEqual(1, actual);
}
```

## Expected divide-by-zero test

```csharp
[TestMethod]
public void DivideByZeroTest()
{
    // Arrange
    var calculator = new Calculator();

    // Act
    var actual = calculator.Divide(1, 0);

    // Assert
    Assert.IsNull(actual);
}
```
