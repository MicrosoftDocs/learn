Our app's goal was to show a list of countries and their flags. Each row needed a thumbnail image of the flag, the name of the country, and the date the flag was adopted. We started with Xamarin.Forms `ListView`, which gave us a scrollable list. Then we added the predefined cell type `ImageCell` and used data binding to load the flag data into the rows.

`ListView` displayed the rows and handled scrolling, so it did most of the work. `ImageCell` and data binding helped too. Without `ImageCell`, we would have had to define the row layout ourselves. Data binding lets you build the list UI without needing any custom code. 

This process demonstrates the value of Xamarin.Forms. We use `ListView` and `ImageCell` to build our UI quickly and get our app to market. At runtime, we get native behavior because Xamarin.Forms `ListView` automatically maps to the native controls `UITableView` on iOS and `ListView` on Android.

## Learn more with a Channel 9 video series

- [Xamarin Tutorial 101](https://channel9.msdn.com/Series/Xamarin-101/?WT.mc_id=Educationalmobile-c9-niner&azure-portal=true)
- [Intro to Visual Studio for Mac](https://channel9.msdn.com/Series/Intro-to-Visual-Studio-for-Mac?azure-portal=true)
