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

Learn to test your C# apps with the testing tools in Visual Studio.

## Learning objectives

1. Upon completion of this module, the student will be able to create a test project, add references to product code, and write tests.
2. Upon completion of this module, the student will be able to view, run, and debug tests in Test Explorer.

## Chunk your content into subtasks

Identify the subtasks of C# Testing Tutorial

| Subtask | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- |
| Create a test project | Knowledge check | 1 | Yes |
| Add a reference from the test project to product code  |Knowledge check | 1 | No, combine with create test. |
| Write a test | Knowledge check | 1 | Yes |
| View tests in the Test Explorer | Exercise | 2 | Yes |
| Run tests from the Test Explorer | Exercise | 2 | No, combine with view tests. |
| Debug tests from the Test Explorer | Exercise | 2 | No, combine with view tests. |

## Outline the units

1. **Introduction**

Suppose you are creating a calculator app for school and you've been able to successfully debug, enter numbers as input, and get the expected results. You have a list of calculations you check each time you make code changes, to make sure that you haven't altered existing behavior as you add methods. As you make changes to your logic, you notice it takes longer and longer to manually make sure all your test inputs still get the correct results as you add more cases. With testing, you can automatically run your app with many different inputs and assert the expected results. This eliminates the need to manually enter your test data into your app as you debug because testing can put your app through its paces with the click of a button. This automated ability to check functionality is the purpose of testing.

1. Create a test project

    - Create a test project
        - The easiest way to add a test project for testing a specific method in your code is to right-click in that method and select 'Create unit tests.' This option to auto-generate test methods is available for most .NET projects, but let's describe how to manually set up test projects as well.
        - You can add test project templates to your solution by right-clicking on the solution in the Solution Explorer and selecting 'Add project.' Select a MSTest project template from the list. There are multiple popular test frameworks in .NET. MSTest is the built-in option for .NET produced by the .NET team.
        - There are many naming conventions that different code bases may use to indicate how the test suite is organized. Commonly, you may find names similar to \<MyAppProjectName\>.Tests for test projects.
    - Add a reference to the product code from the test project
        - Now that you have a test project, it needs to reference the code you would like to test so you can make calls to your app from within your tests. Right-click on the test project in the Solution Explorer and select 'Add Reference.' Select the project you would like to test.
        - Make sure to add an import statement to the top of your C# test files so that references to any types in your product code's namespaces are resolved.
    - Write a test
        - The templates come with a pre-written test. Note the 'Assert' line. Assert statements are what decide if your test passes or fails. You can add multiple asserts to any given test. If one assert fails, then the test will fail.
        - Add an assert statement to check if a type in your product code is null.
        - Add an assert statement that causes your test to fail. An example of a failing assert would be asserting IsTrue on a false boolean.
        - Writing good tests can take a while to learn, just like writing good code. If you would like to learn more about writing good tests, see the [conceptual guidance](TBD).

        ```csharp
        Assert.IsTrue(false); // Will fail the test
        ```

    1. **Knowledge check**

    - You don't need to import the namespace of your product code if your test project already references the target project. True/**False**
    - If one assert statement fails the test will fail. **True**/False

1. View, run, and debug tests with the Test Explorer

    - View your tests in the Test Explorer.
        - You can view your list of tests in the Test Explorer in Visual Studio. To open this window use the top-level "Test" menu and select "Test Explorer."
        - The name of each of your tests appear in an easily navigable list. Note you can use the search box to search for a specific test or substring.
        - The view of tests is highly customizable to better handle navigating huge code bases with hundreds of thousands of tests. You can use buttons to filter the view to by state. Try filtering to show only failed tests.
        - The "Group by" button lets you customize how the test groupings appear in the hierarchy. Try a new grouping by de-selecting the presets and only grouping by Project and Namespace. You can control what levels appear in the hierarchy and how many.
    - Run your tests
        - Click the green run button in the Test Explorer to Run All Tests.
        - Note that small icons now show the test result in the code editor at every test method. This helpful feature is one part of CodeLens. You can use these icons to run, debug, and view test output without leaving the code editor.
    - Debug a test
        - Set a breakpoint in one of the tests you have created by clicking in the margin of the code editor.
        - Right-click inside of the test in the code editor and select 'Debug Test.' Debugging tests let you pause the application to explore variables and what is happening during the execution of your test. Debugging tests is especially helpful because you can precisely isolate which function you'd like the debugger to step through programmatically rather than manually using your app until you trigger the method you would like to test.

    1. **Knowledge check**

    - I can only run tests from the Test Explorer. True/**False** You can run tests with the right-click menu, keyboard shortcuts, or the CodeLens icons. Whatever feels natural to you and helps you get into your most productive coding flow.
    - The Test Explorer group by allows me to view tests groupings according to: (Check all that apply)
        - Project
        - Namespace
        - Class
        - Trait
        - State
        - **(All of the above)**

1. Sharpen your testing tool set
    - Fluent Assertions
    - Data driven tests
    - Mocking

1. **Summary**

    Recall the calculator app example from the beginning. As the functionality of the app expanded, more and more inputs needed to be checked. Manually doing this by running the app and trying it out can take a long time. With tests, you can create test methods to put your app through its paces programmatically. You can save all those inputs in your test methods that make sure the behavior of your code stays stable even as you make changes. The Test Explorer enables you to view your tests, run them automatically with the click of a button, and debug specific parts of your code through your tests.

## Notes

There is a wide range of materials and tools out there to help make you a better tester. Check out the [testing conceptual guidance](TBD) to learn more about best practices.

Ready to find out how tests can improve your entire pipeline? Check out the [automated testing module](https://docs.microsoft.com/en-us/learn/modules/run-quality-tests-build-pipeline/2-what-is-automated-testing)

For a more in-depth look at the Test Explorer and other Visual Studio testing tools check out the [Visual Studio Testing docs](https://docs.microsoft.com/visualstudio/test).
