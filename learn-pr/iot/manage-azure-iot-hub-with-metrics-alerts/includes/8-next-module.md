## Unit 1: Intro

An Azure IoT Hub can handle large volumes of telemetry data, sent from many sensor devices. You can individually set up each device, to be certain of its authenticity. However, with many devices, this task would be onerous to say the least. The process of validating the authenticity of a device is known as "provisioning". In this module, we investigate the IoT Device Provisioning Service (DPS). A service that enables the near-automatic provisioning of any number of devices.

This module builds on the [Remotely monitor and control devices with Azure IoT Hub](https://docs.microsoft.com/learn/modules/remotely-monitor-devices-with-azure-iot-hub/) module - a fun introduction to IoT Hub programming, using the example of a temperature and humidity sensor in a cheese cave. It isn't necessary to complete the introductory module before working on this module on security, though completing it will help your understanding of IoT Hub. The introductory module covers such concepts as _Device Twins_, and _Direct Methods_. These concepts aren't explained in detail in this module on security.

Security is a gnarly subject. However, it is more logical and understandable than you might think. Completing this module will give you a good foundation for making security decisions for your IoT-based projects.

## Learning objectives

In this module you will:

- Create a custom Azure IoT Hub, using the Azure portal
- Learn about device provisioning, X.509 certificates, and enrollments
- Create a DPS resource and a group enrollment, using the Azure portal
- Create an app to send device telemetry to your IoT Hub, using Visual Studio, or Visual Studio Code
- Test multiple devices are provisioned by your DPS resource

## Prerequisites

- An introductory knowledge of Azure IoT
- Ability to navigate the Azure IoT portal
- Ability to use C#, at the beginner level
- Experience using Visual Studio, or Visual Studio Code, at the beginner level

## The scenario

The [Remotely monitor and control devices with Azure IoT Hub](https://docs.microsoft.com/learn/modules/remotely-monitor-devices-with-azure-iot-hub/) module has one sensor in one cheese cave. The sensor ensures the cheese is maturing nicely to the ideal temperature and humidity for your particular brand.

Suppose you're the manager of the cheese cave maturing process. Your first cheese from the one cave has been a huge success. Your company has expanded rapidly and now has 30 cheese caves. Each cave is used to mature your best-selling cheese, but each cave is also in different locations throughout the country. Some of these caves provide near-ideal conditions without much involvement of a temperature/humidity setting fan. Other caves aren't so perfectly located, and require a fan to adjust the temperature and humidity, based on the telemetry output of a sensor.

If your cheese business carries on growing, you're going to need solutions that scale smoothly and effortlessly.

[![Conceptual art, showing the business of agriculture](../media/iot-hub-dps-art.png)](../media/iot-hub-dps-art.png#lightbox)

You decide on a single Azure IoT Hub to process the telemetry from all 30 sensors. You decide that commercial competition requires that your system is secure. You must be certain of each device before accepting its input. You decide to investigate Azure DPS as your security service.

Cheese making is a competitive business, and you want to keep your secrets well wrapped. And maybe your cheese too.

[![Photograph of mature blue cheese](../media/cheese-rect4.png)](../media/cheese-rect4.png#lightbox)

### The first step

The first step is to build an IoT Hub, using the Microsoft Azure portal.

## Unit 2: Create an IoT Hub

In this unit, we'll create an IoT Hub.

## Create a custom IoT Hub

1. Make sure you've activated the sandbox, using the button above. The sandbox creates free temporary resources.
1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
1. Select **+ Create a resource**, from the top of the left-hand menu. In the **Search the Marketplace** search box, enter "IoT Hub".
1. Select **IoT Hub** from the search results, and click **Create**.
1. You'll be required to enter a **Subscription** from the selection offered to you. A sandbox subscription will be **Concierge Subscription**, so choose that. For **Resource Group**, enter <rgn>[sandbox resource group name]</rgn>. A resource group is like a folder, it's largely there to help you organize your resources.
1. The **Region** should be the geographical region closest to you, and finally enter a friendly name (say "CheeseCaveHub-&lt;your ID&gt;") for **IoT Hub Name**.
    >[!IMPORTANT]
    >Your hub names are publicly discoverable, so take this into account when entering names.
1. Now, select **Review + create**, this option gives you a chance to verify your choices before clicking **Create**, and building the hub. Building your hub can take a few minutes.
1. When the IoT Hub is built, click **Go to resource** to go to the **Overview**** page for your hub. Or search for it in **All Resources**, if you happen to miss the completion message.
1. It's a good idea to bookmark the **Overview**** page of your IoT Hub.

Having created the hub, let's take a step back and go over some theory. You might find this knowledge valuable in understanding the security resources.

## Unit 3: Overview of the DPS service and X.509 certs

This module uses X.509 certificates to validate devices, before the devices are allowed to communicate with the IoT Hub. Let's go over some background information about these certificates.

## Introduction to DPS and X.509 certificates

The basis of the X.509 certificate is the concept of public/private key encryption. A _public_ key enables data to be encrypted. Use of the key distorts the text of the message into incomprehensible characters. A _private_ key is used to decrypt the message, back into its original text. The public key can't be used to decrypt the message. Public/private keys is a form of _asymmetric_ encryption. Asymmetric encryption is more secure than _symmetric_ encryption, where the same key is used to encrypt and decrypt a message. However, the private key needs to be kept secret.

To keep private keys secret, a _public key infrastructure_ (PKI) is needed to prevent the keys becoming lost or stolen. This infrastructure is potentially a disadvantage of the public/private key system. However, using X.509 certificates with the Azure Device Provisioning Service (DPS), a public key infrastructure is built into the service. Users of the service don't even need to know their own private keys. The private keys are generated by helper tools that are publicly available. The keys are stored in the X.509 certificates, and a user doesn't need to do much more than upload them to Azure DPS. A password protects the content of the private key.

To validate the authenticity of X.509 certificates, the certificates need to be _signed_. There are two ways of signing. You can use an organization known as a _Certificate Authority_ (or, CA) that specializes in supplying signed certificates. This approach might be the right way to go in a production environment, though there can be a cost involved. The alternative is known as _self-signed_ certificates, where the user validates their own certificates. There's no cost to this second option, though as you would be relying on publicly available tools, this system isn't recommended for production. For our purposes in this module, self-signed certificates will work fine.

The name "X.509" originates from the format the certificate is stored in.

With the X.509 certificates and the PKI, there's no need to distribute the public keys when creating key pairs. Another advantage is the PKI can maintain a list of invalidated certificates, so authentication can be centrally revoked.

There's a bit more to the X.509 story that you need to know, as it's central to our sample.

### Root, intermediate, and leaf certificates

There's perhaps a third way of signing certificates. That is, a certificate can be used to validate another certificate. Such a certificate is known as a _root certificate_, or sometimes a _trust anchor_. This one certificate isn't used to validate any devices, for example, but is only used to validate a range of subordinate certificates.

These subordinate certificates can be _intermediate certificates_. An intermediate certificate is again not used to validate devices, but only to validate other intermediate certificates, or validate _leaf_ certificates. We'll not be using any intermediate certificates in our sample.

A leaf certificate, as its name suggests, is the end-entity certificate that is used to validate a device. Leaf certificates can't be used to validate other certificates. A root certificate can be used to validate any number of intermediate, or leaf, certificates.

In our sample, we'll generate one root certificate for all our devices. From that root, we'll generate one leaf certificate for _each_ device that we'll be connecting to the IoT Hub.

All these certificates will be self-signed.

Cryptography is a complex technology, that goes deep into mathematics, so isn't for everyone. Follow the links on the **Summary** page of this module, if you're interested in a deeper introduction than we have given here. For the record, X.509 certification is the basis of the secure HTTPS protocol - for secure browsing of the internet.

Suffice to conclude that public/private key technology is state-of-the-art security, and by using X.509 certificates correctly, you can be confident you IoT Hub is secure. Secure against an invalid device supplying invalid data, and secure against a denial-of-service type attack. However, no security is perfect, and doing your own research on certification is recommended.

An Azure Device Provisioning Service can be linked to one, or more, IoT Hubs, and can be thought of as a system for managing your certificates, and managing your enrollments.

### Individual and Group Enrollments

An Azure DPS can contain a number of individual, or group, enrollments. In our scenario, the group enrollment provides the solution we're looking for. One enrollment group works with one root certificate, and any number of leaf certificates signed by this root. An enrollment maintains information on all the devices that have tried to register.

Individual enrollments are best used for devices that have a unique configuration, and require greater security than the connection strings you may have used in other Learn modules or Azure samples. Unique configurations aren't what we're looking for in our scenario, where we have many sensors configured to provide an identical set of telemetry data.

Another concept you'll see when we create an Azure DPS resource, is that of _allocation policy_. This policy isn't something we delve into. Allocation policies only apply when you've multiple IoT Hubs handling telemetry from a huge number of devices, and want to direct the incoming data to one of these hubs based on a policy.

After creating your enrollments, and self-signed root certificate, there's one more process necessary to prove to the provisioning service that you own the root certificate.

### Proof of Possession

When uploading certificates to Azure DPS, you'll be asked to generate a verification code.

_Proof of Possession_ of a certificate is provided to DPS by uploading a _verification_ certificate generated from the root certificate with the verification code that you generated within DPS. The verification certificate is _chained_ to the root certificate.

This process is how you provide proof that you own the root certificate. There's no need to provide proof of possession of the leaf certificates, as, if you own the root, trust has been established.

### Next step

That should be enough theory. For the next step, let's create an Azure DPS resource, and then all the necessary certificates.

## Unit 4: Create a DPS resource, a root certificate, and a Group Enrollment

A Device Provisioning Service (DPS) can be linked to one, or multiple hubs. So, it's a separate resource, and is independent of any one IoT Hub. You create a DPS resource the same way you create any other Azure resource.

## Create an Azure IoT Hub Device Provisioning Service

1. In your [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), select **Create a resource**.

1. Type "provisioning" in the search box, and select **IoT Hub Device Provisioning Service**.

    [![Screenshot showing the selection of the IoT Hub Device Provisioning Service](../media/iot-hub-dps-resource-create.png)](../media/iot-hub-dps-resource-create.png#lightbox)

1. Specify the resource, with a name such as "CheeseCave-DPS". Use the sandbox subscription and resource group options. And choose your **Location**.

    [![Screenshot showing the completed fields for a new DPS](../media/iot-hub-dps-resource-name.png)](../media/iot-hub-dps-resource-name.png#lightbox)

1. Create the resource, and wait for it to deploy.

### Link the DPS resource to your IoT Hub

1. In the DPS resource, locate, and select, the **Linked IoT hubs** entry, under **Settings**.

1. Click **+ Add**.

1. In the **Add link to IoT hub** pane, select the sandbox subscription.

1. Locate the name of your IoT hub, and select **iothubowner** as the **Access Policy**. Click **Save**.

    [![Screenshot showing how to link an IoT Hub to the DPS](../media/iot-hub-dps-resource-hub-link.png)](../media/iot-hub-dps-resource-hub-link.png#lightbox)

1. Click **Manage allocation policy**, and verify the policy is set to **Evenly weighted distribution**.

    [![Screenshot showing the DPS allocation policies](../media/iot-hub-dps-resource-policy.png)](../media/iot-hub-dps-resource-policy.png#lightbox)

1. On the **Overview** page, copy the **ID Scope** string to a text file. The string is displayed top-right of the page.

1. Perhaps bookmark a link to the **Overview** page of this resource.

Before we can go any further with the DPS resource, by adding enrollments, we must first create a root certificate.

## Create an X.509 root certificate

The first time we create any X.509 certificates, we need to download some tools.

1. Open an Azure Cloud Shell, and select the **Bash** shell option. We need the Bash option, as the helper tools that you'll download next are written for Bash.

1. Run the following script. It creates a certificate directory in the shell storage, and downloads some helper scripts to it.

    ```azurecli
     # create certificates directory
     mkdir certificates
     # navigate to certificates directory
     cd certificates
    
     # download helper script files
     curl https://raw.githubusercontent.com/Azure/azure-iot-sdk-c/master/tools/CACertificates/certGen.sh --output certGen.sh
     curl https://raw.githubusercontent.com/Azure/azure-iot-sdk-c/master/tools/CACertificates/openssl_device_intermediate_ca.cnf --output openssl_device_intermediate_ca.cnf
     curl https://raw.githubusercontent.com/Azure/azure-iot-sdk-c/master/tools/CACertificates/openssl_root_ca.cnf --output openssl_root_ca.cnf
    
     # update script permissions so user can read, write, and execute it
     chmod 700 certGen.sh
    ```

    These helper scripts are downloaded from the Azure/azure-iot-sdk-c open-source project hosted on GitHub. This project is a part of the Azure IoT SDK. The certGen.sh helper script will help demonstrate the purpose of CA Certificates without diving into the specifics of OpenSSL configuration. If you need additional instructions on using these helper scripts, or for instructions on how to use PowerShell instead of Bash, refer to [CACertificateOverview](https://github.com/Azure/azure-iot-sdk-c/blob/master/tools/CACertificates/CACertificateOverview.md).

    >[!WARNING]
    >Do not use these helper scripts in a production environment, as the scripts contain hard-coded passwords that expire after 30 days. The scripts are provided only for demo purposes.

1. Run the following command to generate root and intermediate certificates. We're only interested in the root certificate, which will be named `azure-iot-test-only.root.ca.cert.pem`.
    
    ```azurecli
     ./certGen.sh create_root_and_intermediate
    ```

1. We need to download the root certificate to your local machine, to then upload it to Azure DPS. Enter:

    ```azurecli
     download ~/certificates/certs/azure-iot-test-only.root.ca.cert.pem
    ```

### Configure Azure DPS to trust the root certificate

1. In the Azure portal, navigate to the cheese cave DPS resource you created earlier.

1. In the **Settings** section, click **Certificates**.

1. Click **Add**. For the **Certificate Name**, enter an understandable name such as "cheesecave-dps-root". The name doesn't have to be the same as the certificate filename.

1. For **Certificate .pem or .cer file**, navigate to and select the azure-iot-test-only.root.ca.cert.pem file that you downloaded.

1. Click **Save**.

After the root certificate has been uploaded, the **Certificates** pane will display the certificate with the status of **Unverified**. Before this CA Certificate can be used to authenticate devices to DPS, you'll need to establish _Proof of Possession_ of the certificate.

### Establish your Proof of Possession

1. In the **Certificates** pane, click on the certificate to open the **Certificate Details** pane.

1. Click **Generate Verification Code**.

1. Copy the **Verification Code** that is displayed above the **Generate Verification Code** button. There's a button to the right of the textbox to copy the code for you. Open a text editor, such as Notepad, and paste in the verification code.

    Proof of Possession of the CA certificate is provided to DPS by uploading a verification certificate generated from the root certificate. The verification certificate contains the verification code you just generated. This process is how you provide proof that you own the CA Certificate.

1. Leave the **Certificate Details** pane open while you generate the verification certificate. If you close the pane, you'll invalidate the verification code, and will need to generate a new one.

1. Copy the following command to the text file containing the verification code, and change the &lt;verification-code&gt; to the actual code.

    ```azurecli
     ./certGen.sh create_verification_certificate <verification-code>
    ```

1. Back in the Azure Cloud Shell, and in the **certificates** directory, run the completed command. This command generates a verification certificate that is chained to the root certificate. The generated certificate is named `verification-code.cert.pem`, and is located within the **./certs** directory of the Azure Cloud Shell.

1. Run the following command to download the verification certificate to your local machine.

    ```azurecli
    download ~/certificates/certs/verification-code.cert.pem
    ```

1. Change focus back to the **Certificate Details** pane of the Azure portal. For **Verification Certificate .pem or .cer file**, navigate to, and select the `verification-code.cert.pem` file.

1. Click **Verify**, and, in the **Certificates** pane, check the status for the certificate is now displayed as **Verified**. You may need to use the refresh button at the top of the pane to see this change.

Great progress, you've created a root certificate, and validated to Azure DPS that you own it. The next step is to create a **Group Enrollment**, and link it to the root certificate.

### Create a Group Enrollment in Azure DPS

1. In the Azure portal, with your DPS resource selected, locate the **Settings** section.

1. Click **Manage enrollments**, then **Add enrollment group**. Make sure you're adding a group, and not an individual, enrollment.

1. For **Group Name**, enter "cheesecave-devices".

1. Ensure the **Attestation Type** is set to **Certificate**, and the **Certificate Type** field is set to **CA Certificate**. These settings are the defaults.

1. In the **Primary Certificate** dropdown, select your CA certificate. This certificate will be **cheesecave-dps-root**, if you used the suggested name.

1. Leave the **Secondary Certificate** dropdown set to **No certificate selected**. You're not required to have a secondary certificate.

1. Leave **Select how you want to assign devices to hubs** as **Evenly weighted distribution**. As you only have one IoT Hub associated with the enrollment, this setting is unimportant.

1. Verify your IoT Hub is selected in the **Select the IoT Hubs this device can be assigned to** field. Leave the reprovisioning settings at their defaults.

1. Finally, click **Save**, and verify your new enrollment group appears in the **Enrollment Groups** pane.

A group enrollment is going to be very useful in handling remote devices at scale. The next unit create multiple leaf certificates.


## Unit 5: Create multiple leaf certs

In this unit, we need to create one leaf certificate for each device that we want to send telemetry to the hub. Two is company, three is a crowd. So, let's create code for a "crowd" of devices. Remember, in our scenario description we stated that there were now 30 cheese caves, requiring 30 sensor devices. Let's limit this number to three for the sake of explanation and testing!

1. In the Azure Cloud Shell, make sure you're in the **certificates** folder.

1. Run the following command:

    ```azurecli
     ./certGen.sh create_device_certificate cheesecave-device1
    ```

1. Verify the leaf certificate was created correctly. You should see numerous console messages, ending in something like the following image.

    [![Console output showing the correct creation of a leaf certificate](../media/iot-hub-dps-cert-create1.png)](../media/iot-hub-dps-cert-create1.png#lightbox)

1. To download the created certificate to your local machine, enter:

    ```azurecli
    download ~/certificates/certs/new-device.cert.pfx
    ```

1. Create a new folder in your **Documents** folder, called "cheesecave certs", or something similar.

1. Copy the **new-device-cert.pfx** file from its downloaded location into the **cheesecave certs** folder, and rename it **new-device-cert1.pfx**.

1. In the Azure Cloud Shell, delete the **new-device-cert** files. This step is important so the tools can be used to create further certificates. You can delete the file, in the **certificates/certs** folder, by going through the following procedure:
    1. Type `cd certs`.
    1. Type `rm new*`.
    1. Answer `y` to the question on the protected file.
    1. Type `cd ..`.

1. In the Azure Cloud Shell, create a second leaf certificate:

    ```azurecli
     ./certGen.sh create_device_certificate cheesecave-device2
    ```

1. If you get a `Permission denied` response, similar to the following, verify you've deleted the earlier certificates correctly.

    [![Console output showing a leaf certificate was not created](../media/iot-hub-dps-cert-denied.png)](../media/iot-hub-dps-cert-denied.png#lightbox)

1. Download the second certificate to your local machine, enter:

    ```azurecli
    download ~/certificates/certs/new-device.cert.pfx
    ```

1. Copy the **new-device-cert.pfx** file from its downloaded location into the **cheesecave certs** folder, and rename it **new-device-cert2.pfx**.

1. In the Azure Cloud Shell, delete the **new-device-cert** files:
    1. Type `cd certs`.
    1. Type `rm new*`.
    1. Answer `y` to the question on the protected file.
    1. Type `cd ..`.

1. In the Azure Cloud Shell, create a third leaf certificate:

    ```azurecli
     ./certGen.sh create_device_certificate cheesecave-device3
    ```

1. Download the third certificate to your local machine, enter:

    ```azurecli
    download ~/certificates/certs/new-device.cert.pfx
    ```

1. Copy the **new-device-cert.pfx** file from its downloaded location into the **cheesecave certs** folder, and rename it **new-device-cert3.pfx**.

Great, you now have three leaf certificates. The next step is to write some code to simulate each device.


## Unit 6: Create the code for the sensor devices

In this unit, we create the code running on each sensor device.

One of the goals is to make the code as identical as possible for each device, so minimizing human involvement. The code will require one tweak as we prepare it for a second device, the path to the leaf certificate needs to be unique for each device. Unique in this case means changing a "1" to a "2" or "3". This change is so minor it could easily be automated in a production environment.

The code is written in C#, and you can choose Visual Studio, or Visual Studio Code, as your development environment.

## Create a project for one simulated device

::: zone pivot="vscode"

1. To use C# in Visual Studio Code, ensure both [.NET Core](https://dotnet.microsoft.com/download), and the [C# extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.csharp) are installed.

1. Open a terminal in Visual Studio Code, and create a folder called "CaveDevice1" (enter `mkdir CaveDevice1`). Navigate to the `CaveDevice1` folder.

1. Enter the following command in the terminal: `dotnet new console`. This command creates a **Program.cs** file in your folder, along with a project file.

1. Enter `dotnet restore` in the terminal. This command gives your app access to the required .NET packages.

1. In the terminal, install the required libraries. Enter:
    - **dotnet add package Microsoft.Azure.Devices.Client**
    - **dotnet add package Microsoft.Azure.Devices.Provisioning.Client**
    - **dotnet add package Microsoft.Azure.Devices.Provisioning.Transport.AMQP**

1. From the **File** menu, open up the **Program.cs** file, and delete the default contents. You will have to navigate to the `CaveDevice1` folder.

1. After you've entered the code below into the **Program.cs** file, you can run the app with the command `dotnet run`. This command will run the **Program.cs** file in the current folder, so ensure you are in the `CaveDevice1` folder.

::: zone-end
::: zone pivot="vstudio"

1. Open Visual Studio, and create a new **Visual C#/Windows Desktop** project. Select **Console App (.NET Framework)**.

1. Give the project a friendly name, such as "CaveDevice1".

1. Under **Tools/NuGet Package Manager**, select **Manage NuGet Packages for Solution**. Install the following libraries:
    - **Microsoft.Azure.Devices.Client**
    - **Microsoft.Azure.Devices.Provisioning.Client**
    - **Microsoft.Azure.Devices.Provisioning.Transport.AMQP**

1. Delete the default contents of the **Program.cs** file.

1. Add all the code that follows to the **Program.cs** file.

::: zone-end

> [!NOTE]
> This module doesn't require you to download any code. However, all of the code is available from [Learn module: Automatically provision IoT devices securely and at scale with DPS](https://github.com/MicrosoftDocs/mslearn-automatically-provision-iot-devices-securely-and-at-scale-with-dps), if needed.

### Add code to send telemetry

This section adds code to send telemetry from a simulated sensor device.

1. Open the **Program.cs** file for the device app.

1. Copy and paste the following code.

    ```cs
    // Copyright (c) Microsoft. All rights reserved.
    // Licensed under the MIT license. See LICENSE file in the project root for full license information.
    
    using Microsoft.Azure.Devices.Client;
    using Microsoft.Azure.Devices.Provisioning.Client;
    using Microsoft.Azure.Devices.Provisioning.Client.Transport;
    using Microsoft.Azure.Devices.Shared;
    using System;
    using System.Text;
    using System.Threading.Tasks;
    using System.IO;
    using Newtonsoft.Json;
    using System.Security.Cryptography.X509Certificates;
    
    
    namespace X509CertificateSimulatedDevice
    {
        class Program
        {
            // Azure Device Provisioning Service (DPS) Global Device Endpoint.
            private const string GlobalDeviceEndpoint = "global.azure-devices-provisioning.net";
    
            // Azure Device Provisioning Service (DPS) ID Scope.
            private static string dpsIdScope = "<your DPS ID Scope>";
    
            // Certificate (PFX) File Name.
            private static string s_certificateFileName = "<your leaf path>";
    
            // Certificate (PFX) Password. Better to use a Hardware Security Module for production devices.
            private static string s_certificatePassword = "1234";
    
            public static int Main(string[] args)
            {
                X509Certificate2 certificate = LoadProvisioningCertificate();
    
                using (var security = new SecurityProviderX509Certificate(certificate))
                {
                    using (var transport = new ProvisioningTransportHandlerAmqp(TransportFallbackType.TcpOnly))
                    {
                        ProvisioningDeviceClient provClient =
                            ProvisioningDeviceClient.Create(GlobalDeviceEndpoint, dpsIdScope, security, transport);
    
                        var provisioningDeviceLogic = new ProvisioningDeviceLogic(provClient, security);
                        provisioningDeviceLogic.RunAsync().GetAwaiter().GetResult();
                    }
                }
    
                return 0;
            }
    
            private static X509Certificate2 LoadProvisioningCertificate()
            {
                var certificateCollection = new X509Certificate2Collection();
                certificateCollection.Import(s_certificateFileName, s_certificatePassword, X509KeyStorageFlags.UserKeySet);
    
                X509Certificate2 certificate = null;
    
                foreach (X509Certificate2 element in certificateCollection)
                {
                    Console.WriteLine($"Found certificate: {element?.Thumbprint} {element?.Subject}; PrivateKey: {element?.HasPrivateKey}");
                    if (certificate == null && element.HasPrivateKey)
                    {
                        certificate = element;
                    }
                    else
                    {
                        element.Dispose();
                    }
                }
    
                if (certificate == null)
                {
                    throw new FileNotFoundException($"{s_certificateFileName} did not contain any certificate with a private key.");
                }
    
                Console.WriteLine($"Using certificate {certificate.Thumbprint} {certificate.Subject}");
                return certificate;
            }
        }    
    
        // The ProvisioningDeviceLogic class contains the device logic to read from the simulated Device Sensors, and send Device-to-Cloud
        // messages to the Azure IoT Hub. It also contains the code that updates the device with changes to the device twin properties.
        public class ProvisioningDeviceLogic
        {
            readonly ProvisioningDeviceClient _provClient;
            readonly SecurityProvider _security;
            DeviceClient s_deviceClient;
    
            // Global constants.
            const float ambientTemperature = 70;                    // Ambient temperature of a southern cave, in degrees F.
            const double ambientHumidity = 99;                      // Ambient humidity in relative percentage of air saturation.
            const double desiredTempLimit = 5;                      // Acceptable range above or below the desired temp, in degrees F.
            const double desiredHumidityLimit = 10;                 // Acceptable range above or below the desired humidity, in percentages.
            const int intervalInMilliseconds = 5000;                // Interval at which telemetry is sent to the cloud.
            enum stateEnum
            {
                off,
                on,
                failed
            }
    
            // Global variables.
            private static stateEnum fanState = stateEnum.off;                      // Initial setting of the fan. 
            private static double desiredTemperature = ambientTemperature - 10;     // Initial desired temperature, in degrees F. 
            private static double desiredHumidity = ambientHumidity - 20;           // Initial desired humidity in relative percentage of air saturation.
    
            public ProvisioningDeviceLogic(ProvisioningDeviceClient provisioningDeviceClient, SecurityProvider security)
            {
                _provClient = provisioningDeviceClient;
                _security = security;
            }
    
            private static void colorMessage(string text, ConsoleColor clr)
            {
                Console.ForegroundColor = clr;
                Console.WriteLine(text);
                Console.ResetColor();
            }
            private static void greenMessage(string text)
            {
                colorMessage(text, ConsoleColor.Green);
            }
    
            private static void redMessage(string text)
            {
                colorMessage(text, ConsoleColor.Red);
            }
    
            private static void whiteMessage(string text)
            {
                colorMessage(text, ConsoleColor.White);
            }
    
            public async Task RunAsync()
            {
                colorMessage($"\nRegistrationID = {_security.GetRegistrationID()}", ConsoleColor.Yellow);
    
                // Register the Device with DPS.
                whiteMessage("ProvisioningClient RegisterAsync . . . ");
                DeviceRegistrationResult result = await _provClient.RegisterAsync().ConfigureAwait(false);
    
                if (result.Status == ProvisioningRegistrationStatusType.Assigned)
                {
                    greenMessage($"Device Registration Status: {result.Status}");
                    greenMessage($"ProvisioningClient AssignedHub: {result.AssignedHub}; DeviceID: {result.DeviceId}");
                }
                else
                {
                    redMessage($"Device Registration Status: {result.Status}");
                    throw new Exception($"DeviceRegistrationResult.Status is NOT 'Assigned'");
                }
    
                // Create x509 DeviceClient Authentication.
                whiteMessage("Creating X509 DeviceClient authentication.");
                var auth = new DeviceAuthenticationWithX509Certificate(result.DeviceId, (_security as SecurityProviderX509).GetAuthenticationCertificate());
    
    
                whiteMessage("Simulated Device. Ctrl-C to exit.");
                using (s_deviceClient = DeviceClient.Create(result.AssignedHub, auth, TransportType.Amqp))
                {
                    // Explicitly open DeviceClient to communicate with Azure IoT Hub.
                    whiteMessage("DeviceClient OpenAsync.");
                    await s_deviceClient.OpenAsync().ConfigureAwait(false);
    
    
                    // Setup OnDesiredPropertyChanged Event Handling to receive Desired Properties changes.
                    whiteMessage("Connecting SetDesiredPropertyUpdateCallbackAsync event handler...");
                    await s_deviceClient.SetDesiredPropertyUpdateCallbackAsync(OnDesiredPropertyChanged, null).ConfigureAwait(false);
    
    
                    // Load Device Twin Properties since device is just starting up.
                    whiteMessage("Loading Device Twin Properties...");
                    var twin = await s_deviceClient.GetTwinAsync().ConfigureAwait(false);
                    // Use OnDesiredPropertyChanged event handler to set the loaded Device Twin properties.
                    await OnDesiredPropertyChanged(twin.Properties.Desired, null);
    
                    // Start reading and sending device telemetry.
                    colorMessage("\nStart reading and sending device telemetry...\n", ConsoleColor.Yellow);
                    await SendDeviceToCloudMessagesAsync2(s_deviceClient);
    
                    // Explicitly close DeviceClient.
                    whiteMessage("DeviceClient CloseAsync.");
                    await s_deviceClient.CloseAsync().ConfigureAwait(false);
                }
            }
            private async Task OnDesiredPropertyChanged(TwinCollection desiredProperties, object userContext)
            {
                whiteMessage("Desired Twin Property Changed:");
                whiteMessage($"{desiredProperties.ToJson()}");
    
                // Read the desired Twin Properties.
                if (desiredProperties.Contains("fanstate") & fanState != stateEnum.failed)
                {
                    string desiredFanState = desiredProperties["fanstate"];
                    desiredFanState = desiredFanState.ToLower();
                    if (desiredFanState == "on" || desiredFanState == "off")
                    {
                        fanState = (stateEnum)Enum.Parse(typeof(stateEnum), desiredFanState);
                        greenMessage($"Set the fan to: {desiredFanState}");
                    }
                    else
                    {
                        redMessage($"Illegal fan state received: {desiredFanState}");
                    }
                }
    
                if (desiredProperties.Contains("temperature"))
                {
                    string desiredTemperatureString = desiredProperties["temperature"];
                    try
                    {
                        desiredTemperature = double.Parse(desiredTemperatureString);
                        greenMessage($"Setting the desired temperature to: {desiredTemperatureString}");
                    }
                    catch
                    {
                        redMessage($"Illegal temperature received: {desiredTemperatureString}");
                    }
                }
    
                if (desiredProperties.Contains("humidity"))
                {
                    string desiredHumidityString = desiredProperties["humidity"];
                    try
                    {
                        desiredHumidity = double.Parse(desiredHumidityString);
                        greenMessage($"Setting the desired humidity to: {desiredHumidityString}");
                    }
                    catch
                    {
                        redMessage($"Illegal humidity received: {desiredHumidityString}");
                    }
                }
    
                // Report Twin properties.
                var reportedProperties = new TwinCollection();
                reportedProperties["fanstate"] = fanState.ToString();
                reportedProperties["humidity"] = desiredHumidity;
                reportedProperties["temperature"] = desiredTemperature;
                await s_deviceClient.UpdateReportedPropertiesAsync(reportedProperties).ConfigureAwait(false);
                greenMessage($"Reported Twin Properties: {reportedProperties.ToJson()}");
            }
    
            // Async method to send simulated telemetry.
            private async Task SendDeviceToCloudMessagesAsync2(DeviceClient deviceClient)
            {
    
                double currentTemperature = ambientTemperature;         // Initial setting of temperature.
                double currentHumidity = ambientHumidity;               // Initial setting of humidity.
    
                Random rand = new Random();
    
                while (true)
                {
                    // Simulate telemetry.
                    double deltaTemperature = Math.Sign(desiredTemperature - currentTemperature);
                    double deltaHumidity = Math.Sign(desiredHumidity - currentHumidity);
    
                    if (fanState == stateEnum.on)
                    {
                        // If the fan is on the temperature and humidity will be nudged towards the desired values most of the time.
                        currentTemperature += (deltaTemperature * rand.NextDouble()) + rand.NextDouble() - 0.5;
                        currentHumidity += (deltaHumidity * rand.NextDouble()) + rand.NextDouble() - 0.5;
    
                        // Randomly fail the fan.
                        if (rand.NextDouble() < 0.01)
                        {
                            fanState = stateEnum.failed;
                            redMessage("Fan has failed");
                        }
                    }
                    else
                    {
                        // If the fan is off, or has failed, the temperature and humidity will creep up until they reaches ambient values, 
                        // thereafter fluctuate randomly.
                        if (currentTemperature < ambientTemperature - 1)
                        {
                            currentTemperature += rand.NextDouble() / 10;
                        }
                        else
                        {
                            currentTemperature += rand.NextDouble() - 0.5;
                        }
                        if (currentHumidity < ambientHumidity - 1)
                        {
                            currentHumidity += rand.NextDouble() / 10;
                        }
                        else
                        {
                            currentHumidity += rand.NextDouble() - 0.5;
                        }
                    }
    
                    // Check: humidity can never exceed 100%.
                    currentHumidity = Math.Min(100, currentHumidity);
    
                    // Create JSON message.
                    var telemetryDataPoint = new
                    {
                        temperature = Math.Round(currentTemperature, 2),
                        humidity = Math.Round(currentHumidity, 2)
                    };
                    var messageString = JsonConvert.SerializeObject(telemetryDataPoint);
                    var message = new Message(Encoding.ASCII.GetBytes(messageString));
    
                    // Add custom application properties to the message.
                    message.Properties.Add("sensorID", "S1");
                    message.Properties.Add("fanAlert", (fanState == stateEnum.failed) ? "true" : "false");
    
                    // Send temperature or humidity alerts, only if they occur.
                    if ((currentTemperature > desiredTemperature + desiredTempLimit) || (currentTemperature < desiredTemperature - desiredTempLimit))
                    {
                        message.Properties.Add("temperatureAlert", "true");
                    }
                    if ((currentHumidity > desiredHumidity + desiredHumidityLimit) || (currentHumidity < desiredHumidity - desiredHumidityLimit))
                    {
                        message.Properties.Add("humidityAlert", "true");
                    }
    
                    colorMessage($"Message data: {messageString}", ConsoleColor.White);
    
                    // Send the telemetry message
                    await deviceClient.SendEventAsync(message);
                    greenMessage("Message sent\n");
    
                    await Task.Delay(intervalInMilliseconds);
                }
            }
        }
    }
    ```

1. Change the &lt;your DPS ID Scope&gt; string to your actual DPS **ID Scope**.

    > [!NOTE]
    > The `dpsIdScope` string is identical for all devices connected to this DPS resource.

1. Change the &lt;your leaf path&gt; to the actual path to your leaf certificate.

    ```csharp
          private static string s_certificateFileName = "C:\\Users\\<your user name>\\Documents\\cheesecave certs\\new-device.cert1.pfx";
    ```

1. Set the app running. In Visual Studio, select **Debug/Start without Debugging**. In Visual Studio Code, enter `dotnet run` in the terminal.

    [![Console output showing the first device running correctly](../media/iot-hub-dps-device1.png)](../media/iot-hub-dps-device1.png#lightbox)

### Create an app for a second device

1. Repeat all the steps in the **Create a project for a simulated device** section, except with a new project name: "CaveDevice2".
1. Change the leaf name from `new-device.cert1.pfx` to `new-device.cert2.pfx`.
1. Set the app running.

    [![Console output showing the second device running correctly](../media/iot-hub-dps-device2.png)](../media/iot-hub-dps-device2.png#lightbox)

### Create an app for a third device

1. Repeat all the steps in the **Create a project for a simulated device** section, except with a new project name: "CaveDevice3".
1. Change the leaf path from `new-device.cert1.pfx` to `new-device.cert3.pfx`.
1. Set the app running.

    [![Console output showing the third device running correctly](../media/iot-hub-dps-device3.png)](../media/iot-hub-dps-device3.png#lightbox)

Great, a bit of repetitive work, but we now have our crowd of devices. The next, and final, step is to test our DPS resource and IoT Hub handle the assignments and telemetry correctly.

## Unit 7: Test your DPS linked IoT Hub with multiple devices

In this unit, we verify all the pieces we have put in place work as expected. You've already set all the device apps running. First, we check the provisioning service handles the registration correctly. Then we'll check the IoT Hub gets automatic updates to its list of connected IoT devices, and receives the telemetry from the devices. Finally, in the portal, we change a device twin setting for one device, and verify the correct device picks up the change.

## Test the multiple devices are automatically assigned to your IoT Hub

> [!TIP]
> With three console screens running, a Visual Studio instance to initiate the devices, and a browser view of the Azure portal, it can help to have multiple monitors. The more screen real estate you've available for testing, the easier you'll find testing is!

1. Verify all three device apps are still sending telemetry.

    [![Console output showing all three devices running](../media/iot-hub-dps-devices123.png)](../media/iot-hub-dps-devices123.png#lightbox)

1. In the Azure portal for your DPS service, locate **Monitoring** in the left-hand menu, and select **Metrics**. Verify all three devices are assigned, by setting **Metric** to **Devices assigned**, and **Aggregation** to **Sum**.

    [![Screenshot showing devices assigned metrics](../media/iot-hub-dps-metrics-devices.png)](../media/iot-hub-dps-metrics-devices.png#lightbox)

1. In the Azure portal, this time for your IoT Hub, select **IoT devices** in the left-hand menu. Verify all three devices are listed, and have **Status** set to **Enabled**.

    [![Screenshot showing the list of device IDs enabled in the IoT Hub](../media/iot-hub-dps-device-list.png)](../media/iot-hub-dps-device-list.png#lightbox)

    > [!NOTE]
    > You'll remember that you did not add any devices using the Azure portal. These devices have been added by the link from your DPS system.

1. For added reassurance, in the left-hand menu select **Metrics** for your hub. Enter **Connected devices** for **Metric**, and set **Aggregation** to **Max**.

    [![Screenshot showing connected devices metrics](../media/iot-hub-dps-metrics-devices-hub.png)](../media/iot-hub-dps-metrics-devices-hub.png#lightbox)

1. Still in **Metrics**, verify telemetry is received by changing **Metric** to **Telemetry messages sent**, and **Aggregation** to **Sum**.

    [![Screenshot showing telemetry messages sent metrics](../media/iot-hub-dps-metrics-telemetry.png)](../media/iot-hub-dps-metrics-telemetry.png#lightbox)

You've now verified that all devices connected automatically to the hub via the DPS resource. You've completed the substance of this module, but let's do one more test, to verify communication in the opposite direction.

### Test the cloud-to-device communication

In this test, let's change one of the device twin properties in the portal, and ensure it's communicated to the device.

1. Select **IoT devices** for your hub, select **cheesecave-device1**.  Then, in the bar, select **Device Twin**.

1. Locate the **desired** section of the **properties** in the code that appears.

1. Change the desired temperature to something different and noticeable: say "50.123". And click **Save**.

    [![Screenshot showing a change to the desired properties, in a device twin](../media/iot-hub-dps-twin-temp.png)](../media/iot-hub-dps-twin-temp.png#lightbox)

1. Verify, in the console output, the change is picked up quickly by the selected device.

    [![Console output, showing the device twin property change has been picked up by the device](../media/iot-hub-dps-twin-temp-set.png)](../media/iot-hub-dps-twin-temp-set.png#lightbox)

If all this worked as expected, great work. You now know what needs to be done to provision devices at scale. We limited ourselves to three devices, but you can imagine, with some automation and tooling, how you could provision a large number of devices, with minimum human involvement.

To complete the module, let's summarize the goals, and finish with a knowledge check.

## Unit 8: Summary

Completing this module should have given you valuable insight into the dark world of cryptography and message security. If you're new to this world, you'll appreciate the thought and design that has gone into X.509 certificates, and Azure DPS Group Enrollments. You'll see how these technologies neatly map the root and leaf X.509 certificates to an IoT Hub and its range of IoT devices. You'll also appreciate how well these technologies make security user-friendly enough for those of us who don't want to know too much about the underlying math.

In short, you have learnt how to keep your cheese maturing practices a secret!

[![Photograph of mature blue cheese](../media/cheese-rect3.png)](../media/cheese-rect3.png#lightbox)

In this module, you learned how to:

- Create a custom Azure IoT Hub, using the Azure portal
- Create a DPS resource and a group enrollment, using the Azure portal
- Create root and leaf X.509 certificates
- Create an app to send device telemetry to your IoT Hub, using Visual Studio, or Visual Studio Code
- Test multiple devices are provisioned by your DPS service

## Next steps

Learn about storing passwords and certificates:

- [Azure Key Vault](https://azure.microsoft.com/services/key-vault/)
- [Azure Dedicated HSM](https://azure.microsoft.com/services/azure-dedicated-hsm/)

Learn more about IoT Hub:

- [IoT Hub Documentation](https://docs.microsoft.com/azure/iot-hub/)
- [Set up X.509 security in your Azure IoT hub](https://docs.microsoft.com/azure/iot-hub/iot-hub-security-x509-get-started)

Learn more about IoT Hub devices:

- [Find your IoT device](https://catalog.azureiotsolutions.com/)

Learn more about X.509 certificates:

- [X.509 Digital Certification](https://docs.microsoft.com/windows/win32/seccrypto/x-509-digital-certification)

To complete this module, there's a slightly harder-than-usual knowledge check. Good luck with it!

```yml
### YamlMime:Module
uid: learn.iot.automatically-provision-iot-devices-securely-and-at-scale-with-dps
metadata:
  title: Securely provision IoT devices at scale with DPS
  description: In this module, create an Azure IoT Hub, and a DPS resource. Code for a number of simulated sensors is created, and the focus of the module is getting these devices securely provisioned and communicating with the hub, via a DPS group enrollment. The scenario is sensors in multiple cheese caves.
  ms.date: 3/15/2020
  author: PeterTurcan
  ms.author: Olivier.Bloch
  ms.topic: interactive-tutorial
  ms.prod: learning-azure
title: Securely provision IoT devices at scale with DPS
summary: >
 In this module, create an Azure IoT Hub, and a DPS resource. Code for a number of simulated sensors is created, and the focus of the module is getting these devices securely provisioned and communicating with the hub, via a DPS group enrollment. The scenario is sensors in multiple cheese caves.
abstract: | 
  In this module, you will:
- Create a custom Azure IoT Hub, using the Azure portal
- Learn about device provisioning, X.509 certificates, and enrollments
- Create a DPS resource and a group enrollment, using the Azure portal
- Create an app to send device telemetry to your IoT Hub, using Visual Studio, or Visual Studio Code
- Test multiple devices are provisioned by your DPS resource
prerequisites: | 
- An introductory knowledge of Azure IoT
- Ability to navigate the Azure IoT portal
- Ability to use C#, at the beginner level
- Experience using Visual Studio, or Visual Studio Code, at the beginner level
iconUrl: /learn/achievements/iot/automatically-provision-iot-devices-securely-and-at-scale-with-dps.svg
ratingEnabled: true
levels:
- beginner
roles:
- developer
products:
- azure-iot-hub
units:
- learn.iot.automatically-provision-iot-devices-securely-and-at-scale-with-dps.introduction
- learn.iot.automatically-provision-iot-devices-securely-and-at-scale-with-dps.create-iot-hub
- learn.iot.automatically-provision-iot-devices-securely-and-at-scale-with-dps.overview-dps-x509-certificates-enrollments
- learn.iot.automatically-provision-iot-devices-securely-and-at-scale-with-dps.exercise-create-dps-resource-root-certificate-group-enrollment
- learn.iot.automatically-provision-iot-devices-securely-and-at-scale-with-dps.exercise-create-multiple-leaf-certificates
- learn.iot.automatically-provision-iot-devices-securely-and-at-scale-with-dps.exercise-create-code-sensor-devices
- learn.iot.automatically-provision-iot-devices-securely-and-at-scale-with-dps.exercise-test-multiple-devices-provision-correctly
- learn.iot.automatically-provision-iot-devices-securely-and-at-scale-with-dps.summary
badge:
  uid: learn.iot.automatically-provision-iot-devices-securely-and-at-scale-with-dps.badge



### YamlMime:ModuleUnit
uid: learn.iot.automatically-provision-iot-devices-securely-and-at-scale-with-dps.introduction
metadata:
  title: Introduction
  description: Describes the scenario of multiple sensor devices needing to be validated before their telemetry can be allowed to reach an IoT Hub.
  ms.date: 3/15/2020
  author: PeterTurcan
  ms.author: Olivier.Bloch
  ms.topic: interactive-tutorial
  ms.prod: learning-azure
title: Introduction
durationInMinutes: 2
content: |
  [!include[](includes/1-introduction.md)]


### YamlMime:ModuleUnit
uid: learn.iot.automatically-provision-iot-devices-securely-and-at-scale-with-dps.create-iot-hub
metadata:
  title: Create an IoT Hub
  description: Goes through the process of creating an IoT Hub to handle cheese cave telemetry.
  ms.date: 3/15/2020
  author: PeterTurcan
  ms.author: Olivier.Bloch
  ms.topic: interactive-tutorial
  ms.prod: learning-azure
title: Create an IoT Hub
durationInMinutes: 8
content: |
  [!include[](includes/2-create-iot-hub.md)]



### YamlMime:ModuleUnit
uid: learn.iot.automatically-provision-iot-devices-securely-and-at-scale-with-dps.overview-dps-x509-certificates-enrollments
metadata:
  title: Overview of the DPS resource, X.509 certificates, and enrollments
  description: Provides an overview of the Azure DPS resource, X.509 certificates, and individual and group enrollments.
  ms.date: 3/15/2020
  author: PeterTurcan
  ms.author: Olivier.Bloch
  ms.topic: interactive-tutorial
  ms.prod: learning-azure
title: Overview of the DPS resource, X.509 certificates, and enrollments
durationInMinutes: 8
content: |
  [!include[](includes/3-overview-dps-x509-certificates-enrollments.md)]



### YamlMime:ModuleUnit
uid: learn.iot.automatically-provision-iot-devices-securely-and-at-scale-with-dps.exercise-create-dps-resource-root-certificate-group-enrollment
metadata:
  title: Exercise - Create a DPS resource, root certificate, and group enrollment
  description: In this unit, a DPS resource is first created, and linked to the IoT Hub created in the previous unit. Then, an X.509 root certificate is created, and validated. Finally, a Group Enrollment is created within the DPS resource.
  ms.date: 3/15/2020
  author: PeterTurcan
  ms.author: Olivier.Bloch
  ms.topic: interactive-tutorial
  ms.prod: learning-azure
title: Exercise - Create a DPS resource, root certificate, and group enrollment
durationInMinutes: 12
content: |
  [!include[](includes/4-exercise-create-dps-resource-root-certificate-group-enrollment.md)]


### YamlMime:ModuleUnit
uid: learn.iot.automatically-provision-iot-devices-securely-and-at-scale-with-dps.exercise-create-multiple-leaf-certificates
metadata:
  title: Exercise - create multiple leaf certificates
  description: Create one leaf certificate for each remote sensor device.
  ms.date: 3/15/2020
  author: PeterTurcan
  ms.author: Olivier.Bloch
  ms.topic: interactive-tutorial
  ms.prod: learning-azure
title: Exercise - create multiple leaf certificates
durationInMinutes: 8
content: |
  [!include[](includes/5-exercise-create-multiple-leaf-certificates.md)]


### YamlMime:ModuleUnit
uid: learn.iot.automatically-provision-iot-devices-securely-and-at-scale-with-dps.exercise-create-code-sensor-devices
metadata:
  title: Exercise - create the code for the sensor devices
  description: Create multiple apps, each app simulating one sensor device.
  ms.date: 3/15/2020
  author: PeterTurcan
  ms.author: Olivier.Bloch
  ms.topic: interactive-tutorial
  ms.prod: learning-azure
title: Exercise - create the code for the sensor devices
durationInMinutes: 12
content: |
  [!include[](includes/6-exercise-create-code-sensor-devices.md)]


uid: learn.iot.automatically-provision-iot-devices-securely-and-at-scale-with-dps.exercise-test-multiple-devices-provision-correctly
metadata:
  title: Exercise - test the multiple devices are automatically provisioned and assigned to your hub
  description: Test that all three devices are provisioned automatically by the DPS resource. Test that sensor telemetry is reaching the hub. Finally, test a device twin change in the portal is picked up by the correct device.
  ms.date: 3/15/2020
  author: PeterTurcan
  ms.author: Olivier.Bloch
  ms.topic: interactive-tutorial
  ms.prod: learning-azure
title: Exercise - test the multiple devices are automatically provisioned and assigned to your hub
durationInMinutes: 6
content: |
  [!include[](includes/7-exercise-test-multiple-devices-provision-correctly.md)]


uid: learn.iot.automatically-provision-iot-devices-securely-and-at-scale-with-dps.summary
metadata:
  title: Summary
  description: Summarizes the skills learnt in the module, and finishes with a knowledge check.
  ms.date: 3/15/2020
  author: PeterTurcan
  ms.author: Olivier.Bloch
  ms.topic: interactive-tutorial
  ms.prod: learning-azure
title: Summary
durationInMinutes: 6
content: |
  [!include[](includes/8-summary.md)]
```
