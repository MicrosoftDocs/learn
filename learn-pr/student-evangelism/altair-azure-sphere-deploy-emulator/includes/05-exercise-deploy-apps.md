In this exercise, you will deploy two real-time applications to your Azure Sphere.

You can either deploy the prebuilt real-time packages to the Azure Sphere or you can compile and deploy your own.

## Deploy the prebuilt real-time packages

1. If you're using Windows, open a Windows **PowerShell command line**. If you're using Linux, open **Terminal**.
1. Navigate to the folder you cloned the **Cloud-Enabled-Altair-on-Azure-Sphere** repo into.
1. Navigate to the **AltairRT_imagepackages** folder.
1. Deploy the **AltairRT_disk_cache_server.imagepackage** package to your Azure Sphere.

   ```bash
   azsphere device sideload deploy --image-package AltairRT_disk_cache_server.imagepackage
   ```

1. Deploy the Environment Monitor real-time application.

    1. For Avnet starter kits, deploy the **AltairRT_enviromon.avnet.imagepackage** package as it has support for the onboard environment sensors.

        * If you're using the MikroE Altair 8800 Retro Click board, then deploy the following image.

            ```bash
            azsphere device sideload deploy --image-package AltairRT_enviromon.generic.imagepackage
            ```

        * Otherwise, deploy the following image.

            ```bash
            azsphere device sideload deploy --image-package AltairRT_enviromon.avnet.imagepackage
            ```

    1. For the Seeed Studio developer kit, deploy the **AltairRT_enviromon.generic.imagepackage** package. This package generates random environment data as there are no onboard sensors.

        ```bash
        azsphere device sideload deploy --image-package AltairRT_enviromon.generic.imagepackage
        ```

## Optional

For reference, the source code for the disk cache and environment monitor real-time applications are found in the following folder locations of the Altair emulator repo.

|Project | Location|
|----|----|
| Altair emulator virtual disk cache server  | AltairRT_disk_cache_server |
| Altair emulator environment monitor   | AltairRT_enviromon |

You can build and deploy the real-time applications to the Azure Sphere from Visual Studio Code.

1. Start Visual Studio Code.
1. Select **Open folder**.
1. Open the **Cloud-Enabled-Altair-on-Azure-Sphere** folder you cloned or downloaded.
1. Open the **AltairRT_disk_cache_server** folder.
1. Select **Select Folder** or the **OK** button to open the project.

### Set Release mode

For the virtual disk cache server, you **must** set the project to **Release** mode. Release mode tells the C compiler to optimize code generation for speed. Release mode is required so the real-time cache server responds to cache lookup requests from the high-level application within the expected time frame.

1. Press <kbd>F1</kbd>.
1. Type **cmake: Select Variant**.
1. Select **Release**.

### Deploy the real-time cache server

1. Press <kbd>Ctrl+F5</kbd> to compile and deploy the application to the Azure Sphere.

## Deploy the AltairRT environment monitor project

1. Start Visual Studio Code.
1. Select **Open folder**.
1. Open the **Cloud-Enabled-Altair-on-Azure-Sphere** folder you cloned or downloaded.
1. Open the **AltairRT_enviromon** folder.
1. Select **Select Folder** or the **OK** button to open the project.

### Set Release mode

1. Set the project to **Release** mode.
    1. Press <kbd>F1</kbd>.
    1. Type **cmake: Select Variant**.
    1. Select **Release**.
1. Press <kbd>F1</kbd>.
1. Type **cmake: Select Variant**.
1. Select **Release**.

### Deploy the real-time cache server

1. Press <kbd>Ctrl+F5</kbd> to compile and deploy the application to the Azure Sphere.
