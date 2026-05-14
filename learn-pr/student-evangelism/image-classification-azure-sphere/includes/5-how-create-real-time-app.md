To create a new real-time application, start with the current [HelloWorld_RTApp_MT3620_BareMetal sample](https://github.com/Azure/azure-sphere-samples/tree/main/Samples/HelloWorld/HelloWorld_RTApp_MT3620_BareMetal) and adjust the copy for this project. The sample already contains the current Azure Sphere RTApp build structure: `CMakePresets.json` with `ARM-Debug` and `ARM-Release` presets, `CMakeLists.txt` with `azsphere_target_add_image_package(${PROJECT_NAME})`, and an `app_manifest.json` file for a `RealTimeCapable` application. You'll use Visual Studio Code for this module.

Before opening the RTApp project, make sure the required tools are installed:

- **Azure Sphere SDK and Azure Sphere extension for Azure CLI:** The SDK installer sets `AzureSphereDefaultSDKDir`, which the Azure Sphere CMake presets use to find the RTCore toolchain file.
- **GNU Arm Embedded Toolchain (arm-none-eabi):** RTApps build for the Cortex-M4 real-time cores. Visual Studio Code normally discovers the toolchain. You can also install it with vcpkg artifacts. If discovery fails, set both the Visual Studio Code **Azure Sphere: Arm Gnu Path** setting and the sample's `ArmGnuPath` environment variable to the GNU Arm toolchain installation root, such as `C:\Program Files (x86)\GNU Arm Embedded Toolchain\10 2020-q4-major` on Windows, not the `bin` subdirectory. The Azure Sphere RTCore CMake toolchain file appends `/bin/<compiler>` automatically, so pointing at `bin` causes a `bin/bin/...` lookup failure. Don't point either value at an Azure Sphere SDK sysroot.
- **Visual Studio Code extensions:** Azure Sphere, C/C++, and CMake Tools.
- **Build tools:** Git, CMake, and Ninja.

You use the following components:

- **Azure Sphere samples repository:** This repository contains samples for the Azure Sphere platform.

- **HelloWorld_RTApp_MT3620_BareMetal:** This sample demonstrates how to create, deploy, and run MT3620 real-time capable applications. In this unit, you'll make a copy of this project and modify it as required.

- **Visual Studio Code:** You use Visual Studio Code as the development environment for the IoT device.

The steps you'll follow:

1. Clone the [Azure Sphere samples repository](https://github.com/Azure/azure-sphere-samples).
2. Create a new project based on [HelloWorld_RTApp_MT3620_BareMetal](https://github.com/Azure/azure-sphere-samples/tree/main/Samples/HelloWorld/HelloWorld_RTApp_MT3620_BareMetal).
3. Generate a new GUID/UUID for the copied application and update the copy's `app_manifest.json`.
4. Adjust the project name and manifest configuration in the copied project.
5. Open the copied project in Visual Studio Code, select the `ARM-Debug` CMake preset, and reconfigure CMake after configuration changes.

After completing this unit, you'll be able to create a real-time application. You'll update the source code and the configuration for your real-time image classification application in the next step.
