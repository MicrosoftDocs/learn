[!include[](../../includes/xamarin-not-maintained.md)]

Designing for accessibility involves designing app user interfaces that work well with operating system features for display assistance and input assistance. These features include large type, high contrast, zoom in, screen reading (text-to-speech), visual or haptic feedback cues, and alternative input methods.

Desktop and mobile platforms like iOS, Android, and Windows provide many APIs that enable developers to build more accessible apps. This module will specifically focus on optimizing your app to work better with screen readers that provide text to speech for user interface controls. Additionally, we'll explore how being intentional about content ordering can improve usability and accessibility for users.

## How do screen readers work?

Each platform has its own versions of screen readers. They give auditory descriptions of user controls that are displayed on the screen. These descriptions help users move through the application and give reference to controls, such as images, that have no input or written text. Screen readers are often controlled through gestures on the touchscreen, a trackpad, or a keyboard. 

Next, you'll learn more about the main screen readers that Xamarin.Forms supports and how to enable them.

> [!NOTE]
> Setup instructions for screen readers vary across device and platform versions.
