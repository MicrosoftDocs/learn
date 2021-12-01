Contrast settings, as discussed in the introductory scenario, are just one of many types of software-based assistive technologies commonly used in gaming.

In this unit, you'll be introduced to other common software settings and tools. Additionally, you will learn how to best support players who use these technologies when creating new gaming experiences.

## What are the common types of software assistive technologies used in gaming?

Software-based assistive technologies can improve access to gaming experiences through a host of functionalities including:

 - Narrating visual UI elements aloud to players
 - Customizing the player's display to optimize the visibility of elements
 - Allowing players to reassign their input controls through software and more

These technologies and tools are available as third-party programs that can be installed on gaming platforms, built-in features on certain game platforms, as well as functions built directly into some games.

An awareness of the following assistive tools is important in ensuring that the gaming products and experiences you create effectively support the players who use them.

### Screen readers

Screen readers are a form of assistive technology that renders text or image content on screen aloud as speech or braille output. They are commonly used by individuals who are blind or have visual disabilities in which adjusting text size or color is not enough to render the text readable.

Screen readers may also be used by players with cognitive or learning disabilities that make reading difficult, or younger players who have not yet learned to read.

In gaming, screen readers should essentially convey what is happening visually within the game's UI aloud via synthesized audio.

In the following video, the player adjusts their screen narration settings at the Xbox platform level. Next, they launch the game Forza Horizon 5. The game launches with its title-provided screen reader already enabled. This is because the user has screen narration enabled at the platform level, and the game is able to read and apply the user's settings to the game upon launch.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWPDLf]

### Contrast settings

Contrast settings are intended to enhance the visibility of on-screen elements by changing color schemes or simplifying backgrounds. These settings are primarily used by players with low vision. However, they can also benefit neurodiverse users, as some high contrast modes also simplify the visual aspects of the user interface considered distracting by some, making the interface easier to navigate.

The following screenshots provide an example of the Xbox Platform's high contrast mode settings in action.

**Xbox Home Screen without High Contrast Mode Enabled:**
:::image type="content" source="../media/hc-three.png" alt-text="The Xbox home screen. Buttons consisting of images with text on top of them are displayed. Behind the buttons, a gradient color pattern of purples and pinks is displayed.":::

**The Xbox Platform High Contrast Settings Menu:**
:::image type="content" source="../media/hc-two.png" alt-text="A screenshot of the Xbox Accessibility High Contrast settings menu. The list box High Contrast: Dark theme is selected. To the right of the list box is an image demonstrating how the Xbox Home screen will look like with a dark theme applied. Text on the screen reads: Turn on high contrast to make on-screen elements easier to see. This will prevent your personal color and background from being shown.":::

**The Xbox Home Screen with High Contrast Dark Theme applied:**

:::image type="content" source="../media/hc-four.png" alt-text="The Xbox home screen. Buttons consisting of images with text on top of them are displayed. The white text of each button now sits on an opaque bar. There is no longer a gradient color pattern of purples and pinks displayed behind the buttons; the background is simply black.":::

Note the following changes that work to simplify and enhance the visibility of the UI elements:

 - The background color is changed from bright pink and purple to solid black.
 - The focus indicator is slightly wider and brighter.
 - The focus indicator's bright turquoise color has a high contrast ratio against the new black background UI elements sit on.
 - The text within the tile options now have a solid black background behind them to increase readability.
 - Content that typically animates or moves within the UI is now static or replaced by the black background.

> [!NOTE]
> The Xbox High Contrast settings are a platform-level feature. These settings do not alter the UI during in-game play.

### Color filters and custom color palettes

Color filters are another type of tool that may allow players with certain types of colorblindness to more easily distinguish certain visual elements on screen. They are often provided at the platform level to provide a base level of access to experiences that might not be otherwise accessible to some individuals.

:::image type="content" source="../media/color-filters-one.png" alt-text="The Xbox Accessibility Color Filters settings screen is shown. The list box Correction type: No correction selected is shown and highlighted. To the right are three circles, each divided into three equal segments of different colors. The circles are labels Deuteranopia, Protanopia, and Tritanopia respectively. Below the circles, a colorful image of an Xbox controller is displayed. Next to it is a grid of colors representing the colors of the rainbow, from red to purple. Text on the screen reads, Before selecting a correction, identify the circle whose three colors look most similar. Then choose the correction named for that circle.":::

:::image type="content" source="../media/color-filters-two.png" alt-text="The Xbox Accessibility Color Filters settings screen is shown. The list box Correction type: Red-green (protanopia) is shown. The slider, Intensity is shown and is set to the maximum value. Below it is a slider labeled, Color boost which is set roughly between the minimum and maximum values. Below that, is a Restore defaults button. To the right are three circles, each divided into three equal segments of different colors. The circles are labels Deuteranopia, Protanopia, and Tritanopia respectively. Below the circles, a colorful image of an Xbox controller is displayed. Next to it is a grid of colors representing the colors of the rainbow, from red to purple. Text on the screen reads, “Before selecting a correction, identify the circle whose three colors look most similar. Then choose the correction named for that circle.":::

As a general rule, however, color filters at the platform or game level should not be considered a solution for players with color blindness. This is because color filters can impact other visual aspects of a game in unintended ways. This can end up making some visual components more difficult to see for certain players depending on the severity of their colorblindness. Instead, a better option is to offer players color palettes to choose from that individually change the color of specific elements.

:::image type="content" source="../media/halo-pallette-2.png" alt-text="A screenshot of the Halo 5 accessibility menu. Under the visuals tab, the player can choose from a variety of colors for the enemy UI color, friendly UI color, and fireteam marker color options.":::

:::image type="content" source="../media/halo-palette-1.png" alt-text="A screenshot of the Halo 5 accessibility menu options. The fireteam marker color selection list is expanded. A scrolling list of about 15 color options total is presented. The color jade is selected.":::

### Magnification tools

Magnification tools typically enlarge a portion of the screen, or all of the screen, so users can more easily see words and images.

In gaming contexts, magnification tools can allow players to zoom in on specific areas of their gameplay environment to get a clearer look at the contents on screen.

Magnification tools can help players with low vision enlarge screen elements to the point where they can be read or interpreted. Additionally, magnification tools can help players who are using small screens like mobile devices, or are playing on screens that are further away, making screen elements appear small.

:::image type="content" source="../media/mag-four.png" alt-text="The Forza Horizon 5 menu. The entire screen is displayed, including buttons named World Map, Settings, Horizon Adventure, and more.":::

:::image type="content" source="../media/mag-five.png" alt-text="The Forza Horizon 5 menu, now zoomed in on a specific section of the screen. Only a portion of the original screen is displayed with text and images larger than they were previously.":::

### Accessible player-to-player communication tools

Online player communication tools like voice chat may be inaccessible for players with disabilities who cannot hear what others are saying aloud.

Additionally, players who cannot speak aloud or choose not to, will be unable to respond to other players in the voice channel. Assistive technologies like speech-to-text and text-to-speech are intended to make communication experiences between players accessible.

These tools may be provided by the gaming platform you are shipping on for certain chat functionality. However, for in-game chat, some of these tools require the use of specific APIs for games to make use of them. There are also non-platform services that exist that developers can integrate as part of their games to provide such functionality, such as PlayFab Party chat.

- Speech-to-text: Transcribes incoming speech from other players into text on-screen in real time. Players who cannot hear voice chat can read what other players have said aloud on their screen.
- Text-to-speech: Converts text typed by the player into synthesized audio that is read aloud to all other players in the voice channel. This essentially allows players who cannot speak verbally to have their thoughts expressed to the rest of the players in their party aloud.

:::image type="content" source="../media/player-comms.png" alt-text="The Xbox Accessibility Game and Chat Transcription settings are show. Two columns of settings are shown. The first column of settings is labeled Party chat options. Underneath are two checkboxes, Speech-to-text and Text-to-speech. A list box is shown labeled, Text-to-speech voice: Guy. The second column of settings is labeled, Game transcription. Underneath are three check boxes, Speech-to-text, Text-to-speech, and Let game read to me. A list box is shown labeled, In-game chat voice: Microsoft Mark. Text on the screen reads, Turn on speech-to-text to transcribe other players’ voices into text on your device, when you are in a system party chat.":::

### Captioning

Captioning is an important tool useful for players who are d/Deaf or Hard of Hearing to translate noise and dialogue from the game into text that appears on-screen.

> [!NOTE]
> The terms “captioning,” “closed captions,” and “subtitles” are often used interchangeably although there are subtle differences between them. For the purpose of this module, we are using “captioning” to refer to the use of on screen text to represent audio, including both sound effects and character dialogue.

Captions can help identify aspects of the game like:

- The dialogue of other characters
- The character that is currently speaking
- The presence and direction of important audio cues

Captions are also used by players who don't have hearing-related disabilities but prefer to have the text appear on screen. Perhaps the player is in a loud environment or finds it easier to recall storylines by reading text in addition to listening to it.

Captions can support players at the platform and individual game title levels to ensure audio is accessible.

The following image displays the Xbox Platform's captioning settings. Note the vast array of customization options that work to ensure that captioned text is also accessible to players from a visual perspective. Games and applications can choose to read these settings and use them to adjust how their caption systems present information to their players.

:::image type="content" source="../media/caption.png" alt-text="The Xbox Accessibility Captioning settings are shown. On the left of the screen are three radio buttons, “Captioning off,” “On using default style,” and “On using custom style.” “On using custom style” is set. To the right is a column of settings labeled “Caption Font.” These include list items such as, “Caption color: White,” “Caption transparency: Opaque,” “Caption Size: 200%,” “Caption Style: Default,” and “Caption Effects: Default.” To the right is another column of settings labeled “Background & window.” These include list items such as, “Background color: Black,” “Background transparency: Opaque,” “Window color: Black,” and “Window transparency: Transparent.” Below is a window titled, “Preview” and shows sample captions on top of sample game graphics.":::

Forza Horizon 5 provides users the ability to customize how spoken dialogue appears on screen, allowing users to adjust not only the size and background opacity of their subtitles, but also have key words highlighted to more easily draw player attention to important information.

:::image type="content" source="../media/fh-subtitles.png" alt-text="A screenshot of the Forza Horizon 5 accessibility settings menu. The subtitles text size option has focus. A slider to increase and decrease subtitle text size is provided. A preview of the users current subtitle settings is shown on the bottom of the screen.":::

### Input remapping

Input remapping allows players to reassign the functions on their standard input devices. Remapping capabilities are helpful in allowing players with limited mobility to change the arrangement of their controls through software. For example, if the default assignment for sprinting in a game is right stick-click and a player with a thumb injury finds performing that action difficult, they can reassign the sprint function via software to a different button on their controller that is easier to activate.

:::image type="content" source="../media/input-remapping.png" alt-text="The Xbox Accessibility Controller Profile 1 settings screen is shown. Text on the screen reads, “Choose a button to map. Or press and hold a button.” Below the “A Button” list item is selected. Below, a “Map to” setting is displayed that is also set to “A Button.” Additional checkboxes are also shown, including “Swap sticks,” “Invert right stick Y axis,” “Invert left stick Y axis,” “Swap triggers,” and “Turn on vibration.” To the right, an Xbox controller is shown with a “Restore to default” button below it.":::

Platform-level remapping tools can provide an effective "safety net" for players. However, gaming experiences can be made more accessible when in-game remapping features are also provided. This ensures that any tutorials, prompts, or references to game controls on-screen have properly translated the player's newly remapped controls to avoid confusion.

:::image type="content" source="../media/flight-sim-remap.png" alt-text="A screenshot of the Microsoft Flight Simulator Controls Options menu. The controller option is selected. A long list of game controls that can be reassigned to the player's desired controller input is displayed.":::

## Software considerations for game accessibility

With a new understanding of common software-based AT players use in gaming, the next step is ensuring that future experiences you create also support players who need these technologies.

When developing game titles, consider the following steps:

 - Assess the scope of assistive tools that are provided by the platform(s) your title will ship on.
 - Ensure your product works smoothly with any assistive tools that are present.
 - Regardless of what platform-level accessibility tools exist, aim to include more robust, in-game version of these functions and features as platform level assistive technology is often designed to be a “last resort” for gamers who have no other options and may not provide an ideal experience.

When developing new gaming platforms or platform features, consider the following steps:

 - Assess the scope of assistive tools provided by the platform.
 - Note any key settings or tools missing. Players must first navigate their platform to start their game. If a game title offers assistive tools but the platform does not, players can still be blocked from play while attempting to navigate the platform without these tools.
 - Additionally, you can identify any sources of incompatibility between platform provided AT and a game title's ability to use them. For example, if a player has screen narration turned on at the platform level, but the platform does not expose this information to the game title, the game cannot leverage the player's platform settings on launch.