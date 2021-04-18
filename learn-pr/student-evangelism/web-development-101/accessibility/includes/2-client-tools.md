Chances are you are very familiar with using a browser as a client to navigate the web. When you think about designing web pages you can picture the user experience with this client as it's one you have personal experience with. However, not all users utilize a browser in the same fashion, or use a browser at all. In order to create experiences for all users you should have an understanding of the different tools people may use when navigating the web.

## Screen readers

One of the best-known accessibility tools are screen readers. [Screen readers](https://en.wikipedia.org/wiki/Screen_reader) are commonly used clients for those with vision impairments. As we spend time ensuring a browser properly conveys the information we wish to share, we must also ensure a screen reader does the same.

At its most basic, a screen reader will read a page from top to bottom audibly. If your page is all text, the reader will convey the information in a similar fashion to a browser. Of course, web pages are rarely purely text; they will contain links, graphics, color, and other visual components. Care must be taken to ensure that this information is read correctly by a screen reader.

As highlighted earlier, you should become familiar with the different tools and clients people use, especially screen readers. Fortunately, screen readers are built into most operating systems.

Some browsers also have built-in tools and extensions that can read text aloud or even provide some basic navigational features, such as [these accessibility-focused Edge browser tools](https://support.microsoft.com/help/4000734/microsoft-edge-accessibility-features). These are also important accessibility tools, but function very differently from screen readers and they should not be mistaken for screen reader testing tools.

> [!NOTE]
> Try a screen reader and browser text reader. On Windows [Narrator](https://support.microsoft.com/windows/complete-guide-to-narrator-e4397a0d-ef4f-b386-d8ae-c172f109bdb1) is included by default, while [JAWS](https://webaim.org/articles/jaws/) and [NVDA](https://www.nvaccess.org/about-nvda/) can also be installed. On macOS and iOS, [VoiceOver](https://support.apple.com/guide/voiceover/welcome/10) is installed by default.

## Zoom

Another tool commonly used by people with vision impairments is zooming. The most basic type of zooming is static zoom, controlled through `Control + plus sign (+)` or by decreasing screen resolution. This type of zoom causes the entire page to resize. Using [responsive design](https://developer.mozilla.org/docs/Learn/CSS/CSS_layout/Responsive_Design), where items shift based on the [viewport](https://developer.mozilla.org/docs/Web/CSS/Viewport_concepts) is important to provide a good user experience at increased zoom levels.

Your OS itself likely has built-in zoom capabilities, which allow you to magnify parts of the screen, much like using a real magnifying glass. [Magnifier](https://support.microsoft.com/windows/use-magnifier-to-make-things-on-the-screen-easier-to-see-414948ba-8b1c-d3bd-8615-0e5e32204198) is built into Windows, with [ZoomText](https://www.freedomscientific.com/training/zoomtext/getting-started/) being available as a more fully-featured and popular third-party add-on. Both macOS and iOS have a built-in magnification tool called [Zoom](https://www.apple.com/accessibility/mac/vision/).
