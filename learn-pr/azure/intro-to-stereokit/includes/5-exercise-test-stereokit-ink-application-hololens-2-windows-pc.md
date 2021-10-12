In the previous chapter, you have learned how the StereoKitInk application is developed and configured. Now in this chapter, you will learn how to build and test StereoKitInk application on HoloLens 2 and Desktop.

During the build process, you may encounter errors when opening the Solution Explorer and the C# program file. In order to debug the errors, you need to run the initial build solution.

## Build your application on HoloLens 2

1. To build your application to HoloLens 2, configure Visual Studio for HoloLens 2 by selecting the **Release** configuration on the "Solution Platform," the **ARM64** architecture, and set **Device** as target:
  
    :::image type="content" source="../media/configuration-solution-platform.png" alt-text="Screenshot shows configuration of solution platform." lightbox="../media/configuration-solution-platform.png":::

2. Connect your HoloLens 2 to your computer, then in the menu bar click on the **Debug** > **Start Debugging**.
  Start Debugging automatically starts the application on your device with the Visual Studio debugger attached.
  
   :::image type="content" source="../media/start-debug.png" alt-text="Screenshot shows selectings of Start Debugging." lightbox="../media/start-debug.png":::

3. In the menu bar click on the **Build** > **Deploy Solution** to deploy to your device without having the app start automatically.
  
    :::image type="content" source="../media/select-deploy-solution.png" alt-text="Screenshot shows Selecting of Deploy Solution." lightbox="../media/select-deploy-solution.png":::

## Build your application on Desktop

1. To build your application to Desktop, configure Visual Studio for Desktop by clicking onto "Solution Configuration" ensure the **Debug** and **Any device** is selected.
  
    :::image type="content" source="../media/change-solution-configuration.png" alt-text="Screenshot shows changing of Solution configuration." lightbox="../media/change-solution-configuration.png":::

2. Click on the Device dropdown and ensure the **StereoKitInk** is selected.
  
    :::image type="content" source="../media/ensure-project-setup-desktop.png" alt-text="Screenshot shows ensuring of project setup desktop is selected." lightbox="../media/ensure-project-setup-desktop.png":::

3. Then in the menu bar click on the **Debug** > **Start Debugging**.
  Start Debugging automatically starts the application on your device with the Visual Studio debugger attached.
  
    :::image type="content" source="../media/select-start-debug.png" alt-text="Screenshot shows Selecting of Start Debugging." lightbox="../media/select-start-debug.png":::
