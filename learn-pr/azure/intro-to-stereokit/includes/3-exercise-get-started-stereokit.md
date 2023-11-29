Now that we know a bit about what StereoKit is let's move on to the next step. We will start by installing the tools and pre-requisites to work with StereoKit. Next, this unit will teach you how to install StereoKit via the Visual Studio templates and enable Developer Mode on your device, PC, and HoloLens 2.

Here is a quick list of what is required to start developing with StereoKit:

* **[Visual Studio 2019 or 2022](https://visualstudio.microsoft.com/vs/)** with the following packages installed,
  * .NET Desktop development
  * Universal Windows Platform development (for HoloLens)
  * Mobile development with .NET (for Quest)

* **[StereoKit's Visual Studio Template](https://marketplace.visualstudio.com/items?itemName=NickKlingensmith.StereoKitTemplates)**

  * Experienced users might directly use the [NuGet package](https://www.nuget.org/packages/StereoKit).

* **Any OpenXR runtime**
  * A flatscreen fallback is available for development.

* **Enable developer mode (for UWP/HoloLens)**

## Install Visual Studio 2019

1. **Download** the free edition of **[Visual Studio Community](https://developer.microsoft.com/windows/downloads)**.

   :::image type="content" source="../media/visual-studio-community.png" alt-text="The screenshot shows how to begin your download, by clicking the Free download button from Visual Studio Community." lightbox="../media/visual-studio-community.png":::

2. Save the **Visual Studio installer** to your device path. Once the download is complete, start the installation by running the Visual Studio installer.

3. Once your Visual Studio starts to install, you'll see a few seconds of initialization followed by a feature selection option. First, select the **.NET Desktop development** and **Universal Windows Platform development (for HoloLens)** checkbox in Visual Studio 2019's features list. Then, after making the required selections, click the **Modify** button.

   :::image type="content" source="../media/select-workloads.png" alt-text="Screenshot of how to select .NET Desktop development and Universal Windows Platform development (for HoloLens) in Visual Studio 2019." lightbox="../media/select-workloads.png":::

4. After you click **Modify**, Visual Studio proceeds to download and install the features you've specified. You'll be asked to **Restart** your computer when the installation completes. Next, launch your Visual Studio to verify the installation was successful.

   :::image type="content" source="../media/test-visual-studio.png" alt-text="Screenshot of testing the visual studio launcher." lightbox="../media/test-visual-studio.png":::

## StereoKit's Visual Studio template

StereoKit's Visual Studio template is the quickest method to start a StereoKit project. By default, it has been set to copy project assets correctly and comes with some basic code that gives you some functionality to play around with right away.

There are two templates provided:

1. **Universal Windows Platform** - is for HoloLens 2 and can also run on Windows desktop. However, UWP can be slower to compile and is no longer receiving updates from the .NET team.
2. **.NET Core** - is used for desktop XR on Windows and Linux. It is simple to use, compiles quickly, and is the best option for most developers.

   :::image type="content" source="../media/stereokit-templates-visual-studio.png" alt-text="Screenshot of downloaded stereoKit templates in Visual Studio." lightbox="../media/stereokit-templates-visual-studio.png":::

3. **[Native C++ Template (in development)](https://github.com/StereoKit/StereoKit/tree/master/StereoKit/Native)**: StereoKit does provide a C API, but experienced developers should only choose this if the benefits outweigh the lack of C API documentation.

> [!Note]
> Iteration is slower with Universal Windows Platform, so use it only if HoloLens is essential to you. Building for ARM instead of ARM64 can save some time, as it can skip the .NET Native compile required by ARM64.
>You may also skip the template and install the [NuGet package](https://www.nuget.org/packages/StereoKit) directly into an existing project.

### Download & install StereoKit's Visual Studio template

1. Download the StereoKit templates from [StereoKit Templates - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=NickKlingensmith.StereoKitTemplates).

   :::image type="content" source="../media/download-stereokit-templates.png" alt-text="Screenshot of StereoKit Templates - Visual Studio Marketplace." lightbox="../media/download-stereokit-templates.png":::

2. Open the downloaded file & click the **Install** button.

   :::image type="content" source="../media/install-stereokit-templates.png" alt-text="Screenshot of VSIX installer dialogue box." lightbox="../media/install-stereokit-templates.png":::

3. Click **close** in the pop-up once the installation is complete.

   :::image type="content" source="../media/close-stereokit-templates-installation.png" alt-text="Screenshot of VSIX installer close button." lightbox="../media/close-stereokit-templates-installation.png":::

## Enable developer mode

Enabling Developer Mode in **HoloLens 2** & **Windows PC** makes it easier to test applications. This allows you to install Universal Windows Platform & Windows apps from outside the Windows Store, an essential feature for app developers who want to test their apps on PC while developing.

### Enable developer mode for HoloLens 2

1. Switch on your **HoloLens 2** and put it on. Then, access the main menu using the start gesture.

2. To start the app in your environment, select the **Settings** tile.

3. Select the **Update and Security** option from the menu.

   :::image type="content" source="../media/hololens-update-security.png" alt-text=" The screenshot of Update & Security menu item." lightbox="../media/hololens-update-security.png":::

4. Select the menu item **For developers**.

5. Enable **Use developer features** to deploy apps from Visual Studio to your HoloLens. If your device is running Windows Holographic version 21H1 or newer, enable **Device discovery**.

6. Optional: Scroll down and enable Device Portal, allowing you to connect to your HoloLens Windows **Device Portal** from a web browser.

   :::image type="content" source="../media/enable-developer-mode-hololens.png" alt-text="Screenshot shows enabling the developer mode." lightbox="../media/enable-developer-mode-hololens.png":::

### Enable developer mode for Windows PC

If you're using a Windows Mixed Reality headset with your PC, enable Developer Mode on your computer.

1. Go to the **Settings** in the menu.

2. Select **Update and Security**.

   :::image type="content" source="../media/update-security.png" alt-text="Screenshot of Select Update and Security menu item." lightbox="../media/update-security.png":::

3. Next, select **For developers**.

   :::image type="content" source="../media/for-developers-option.png" alt-text="Screenshot of Select For developers option." lightbox="../media/for-developers-option.png":::

4. Enable **Developer Mode**, read the disclaimer for the selected setting, then accept the change by selecting **Yes**.

   :::image type="content" source="../media/enable-developer-mode.png" alt-text="Screenshot of On the toggle button to enable Developer Mode."  lightbox="../media/enable-developer-mode.png":::

In this unit, you have seen the pre-requisites for developing a Mixed Reality application using StereoKit. Next, you'll get an overview of the StereoKit Ink demo project as a simplified example of some of StereoKit's features and abilities.
