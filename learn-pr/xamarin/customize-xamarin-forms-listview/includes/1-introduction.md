[!include[](../../includes/dotnet-maui-note.md)]

Xamarin.Forms `ListView` controls are used to display a row for every element of a collection. For some apps, a simple row per element might be enough. For other apps, you might want to customize of your `ListView` controls. You might want to use rows with custom user interfaces (UI), groupings of similar elements, or headers and footers.

Imagine that you work a manufacturer of smart home hardware. Your job is to craft an app that users can install on their phones to monitor and control things like thermostats, lights, garage door openers, and smoke detectors. The main screen of your app displays a list of all the user's smart home appliances. Because these device types are diverse, you want their rows in the `ListView` to be optimized for each type. And because users might have many devices, you want your `ListView` to support grouping rows for easier browsing.

In this module, you'll modify an existing app that uses a `ListView` with simple text rows. You'll create a custom cell layout and use a different cell template for each device type. You'll also add grouping and indexing and learn how to add headers and footers to each group.

[!include[](../../../includes/install-vs-mobile-workload.md)]

## Learning objectives

In this module, you will:

- Create custom cell layouts for a `ListView`
- Use multiple cell layouts in a single `ListView`
- Group cells into sections

## Prerequisites

[!include[](../../../includes/prerequisites.md)]
