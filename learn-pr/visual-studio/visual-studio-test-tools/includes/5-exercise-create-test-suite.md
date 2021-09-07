In the last exercise, you added product code for the calculator app and a first test method. Now you'll keep building out your test project.

In this exercise, we'll build out a test suite and exercise the Test Explorer.

* Add more tests
* Filter to failing test in Test Explorer
* Use the Group By options to customize the test view
* Debug a test
* Red, green, refactor

## Add more tests

Next, you are looking to add more tests to ensure you test all the functionality of your calculator product code.

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

   The code above demonstrates a simple test for inputting two numbers into the `Add` method and asserting a result.

   **Challenge**: Can you create similar tests for the `Subtract`, `Multiply`, and `Divide` methods?
   Now you should have tests for the `Subtract`, `Multiply`, and `Divide` methods.

   > [!NOTE]
   > If you want to check your code, see the [expected examples](#expected-examples-for-subtract-multiply-and-divide-tests) section at the end of this page.

1. Add another test for the `Divide` method that fails. The `Divide` method in our calculator cannot yet handle dividing by zero. Create a test method that inputs zero as the divisor. Run the new test to confirm it fails.
   It doesn't matter what is in your assert statement since an uncaught exception fails the test. For now, let's say the `Divide` method should return null when dividing by zero. What assert should you use?
   > [!NOTE]
   > If you want to check your code, see the [expected divide by zero test](#expected-divide-by-zero-test) at the end of this page.

Now that you're accumulating a test suite, let's learn more about managing multiple tests with the Visual Studio Test Explorer.

## Filter to failing tests

In a larger project, you might have hundreds of tests running in the Test Explorer, to quickly identify which tests failed, you can use the filter functionality.

1. Select the "failed test button" in the Test Explorer toolbar, to show only failed tests. This button also summarizes how many tests are failing in the current view.

   :::image type="content" source="../media/test-explorer-filter.png" alt-text="Screenshot in Visual Studio of Test Explorer with the top failed test filter button highlighted, but not depressed. The failed test filter button also has the number 2 on it to indicate there are 2 failed tests in the current view.":::

   The test view will filter down to only the failing tests.

   :::image type="content" source="../media/test-explorer-filter-fail.png" alt-text="Screenshot in Visual Studio of Test Explorer with the top failed test filter button selected. Only two failing tests show in the test list view since the other four passing tests are now filtered.":::

1. Select the "test flask button" to go back to viewing tests with all outcomes. This button also lists the total number of tests and how many tests are visible in the current view as a fraction. There are only two tests visible out of a total of six tests with the current filtering.

   :::image type="content" source="../media/test-explorer-total-summary.png" alt-text="Screenshot in Visual Studio of Test Explorer with the top total test filter button highlighted. This button shows the total number of tests and how many are appearing in the display with a fraction that says 2/6.":::

## Use the Group By options

By using groupings it makes it easier to work with large amount of tests. Let's explore some of the Group By settings.

1. Try a new grouping by de-selecting the presets and only grouping by State (passed, failed, not run, and so on) and then Class.

   :::image type="content" source="../media/test-explorer-groupby-state.png" alt-text="Screenshot in Visual Studio of Test Explorer with the top Group By button highlighted. The Group By menu is open and State is selected as the first hierarchy level of the test list and then Class.":::

   Once you click outside the menu, the new Group By selection is applied to the test view.

   :::image type="content" source="../media/test-explorer-groupby-state-class.png" alt-text="Screenshot in Visual Studio of Test Explorer where the test list now organizes tests into a hierarchy of the State grouping and then the class grouping. The first group is of failed tests and then it's organized by class within that group. The second group is passed tests that are also then organized within that group by class.":::

## Debug a test

Sometimes, it's not obvious why a test fails. You might need to do a closer inspection by setting a breakpoint and _debug_ the test while it's running.

1. Set a breakpoint in `DivideByZeroTest` at the `Assert` line by clicking in the margin of the code editor.
1. Right-click in the test method in the code editor and select **Debug Test**.

   :::image type="content" source="../media/debug-divide-zero.png" alt-text="Screenshot in Visual Studio of editor window inside DivideByZero test method. A breakpoint is set on the Assert statement. The right-click menu is open and debug test is selected.":::

   You'll notice the debugger doesn't reach your breakpoint because it fails on the `System.DivideByZeroException` as expected.

   :::image type="content" source="../media/debug-exception.png" alt-text="Screenshot in Visual Studio throwing a divide by zero system exception in the midst of debugging. The exception appears in a call out above the Divide method on the return statement.":::

## Red, green, refactor

Red, green, refactor is all about starting with a failing test, to see the test can fail but also that the product code might not be written yet. Let's adapt this mindset in the upcoming steps.
`DivideByZeroTest` will fail until you update the `Divide` method in the `Calculator.cs` to gracefully handle when the divisor is zero, thereby this test is on "Red", it's waiting for you to write missing product code.

1. Write some code to catch the exception if the divisor is zero, and notify the user with a console message such as, "Cannot divide by zero." After catching the exception, the `Divide` method can then return null. Edit the `Divide` method signature to allow a nullable int return type.

    Your `Divide` method should now look similar to the code below.

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

1. Rerun your `DivideByZero` test to confirm it now passes! The `Divide` method now returns null when the divisor is zero. Note the output that warns the user they cannot divide by zero appears in the test detail summary in the Test Explorer.

   :::image type="content" source="../media/test-explorer-output.png" alt-text="Screenshot in Visual Studio of Test Explorer showing passing Divide By Zero Test. The lower pane of the Test Explorer window shows the test details including the Console.Writeline output.":::

   Thereby your test went from "Red" to "Green" as you added  product code to get the test to pass.
   Now that you have working product code, and a test, it's time to refactor your product code to create an even better and more robust solution, if possible.

  > [!TIP]
  > Consider scenarios that might need to be updated because of your recent changes. Feel free to add comments to describe new functionality.

Congratulations!  You've managed to add more tests and learned to use a Red, Green, Refactor pattern. You started with the red failing `DivideByZeroTest` and modified the product code until it got to green. The last step before moving on was refactoring.

## Expected examples for Subtract, Multiply, and Divide tests

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

## Expected divide by zero test

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
