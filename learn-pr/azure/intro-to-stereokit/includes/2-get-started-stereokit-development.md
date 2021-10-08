In this chapter, you'll learn how to install StereoKit and enable Developer Mode on your Development PC and HoloLens2 devices

## Install Visual Studio 2019 for StereoKit

1. Download the free edition of **[Visual Studio Community](https://developer.microsoft.com/windows/downloads)**.

    :::image type="content" source="../media/visual-studio-community.png" alt-text="The screenshot shows how to begin your download, by clicking the “Free download” button from Visual Studio Community." lightbox="../media/visual-studio-community.png":::

2. Save the Visual Studio installer to your desired path. Once the download is complete, you can start the installation process by running the Visual Studio installer.

    :::image type="content" source="../media/run-visual-studio-installer.png" alt-text="Screenshot shows how to run the Visual Studio installer to your PC." lightbox="../media/run-visual-studio-installer.png":::

3. Once Visual Studio installation starts, you'll see a few seconds of initialization followed by a feature selection option. Select the **".NET Desktop development** and **Universal Windows Platform development (for HoloLens)"** checkbox in Visual Studio 2019's features list. Then, after making the required selections, click on the **"Install"** button.

    :::image type="content" source="../media/select-workloads.png" alt-text="Screenshot of how to select .NET Desktop development and Universal Windows Platform development (for HoloLens) in Visual Studio 2019." lightbox="../media/select-workloads.png":::

4. When you click "Install," Visual Studio will proceed with downloading and installing the features you've specified. You may be requested to **"Restart"** your computer once the installation process is complete. Launch your Visual Studio to verify that the installation was successful.

    :::image type="content" source="../media/test-visual-studio.png" alt-text="Screenshot of testing the visual studio launcher." lightbox="../media/test-visual-studio.png":::

## StereoKit’s Visual Studio template

StereoKit’s visual studio template is the quickest methods for you to start a StereoKit project. It is also configured to properly copy project assets by default, and includes some boilerplate code that gives you a bit of functionality to work right away.

There are two templates provided:

1. **Universal Windows Platform** for deploying on HoloLens 2 platform.
2. **.NET Core** for desktop Windows or Linux environment.

    :::image type="content" source="../media/stereokit-templates-visual-studio.png" alt-text="Screenshot of downloaded stereoKit templates in Visual Studio." lightbox="../media/stereokit-templates-visual-studio.png":::

> [!Note]
    >Iteration is slower with Universal Windows Platform because it builds apps, so use it only if HoloLens is essential to you.
    >You may also install the [NuGet package](https://www.nuget.org/packages/StereoKit) directly into your project.

### Download & install StereoKit’s Visual Studio template

1. Download the StereoKit templates from [StereoKit Templates - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=NickKlingensmith.StereoKitTemplates).

    :::image type="content" source="../media/download-stereokit-templates.png" alt-text="Screenshot of StereoKit Templates - Visual Studio Marketplace.” " lightbox="../media/download-stereokit-templates.png":::

2. Open the downloaded file & click on **Install** button.

    :::image type="content" source="../media/install-stereokit-templates.png" alt-text="Screenshot of VSIX installer dialogue box.” " lightbox="../media/install-stereokit-templates.png":::

3. Click **close** in the pop up once the installation is complete.

    :::image type="content" source="../media/close-stereokit-templates-installation.png" alt-text="Screenshot of VSIX installer close button.” " lightbox="../media/close-stereokit-templates-installation.png":::

## Enable Developer Mode

Enabling Developer Mode in UWP/Hololens 2 & Windows PC makes it easier to test the applications you're working on. In addition, you can install Universal Windows Platform & Windows apps from outside the Windows Store, even if they're not signed with a valid certificate. This is an essential feature for app developers who want to test their apps on their PCs while still developing.

### Enable developer mode for HoloLens 2

1. Switch on your HoloLens 2 and put it on. Then, access the main menu by using the start gesture.

2. To start the app in your environment, select the **Settings** tile.

3. Select the **Update and Security** option from the menu.

    :::image type="content" source="../media/hololens-update-security.png" alt-text=" The screenshot of Update & Security menu item." lightbox="../media/hololens-update-security.png":::

4. Select the menu item **For developers**.

5. Enable **Use developer features** to deploy apps from Visual Studio to your HoloLens. If your device is running Windows Holographic version 21H1 or newer, also enable **Device discovery**.

6. Optional: Scroll down and enable Device Portal, which allows you to connect to your HoloLens' Windows **Device Portal** from a web browser.

    :::image type="content" source="../media/enable-developer-mode-hololens.png" alt-text="Screenshot shows enabling the developer mode." lightbox="../media/enable-developer-mode-hololens.png":::

### Enable Developer Mode for Windows PC

If you're using a Windows Mixed Reality headset with your PC, you'll have to enable Developer Mode on your computer.

1. Go to **Settings** menu.

    :::image type="content" source="../media/settings-menu.png" alt-text="Screenshot of Click the setting menu." lightbox="../media/settings-menu.png":::

2. Select **Update and Security**.

    :::image type="content" source="../media/update-security.png" alt-text="Screenshot of Select “Update and Security” menu item." lightbox="../media/update-security.png":::

3. Select **For developers**.

    :::image type="content" source="../media/for-developers-option.png" alt-text="Screenshot of Select “For developers” option." lightbox="../media/for-developers-option.png":::

4. Enable **Developer Mode**, read the disclaimer for the selected setting, and then accept the change by selecting Yes.

    :::image type="content" source="../media/enable-developer-mode.png" alt-text="Screenshot of On the toggle button to enable “Developer Mode.” " lightbox="../media/enable-developer-mode.png":::
