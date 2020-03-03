Modern applications typically connect to back-end services to provide social and cross-device experiences. It's rare to find applications that are isolated and have no connection to the internet.

In Xamarin.Forms, you can use `HttpClient` to consume REST web services and perform CRUD operations. Xamarin.Forms also has APIs that you can use to detect if you have an internet connection. This information is important because if you run code that uses the internet without a network connection, your application could stop responding. Finally, both Xamarin.iOS and Xamarin.Android have native networking stacks that we can take advantage of with `HttpClient` by using message handlers.

## Learn more with a Channel 9 video series

- [Xamarin Tutorial 101](https://channel9.msdn.com/Series/Xamarin-101/?WT.mc_id=Educationalmobile-c9-niner&azure-portal=true)
- [Intro to Visual Studio for Mac](https://channel9.msdn.com/Series/Intro-to-Visual-Studio-for-Mac?azure-portal=true)
