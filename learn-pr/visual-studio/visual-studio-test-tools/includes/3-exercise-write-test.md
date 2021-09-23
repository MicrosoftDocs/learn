Let's put that test-creation knowledge to use. Imagine that you're developing the calculator app mentioned at the beginning of this module. As part of development, you now need to set up your test project and write your first test.

In this exercise, you'll write a test in a few basic steps.

## Set up product code to be tested

Your product code is a calculator app, so it supports addition, subtraction, multiplication, and division. You'll create the program as a console app.

1. Start a .NET console project called *LearnMyCalculatorApp*.
1. Add a new *Calculator.cs* file by using the following code.

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

You can leave the *Program.cs* file unchanged for this minimal example.

## Create a test project

As mentioned in the previous unit, the easiest way to add a test project for testing a specific method in your code is to right-click that method and select **Create unit tests**. However, for this exercise, let's manually set up test projects to better understand the relationship between tests and the code that's being tested.

1. Right-click the solution and select **Add project**, to add a test project template and open Solution Explorer.
1. Select an MSTest project template from the **Add a new project** dialog. There are multiple popular test frameworks in .NET. [MSTest](/visualstudio/test/using-microsoft-visualstudio-testtools-unittesting-members-in-unit-tests) is the built-in option for .NET produced by the .NET team.

   :::image type="content" source="../media/add-new-test-project.png" alt-text="Screenshot of the Add New Project dialog in Visual Studio, with MSTest Test Project selected.":::

1. Name the test project. Code bases use many naming conventions to indicate how the test suite is organized. Commonly, you might find names similar to `<MyAppProjectName>.Tests` for test projects.

   :::image type="content" source="../media/name-test-project.png" alt-text="Screenshot of the page for configuring a new project, with the new project name selected.":::

1. Make sure your test is targeting the same framework as the app that you want to test.

   :::image type="content" source="../media/match-target-frameworks.png" alt-text="Screenshot in Visual Studio with two projects open side by side. Both projects reference the same target framework.":::

## Add a reference to the product code from the test project

Now that you have a test project, it needs to reference the code that you want to test. With a reference, you can make calls to your app from within your tests.

1. Right-click the test project in Solution Explorer and select **Add Project Reference**. Select the project that you want to test. In this case, select the console project you created that contains *Calculator.cs*.

   :::image type="content" source="../media/add-project-reference.png" alt-text="Screenshot of Solution Explorer in Visual Studio, with the right-click menu of the dependencies node open and Add Project Reference selected.":::

1. Add an import statement to the top of your C# test files so that references to any types in your product code's namespaces are resolved.

    ```csharp
    using Microsoft.VisualStudio.TestTools.UnitTesting;
    using LearnMyCalculatorApp;
    ```

## Add assert statements

Now let's add an assert statement to instruct the test runner under what conditions the test should succeed. The templates come with a prewritten test. Let's add a test to check that the calculator type is not null after initialization.

1. Add an assert statement `Assert.IsNotNull()`, at the end of the method, to check if a type in your product code is null.

    ```csharp
    [TestMethod]
    public void CalculatorNullTest()
    {
        var calculator = new Calculator();
        Assert.IsNotNull(calculator);
    }
    ```

1. Run your test by right-clicking and selecting **Run Test(s)**. Your test should pass because the `calculator` variable isn't null.
1. Add an assert statement to the end of the method `CalculatorNullTest` that causes your test to fail. You can use the following example, which asserts `IsTrue` on a false Boolean.

    ```csharp
    Assert.IsTrue(false); // Will fail the test
    ```

1. Confirm that your test fails by running it again.

   :::image type="content" source="../media/run-first-test.png" alt-text="Screenshot of the editor window in Visual Studio, with Run Tests selected by right-clicking a test method.":::

Congratulations! You've managed to successfully create and run a test on your product code. You're in a great position to keep adding tests and build a reliable product.
