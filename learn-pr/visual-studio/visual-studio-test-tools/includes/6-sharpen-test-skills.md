Being able to write tests and applying a red, green, refactoring pattern is a good start. One challenge you will face is test readability, it might be hard to understand why certain asserts exist when you look at a colleague's code or a piece of code you wrote 6 months ago. Another difficult thing about testing, is that you want to test in isolation, you don't want a unit test to make a network call or write files to a disk or a database, most likely.

In this unit we will cover the following topics to try to address these problems:

* **Fluent assertions**: Enables using assert statements that are more human-readable.
* **Data driven tests**: Run the same test repeatedly with different parameters.
* **Mocking**: Isolate your test by mocking parts of your code that don't affect the test outcome.

You can learn about different types of tests and more testing concepts with [Introduction to software testing concepts](/learn/modules/visual-studio-test-concepts/). There are many tools to help make tests easy to understand, avoid repetition, and get coverage for any architecture. Let's go over some popular ones and their advantages.

## Fluent Assertions

[Fluent assertions](https://fluentassertions.com/) is a popular set of extension methods provided by the .NET community that can help you clearly identify your assertion methods. It uses more human-readable language making it easier to write and read tests.

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

    // Same asserts as what is commented out above, but using Fluent assertion
    actual.Should().Be(2).And.NotBe(1);
}
```

:::image type="content" source="../media/test-fluent-assertion.png" alt-text="Screenshot in Visual Studio of AddTest method. A hover tip on the fluent assertion describes the And constraint of fluent assertions with a generic type of int. The description reads the integral number value is exactly the same as the expected value.":::

## Data driven tests

[Data driven tests](/visualstudio/test/how-to-create-a-data-driven-unit-test) allows you to run the same test method many times with various parameters. This test may also be referred to as parameterized testing or DDT. This ability allows you to avoid repetition in your code while also checking the same function with a whole set of different data inputs. You can input data in-line as shown in the example below or even connect to a database to get input.

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

:::image type="content" source="../media/data-driven-test.png" alt-text="Screenshot in Visual Studio showing the Test Explorer and the CalculatorTests.cs side by side. The Data Test Method in the editor is failing. The Test Explorer shows 4 results for each data row of the test and shows the final data row's failure message.":::

## Mocking

* Sometimes the architecture of your code isn't modular enough to unit test it well. In order to isolate the parts of your code that you're testing without rewriting it you may want to use a mocking framework. Mocking helps you isolate the code you're trying to test by creating stubs or shims of that code's dependencies. Stubs and shims allow the code you're testing to make the required calls to its dependencies without actually testing the dependencies. This ability helps you focus a unit test down to precisely the behavior you want to test. There are many popular mocking frameworks available including [MOQ](https://github.com/Moq/moq4/wiki/Quickstart) and [Microsoft Fakes](/visualstudio/test/isolating-code-under-test-with-microsoft-fakes).
* You can find a [full tutorial for Microsoft Fakes here](/visualstudio/test/using-stubs-to-isolate-parts-of-your-application-from-each-other-for-unit-testing), but let's explore a short overview.
  * Microsoft Fakes is only available with Visual Studio Enterprise.
  * Navigate to the test project you want to isolate in the Solution Explorer. Right-click on the project under the Project node that you want to mock and select 'Add Fakes Assembly'.

   :::image type="content" source="../media/test-add-fakes.png" alt-text="Screenshot in Visual Studio of Solution Explorer showing the projects node under the LearnMyCalculator.Tests project expanded. The right-click menu s open on the LearnMyCalculatorApp node underneath projects. The command Add Fakes Assembly is selected.":::

  * Add the using statements to the test file in which you'd like to use shims and stubs.

    ```csharp
    using LearnMyCalculatorApp.Fakes;
    using Microsoft.QualityTools.Testing.Fakes;
    ```

  * Now you can create stubs or shims for different parts of your code like the example below. In the below test I don't want to really call the Calculator's `Divide` method, I just want to pretend for now that it always returns `1` so I can focus on testing other parts of my code. The shim allows me to do that.

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
            Assert.AreEqual(1, actual); // This assert will pass since the Divide method above is a shim that will return 1
        }
    }
    
    ```

Writing good tests can take a while to learn, just like writing good code. If you would like to learn more about different testing schools of thought, see the [Introduction to software testing concepts](/learn/modules/visual-studio-test-concepts/).
