Data binding lets you declare relationships between your data and your user interface (UI) controls. They automatically stay in sync when either element changes. Data bindings can make your code faster to read, easier to maintain, and more testable.

Data binding offers a way of coupling your UI directly to data instead of associating your UI with code in the UI's code-behind. When the UI is bound to data, the UI automatically updates when the data changes, staying in sync with the data. Oppositely If the user interacts with the UI, the data is kept in sync with the UI.

## Example scenario

Imagine you're working on an app that presents users with weather information for a selected region or address. As the user inputs a location, the app loads the weather forecast data from an external weather service and updates the UI. The UI and the weather service data are tightly coupled via the XAML UI and the XAML code-behind file. The weather service is already abstracted to its own class, but your UI relies heavily on the code-behind to present that data to the UI.

Some time after your app is released, the weather service you use announces that they're going to be shutting down. Anticipating this, you start looking for a replacement service. Of the services you've evaluated, you notice that they all input and output data in different ways. Since your UI uses code-behind events for interaction with the service, your UI experience could be impacted by this change.

It would be useful to change how the UI synchronizes the weather updates, from code-behind events to data binding. This way, if a service change happens again, you have minimized the impact to your code.

## What will you do

This module demonstrates the differences between a code-based UI and a data-bound UI and shows you how to use data binding to update the UI instead of code-behind. Using a sample weather app, you'll convert UI updates from code-behind to data binding.

## What do you learn

By the end of this module, you're able to use data binding to present data in the UI, and transform data when the UI types and data types don't match.
