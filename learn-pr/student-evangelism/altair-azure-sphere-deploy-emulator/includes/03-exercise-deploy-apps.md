Use the following procedures to deploy Altair emulator disk services to Azure Sphere.

## Open the folder for prebuilt real-time packages

1. If you're using Windows, open a Windows PowerShell command line. If you're using Linux, open a terminal.
1. Go to the folder where you cloned the *Altair8800Emulator* repository.
1. Go to the *AltairRT_imagepackages* folder.

## Deploy the SD card service

If you have an Avnet Azure Sphere Starter Kit and the MikroE microSD Click, then deploy the SD card service.

For this procedure, you'll need a microSD card that has a capacity of at least 10 megabytes. 

> [!NOTE]
> The formatting process will destroy the existing contents of the SD card.

1. Insert the card into the MikroE microSD Click.

   The following steps prepare the microSD card for use with the Altair emulator. Drive A is formatted to boot CP/M, and it includes utilities plus compilers. Drive B is used to save your files and is formatted to be blank.

1. For the Avnet Azure Sphere Starter Kit Rev 1, deploy:

    ```bash
    azsphere device sideload deploy --image-package AltairRT_sd_card_service_avnet_rev_1.imagepackage
    ```

   For the Avnet Azure Sphere Starter Kit Rev 2, deploy:

    ```bash
    azsphere device sideload deploy --image-package AltairRT_sd_card_service_avnet_rev_2.imagepackage
    ```

1. Format drive A.
    1. Deploy the following application image:

        ```bash
        azsphere device sideload deploy --image-package AltairHL_sd_card_format_a.imagepackage
        ```

     1. Press **Button A** on the Avnet Azure Sphere device. The status LED will turn green during formatting. The status LED will turn off when formatting is complete. 
     
        If formatting fails, the status LED will turn red. Try another SD card.

1. Format drive B.
    1. Deploy the following application image:

        ```bash
        azsphere device sideload deploy --image-package AltairHL_sd_card_format_b.imagepackage
        ```

    1. Press **Button A** on the Avnet Azure Sphere device. The status LED will turn green during formatting. The status LED will turn off when formatting is complete. 
    
       If formatting fails, the status LED will turn red. Try another SD card.

## Deploy the virtual disk cache service

Skip this step if you have the Avnet Azure Sphere Starter Kit and the MikroE microSD Click.

The virtual disk cache service improves the performance of the virtual disk server. To deploy it, use the following command to deploy the *AltairRT_disk_cache_service.imagepackage* package to Azure Sphere:

```bash
azsphere device sideload deploy --image-package AltairRT_disk_cache_service.imagepackage
```

## Install software for the SD card and virtual disk cache services

You can build and deploy the disk applications to Azure Sphere from Visual Studio Code. Get the source code from these locations:

|Project | Location|
|----|----|
| Altair emulator disk cache service  | AltairRT_disk_cache_service |
| Altair emulator SD card service   | AltairRT_disk_cache_service |
| Altair emulator drive A formatter | AltairHL_sd_card_format_drive_a |
| Altair emulator drive B formatter   | AltairHL_sd_card_format_drive_b |

## Compile the virtual disk cache service

If you choose to compile the virtual disk cache service, you *must* set the project to Release mode. Release mode tells the C compiler to optimize code generation for speed. Release mode is required so that the real-time cache service responds to cache lookup requests from the high-level Altair emulator application within the expected time frame.

