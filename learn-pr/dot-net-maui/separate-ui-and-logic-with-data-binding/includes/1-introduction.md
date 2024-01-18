
Data binding lets you declare relationships between your data and your user interface (UI) controls. They automatically stay in sync when either element changes. Data bindings can make your code faster to read, easier to maintain, and more testable.

Data binding offers a fantastic way of coupling your UI directly to data instead of associating your UI with code in the UI's code-behind. When the UI is bound to data, the UI automatically updates when the data changes, staying in sync with the data. Data binding can make your code easier to read and maintain, and also makes it more testable.

## Example scenario

Imagine you're working on an app that presents users with weather information for a selected region or address. As the user inputs a location, the app loads the weather forecast data from an external weather service and updates the UI. The UI and the weather service data are tightly coupled via the XAML UI and the XAML code-behind file.

Some time after your app is released, the weather service shuts down and the app can no longer retrieve weather data. You found a replacement service, but it doesn't input and output data in the same way. You'll need to update the UI and the code-behind for this new service.

Because you must update the app to change weather services, you've decided to enhance the app with a new view that shows a five-day forecast. You also learn that you have customers in different regions that prefer either Celsius or Fahrenheit, so you'll need to provide a way for the user to toggle between the two.

## What will you do

This module demonstrates the differences between a code-based UI to a data-bound UI and shows you how to add data binding to a UI. You'll then learn about the ways you can customize data binding, and how you can design smart data objects. With this information, you'll update a sample weather app that contains a single view of the data, adding a second (but different) view of the same data.

## What do you learn

By the end of this module, you'll be able to design data objects and bind them to a UI, with minimal code-behind.
