The first step to set up an immersive experience project for Windows Mixed Reality. StereoKit requires Visual Studio 2019.

## Steps to install visual studio for StereoKit

1. Download the free edition of [Visual Studio Community](https://developer.microsoft.com/windows/downloads).

    :::image type="content" source="../media/visual-studio-community.png" alt-text="The screenshot shows how to begin your download, by clicking the “Free download” button from Visual Studio Community." lightbox="../media/visual-studio-community.png":::

2. Save the Visual Studio installer to your desired path. Once the download is complete, you can start the installation process by running the Visual Studio installer. Below image shows how the installation appears in the Microsoft Edge browser when you execute it.

    :::image type="content" source="../media/run-visual-studio-installer.png" alt-text="Screenshot shows how to run the Visual Studio installer to your PC." lightbox="../media/run-visual-studio-installer.png":::

3. When you run the Visual Studio installation, you'll see a few seconds of initialization followed by a feature selection option, as shown in below image. First, select the ".NET Desktop development and Universal Windows Platform development (for HoloLens)" checkbox in Visual Studio 2019's features list. Then, after making the required selections, click on "Next" or "Install.

    :::image type="content" source="../media/select-workloads.png" alt-text="Screenshot of how to select .NET Desktop development and Universal Windows Platform development (for HoloLens) in Visual Studio 2019." lightbox="../media/select-workloads.png":::

4. When you click "Install," Visual Studio will proceed with downloading and installing the features you've specified. Visual Studio is a huge application that could take several minutes to download and install depending on your internet connection. You may be requested to restart your computer once the installation process is complete. By launching Visual Studio after restarting, you may verify that the installation was successful. Depending on your Visual Studio edition, the welcome screen should look like the one shown in below image when you first open it.

    :::image type="content" source="../media/test-visual-studio.png" alt-text="Screenshot of testing the visual studio launcher." lightbox="../media/test-visual-studio.png":::

## Enable developer mode

Enabling Developer Mode in UWP/Hololens & Windows PC makes it easier to test the applications you're working on. In addition, you can install UWP &Windows apps from outside the Windows Store, even if they're not signed with a valid certificate. This is an essential feature for UWP app developers who want to test their apps on their PCs while still developing.

### Steps to enable developer mode for HoloLens

1. Switch on your HoloLens and put it on. Then, access the main menu by using the start gesture.
2. To start the app in your environment, select the **Settings** tile.
3. Select the **Update and Security** option from the menu.

    :::image type="content" source="../media/hololens-update-and-security.png" alt-text=" The screenshot of Update & Security menu item." lightbox="../media/hololens-update-and-security.png":::
4. Select the menu item **For developers**.
5. Enable **Use developer features** to deploy apps from Visual Studio to your HoloLens. If your device is running Windows Holographic version 21H1 or newer, also enable **Device discovery**.
6. Optional: Scroll down and enable Device Portal, which allows you to connect to your HoloLens' Windows **Device Portal** from a web browser.

    :::image type="content" source="../media/enable-developer-mode-hololens.png" alt-text="Screenshot shows enabling the Developer mode." lightbox="../media/enable-developer-mode-hololens.png":::

### Steps to enable developer mode for Windows PC

If you're using a Windows Mixed Reality headset with your PC, you'll have to enable Developer Mode on your computer.

1. Go to **Settings** menu.

    :::image type="content" source="../media/setting-menu.png" alt-text="Screenshot of Click the setting menu." lightbox="../media/setting-menu.png":::
2. Select **Update and Security**.

    :::image type="content" source="../media/update-and-security.png" alt-text="Screenshot of Select “Update and Security” menu item" lightbox="../media/update-and-security.png":::
3. Select **For developers**.

    :::image type="content" source="../media/for-developers-option.png" alt-text="Screenshot of Select “For developers” option" lightbox="../media/for-developers-option.png":::
4. Enable **Developer Mode**, read the disclaimer for the selected setting, and then accept the change by selecting Yes.

    :::image type="content" source="../media/enable-developer-mode.png" alt-text="Screenshot of On the toggle button to enable “Developer Mode” " lightbox="../media/enable-developer-mode.png":::

## StereoKit’s visual studio template

It's one of the quickest methods to get a StereoKit project started. There are two templates provided: one for Universal Windows Platform and the other for .NET Core. If you're deploying on HoloLens 2 platform, use UWP; if you're developing for a desktop Windows or Linux environment, use .NET Core. Iteration is slower with UWP because it builds apps, so use it only if HoloLens is essential to you.

### Steps to download & install StereoKit’s visual studio template

1. Download the StereoKit templates from [StereoKit Templates - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=NickKlingensmith.StereoKitTemplates).

    :::image type="content" source="../media/.png" alt-text="” " lightbox="../media/.png":::
2. Open the downloaded file & click on **Install** button.

    :::image type="content" source="../media/.png" alt-text="” " lightbox="../media/.png":::
3. Click **close** in the pop up once the installation is complete.

    :::image type="content" source="../media/.png" alt-text="” " lightbox="../media/.png":::

> [!Note]
    > You may also install the [NuGet package](https://www.nuget.org/packages/StereoKit) directly into your project.