Let's put that test creation knowledge to use. Imagine you are developing the calculator app mentioned at the beginning of this module. As part of development you now need to set up your test project and write your first test.

In this exercise, we'll write tests with a few basic steps:

* Set up product code to be tested
* Create a test project
* Add a reference to the product code from the test project
* Add assert statements

## Set up product code to be tested

Your product code is a calculator app, as such, it supports addition, subtraction, multiplication and division. You will create the program as a console app.

1. Start a .NET console project called `LearnMyCalculatorApp`.
1. Add a new `Calculator.cs` with the code below.

    ```csharp
    namespace LearnMyCalculatorApp
    {
        public class Calculator
        {
            public int Add(int x, int y)
            {
                return x + y;
            }
    
            public int Subtract(int x, int y)
            {
                return x - y;
            }
    
            public int Multiply(int x, int y)
            {
                return x * y;
            }
    
            public int Divide(int x, int y)
            {
                return x / y;
            }
        }
    }
    ```

1. You can leave the `Program.cs` unchanged for this minimal example.

## Create a test project

As mentioned in the previous unit, the easiest way to add a test project for testing a specific method in your code is to right-click in that method and select **Create unit tests**. However, for this exercise let's manually set up test projects to better understand the relationship between tests and the code that is being tested.

1. Right-click on the solution and select **Add project**, to add a test project template open the Solution Explorer.
1. Select a MSTest project template from the new project dialog, there are multiple popular test frameworks in .NET. [MSTest](/visualstudio/test/using-microsoft-visualstudio-testtools-unittesting-members-in-unit-tests) is the built-in option for .NET produced by the .NET team.

   :::image type="content" source="../media/add-new-test-project.png" alt-text="Screenshot in Visual Studio of Add New Project dialog with MSTest Test Project selected.":::

1. Name the test project. There are many naming conventions that different code bases use to indicate how the test suite is organized. Commonly, you may find names similar to `<MyAppProjectName>.Tests` for test projects.

   :::image type="content" source="../media/name-test-project.png" alt-text="Screenshot in Visual Studio of the next page in the Create New Project dialog called Configure your new project. The cursor has the new project name selected which is LearnMyCalculatorApp.Tests":::

1. Make sure your test is targeting the same framework as the app you would like to test.

   :::image type="content" source="../media/match-target-frameworks.png" alt-text="Screenshot in Visual Studio with LearnMyCalculatorApp.csproj and the test csproj open side-by-side. Call out indicates both projects reference the same target framework which is net5.0.":::

## Add a reference to the product code from the test project

Now that you have a test project, it needs to reference the code you want to test. With a reference, you can make calls to your app from within your tests.

1. Right-click on the test project in the Solution Explorer and select **Add Reference**. Select the project you would like to test. In this case, the console project you created that contains the `Calculator.cs`.

   :::image type="content" source="../media/add-project-reference.png" alt-text="Screenshot in Visual Studio of Solution Explorer. The right-click menu of the dependencies node under the test project is open and Add Project Reference is selected.":::

1. Make sure to add an import statement to the top of your C# test files so that references to any types in your product code's namespaces are resolved.

    ```csharp
    using Microsoft.VisualStudio.TestTools.UnitTesting;
    using LearnMyCalculatorApp;
    ```

## Add assert statements

Now let's add an assert statement to instruct the test runner under what conditions the test should succeed. The templates come with a pre-written test. Let's add a test to check that the Calculator type is not null after initialization.

1. Add an assert statement `Assert.IsNotNull()`, at the end of the method, to check if a type in your product code is null.

    ```csharp
    [TestMethod]
    public void CalculatorNullTest()
    {
        var calculator = new Calculator();
        Assert.IsNotNull(calculator);
    }
    ```

1. Run your test with right-click **Run Tests**. Your test should pass since the `calculator` variable isn't null.
1. Add an assert statement to the end of the method `CalculatorNullTest` that causes your test to fail. You can use the example below which asserts IsTrue on a false boolean.

    ```csharp
    Assert.IsTrue(false); // Will fail the test
    ```

1. Confirm your test fails by running again.

   :::image type="content" source="../media/run-first-test.png" alt-text="Screenshot in Visual Studio of editor window right-clicking in a test method with Run Tests selected.":::

Congratulations! You've managed to successfully create and run a test on your product code. You are in a great position to keep adding tests and build a reliable product.
