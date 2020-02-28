In this module, we explored and used the Model-View-ViewModel pattern.

We mentioned that testability is a primary motivation for using the MVVM pattern. It helps testability by decoupling your user interface from the inputs and outputs that drive it. Those inputs and outputs, exposed as bindings, are more easily exercised through unit-testing frameworks.

There are a few places where the MVVM pattern alone doesn't address how to handle decoupling. For example, if you want to trigger a screen navigation from a viewmodel command. MVVM frameworks and toolkits address these limitations. For that reason, it's far more common to implement MVVM through a framework than to do it directly like we did in this module.

To provide a basic understanding that applies to all situations, this module hasn't used MVVM frameworks. The next steps to learn about using MVVM involve searching for frameworks that work with Xamarin.Forms and following the documentation and tutorials for those frameworks.

## Learn more with a Channel 9 video series

- [Xamarin Tutorial 101](https://channel9.msdn.com/Series/Xamarin-101/?WT.mc_id=Educationalmobile-c9-niner&azure-portal=true)
- [Intro to Visual Studio for Mac](https://channel9.msdn.com/Series/Intro-to-Visual-Studio-for-Mac?azure-portal=true)
