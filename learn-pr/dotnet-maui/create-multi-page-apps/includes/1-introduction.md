Part of planning your app's architecture is deciding how the user will move between pages. Will users need to go forward and backward through a sequence of pages? Does your app have one start page, or are there several top-level pages that are equally important? Your choice of navigation must work well with your app's content. It should also feel native to each platform you target.

Suppose you're writing an app for a planetarium by using .NET MAUI. You want to generate interest in astronomy by presenting astronomical facts and concepts that are relevant to everyday life. The app will have pages covering sunrise and sunset, lunar phases, astronomical bodies, and an About page. Your job is to design and implement an intuitive navigation pattern for these pages.

In this module, you'll learn how to use tabbed pages to implement an app that presents data on multiple pages. You'll see when this navigation pattern is appropriate, and how you can customize the behavior of tabbed pages. You'll also learn how to combine tabbed pages with navigation pages that use the navigation stack.

> [!NOTE]
> This module requires Visual Studio 2022. You can use either Windows or a Mac.
> If you're running on Windows, make sure you have the Mobile development with .NET workload installed in Visual Studio 2022 for Windows. Refer to the documentation if you need to add it to your installation.
> If you're running on a Mac, the standard Visual Studio for Mac installation includes everything you need to build apps with .NET MAUI.

## Learning objectives

In this module, you'll learn how to:

- Implement tab navigation with the `TabbedPage` layout
- Configure platform-specific settings for tabs
- Use navigation pages within tabbed pages

## Prerequisites

- Visual Studio 2022 with the MAUI workload installed
- Familiarity with C# and .NET
