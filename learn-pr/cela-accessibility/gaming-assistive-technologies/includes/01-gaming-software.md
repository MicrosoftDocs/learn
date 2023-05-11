Contrast settings, as discussed in the introductory scenario, are just one of many types of software-based assistive technologies (AT) commonly used in gaming.

In this unit, you're introduced to other common software settings and tools. You also learn how to best support players who use these technologies when you create new gaming experiences.

## What are the common types of software assistive technologies used in gaming?

Software-based AT can improve access to gaming experiences through a host of functionalities including:

- Narrating visual UI elements aloud to players.
- Customizing the player's display to optimize the visibility of elements.
- Allowing players to reassign their input controls through software.

These technologies and tools are available as third-party programs that can be installed on gaming platforms, built-in features on certain game platforms, and functions built directly into some games.

Awareness of the following assistive tools helps you to ensure the gaming products and experiences you create effectively support the players who use them.

### Screen readers

Screen readers are a form of AT that renders text or image content onscreen aloud as speech or Braille output. They're commonly used by individuals who are blind or have visual disabilities in which adjusting text size or color isn't enough to render the text readable.

Players with cognitive or learning disabilities that make reading difficult or younger players who haven't yet learned to read might also use screen readers.

In gaming, screen readers should convey what's happening visually within the game's UI aloud via synthesized audio.

In the following video, the player adjusts their screen narration settings at the Xbox platform level. Next, they launch the game Forza Horizon 5. The game starts with its title-provided screen reader already enabled. The user has screen narration enabled at the platform level, so the game can read and apply the user's settings to the game when it starts.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWPDLf]

### Contrast settings

Contrast settings are intended to enhance the visibility of onscreen elements by changing color schemes or simplifying backgrounds. These settings are primarily used by players with low vision. They can also benefit neurodiverse users. Some high-contrast modes also simplify the visual aspects of the user interface considered distracting by some players, which makes the interface easier to navigate.

The following screenshots provide an example of the Xbox platform's high-contrast mode settings in action:

**Xbox home screen without high-contrast mode enabled:**

:::image type="content" source="../media/hc-home.png" alt-text="A screenshot that shows the Xbox home screen. The Microsoft Rewards tab has focus. Buttons consisting of images with text on top of them are displayed. Behind the buttons, a gradient color pattern of purples and pinks is displayed.":::

**The Xbox platform high-contrast settings menu:**

:::image type="content" source="../media/hc-two.png" alt-text="A screenshot that shows the Xbox Accessibility High-contrast settings menu with High contrast: Dark theme selected. An image next to the setting demonstrates what the Xbox home screen looks like with a dark theme applied. Text on the screen reads: Turn on high contrast to make on-screen elements easier to see. This will prevent your personal color and background from being shown.":::

**The Xbox home screen with the high-contrast dark theme applied:**

:::image type="content" source="../media/hc-dark.png" alt-text="A screenshot that shows the Xbox home screen. Buttons consisting of images with text on top of them are displayed. The white text of each button now sits on an opaque bar. A gradient color pattern of purples and pinks is no longer displayed behind the buttons. The background is black.":::

The following changes work to simplify and enhance the visibility of the UI elements:

- The background color is changed from bright pink and purple to solid black.
- The focus indicator is slightly wider and brighter.
- The focus indicator's bright turquoise color has a high-contrast ratio against the new black background UI elements sit on.
- The text within the tile options now has a solid black background behind it to increase readability.
- Content that typically animates or moves within the UI is now static or replaced by the black background.

> [!NOTE]
> The Xbox high-contrast settings are a platform-level feature. These settings don't alter the UI during in-game play.

### Color filters and custom color palettes

Color filters are another tool that might allow players with certain types of color blindness to more easily distinguish visual elements onscreen. They're often provided at the platform level to provide a base level of access to experiences that might not be otherwise accessible to some individuals.

:::image type="content" source="../media/color-filters-one.png" alt-text="A screenshot that shows the Xbox Accessibility Color filters settings screen. The list box Correction type: No correction selected is shown and highlighted. To the right are three circles, each divided into three equal segments of different colors and labeled Deuteranopia, Protanopia, and Tritanopia. Underneath the circles is a colorful image of an Xbox controller. Next to it is a grid of colors representing the colors of the rainbow, from red to purple. Text on the screen reads: Before selecting a correction, identify the circle whose three colors look most similar. Then choose the correction named for that circle.":::

:::image type="content" source="../media/color-filters-two.png" alt-text="A screenshot that shows the Xbox Accessibility Color filters settings screen. The list box Correction type: Red-green (protanopia) is shown. The Intensity slider is shown set to the maximum value. Underneath, the Color boost slider is set closer to the maximum value. Underneath the slider is a Restore defaults button. To the right are three circles, each divided into three equal segments of different colors and labeled Deuteranopia, Protanopia, and Tritanopia. Underneath the circles is a colorful image of an Xbox controller. Next to it is a grid of colors representing the colors of the rainbow, from red to purple. Text on the screen reads: Before selecting a correction, identify the circle whose three colors look most similar. Then choose the correction named for that circle.":::

As a general rule, color filters at the platform or game level shouldn't be considered a solution for players with color blindness. Color filters can affect other visual aspects of a game in unintended ways. For example, some visual components might be more difficult to see for certain players depending on the severity of their color blindness. A better option is to offer players color palettes to choose from that individually change the color of specific elements.

:::image type="content" source="../media/halo-pallette-2.png" alt-text="A screenshot that shows the Halo 5 Accessibility menu. Under the Visual tab, the player can choose from various colors for the enemy UI color, friendly UI color, and fire team marker color options.":::

:::image type="content" source="../media/halo-palette-1.png" alt-text="A screenshot that shows the Halo 5 Accessibility menu options. The fire team marker color selection list is expanded. A scrolling list of about 15 color options total is presented. The color jade is selected.":::

### Magnification tools

Magnification tools typically enlarge a portion of the screen, or all the screen, so that users can more easily see words and images.

In gaming contexts, magnification tools allow players to zoom in on specific areas of their gameplay environment to get a clearer look at the contents onscreen.

Magnification tools can help players with low vision enlarge screen elements to the point where they can be read or interpreted. Magnification tools can also help players who are using small screens, like mobile devices. They also help when playing on screens that are further away, which makes screen elements appear small.

:::image type="content" source="../media/mag-horn-one.png" alt-text="A screenshot that shows the Forza Horizon 5 Car Horns menu. The entire screen is displayed, including the Standard Horns, Musical Horns, and Sound Effects tabs.":::

:::image type="content" source="../media/mag-horn-two.png" alt-text="A screenshot that shows the Forza Horizon 5 Car Horns menu, now zoomed in on a specific section of the screen. Only a portion of the original screen is displayed with text and images larger than they were previously.":::

### Accessible player-to-player communication tools

Online player communication tools like voice chat might be inaccessible for players with disabilities who can't hear what others are saying aloud.

Players who can't speak aloud or choose not to are unable to respond to other players in the voice channel. AT like speech to text and text to speech are intended to make communication experiences between players accessible.

The gaming platform you're shipping on might provide these tools for certain chat functionality. For in-game chat, some of these tools require the use of specific APIs for games to make use of them. There are also nonplatform services that exist that developers can integrate as part of their games to provide such functionality, such as PlayFab Party chat.

- **Speech to text**: Transcribes incoming speech from other players into text onscreen in real time. Players who can't hear voice chat can read what other players have said aloud on their screen.
- **Text to speech**: Converts text typed by the player into synthesized audio that's read aloud to all other players in the voice channel. This feature allows players who can't speak verbally to have their thoughts expressed aloud to the rest of the players in their party.

:::image type="content" source="../media/player-comms.png" alt-text="A screenshot that shows the Xbox Accessibility Game and chat transcription settings. Two columns of settings are shown. The left column of settings is labeled Party chat options. Underneath are two checkboxes: Speech to text and Text to speech. A list box is labeled Text to speech voice: Guy. The right column of settings is labeled Game transcription. Underneath are three checkboxes: Speech to text, Text to speech, and Let games read to me. A list box is labeled In-game chat voice: Microsoft Mark. Text on the screen reads: Turn on speech to text to transcribe other players' voices into text on your device, when you are in a system party chat session.":::

### Captioning

Captioning is an important tool that's useful for players with hearing impairments to translate noise and dialogue from the game into text that appears onscreen.

> [!NOTE]
> The terms "captioning," "closed captions," and "subtitles" are often used interchangeably, although there are subtle differences between them. For this module, we use "captioning" to refer to the use of onscreen text to represent audio, which includes both sound effects and character dialogue.

Captions can help identify aspects of the game like:

- The dialogue of other characters.
- The character that's currently speaking.
- The presence and direction of important audio cues.

Captions are also used by players who don't have hearing impairments but prefer to have the text appear onscreen. Perhaps the player is in a loud environment or finds it easier to recall storylines by reading text while also listening to it.

Captions can support players at the platform and individual game title levels to ensure audio is accessible.

The following image displays the Xbox platform's captioning settings. An array of customization options work to ensure that captioned text is also accessible to players from a visual perspective. Games and applications can choose to read these settings and use them to adjust how their caption systems present information to their players.

:::image type="content" source="../media/caption.png" alt-text="A screenshot that shows the Xbox Accessibility Captioning settings. On the left are three buttons: Captioning off, On using default style, and On using custom style. The button On using custom style is set. To the right is a column of settings labeled Caption Font. These list items include Caption color: White, Caption transparency: Opaque, Caption size: 200%, Caption style: Default, and Caption effects: Default. To the right is another column of settings labeled Background & window. These list items include Background color: Black, Background transparency: Opaque, Window color: Black, and Window transparency: Transparent. At the bottom of the screen is a window titled Preview that shows sample captions on top of sample game graphics.":::

In Forza Horizon 5, users can customize how spoken dialogue appears onscreen. They can adjust the size and background opacity of their subtitles. They can also have key words highlighted to more easily draw player attention to important information.

:::image type="content" source="../media/fh-subtitles.png" alt-text="A screenshot that shows the Forza Horizon 5 Accessibility settings menu. The Subtitles Text Size option has focus. A slider to increase and decrease subtitle text size is provided. A preview of the user's current subtitle settings is shown at the bottom of the screen.":::

### Input remapping

Input remapping allows players to reassign the functions on their standard input devices. Remapping capabilities are helpful in allowing players with limited mobility to change the arrangement of their controls through software. For example, if the default assignment for sprinting in a game is right stick-click, a player with a thumb injury might find performing that action difficult. They can then reassign the sprint function via software to a different button on their controller that's easier to activate.

:::image type="content" source="../media/input-remapping.png" alt-text="A screenshot that shows the Xbox Accessibility Controller Profile 1 settings screen. Text on the screen reads: Choose a button to map. Or press and hold a button. Underneath, the A button list item is selected. A Map to setting is displayed that's also set to A button. More checkboxes include Swap sticks, Invert right stick Y axis, Invert left stick Y axis, Swap triggers, and Turn on vibration. To the right, an Xbox controller is shown with a Restore to default button underneath it.":::

Platform-level remapping tools can provide an effective "safety net" for players. But gaming experiences can be made more accessible when in-game remapping features are also provided. This addition ensures that any tutorials, prompts, or references to game controls onscreen have properly translated the player's newly remapped controls to avoid confusion.

:::image type="content" source="../media/flight-sim-remap.png" alt-text="A screenshot that shows the Microsoft Flight Simulator Controls Options menu. The controller option is selected. A long list of game controls that can be reassigned to the player's desired controller input is displayed.":::

## Software considerations for game accessibility

You now have a new understanding of common software-based AT that players use in gaming. The next step is to ensure that future experiences you create also support players who need these technologies.

When you develop game titles, consider the following steps:

- Assess the scope of assistive tools that are provided by the platforms your title ships on.
- Ensure your product works smoothly with any assistive tools that are present.
- No matter what platform-level accessibility tools exist, aim to include more robust, in-game versions of these functions and features. Platform-level AT is often designed to be a last resort for gamers who have no other options and might not provide an ideal experience.

When you develop new gaming platforms or platform features, consider the following steps:

- Assess the scope of assistive tools provided by the platform.
- Note any key settings or tools missing. Players must first navigate their platform to start their game. If a game title offers assistive tools but the platform doesn't, players can still be blocked from play while they attempt to navigate the platform without these tools.
- You can also identify any sources of incompatibility between platform-provided AT and a game title's ability to use them. For example, if a player has screen narration turned on at the platform level, but the platform doesn't expose this information to the game title, the game can't use the player's platform settings on launch.
