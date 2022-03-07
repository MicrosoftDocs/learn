# Title

C# Testing Tutorial

## Role(s)

- developer
- student

## Level

- beginner

## Product(s)

- dotnet
- dotnet-core
- visual-studio

## Prerequisites

- Ability to write C# at the beginner level with C# concepts including writing methods and creating projects.
- Basic familiarity with debugging an app.
- Visual Studio should be installed.

## Summary

Start testing your C# apps with the testing tools in Visual Studio.

## Learning objectives

1. Upon completion of this module, the student will be able to create a test project, add references to product code, and write tests.
2. Upon completion of this module, the student will be able to view, run, and debug tests in Test Explorer.
3. Sharpen the student's test writing skills with fluent assertions, data driven tests, and mocking.

## Chunk your content into subtasks

Identify the subtasks of C# Testing Tutorial

| Subtask | How will you assess it? **Exercise or Knowledge check** | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- |
| Define a unit test | Knowledge check | 1 | Yes |
| Create a test project and add a reference from the test project to product code  | Knowledge check | 1 | No, combine with create test. |
| The three A's Arrange, Act Assert  | Knowledge check | 1 | No, combine with create test. |
| Run a test  | Knowledge check | 1 | No, combine with create test. |
| Red Green Refactor  | Knowledge check | 1 | No, combine with create test. |
| Different Asserts  | Knowledge check | 1 | No, combine with create test. |
| Write a test | Exercise | 1 | Yes |
| View, run, and debug test suites in the Test Explorer | Knowledge check | 2 | Yes |
| Create and manage a test suite | Exercise | 1 | Yes |
| Sharpen your test writing skills | Knowledge check | 3 | Yes |

## Outline the units

- Introduction
- Concept: Create a test
  - What's a unit test
  - The three As, Arrange, Act, Assert
  - Mini-run test instruction
  - Red green refactor (fail at least once)
  - Different asserts
- Exercise: Write a test
  - Create a test project, start with a failing red test, add reference, minimal test implementation, green test
  - Different asserts
- Concept: View, run, and debug test suites in the Test Explorer
  - What's a test suite
  - Running a suite
  - Running only failing test
  - Other features with the explorer
- Exercise: Create and manage a test suite
  - Create a suite
  - See certain tests fail, only rerun failing tests
- Concept: Sharpen your test skills
  - Sharpen your test skills: fluent assertions, data driven tests, mocking
  - Knowledge check
- Summary
- Check

1. **Introduction**

Suppose you're creating a calculator app for school and you've been able to successfully debug, enter numbers as input, and get the expected results. You have a list of calculations you check each time you make code changes, to make sure you haven't altered existing behavior as you add methods. As you make changes to your logic, you notice it takes longer and longer to manually make sure all your test inputs still get the correct results as you add more cases. With testing, you can automatically run your app with many different inputs and assert the expected results. This automation eliminates the need to manually enter your test data into your app as you debug because testing can put your app through its paces with the click of a button. This automated ability to check functionality is the purpose of testing.

1. Write a Test

    - Create a test project
        - The easiest way to add a test project for testing a specific method in your code is to right-click in that method and select 'Create unit tests.' This option to autogenerate test methods is available for most .NET projects, but let's describe how to manually set up test projects as well.
        - You can add test project templates to your solution by right-clicking on the solution in the Solution Explorer and selecting 'Add project.' Select a MSTest project template from the list. There are multiple popular test frameworks in .NET. MSTest is the built-in option for .NET produced by the .NET team.
        - There are many naming conventions that different code bases may use to indicate how the test suite is organized. Commonly, you may find names similar to \<MyAppProjectName\>.Tests for test projects.
    - Add a reference to the product code from the test project
        - Now that you have a test project, it needs to reference the code you would like to test so you can make calls to your app from within your tests. Right-click on the test project in the Solution Explorer and select 'Add Reference.' Select the project you would like to test.
        - Make sure to add an import statement to the top of your C# test files so that references to any types in your product code's namespaces are resolved.
    - Write a test
        - The templates come with a pre-written test. Note the 'Assert' line. Assert statements are what decide if your test passes or fails. You can add multiple asserts to any given test. If one assert fails, then the test will fail.
        - Add an assert statement to check if a type in your product code is null.
        - Add an assert statement that causes your test to fail. An example of a failing assert would be asserting IsTrue on a false boolean.
        - Writing good tests can take a while to learn, just like writing good code. If you would like to learn more about writing good tests, see the [conceptual guidance](../../visual-studio-test-concepts/resources/design-doc.md).

        ```csharp
        Assert.IsTrue(false); // Will fail the test
        ```

    1. **Knowledge check**

    - You don't need to import the namespace of your product code if your test project already references the target project. True/**False**
    - If one assert statement fails the test will fail. **True**/False

1. View, run, and debug tests with the Test Explorer

    - View your tests in the Test Explorer.
        - You can view your list of tests in the Test Explorer in Visual Studio. To open this window, use the top-level "Test" menu and select "Test Explorer."
        - The names of each of your tests appear in an easily navigable list. Note you can use the search box to search for a specific test or substring.
        - The view of tests is highly customizable to better handle navigating huge code bases with hundreds of thousands of tests. You can use buttons to filter the view to by state. Try filtering to show only failed tests.
        - The "Group by" button lets you customize how the test groupings appear in the hierarchy. Try a new grouping by de-selecting the presets and only grouping by Project and Namespace. You can control what levels appear in the hierarchy and how many.
    - Run your tests
        - Click the green run button in the Test Explorer to Run All Tests.
        - Small icons now show the test result in the code editor at every test method. This helpful feature is one part of CodeLens. You can use these icons to run, debug, and view test output without leaving the code editor.
    - Debug a test
        - Set a breakpoint in one of the tests you have created by clicking in the margin of the code editor.
        - Right-click in the test in the code editor and select 'Debug Test.' Debugging tests let you pause the application to explore variables and what is happening during the execution of your test. Debugging tests is especially helpful because you can precisely isolate which function you'd like the debugger to step through programmatically rather than manually using your app until you trigger the method you would like to test.

    1. **Knowledge check**

    - I can only run tests from the Test Explorer. True/**False** You can run tests with the right-click menu, keyboard shortcuts, or the CodeLens icons. Whatever feels natural to you and helps you get into your most productive coding flow.
    - The Test Explorer Group By allows me to view tests groupings according to:
        - Project
        - Namespace
        - Class
        - Trait
        - State
        - **(All of the above)**

1. Sharpen your test writing skills
    - You can brush up on different types of tests and more testing concepts in the [Testing concept learning module](../../visual-studio-test-concepts/resources/design-doc.md)
    - There are many tools out there to help you write good tests that help make your tests easy to understand, avoid repetition, and help you test any architecture. Let's go over some popular ones and their advantages.
        - Fluent Assertions
            - [Fluent assertions](https://fluentassertions.com/) is a popular set of extension methods provided by the .NET community that can help you clearly identify your assertion methods. It uses more human-readable language making it easier to write and read tests.

            ```csharp
                using FluentAssertions;
    
                // Check if a string begins, ends, or contains a particular phrase
                string actual = "ABCDEFGHI";
                actual.Should().StartWith("AB").And.EndWith("HI").And.Contain("EF").And.HaveLength(9);
            ```

        - Data driven tests
            - [Data driven tests](https://docs.microsoft.com/visualstudio/test/how-to-create-a-data-driven-unit-test) (also known as parameterized testing or DDT) allows you to run the same test method many times with various parameters. This tool allows you to avoid repetition in your code while also checking the same function with a whole set of different data inputs. You can input data in-line as shown in the example below or even connect to a database the get input.

            ```csharp
            [DataTestMethod]
            [DataRow(1, 1, 2)]
            [DataRow(2, 2, 4)]
            [DataRow(3, 3, 6)]
            [DataRow(0, 0, 1)] // The test run with this row fails
            public void AddDataTests(int x, int y, int expected)
            {
                Assert.AreEqual(expected, x + y);
            }
            ```

        - Mocking
            - Sometimes the architecture of your code is not as modular as you may want to unit test it well. In order to isolate the parts of your code that you're testing without re-writing it you may want to use a mocking framework. Mocking helps you isolate the code you're trying to test by creating stubs or shims of that code dependencies. This allows the code you're testing to make the required calls to its dependencies without actually testing the dependencies. This helps you focus a unit test down to precisely the behavior you want to test. There are many popular mocking frameworks available including [MOQ](https://github.com/Moq/moq4/wiki/Quickstart) and [Microsoft Fakes](https://docs.microsoft.com/visualstudio/test/isolating-code-under-test-with-microsoft-fakes).

    1. **Knowledge check**

    - If you've one method that you'd like to test with multiple different inputs, what testing tool could help you?
        - Fluent Assertions
        - **Data driven tests**
        - Mocking
        - No framework is needed, you should copy and paste the test multiple times and only change the parameters.
    - Stubs and shims are found in what testing tool?
        - Fluent Assertions
        - Data driven tests
        - **Mocking**
        - Behavior driven tests

1. **Summary**

    Recall the calculator app example from the beginning. As the functionality of the app expanded, more inputs needed to be checked. Manually testing by running the app and trying it out can take a long time. With tests, you can create test methods to put your app through its paces programmatically. You can save all those inputs in your test methods that make sure the behavior of your code stays stable even as you make changes. The Test Explorer enables you to view your tests, run them automatically with the click of a button, and debug specific parts of your code through your tests.

## Notes

There's a wide range of materials and tools out there to help make you a better tester. Check out the [testing conceptual guidance](../../visual-studio-test-concepts/resources/design-doc.md) to learn more about best practices.

Ready to find out how tests can improve your entire pipeline? Check out the [automated testing module](https://docs.microsoft.com/learn/modules/run-quality-tests-build-pipeline/2-what-is-automated-testing)

For a more in-depth look at the Test Explorer and other Visual Studio testing tools, check out the [Visual Studio Testing docs](https://docs.microsoft.com/visualstudio/test).
