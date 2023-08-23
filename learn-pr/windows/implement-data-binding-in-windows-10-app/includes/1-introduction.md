![Tech logo.](../media/tech-all.png)

Suppose you work for a custom clothing designer company, and you want to create an app that helps your customers select their favorite materials or colors. The user's name, the list of colors they can choose from, and their selected favorite colors are all data. This is data that the user enters, selects, and reviews through a variety of controls displayed on the UI: text boxes, drop downs, lists, buttons, and so on. All of this is controlled by the logic of the app.

Most apps have three main components:

- **User interface (UI):** The labels, buttons, text boxes, sliders, charts, and all other controls that present information to the user. This also includes the controls that let the user interact with the app by entering data, selecting options, or giving commands.
- **Data:** The information the application is working on. For a basic calculator app, it can be the currently displayed number, the result of the previous operation, or the value stored in the memory. For a game, the data can include the status and position of the player and the enemies, the layout and behavior of the environment, or the properties of weapons and other objects. For an enterprise app, the data can be the employee database, the order history, and so on. For the clothing company's app in our example, the data is stored in the actual objects that represent the current time, or the colors that the UI displays.
- **Logic:** The construct that communicates with external resources (such as storage, databases, online services, or other apps), performs operations on the data, and updates the UI to reflect changes in the data. The logic also receives user input from the UI, and acts according to the information entered or commands given. In our example, logic updates the clock, builds the list of available colors, and stores and retrieves the user's color preferences.

The connection between the app's logic and the UI is essential. Frameworks like Windows App SDK, Universal Windows Platform (UWP), and Windows Presentation Foundation (WPF) have incorporated an extremely efficient and versatile method of transferring data to and from the UI called *data binding*.

In this module, you will learn how to use data binding to:

- Display and automatically update simple text data (displaying the clock in the app).
- Automatically update C# properties when the UI receives input (entering the user's name).
- Automatically reflect data changes on the UI (greeting the user, displaying the clock).
- Show and edit a list of more complex data structures (listing the available and favorite colors).

We will also cover some best practices for a good separation of UI and logic. Separating UI and logic helps you to test each component separately, and identify errors more easily. It also greatly reduces the amount of boilerplate code you have to write. Less boilerplate code means fewer mistakes, fewer bugs, and more time to focus on the important things you want to accomplish with your app.

## Prerequisites

To get the most out of this module, you should be familiar with:

- Creating new UWP or WPF projects in Visual Studio.
- The C# language.
- Basic concepts of XAML markup.
- Basic XAML layout controls, including `StackPanel` and `Grid`.
