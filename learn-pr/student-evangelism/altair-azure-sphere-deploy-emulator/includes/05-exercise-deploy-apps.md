In this exercise, you'll deploy two real-time applications to your Azure Sphere.

You can either deploy the prebuilt real-time packages to the Azure Sphere or you can compile and deploy your own.

## Deploy the prebuilt real-time packages

1. If you're using Windows, open a Windows **PowerShell command line**. If you're using Linux, open **Terminal**.
1. Navigate to the folder you cloned the **Altair8800Emulator** repo into.
1. Navigate to the **AltairRT_imagepackages** folder.

## Deploy the virtual disk cache server

Deploy the virtual disk cache server unless you have an Avnet Azure Sphere Rev 2 developer board and the MikroE microSD Click.

1. Deploy the **AltairRT_disk_cache_server.imagepackage** package to your Azure Sphere.

   ```bash
   azsphere device sideload deploy --image-package AltairRT_disk_cache_server.imagepackage
   ```

## Deploy the SD Card server

Deploy the SD Card server if you have an Avnet Azure Sphere **Rev 2** developer board and the MikroE microSD Click.

```bash
azsphere device sideload deploy --image-package AltairRT_sd_card_server.imagepackage
```

## Optional

For reference, the source code for the disk cache and environment monitor real-time applications are found in the following folder locations of the Altair emulator repo.

|Project | Location|
|----|----|
| Altair emulator virtual disk cache server  | AltairRT_disk_cache_server |
| Altair emulator SD Card server   | AltairRT_disk_cache_server |

You can build and deploy the real-time applications to the Azure Sphere from Visual Studio Code.

1. Start Visual Studio Code.
1. Select **Open folder**.
1. Open the **Altair8800Emulator** folder you cloned to your computer.
1. Open the **AltairRT_disk_cache_server** folder.
1. Select **Select Folder** or the **OK** button to open the project.

### Set Release mode

For the virtual disk cache server, you **must** set the project to **Release** mode. Release mode tells the C compiler to optimize code generation for speed. Release mode is required so the real-time cache server responds to cache lookup requests from the high-level application within the expected time frame.

1. Press <kbd>F1</kbd>.
1. Type **cmake: Select Variant**.
1. Select **Release**.

### Deploy the real-time cache server

1. Press <kbd>Ctrl+F5</kbd> to compile and deploy the application to the Azure Sphere.
