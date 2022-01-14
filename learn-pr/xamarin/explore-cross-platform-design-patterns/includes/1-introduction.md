[!include[](../../includes/dotnet-maui-note.md)]

When building cross-platform mobile applications, you have to use platform-specific APIs. For example, to use the device's camera to take a picture, you need to use the specific APIs for that platform. This means if you wanted to build an iOS and Android camera application, you would need to write the code that uses the camera multiple times for each platform.

This task would be tedious, but you could find ways to make it easier. For example, you could define the platform-specific code by using a contract, which you would then use in your shared code. This technique would allow you to use a single code base to invoke your platform-specific code.

By the end of this module, you'll learn how to share common code and invoke platform-specific code from a single project.

[!include[](../../../includes/install-vs-mobile-workload.md)]

## Learning objectives

In this module, you will:

- Structure your shared code by using .NET Standard
- Locate dependencies by using the factory pattern
- Use a service locator to register and retrieve dependencies
- Use an inversion of control (IoC) container to automatically inject dependencies

## Prerequisites

[!include[](../../../includes/prerequisites.md)]
