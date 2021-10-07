In the pervious chapters you learnt how to download the template, import the package and 3D models. Now in this chapter lets learn how to build and test your application on HoloLens 2.

## Build your application on HoloLens

1. To build your application to hololens, configure Visual Studio for HoloLens by selecting the **Release** configuration on the "Solution Platform," the **ARM64** architecture, and set **Device** as target:
  
    :::image type="content" source="../media/configuration-solution-platform.png" alt-text="Screenshot shows Configuration of Solution platform." lightbox="../media/configuration-solution-platform.png":::

2. Connect your HoloLens 2 to your computer, then in the menu bar click on the **Debug** > **Start Debugging**.
  Start Debugging automatically starts the application on your device with the Visual Studio debugger attached.
  
   :::image type="content" source="../media/start-debug.png" alt-text="Screenshot shows Selecting of Start Debugging." lightbox="../media/start-debug.png":::

3. In the menu bar click on the **Build** > **Deploy Solution** to deploy to your device without having the app start automatically.
  
    :::image type="content" source="../media/select-deploy-solution.png" alt-text="Screenshot shows Selecting of Deploy Solution." lightbox="../media/select-deploy-solution.png":::

## Build your application on desktop

During the build process, you may encounter errors when opening the Solution Explorer and the C# program file. To debug the errors, run the initial build solution.

1. To bulid your application to desktop, configure Visual Studio for desktop by clicking onto "Solution Configuration" ensure the **Debug** and **Any device** is selected.
  
    :::image type="content" source="../media/change-solution-configuration.png" alt-text="Screenshot shows changing of Solution configuration." lightbox="../media/change-solution-configuration.png":::

2. Click on the Device dropdown and ensure the **StereoKitInk** is selected.
  
    :::image type="content" source="../media/ensure-project-setup-desktop.png" alt-text="Screenshot shows ensuring of projectsetup desktop is selected." lightbox="../media/ensure-project-setup-desktop.png":::

3. Then in the menu bar click on the **Debug** > **Start Debugging**.
  Start Debugging automatically starts the application on your device with the Visual Studio debugger attached.
  
    :::image type="content" source="../media/select-start-debug.png" alt-text="Screenshot shows Selecting of Start Debugging." lightbox="../media/select-start-debug.png":::