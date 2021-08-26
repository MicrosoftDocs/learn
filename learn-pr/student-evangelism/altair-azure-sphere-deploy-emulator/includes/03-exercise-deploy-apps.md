In this exercise, you'll deploy two real-time applications to your Azure Sphere.

You can either deploy the prebuilt real-time packages to the Azure Sphere or you can compile and deploy your own.

## Deploy the prebuilt real-time packages

1. If you're using Windows, open a Windows **PowerShell command line**. If you're using Linux, open **Terminal**.
1. Navigate to the folder you cloned the **Altair8800Emulator** repo into.
1. Navigate to the **AltairRT_imagepackages** folder.

## Deploy the virtual disk cache server

Deploy the virtual disk cache server.

Skip this step is you have the Avnet Azure Sphere Rev 2 Starter Kit and the MikroE microSD Click.

1. Deploy the **AltairRT_disk_cache_server.imagepackage** package to your Azure Sphere.

   ```bash
   azsphere device sideload deploy --image-package AltairRT_disk_cache_server.imagepackage
   ```

## Avnet Azure Sphere Rev 2 Starter Kit with the MikroE microSD Click

Deploy the SD Card server if you have an Avnet Azure Sphere **Rev 2** Starter Kit and the MikroE microSD Click.

### Step 1: Insert Micro SD Card

Ensure you have inserted a SD Card into the MikroE microSD Card Click.

### Step 2: Deploy the SD Card server

```bash
azsphere device sideload deploy --image-package AltairRT_sd_card_server.imagepackage
```

### Step 3: Format the A: drive

1. Format the A: drive. Deploy the following application image.

    ```bash
    azsphere device sideload deploy --image-package AltairHL_sd_card_format_a.imagepackage
    ```

1. Press **Button A** on the Avnet Azure Sphere. The status LED will turn green while formatting. The status LED will turn off when the formatting is complete. The status LED will turn red to indicate formatting failed. If formatting fails, try another SD Card.

### Step 4: Format the B: drive

1. Format the B: drive. Deploy the following application image.

    ```bash
    azsphere device sideload deploy --image-package AltairHL_sd_card_format_b.imagepackage
    ```

1. Press **Button A** on the Avnet Azure Sphere. The status LED will turn green while formatting. The status LED will turn off when the formatting is complete. The status LED will turn red to indicate formatting failed. If formatting fails, try another SD Card.

## Optional

For reference, the source code for drive B: read/write support is listed in the table below.

|Project | Location|
|----|----|
| Altair emulator virtual disk cache server  | AltairRT_disk_cache_server |
| Altair emulator SD Card server   | AltairRT_disk_cache_server |
| Altair emulator drive A: formatter | AltairHL_sd_card_format_drive_a |
| Altair emulator drive B: formatter   | AltairHL_sd_card_format_drive_b |

You can build and deploy the real-time applications to the Azure Sphere from Visual Studio Code.

1. Start Visual Studio Code.
1. Select **Open folder**.
1. Open the **Altair8800Emulator** folder you cloned to your computer.
1. Open the appropriate folder.
1. Select **Select Folder** or the **OK** button to open the project.

### Set Release mode

For the virtual disk cache server, you **must** set the project to **Release** mode. Release mode tells the C compiler to optimize code generation for speed. Release mode is required so the real-time cache server responds to cache lookup requests from the high-level application within the expected time frame.

1. Press <kbd>F1</kbd>.
1. Type **cmake: Select Variant**.
1. Select **Release**.

### Deploy the real-time cache server

1. Press <kbd>Ctrl+F5</kbd> to compile and deploy the application to the Azure Sphere.

In the following you'll learn, you'll learn how to deploy the Altair emulator to your Azure Sphere.
