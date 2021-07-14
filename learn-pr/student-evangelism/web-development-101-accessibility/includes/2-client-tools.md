You're probably very familiar with using a browser as a client to browse the web. When you think about designing webpages, you can picture the user experience with this client because you have personal experience with it. But not all users use a browser in the same way, or use a browser at all. To create experiences for all users, you should understand the various tools that people might use when they browse the web.

## Screen readers

One of the best-known accessibility tools is a [screen reader](https://en.wikipedia.org/wiki/Screen_reader). Screen readers are commonly used clients for people with vision impairments. They're built into most operating systems. As we spend time ensuring that a browser properly conveys the information that we want to share, we must also ensure that a screen reader does the same.

At its most basic, a screen reader reads a page from top to bottom audibly. If your page is all text, the reader conveys the information in a similar way to a browser. Of course, webpages are rarely purely text; they contain links, graphics, color, and other visual components. Care must be taken to ensure that a screen reader can correctly read this information.

Some browsers also have built-in tools and extensions that can read text aloud or even provide some basic navigational features, such as [these accessibility-focused Edge browser tools](https://support.microsoft.com/help/4000734/microsoft-edge-accessibility-features). These browser tools are also important accessibility tools, but they function differently from screen readers. They shouldn't be mistaken for screen-reader testing tools.

> [!NOTE]
> Try a screen reader and a browser text reader. On Windows, [Narrator](https://support.microsoft.com/windows/complete-guide-to-narrator-e4397a0d-ef4f-b386-d8ae-c172f109bdb1) is included by default. [JAWS](https://webaim.org/articles/jaws/) and [NVDA](https://www.nvaccess.org/about-nvda/) can also be installed on Windows. On macOS and iOS, [VoiceOver](https://support.apple.com/guide/voiceover/welcome/10) is installed by default.

## Zoom

Another tool that people with vision impairments commonly use is zooming. The most basic type of zooming is static zoom, which is controlled through the keyboard shortcut Ctrl+Plus sign (+) or by decreasing screen resolution. This type of zoom resizes the entire page. Using [responsive design](https://developer.mozilla.org/docs/Learn/CSS/CSS_layout/Responsive_Design), where items shift based on the [viewport](https://developer.mozilla.org/docs/Web/CSS/Viewport_concepts), is important to provide a good user experience at increased zoom levels.

Your operating system likely has built-in zoom capabilities that allow you to magnify parts of the screen, much like using a real magnifying glass. [Magnifier](https://support.microsoft.com/windows/use-magnifier-to-make-things-on-the-screen-easier-to-see-414948ba-8b1c-d3bd-8615-0e5e32204198) is built into Windows, whereas [ZoomText](https://www.freedomscientific.com/training/zoomtext/getting-started/) is available as a more fully featured and popular partner add-on. Both macOS and iOS have a built-in magnification tool called [Zoom](https://www.apple.com/accessibility/mac/vision/).
