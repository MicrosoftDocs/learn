The first step to set up a project on immersive experience for Windows Mixed Reality using the StereoKit requires Visual Studio 2019. 

## Steps to install visual studio for StereoKit

1. Download the free edition of Visual Studio Community and ensure to get the Visual Studio membership if you don't have it already.
Figure 1 shows how the download button might look.
If you have the Visual Studio subscription already, you can proceed to download Visual Studio by clicking on the provided following link: https://developer.microsoft.com/en-us/windows/downloads 
:::image type="content" source="../media/1.png" alt-text="Click on the “Free download” button for Visual Studio Community to begin your download." lightbox="../media/1.png":::

2. Save the Visual Studio installer to your desired path. Once the download is complete, you can start the installation process by running the Visual Studio installer. Figure 2 shows how the installation appears in the Microsoft Edge browser when you execute it.
:::image type="content" source="../media/2.png" alt-text="Unity Hub with New button highlighted." lightbox="../media/2.png":::

3. When you run the Visual Studio installation, you'll see a few seconds of initialization followed by a feature selection option, as shown in Figure 3. First, select the ".NET Desktop development and Universal Windows Platform development (for HoloLens)" checkbox in Visual Studio 2019's features list. Then, after making the required selections, click on "Next" or "Install.
:::image type="content" source="../media/3.png" alt-text="Select.NET Desktop development and Universal Windows Platform development (for HoloLens) in Visual Studio 2019. ." lightbox="../media/3.png":::

4. When you click "Install," Visual Studio will proceed with downloading and installing the features you've specified. Visual Studio is a huge application that could take several minutes to download and install depending on your stable internet connection. You may be requested to restart your computer once the installation process is complete. By launching Visual Studio after restarting, you may verify that the installation was successful. Depending on your Visual Studio edition, the welcome screen should look like the one shown in Figure 4 when you first open it.
:::image type="content" source="../media/4.png" alt-text="After the setup is complete, you may test if Visual Studio is installed correctly by launching it." lightbox="../media/4.png":::

## Enable developer mode (for UWP/HoloLens)

Enabling Developer Mode in UWP/Hololens makes it easier to test the applications you're working on. In addition, you can install UWP apps from outside the Windows Store, even if they're not signed with a valid certificate. This is an essential feature for UWP app developers who want to test their apps on their PCs while still developing.

## HoloLens

1. Switch on your HoloLens and put it on. Then, access the main menu by using the start gesture.
2. To start the app in your environment, select the **Settings** tile.
3. Select the **Update** option from the menu.
4. Select the menu item **For developers**.
5. Enable **Use developer features** to deploy apps from Visual Studio to your HoloLens. If your device is running Windows Holographic version 21H1 or newer, also enable **Device discovery**.
6. Optional: Scroll down and enable Device Portal, which allows you to connect to your HoloLens' Windows **Device Portal** from a web browser.

## Windows PC

If you're using a Windows Mixed Reality headset with your PC, you'll have to enable Developer Mode on your computer.

1. Go to **Settings** menu.
2. Select **Update and Security**.
3. Select **For developers**.
4. Enable **Developer Mode**, read the disclaimer for the selected setting, and then accept the change by selecting Yes.

## StereoKit’s visual studio template

It's one of the quickest methods to get a StereoKit project started. There are two templates provided: one for Universal Windows Platform and the other for .NET Core. If you're deploying on HoloLens 2 platform, use UWP; if you're developing for a desktop Windows or Linux environment, use .NET Core. Iteration is slower with UWP because it builds apps, so use it only if HoloLens is essential to you.

## Steps to install StereoKit’s visual studio template

1. Download the StereoKit templates from [StereoKit Templates - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=NickKlingensmith.StereoKitTemplates).
2. Click **close** once the download is completed.

*Note:*
 You may also install the [NuGet package](https://www.nuget.org/packages/StereoKit) directly into your project.
