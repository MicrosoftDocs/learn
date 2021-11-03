In the previous chapter, you have learned how the StereoKit Ink application is developed and configured. In this chapter, you'll learn how to build and test the StereoKit Ink application on HoloLens 2 and Desktop.

You may encounter errors when opening the Solution Explorer and the C# program file during the build process. To debug the errors, you need to run the initial build solution.

## Build StereoKit Ink application on HoloLens 2

1. To build StereoKit Ink application to HoloLens 2, configure Visual Studio for HoloLens 2 by selecting the **Release** configuration on the "Solution Platform," the **ARM64** architecture, and set **Device** as target:
  
   :::image type="content" source="../media/configuration-solution-platform.png" alt-text="Screenshot shows configuration of solution platform." lightbox="../media/configuration-solution-platform.png":::

2. Connect your HoloLens 2 to your computer, then in the menu bar, click on the **Debug** > **Start Debugging**.
  Start Debugging automatically starts the application on your device with the Visual Studio debugger attached.
  
   :::image type="content" source="../media/start-debug.png" alt-text="Screenshot shows selectings of Start Debugging." lightbox="../media/start-debug.png":::

3. In the menu bar, click on the **Build** > **Deploy Solution** to deploy to your device without having the app start automatically.
  
   :::image type="content" source="../media/select-deploy-solution.png" alt-text="Screenshot shows Selecting of Deploy Solution." lightbox="../media/select-deploy-solution.png":::

4. As shown in the image below, the StereoKit Ink application is now available in HoloLens 2.
   :::image type="content" source="../media/hololens-2-stereokit-ink-application.png" alt-text="Screenshot shows the StereoKit Ink application on HoloLens 2." lightbox="../media/hololens-2-stereokit-ink-application.png":::

## Build StereoKit Ink application on Desktop

1. To build StereoKit Ink application to Desktop, configure Visual Studio for Desktop by clicking on "Solution Configuration" to ensure the **Debug** and **Any device** is selected.
  
   :::image type="content" source="../media/change-solution-configuration.png" alt-text="Screenshot shows changing of Solution configuration." lightbox="../media/change-solution-configuration.png":::

2. Click on the Device dropdown and ensure the **StereoKitInk** is selected.
  
   :::image type="content" source="../media/ensure-project-setup-desktop.png" alt-text="Screenshot shows ensuring of project setup desktop is selected." lightbox="../media/ensure-project-setup-desktop.png":::

3. Then, click on the **Debug** > **Start Debugging** in the menu bar.
  Start Debugging automatically starts the application on your device with the Visual Studio debugger attached.
  
   :::image type="content" source="../media/select-start-debug.png" alt-text="Screenshot shows Selecting of Start Debugging." lightbox="../media/select-start-debug.png":::

4. When the debugging is complete, the application will open on your desktop, and you'll be ready to draw.

   :::image type="content" source="../media/desktop-stereokit-ink-application.png" alt-text="Screenshot shows the StereoKit Ink application on Desktop." lightbox="../media/desktop-stereokit-ink-application.png":::

## Test StereoKit Ink application

Once the solution is deployed, you can see the StereoKit Ink application window pop-up on your target device, such as HoloLens 2 or desktop. You can see a UI with three operable components. The components present on the screen are the painting menu, palette menu, handle, and operating hand.

You may start interacting with the application using the fingertip of your right hand. Choose a color of your choice from the available six colors and can customize these colors by altering the Hue, Saturation, and Value properties. You can modify the size of brushstrokes using the slider. You may move around your painting using the handle.

You can use UI buttons in the painting menu to make changes to the drawing if necessary. Undo option removes the most recent to the painting, while the Redo option removes the most recent undo from the stack. Save the drawing in the system's preferred location by clicking the save button. The Load button lets you select any .skp file, while the clear button clears the painting stroke. Finally, the Quit button allows you to close the StereoKit Ink application window.
