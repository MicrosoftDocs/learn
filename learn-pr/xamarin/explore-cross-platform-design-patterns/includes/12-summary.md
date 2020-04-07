.NET Standard is a specification of .NET APIs that are intended to be available on all .NET implementations. 

You'll use libraries based on .NET Standard to share common code in your application. Some things, however, can't be shared, even in a .NET Standard library. These unsharable things are the platform-specific features of each platform.

To solve this problem, implement abstractions to provide contracts that can be used in your shared code. Use inversion of control (IoC) to move the responsibility of creating the concrete implementation for a dependency. Your aim is to create loosely coupled code. By using loosely coupled code, you can easily switch out platform-specific implementations for abstractions.

Many existing containers are available for use. We encourage you to use an existing one if you decide to use dependency injection for your project.

Finally, you should consider using [Xamarin.Essentials](https://docs.microsoft.com/xamarin/essentials/) in your applications. Xamarin.Essentials provides you with a single cross-platform API that works with any Xamarin.Forms, Android, or iOS application that's accessed from shared code, no matter how the user interface is created.

## Learn more with a Channel 9 video series

- [Xamarin Tutorial 101](https://channel9.msdn.com/Series/Xamarin-101/?WT.mc_id=Educationalmobile-c9-niner&azure-portal=true)
- [Intro to Visual Studio for Mac](https://channel9.msdn.com/Series/Intro-to-Visual-Studio-for-Mac?azure-portal=true)
