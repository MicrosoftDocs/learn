We looked at three common navigation strategies used in Xamarin.Forms apps. The following table summarizes the key points.

---
|  | **When to use** | **How to implement** |
|---|---|---|
| **Stack** | When your content has a linear progression of pages from general to specific. | `NavigationPage` and its `PushAsync` and `PopAsync` methods. |
| **Tab** | When you have a small number of top-level pages that have equal importance to the user. You want it to be easy to switch among them. | `TabbedPage` and its `Children` property. |
| **Modal** | When a page requires an affirmative action from the user before dismissal. | The  `PushModalAsync` and `PopModalAsync` methods, available from the `Navigation` property in all page types. |

To test out these strategies, we implemented the **Astronomy** app by using both stack and tab navigation. Which felt more natural? With all things considered, tab navigation was probably a better choice in this case because:

* The pages were all relatively equal in importance.
* The user would probably switch between the pages frequently.

Tabs make this type of navigation simple. It only takes one tap for the user to switch to any of the pages. Stack navigation would require a longer navigation sequence. The user would need to return to the root page before they could go to a different part of the app.

## Learn more with a Channel 9 video series

- [Xamarin Tutorial 101](https://channel9.msdn.com/Series/Xamarin-101/?WT.mc_id=Educationalmobile-c9-niner&azure-portal=true)
- [Intro to Visual Studio for Mac](https://channel9.msdn.com/Series/Intro-to-Visual-Studio-for-Mac?azure-portal=true)
