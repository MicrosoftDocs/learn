So far, you've learned how to install and configure Visual Studio and enable developer mode for both desktop and HoloLens 2. In this unit, you'll get an overview of StereoKit Ink's structure. StereoKit Ink is a sample project used to demonstrate the core components provided by StereoKit.

> [!Note]
> You can find the source code for StereoKit Ink [on Github here](https://github.com/maluoi/StereoKit-PaintTutorial).

This StereoKit demo project aims to introduce people to the fundamentals of how to draw and interact with **Mixed Reality** content. You'll learn how to make:

* Radial hand menus.
* Easy window menus with automatic layouts.
* Custom UI elements.
* File pickers.

Also, you'll discover how simple it is to draw models, lines, and create hand-based interactions.

:::image type="content" source="../media/desktop-stereokit-ink-application.png" alt-text="Screenshot of the StereoKit Ink application on desktop" lightbox="../media/desktop-stereokit-ink-application.png":::

StereoKit Ink's features were chosen to represent a sampling of common tasks required by content creation tools. The code provided is meant to be easy to read and understand rather than fully featured or robust. This should serve as a great way to get a feel for how to use StereoKit's API and see how much can be done with very little code.

## Prerequisites

This project uses **StereoKit** to build a Mixed Reality application on HoloLens 2 and VR headsets.

## Project layout

StereoKit Ink's solution uses a 2 project setup: **.NET Core** and  **UWP**. Different project types support different features and platforms, and it may be common to switch between them depending on what you're working on.

* **.NET Core project** includes:
  * Desktop VR
  * Flatscreen MR Simulator
  * Leap Motion articulated hands
  * No compile time

* **UWP project** includes:
  * HoloLens 2 + articulated hands
  * Desktop VR
  * Flatscreen MR Simulator
  * Controller simulated hands
  * Some compile time

## Window menus

There are two window menus used in the **StereoKit Ink** application: the **Ink Tools** window and the **Ink Menu** window. Both windows perform several different tasks using UI elements.

* **Ink Tools Window** - The **Ink Tools Window** consists of some options for configuring the line you're drawing. This window allows users to choose colors from swatches, refine the colors with sliders, and even change the size of the lines. This window also contains an ink bottle model at the top to spice things up a bit and clarify what the window is for. While most of these are easy built-in UI elements, the swatch buttons are done using custom UI tools to illustrate how to use StereoKit's API to design UI elements of your own.

* **Ink Menu Window** - The **Ink Menu Window** has some options for managing the active ink drawing: *Undo*, *Redo*, *Save*, *Load*, *Clear*, and *Quit*. Most of these buttons are pretty simple, but *Save* and *Load* illustrate using the built-in cross-platform file picker to work with files.

StereoKit uses an Immediate Mode UI paradigm. This may be different from UI systems that you're used to, but it has some rather pleasant strengths. In particular, the API is really simple, and StereoKit doesn't store the state of the UI itself. Instead, you can add, remove, or completely rearrange your UI from one frame to the next using standard code structures, and you can change or check the state of the UI quite trivially. This combination of features allows for rapid development of UI with very little mental overhead.

The UI system also provides a collection of tools for customizing the look and feel of the UI visuals. While StereoKit Ink preserves most of StereoKit's default UI settings, it's entirely possible to modify the UI's appearance quite a bit!

## Accessing hand data

The **StereoKit Ink** application uses hand joint data to draw lines on the canvas. StereoKit is a hands-first API and will **always** provide good hand joints. While StereoKit will prioritize any articulated hand sensors the system might have, it will also fall back to controllers or a mouse and simulate hand joints based on those devices.

StereoKit provides a collection of high-level and low-level information about hand data. In addition, you can find a quick overview of how to get and use hand data in [this guide](https://stereokit.net/Pages/Guides/Using-Hands.html).

The StereoKit Ink sample consists of only three code files and a few art assets. Nevertheless, the code aims to be very readable, with plenty of comments to clarify anything not immediately apparent. The following chapters will explain some of these details.
