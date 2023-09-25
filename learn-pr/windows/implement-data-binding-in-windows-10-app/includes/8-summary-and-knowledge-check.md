In this module, you've seen how Universal Windows Platform (UWP) and Windows Presentation Foundation (WPF) supports data binding. You now know more about the process of connecting the app's UI and business logic in an automated, robust, and high-performance manner. 

You've learned how to update the UI when a property of an object changes in code, and how to update the property when the UI changes. You've displayed a list of elements (such as colors) in a `ListBox` or a `ComboBox`: just two of the many controls you can use to show a collection of items on the screen. If you followed each tutorial, by now you also have hands-on experience with how to control the display of individual items in these controls. You also have experience with how to notify your business logic that the user has selected an item. Finally, you now know how to automatically reflect changes to your collection (such as adding or removing items) on the UI.

This separation of UI and logic is crucial when developing even moderately complex apps. It allows your business logic (code) to *think* in terms of business objects. For example, we didn't have to consider the `TextBox` control in our logic when we requested the user's name. We only had to deal with the `String` object of the text they entered. Our list of favorite colors was storing actual `ColorDescriptor` objects instead of UI-related objects, such as `ListItem`. But, thanks to data binding, the UI could still display those items in any way the designer chooses: in a `ListBox`, a `ComboBox`, a grid-like layout with cards, or even a carousel. Your business logic won't have to be changed for any of those choices.

Proper separation of logic and UI also enables you to write separate automated unit tests for your business logic. These tests can run without launching the app (for example, with <a href="/visualstudio/test/unit-test-basics" target="_blank">Visual Studio Unit Testing</a>). The tests rely on the tried and tested data binding mechanism to transfer data between the UI and your business logic code.

#### Simplify class coding

Finally, in this module you've seen how you can take advantage of a base class to simplify the coding of data binding-friendly classes. This was the first step in applying the industry best practice of the **Model-View-ViewModel** (MVVM) architecture.

The model, in our small sample, is well exemplified by the `ColorDescriptor` class. The data stored about a real-world object or concept is, in this case, color.

The view is our XAML code, **MainPage.xaml** (UWP) / **MainWindow.xaml** (WPF) and **ColorList.xaml**, along with their code-behind files, **MainPage.xaml.cs** (UWP) / **MainWindow.xaml.cs** (WPF) and **ColorList.xaml.cs**.

The viewmodel is the actual business logic driving the UI, making decisions (for example, whether a button should be enabled). In our UWP sample, the `MainPageLogic` and `ColorListLogic` classes are essentially viewmodel classes. In the WPF sample, the `MainWindowDataContext`, the `Clock`, and the `ColorListDataContext` classes are the viewmodels.

MVVM is the most widely used architecture pattern for UI frameworks that support data binding. There are many MVVM toolkits and frameworks available that can jumpstart your development in UWP and WPF, or even Windows App SDK and .NET MAUI. Some of the most popular are:

- <a href="/windows/communitytoolkit/mvvm/introduction" target="_blank">MVVM Toolkit</a>
- <a href="http://prismlibrary.github.io/" target="_blank">Prism</a>
- <a href="https://www.mvvmcross.com/" target="_blank">MVVM Cross</a>

### Before you go...

Now that you've got yourself set up for Windows development, we encourage you to keep learning. Check out the next module to learn more about connecting your app to the cloud. But first, check your knowledge with the following quiz.
