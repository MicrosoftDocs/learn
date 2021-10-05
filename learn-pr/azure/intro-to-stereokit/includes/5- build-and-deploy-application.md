## Build and deploy
​
The build is the most commonly used feature in the Visual Studio community. As a developer, you write the code, build and run the application.

Deployment is the process of installing, configuring, and enabling a specific application or set of applications.
​
## Build your application on Desktop with StereoKit

During the build process, you may encounter errors when opening the Solution Explorer and the C# program file. To debug the
errors, run the initial build solution.

1. To bulid the application to desktop, configure Visual Studio for desktop by clicking onto "Solution Configuration" ensure the
Debug and Any device is selected.
:::image type="content" source="../media/change-solution-configuration.png" alt-text="Screenshot shows changing of Solution configuration." lightbox="../media/change-solution-configuration.png":::
​
2. Click on the Device dropdown and ensure the projectsetup-desktop is selected.(ss)

3. Then in the menu bar click on the Debug > Start Debugging.
Start Debugging automatically starts the application on your device with the Visual Studio debugger attached.(ss)

## Build your application on HoloLens 2 with StereoKit
​
During the build process, you may encounter errors when opening the Solution Explorer and the C# program file. To debug the
errors, run the initial build solution.

1. To build the application to hololens, configure Visual Studio for HoloLens by selecting the Release configuration on the "Solution Platform," the ARM64 architecture, and set Device as target: (Ss)

2. Connect your hololens to your computer, then in the menu bar click on the Debug > Start Debugging.
Start Debugging automatically starts the application on your device with the Visual Studio debugger attached.(ss)

3. In the menu bar click on the Build > Deploy Solution to deploy to your device without having the app start automatically.(ss)
