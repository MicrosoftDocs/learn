The first step to set up a project on immersive experience for Windows Mixed Reality using the StereoKit requires the following software list.
Here you'll create a new StereoKit project and configure it for Windows Mixed Reality development.

## Prerequisite softwares to build StereoKit project

* **Visual Studio 2019 - the Community version**

Visual Studio is mainly responsible for creating and modifying the app's code, but it can also test and debug the app on a Mixed Reality headset.

**Installing Visual Studio**

1. You can download the free edition of Visual Studio, often known as "Visual Studio Community," if you don't already have a Visual Studio membership. Figure 1-9 represents how the download button may appear.
If you already have a Visual Studio subscription. You can download Visual Studio at the following link: https://developer.microsoft.com/en-us/windows/downloads [SS]
2. Save the Visual Studio installer to your preferred location. After the download is complete, you can start the installation process by running the Visual Studio installer. SS shows how the installation appears in the Microsoft Edge browser when you execute it. [SS]
3. When you run the Visual Studio installation, you'll see a few seconds of initialization followed by a feature selection option, as shown in (SS). Select the ".NET Desktop development and Universal Windows Platform development (for HoloLens)" checkbox in Visual Studio 2019's features list. After making the necessary selections, click "Next" or "Install."[SS]
4. Visual Studio will begin downloading and installing your selected features when you click "Install." Visual Studio is a huge application that could take several hours to download and install depending on your internet connection. Be prepared for a lengthy installation process! You may be requested to restart your computer after the installation is complete. By launching Visual Studio after restarting, you may verify that the installation was successful. Depending on your Visual Studio edition, the welcome screen should look like the one shown in SS when you first open it.[SS]

* **Enable Developer Mode (for UWP/HoloLens)**
Enable Developer Mode (for UWP/HoloLens) helps to deploy the application using Visual Studio.

**HoloLens**

1. Switch on your HoloLens and put it on. Then, access the main menu by using the start gesture.
2. To start the app in your environment, select the **Settings** tile.
3. Select the **Update** option from the menu.
4. Select the menu item **For developers**.
5. Enable To deploy programs from Visual Studio to your HoloLens, use developer features. Also, Enable **Device discovery** if your device is running Windows Holographic version 21H1 or newer.
6. Optional: Scroll down and enable Device Portal, which allows you to connect to your HoloLens' Windows **Device Portal** from a web browser.

**Windows PC**
If you're using a Windows Mixed Reality headset with your PC, you'll have to enable Developer Mode on the computer.

1. Go to the **Settings** menu.
2. Select Update and Security.
3. Select **For developers**.
4. Enable **Developer Mode**, read the disclaimer for the selected setting, and then accept the change by selecting Yes.






