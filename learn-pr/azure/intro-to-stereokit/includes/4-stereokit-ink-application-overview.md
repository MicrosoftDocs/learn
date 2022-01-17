So far, you've learned how to install and configure your Visual Studio enabling the developer mode for both desktop and HoloLens 2. In this module, you'll have a basic understanding of the components that are included in **StereoKit Ink Application**. StereoKit Ink is a demo application used to help you understand the core components provided by StereoKit.

This StereoKit demo project aims to introduce people to the fundamentals of how to draw and interact with **Mixed Reality** content. You'll learn how to make:

* radial hand menus
* easy window menus with automatic layout
* object-based menus with more specific designs
* file pickers etc.

Also, discover how simple it is to draw models, lines and interact with the game with only your fingers.

:::image type="content" source="../media/desktop-stereokit-ink-application.png" alt-text="Screenshot of the StereoKit Ink application on desktop" lightbox="../media/desktop-stereokit-ink-application.png":::

It's a great example of how to do things and a great way to start for anyone who wants to make an identical feature for themselves. These simple features can help you build a fully functional product at ease.

## Pre-requisites

This project uses **StereoKit** to generate and build a Mixed Reality application, that runs on HoloLens 2 and VR headsets.

## Project layout

Different projects support different features and goals. One can frequently swap between them depending on the current project. There're two project arrangements used in this solution: **.Net Core** and **UWP**.

* Features and targets supported in **.Net Core Project** include:
  * WMR VR Desktop
  * Flatscreen Desktop
  * Leap Motion articulated hands
  * No compile time

* Features and targets supported in **UWP Project** include:
  * HoloLens 2 + articulated hands
  * WMR VR Desktop
  * Flatscreen Desktop
  * Controller simulated hands
  * Some compile time

## Window menus

There are two window menus used in the **StereoKit Ink** application: the **Ink Tools** window and the **Ink Functional** window. Both windows have a series of functionalities attached through various UI components.

* **Ink Tools Window** - The **Ink Tools Window** consists of all the options required to draw models, lines and interact with your fingers. This window allows users to choose colors, customize the colors, and even change the size of the lines. In addition, there are various blobs of primary colors that are frequently used from which the user can choose. The **Ink** bottle present at the top of the window indicates the color selected for the drawing. There are three sliders attached to the window allowing users to alter some properties of the selected color, such as *Hue*, *Saturation*, and *Value*. You also have a slider to modify the size of the drawing.

* **Ink Functional Window** - The **Ink Functional Window** has some options functional like *Undo*, *Redo*, *Save*, *Load*, *Clear*, and *Quit*. UI buttons allow you to take **action** and make **choices**. If you want to perform specific actions after any interaction with the objects on the scene, you can use UI buttons.

Creating windows using StereoKit is precise. You can convert any object into an interface by adding required UI elements. In addition, instead of using the old "window" pattern, users can customize the look and feel of their window through StereoKit.

Since StereoKit doesn't store state, you can add, remove, and change your UI components with minor and standard code structures. The main reason is to accelerate working with UI and avoid compromising the design outcome. All the visual elements added to the window are relative to it.

## Accessing hand interaction

The **StereoKit Ink** application utilizes a fully articulated hand to draw lines and models on the canvas. The accessing hand in the application is essential as it mimics the movement of the user's hands to draw effortlessly. Fully flexible hands are always available to work with as StereoKit uses a hands-first approach. Even when the hand sensors aren't available, the existing devices simulate the hand data.

StereoKit provides various functions to users to access the hand information. Some of the functions are listed below:

* hand.IsPinched

* hand.IsJustPinched

* hand.IsJustUnpinched

* hand.IsGripped

* hand.IsJustGripped

* hand.IsJustUngripped

Only three code files and a few art elements make up this project. The code strives to be very readable, with plenty of comments to clarify anything that isn't immediately obvious. These functions are explained in brief in the following chapters.
