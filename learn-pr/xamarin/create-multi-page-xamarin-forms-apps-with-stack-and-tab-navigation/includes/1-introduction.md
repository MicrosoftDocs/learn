[!include[](../../includes/dotnet-maui-note.md)]

Part of planning your app's architecture is deciding how the user will move between pages. Will users need to go forward and backward through a sequence of pages? Does your app have one start page, or are there several top-level pages that are equally important? Your choice of navigation should work well with your app's content. It should also feel native to each platform you target.

Suppose you're writing an app for a planetarium by using Xamarin.Forms. You want to generate interest in astronomy by presenting astronomical facts and concepts that are relevant to everyday life. The app will have pages covering sunrise and sunset, lunar phases, astronomical bodies, and an *About* page. Your job is to design and implement an intuitive navigation pattern for these pages.

Here, you'll code two common navigation patterns: stack and tabs. We'll discuss some guidelines to help you decide which pattern is appropriate for your app. You'll also see how Xamarin.Forms automatically adapts your UI to the runtime platform, and how to customize the behavior when needed.

[!include[](../../../includes/install-vs-mobile-workload.md)]

## Learning objectives

In this module, you will:

- Choose between stack and tab navigation for your app
- Implement stack and tab navigation
- Display transitory content by using modal pages

## Prerequisites

[!include[](../../../includes/prerequisites.md)]
