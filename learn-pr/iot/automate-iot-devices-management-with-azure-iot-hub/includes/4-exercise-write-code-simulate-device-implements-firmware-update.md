At the end of this unit, you'll have a device simulator awaiting for a firmware update request from IoT Hub.

## Create the device simulator app

1. In the following we will be using the sandbox with the Azure Shell, but you can use Visual Studio Code on your local machine to do the same. If you decide to use Visual Studio Code locally, you need to ensure both [.NET Core](https://dotnet.microsoft.com/download), and the [C# extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.csharp) are installed.

1. In the Azure Shell terminal, create a folder called **fwupdatedevice** and navigate to it:

    ```bash
    mkdir fwupdatedevice
    cd fwupdatedevice

    ```
    
1. Enter the below commands in the terminal. The first command creates a **Program.cs** file in your folder, along with a project file and the second one gives your app access to the required .NET packages.

    ```bash
    dotnet new console
    dotnet restore

    ```

1. In the terminal, install the required libraries using the following commands:

    ```bash
    dotnet add package Microsoft.Azure.Devices.Client
    dotnet add package Microsoft.Azure.Devices.Shared
    dotnet add package Newtonsoft.Json

    ```

At this point, your project is ready for coding.

## Add code to your app

1. Open the **Program.cs** file for the device app typing the following command in the Azure shell:

    ```bash
    code Program.cs

    ```

1. Delete all the content form the document.

1. Copy and paste the following code.

    ```cs
    // Copyright (c) Microsoft. All rights reserved.
    // Licensed under the MIT license. See LICENSE file in the project root for full license information.

    using Microsoft.Azure.Devices.Shared;
    using Microsoft.Azure.Devices.Client;
    using System;
    using System.Threading.Tasks;
    
    namespace fwupdatedevice
    {
        class SimulatedDevice
        {
            // The device connection string to authenticate the device with your IoT hub.
            static string s_deviceConnectionString = "";
    
            // Device ID variable
            static string DeviceID="unknown";
    
            // Firmware version variable
            static string DeviceFWVersion = "1.0.0";
    
            // Simple console log function
            static void LogToConsole(string text)
            {
                // we prefix the logs with the device ID
                Console.WriteLine(DeviceID + ": " + text);
            }
    
            // Function to retreive firmware version from the OS/HW
            static string GetFirmwareVersion()
            {
                // In here you would get the actual firmware version from the hardware. For the simulation purposes we will just send back the FWVersion variable value
                return DeviceFWVersion;
            }
    
            // Function for updating a device twin reported property to report on the current Firmware (update) status
            // Here are the values expected in the "firmware" update property by the firmware update configuration in IoT Hub
            //  currentFwVersion: The firmware version currently running on the device.
            //  pendingFwVersion: The next version to update to, should match what's
            //                    specified in the desired properties. Blank if there
            //                    is no pending update (fwUpdateStatus is 'current').
            //  fwUpdateStatus:   Defines the progress of the update so that it can be
            //                    categorized from a summary view. One of:
            //         - current:     There is no pending firmware update. currentFwVersion should
            //                    match fwVersion from desired properties.
            //         - downloading: Firmware update image is downloading.
            //         - verifying:   Verifying image file checksum and any other validations.
            //         - applying:    Update to the new image file is in progress.
            //         - rebooting:   Device is rebooting as part of update process.
            //         - error:       An error occurred during the update process. Additional details
            //                    should be specified in fwUpdateSubstatus.
            //         - rolledback:  Update rolled back to the previous version due to an error.
            //  fwUpdateSubstatus: Any additional detail for the fwUpdateStatus . May include
            //                     reasons for error or rollback states, or download %.
            //
            // reported: {
            //       firmware: {
            //         currentFwVersion: '1.0.0',
            //         pendingFwVersion: '',
            //         fwUpdateStatus: 'current',
            //         fwUpdateSubstatus: '',
            //         lastFwUpdateStartTime: '',
            //         lastFwUpdateEndTime: ''
            //   }
            // }

            static async Task UpdateFWUpdateStatus(DeviceClient client, string currentFwVersion, string pendingFwVersion, string fwUpdateStatus, string fwUpdateSubstatus, string lastFwUpdateStartTime, string lastFwUpdateEndTime)
            {
                TwinCollection properties = new TwinCollection();
                if (currentFwVersion!=null)
                    properties["currentFwVersion"] = currentFwVersion;
                if (pendingFwVersion!=null)
                    properties["pendingFwVersion"] = pendingFwVersion;
                if (fwUpdateStatus!=null)
                    properties["fwUpdateStatus"] = fwUpdateStatus;
                if (fwUpdateSubstatus!=null)
                    properties["fwUpdateSubstatus"] = fwUpdateSubstatus;
                if (lastFwUpdateStartTime!=null)
                    properties["lastFwUpdateStartTime"] = lastFwUpdateStartTime;
                if (lastFwUpdateEndTime!=null)
                    properties["lastFwUpdateEndTime"] = lastFwUpdateEndTime;
    
                TwinCollection reportedProperties = new TwinCollection();
                reportedProperties["firmware"] = properties;
    
                await client.UpdateReportedPropertiesAsync(reportedProperties).ConfigureAwait(false);
            }
            
            // Execute firmware update on the device
            static async Task UpdateFirmware(DeviceClient client, string fwVersion, string fwPackageURI, string fwPackageCheckValue)
            {
                LogToConsole("A firmware update was requested from version " + GetFirmwareVersion() + " to version " + fwVersion);
                await UpdateFWUpdateStatus(client, null, fwVersion, null, null, DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ssZ"), null);
    
                // Get new firmware binary. Here you would download the binary or retreive it from the source as instructed for your device, then double check with a hash the integrity of the binary you downloaded 
                LogToConsole("Downloading new firmware package from " + fwPackageURI);
                await UpdateFWUpdateStatus(client, null, null, "downloading", "0", null, null);
                await Task.Delay(2 * 1000);
                await UpdateFWUpdateStatus(client, null, null, "downloading", "25", null, null);
                await Task.Delay(2 * 1000);
                await UpdateFWUpdateStatus(client, null, null, "downloading", "50", null, null);
                await Task.Delay(2 * 1000);
                await UpdateFWUpdateStatus(client, null, null, "downloading", "75", null, null);
                await Task.Delay(2 * 1000);
                await UpdateFWUpdateStatus(client, null, null, "downloading", "100", null, null);
                // report the binary has been downloaded
                LogToConsole("The new firmware package has been successfully downloaded.");
                
                // Check binary integrity
                LogToConsole("Verifying firmware package with checksum " + fwPackageCheckValue);
                await UpdateFWUpdateStatus(client, null, null, "verifying", null, null, null);
                await Task.Delay(5 * 1000);
                // report the binary has been downloaded
                LogToConsole("The new firmware binary package has been successfully verified");
    
                // Apply new firmware
                LogToConsole("Applying new firmware");
                await UpdateFWUpdateStatus(client, null, null, "applying", null, null, null);
                await Task.Delay(5 * 1000);
    
                // On a real device you would reboot at the end of the process and the device at boot time would report the actual firmware version, which if successfull should be the new version.
                // For the sake of the simulation, we will simply wait some time and report the new firmware version
                LogToConsole("Rebooting");
                await UpdateFWUpdateStatus(client, null, null, "rebooting", null, null, DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ssZ"));
                await Task.Delay(5 * 1000);
    
                // On a real device you would issue a command to reboot the device. Here we are simply runing the init function
                DeviceFWVersion = fwVersion;
                await InitDevice(client);
    
            }
    
            // Callback for responding to desired property changes 
            static async Task OnDesiredPropertyChanged(TwinCollection desiredProperties, object userContext)
            {
                LogToConsole("Desired property changed:");
                LogToConsole($"{desiredProperties.ToJson()}");
    
                // Execute firmware update
                if (desiredProperties.Contains("firmware") && (desiredProperties["firmware"]!=null))
                {
                    // In the desired properties, we will find the following information:
                    // fwVersion: the version number of the new firmware to flash
                    // fwPackageURI: URI from where to download the new firmware binary
                    // fwPackageCheckValue: Hash for validating the integrity of the binary  downloaded
                    // We will assume the version of the firmware is a new one
                    TwinCollection fwProperties = new TwinCollection(desiredProperties["firmware"].ToString());
                    await UpdateFirmware((DeviceClient)userContext, fwProperties["fwVersion"].ToString(), fwProperties["fwPackageURI"].ToString(), fwProperties["fwPackageCheckValue"].ToString());
    
                }
            }
    
            static async Task InitDevice(DeviceClient client)
            {
                LogToConsole("Device booted");
                LogToConsole("Current firmware version: " + GetFirmwareVersion());
                await UpdateFWUpdateStatus(client, GetFirmwareVersion(), "", "current", "", "", "");
            }
    
            static async Task Main(string[] args)
            {
                // Get the device connection string from the command line
                if (string.IsNullOrEmpty(s_deviceConnectionString) && args.Length > 0)
                {
                    s_deviceConnectionString = args[0];
                } else
                {
                    Console.WriteLine("Please enter the connection string as argument.");
                    return;
                }
    
                DeviceClient deviceClient = DeviceClient.CreateFromConnectionString(s_deviceConnectionString, TransportType.Mqtt);
    
                if (deviceClient == null)
                {
                    Console.WriteLine("Failed to create DeviceClient!");
                    return;
                }
    
                // Get the device ID 
                string[] elements = s_deviceConnectionString.Split('=',';');
    
                for(int i=0;i<elements.Length; i+=2)
                {
                    if (elements[i]=="DeviceId") DeviceID = elements[i+1];
                }
    
                // Run device init routine
                await InitDevice(deviceClient);
    
                // Attach callback for Desired Properties changes
                await deviceClient.SetDesiredPropertyUpdateCallbackAsync(OnDesiredPropertyChanged, deviceClient).ConfigureAwait(false);
    
                // Wait for keystroke to end app
                // TODO
                while (true)
                {
                    string line = Console.ReadLine();
                    if (line=="q")
                        return;
                }
            }
        }
    }
        
    ```

    > [!NOTE]
    > Read through the comments in the code, noting how the device reacts to device twin changes to execute a firmware update based on the configuration shared in the desired Property "firmware". You can also note the function that will report the current firmware update status through the reported properties of the device twin.


1. Save the **Program.cs** file and close the editor (to close the editor, find the ellipse "..." menu on the right-hand side of the editor).

Your device is now ready to be managed from IoT Hub. In the next unit, we will test that the firmware update process works as expected for this simulated device.
