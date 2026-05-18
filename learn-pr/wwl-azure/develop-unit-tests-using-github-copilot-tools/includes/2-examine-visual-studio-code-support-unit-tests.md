Before you can generate unit tests with GitHub Copilot, your project needs a working test framework and a way to run tests inside Visual Studio Code. Visual Studio Code, the .NET SDK, and the C# Dev Kit extension provide the environment that hosts your unit tests, while GitHub Copilot focuses on generating and refining the test code. Understanding the underlying environment makes the GitHub Copilot workflow much easier to follow.

This unit examines the Visual Studio Code features and C# tooling that support unit testing. Later units focus on how GitHub Copilot generates and maintains the test code that runs in this environment.

## Visual Studio Code support for unit tests

To create and run C# unit tests in Visual Studio Code, you need the following resources:

- The .NET 8.0 SDK or later.
- The C# Dev Kit extension for Visual Studio Code.
- A test framework package added to your project.

### C# Dev Kit support for unit tests

The C# Dev Kit extension provides the testing features you use throughout this module:

- **Test Explorer**: A tree view that shows all test cases in your workspace. You can open Test Explorer by selecting the beaker icon on the Activity bar.
- **Run/Debug test cases**: Green play buttons appear in the editor next to each test class and method. Right-click a play button to see more options.
- **View test results**: After a test runs, the result is reflected in editor decorations and in Test Explorer. Selecting a link in a stack trace navigates to the source location.
- **Testing commands**: Commands like `Test: Run All Tests` are available in the Command Palette. Search for `Test:` to see the full list.
- **Testing settings**: Settings that control test discovery and runtime behavior are available in the Settings editor. Search for `Testing` to see the available options.

The C# Dev Kit supports the following test frameworks:

- xUnit
- NUnit
- MSTest

### Create a test project using the Command Palette

The Command Palette in Visual Studio Code provides the easiest way to create a test project that uses a supported framework. You can open the Command Palette in the following ways:

- Press the **Ctrl** + **Shift** + **P** keys (Windows/Linux) or **Cmd** + **Shift** + **P** (macOS).
- Open the **View** menu, and then select **Command Palette**.
- Open the Solution Explorer view, right-click the solution folder, and then select **New Project**. This option opens the Command Palette with the **.NET: New Project...** command already selected.

The following sections show how to create a test project for each supported framework.

#### xUnit

Open the Command Palette and select **.NET: New Project...**, select **xUnit Test Project**, and then provide a name and location for the new project. This command creates a project that uses xUnit as the test library and configures the test runner by adding the following `<PackageReference />` elements to the project file:

- `Microsoft.NET.Test.Sdk`
- `xUnit`
- `xunit.runner.visualstudio`
- `coverlet.collector`

From the integrated Terminal, you can add a reference from the test project to the project under test:

```dotnetcli
dotnet add [location of your test csproj file] reference [location of the csproj file for project to be tested]
```

#### NUnit

Open the Command Palette and select **.NET: New Project...**, select **NUnit3 Test Project**, and then provide a name and location for the new project. This command creates a project that uses NUnit as the test library and adds the following `<PackageReference />` elements to the project file:

- `Microsoft.NET.Test.Sdk`
- `NUnit`
- `NUnit3TestAdapter`

Add a reference to the project under test from the Terminal:

```dotnetcli
dotnet add [location of your test csproj file] reference [location of the csproj file for project to be tested]
```

#### MSTest

Open the Command Palette and select **.NET: New Project...**, select **MSTest Test Project**, and then provide a name and location for the new project. This command adds the following `<PackageReference />` elements to the project file:

- `Microsoft.NET.Test.Sdk`
- `MSTest.TestAdapter`
- `MSTest.TestFramework`
- `coverlet.collector`

Add a reference to the project under test from the Terminal:

```dotnetcli
dotnet add [location of your test csproj file] reference [location of the csproj file for project to be tested]
```

## Run and manage unit tests in Visual Studio Code

After a test project exists, Visual Studio Code and the C# Dev Kit give you several ways to run and manage tests:

- **Run/Debug from the editor**: Select the green play button next to a class or method to run that target. Right-click the play button to see options like **Run Test** and **Debug Test**.
- **Test Explorer**: Run or debug individual tests, groups, or the full suite from the tree view. Test results, including pass/fail icons and durations, appear next to each item.
- **View test results**: Editor decorations and Test Explorer both reflect the current state of each test after a run. Select links in stack traces to jump to the failing line.
- **Testing commands**: Use commands like `Test: Run All Tests`, `Test: Debug Failed Tests`, and `Test: Show Output` from the Command Palette.
- **Testing settings**: Search for `Testing` in the Settings editor to configure behavior such as auto-run on save or test result formatting.

## The unit testing workflow with GitHub Copilot

When you combine Visual Studio Code with GitHub Copilot, the unit testing process breaks down into three stages:

1. **Set up the environment**: Use Visual Studio Code, the .NET SDK, and the C# Dev Kit to create a test project and reference the project under test. You completed this stage in this unit.
1. **Generate test code**: Use GitHub Copilot in the Chat view to generate unit tests for your application code. The next units cover this stage.
1. **Run and maintain tests**: Use Test Explorer and the C# Dev Kit to run tests, then use GitHub Copilot to extend coverage and fix failing tests.

The remaining units focus on the GitHub Copilot tools that support stages 2 and 3.
