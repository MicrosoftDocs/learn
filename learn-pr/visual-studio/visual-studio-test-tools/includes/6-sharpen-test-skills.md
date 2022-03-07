Being able to write tests and applying a red, green, refactor pattern are a good start. One challenge you'll face is test readability. It might be hard to understand why certain assertions exist when you look at a colleague's code or a piece of code that you wrote six months ago. 

Another difficult thing about testing is that you want to test in isolation. You probably don't want a unit test to make a network call or write files to a disk or a database.

In this unit, we'll cover the following topics to address these challenges:

* **Fluent Assertions**: Use assert statements that are more human-readable.
* **Data-driven tests**: Run the same test repeatedly with different parameters.
* **Mocking**: Isolate your test by mocking parts of your code that don't affect the test outcome.

There are many tools to help make tests easy to understand, avoid repetition, and get coverage for any architecture. Let's go over some popular ones and their advantages.

## Fluent Assertions

[Fluent Assertions](https://fluentassertions.com/) is a popular set of extension methods provided by the .NET community that can help you clearly identify your assertion methods. It uses human-readable language to make it easier to write and read tests.

```csharp
using FluentAssertions;
...
[TestMethod]
public void AddTestFluentassertion()
{
    var calculator = new Calculator();
    var actual = calculator.Add(1, 1);

    // Non-fluent asserts:
    // Assert.AreEqual(actual, 2);
    // Assert.AreNotEqual(actual, 1);

    // Same asserts as what is commented out above, but using Fluent Assertions
    actual.Should().Be(2).And.NotBe(1);
}
```

The following example shows the `AddTest` method in Visual Studio. A hover tip on the assertion describes the `And` constraint of Fluent Assertions with a generic type of `int`. The description says that the integral number value is exactly the same as the expected value.

:::image type="content" source="../media/fluent-assertion.png" alt-text="Screenshot of the AddTest method with a hover tip on the assertion.":::

## Data-driven tests

You can use [data-driven tests](/visualstudio/test/how-to-create-a-data-driven-unit-test) to run the same test method many times with various parameters. This technique is also called parameterized testing. It enables you to avoid repetition in your code while also checking the same function with a whole set of different data inputs. 

You can enter data inline as shown in the following example, or even connect to a database to get input.

```csharp
[DataTestMethod]
[DataRow(1, 1, 2)]
[DataRow(2, 2, 4)]
[DataRow(3, 3, 6)]
[DataRow(0, 0, 1)] // The test run with this row fails
public void AddDataTests(int x, int y, int expected)
{
    var calculator = new Calculator();
    var actual = calculator.Add(x, y);
    Assert.AreEqual(expected, actual);
}
```

In the following example, Test Explorer and *CalculatorTests.cs* are side by side. The `DataTest` method in the editor is failing. Test Explorer shows four results for each data row of the test, and it shows the final data row's failure message.

:::image type="content" source="../media/data-driven-test.png" alt-text="Screenshot of Test Explorer and CalculatorTests.cs, with a failing method in the editor.":::

## Mocking

Sometimes the architecture of your code isn't modular enough for effective unit testing. To isolate the parts of your code that you're testing without rewriting it, you might want to use a mocking framework. 

Mocking helps you isolate the code that you're trying to test by creating stubs or shims of that code's dependencies. Stubs and shims allow the code to make the required calls to dependencies without actually testing the dependencies. This ability helps you focus a unit test down to precisely the behavior that you want to test. 

Many popular mocking frameworks are available, including [MOQ](https://github.com/Moq/moq4/wiki/Quickstart) and [Microsoft Fakes](/visualstudio/test/isolating-code-under-test-with-microsoft-fakes). You can get a [full tutorial for Microsoft Fakes](/visualstudio/test/using-stubs-to-isolate-parts-of-your-application-from-each-other-for-unit-testing), but let's explore a short overview. 

> [!NOTE]
> Microsoft Fakes is available only with Visual Studio Enterprise.

1. In Solution Explorer, go to the test project that you want to isolate. 

1. Right-click the project under the project node that you want to mock, and then select **Add Fakes Assembly**.

   The following example uses the **LearnMyCalculatorApp** node under the **LearnMyCalculatorApp.Tests** project.

   :::image type="content" source="../media/add-fakes.png" alt-text="Screenshot of Solution Explorer that shows a node selected for adding a Fakes assembly.":::

1. Add the `using` statements to the test file in which you want to use stubs and shims.

   ```csharp
   using LearnMyCalculatorApp.Fakes;
   using Microsoft.QualityTools.Testing.Fakes;
   ```

1. Now you can create stubs or shims for different parts of your code. In the following example, you don't want to call the calculator's `Divide` method. You just want to pretend for now that it always returns `1` so that you can focus on testing other parts of your code. The shim allows you to do that.

   ```csharp
   [TestMethod]
   public void DivideByZeroWithFakesShim()
   {
       using (ShimsContext.Create())
       {
           // Define what the Divide shim should return
           ShimCalculator.AllInstances.DivideInt32Int32 = (x, y, z) => { return 1; };

           var calculator = new Calculator();
            
           // This really calls the DivideInt32Int32
           // defined above to always return 1
           // instead of actually calling Divide
           var actual = calculator.Divide(1, 0); 
           Assert.AreEqual(1, actual); // This assertion will pass because the preceding Divide method is a shim that will return 1
       }
   }
    
   ```

Writing good tests can take a while to learn, just like writing good code. If you want to learn more about testing schools of thought, see  [Introduction to software testing concepts](/learn/modules/visual-studio-test-concepts/).
