The Model-View-ViewModel (MVVM) pattern is a *software design pattern*. Design patterns are sets of rules and templates that help make application code better or more consistent. You use the MVVM pattern to help separate the app's behavior logic from the user interface-rendering code, and to do so in a way that supports unit testing.

## Example scenario

Say your company produces management software for human resources departments. They use the software to manage and review details about the employees of the company. The existing system is web-based. You were asked to create a mobile app that can be used with the same back-end APIs that the web system uses. You know that the back-end APIs and the web front end are thoroughly covered by unit tests. And you want to maintain that standard for the mobile app. You heard that the MVVM pattern can help design mobile apps for maximum testability, so you plan to try it out.

MVVM itself is a design pattern that's the basis for many frameworks and programming tool-kits. Most of those frameworks also provide other things, like navigation and messaging abstractions, that help MVVM promote unit testing. In this discussion, you concentrate on the basics of the pattern because frameworks can widely vary in their implementations.

In this module, you learn the parts of the MVVM pattern and the responsibilities of the model, view, and viewmodel. Then, you write code in a viewmodel that handles application behavior in a way which is isolated from the UI libraries (even from .NET MAUI itself).

## What do you learn

In this module, you will:

- Identify when to use the Model-View-ViewModel pattern.
- Use a viewmodel to drive visual behavior.
- Improve code testability through data-bindable properties.

## Prerequisites

- Visual Studio 2022 with the .NET MAUI workload installed
- Optional: Visual Studio Code with the .NET MAUI Extension and .NET SDK with the .NET MAUI workload installed
- Familiarity with intermediate programming concepts like interfaces, classes, and attributes.
- Ability to write XAML code.
- Completed the previous module in this training path or understand how data binding works in .NET MAUI.

[!include[](../../../includes/install-dotnet-maui-workload.md)]
