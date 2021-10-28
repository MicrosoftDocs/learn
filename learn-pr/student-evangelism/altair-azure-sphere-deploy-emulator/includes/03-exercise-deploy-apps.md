In this exercise, you'll deploy Altair emulator disk services to your Azure Sphere.

You will deploy prebuilt real-time packages to the Azure Sphere.

## Deploy the prebuilt real-time packages (recommended)

1. If you're using Windows, open a Windows **PowerShell command line**. If you're using Linux, open **Terminal**.
1. Navigate to the folder you cloned the **Altair8800Emulator** repo into.
1. Navigate to the **AltairRT_imagepackages** folder.

## Avnet Azure Sphere Starter Kit with the MikroE microSD Click

If you have an Avnet Azure Sphere Starter Kit and the MikroE microSD Click, then deploy the SD Card service.

You will need a Micro SD Card.

- The Micro SD Card capacity must be at least 10 Megabytes.
- The existing contents of the SD Card will be destroyed by the formatting process.
- Insert an SD Card into the MikroE microSD Card Click.

The following steps prepare the Micro SD Card for use with the Altair emulator. Drive A: is formatted to boot CP/M, and also includes utilities plus compilers. Drive B: is used to save your files and is formatted to be blank.

- For the Avnet Azure Sphere Starter Kit Rev 1, deploy:

    ```bash
    azsphere device sideload deploy --image-package AltairRT_sd_card_service_avnet_rev_1.imagepackage
    ```

- For the Avnet Azure Sphere Starter Kit Rev 2, deploy:

    ```bash
    azsphere device sideload deploy --image-package AltairRT_sd_card_service_avnet_rev_2.imagepackage
    ```

1. Format the A: drive
    - Deploy the following application image.

        ```bash
        azsphere device sideload deploy --image-package AltairHL_sd_card_format_a.imagepackage
        ```

    - Press **Button A** on the Avnet Azure Sphere. The status LED will turn green while formatting. The status LED will turn off when the formatting is complete. The status LED will turn red to indicate formatting failed. If formatting fails, try another SD Card.

1. Format the B: drive.
    - Deploy the following application image.

        ```bash
        azsphere device sideload deploy --image-package AltairHL_sd_card_format_b.imagepackage
        ```

    - Press **Button A** on the Avnet Azure Sphere. The status LED will turn green while formatting. The status LED will turn off when the formatting is complete. The status LED will turn red to indicate formatting failed. If formatting fails, try another SD Card.

## Deploy the virtual disk cache service

Skip this step is you have the Avnet Azure Sphere Starter Kit and the MikroE microSD Click.

Deploy the virtual disk cache service. The virtual disk cache service improves the performance of the virtual disk server.

1. Deploy the **AltairRT_disk_cache_service.imagepackage** package to your Azure Sphere.

   ```bash
   azsphere device sideload deploy --image-package AltairRT_disk_cache_service.imagepackage
   ```

## SD Card and virtual disk cache service software

You can build and deploy the disk applications to the Azure Sphere from Visual Studio Code. For reference, the source code is listed in the following table.

|Project | Location|
|----|----|
| Altair emulator disk cache service  | AltairRT_disk_cache_service |
| Altair emulator SD Card service   | AltairRT_disk_cache_service |
| Altair emulator drive A: formatter | AltairHL_sd_card_format_drive_a |
| Altair emulator drive B: formatter   | AltairHL_sd_card_format_drive_b |

### Compiling the virtual disk cache service

If you choose to compile the virtual disk cache service, you **must** set the project to **Release** mode. Release mode tells the C compiler to optimize code generation for speed. Release mode is required so the real-time cache service responds to cache lookup requests from the high-level Altair emulator application within the expected time frame.

