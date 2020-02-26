With an Azure IoT Hub potentially receiving many thousands of telemetry messages, we want to make it easy for a human operator to see what is going on.

In this module, you'll learn about Azure IoT Hub monitoring. Monitoring encompasses a number of features: logging, diagnostics, metrics, and alerts. Of these features, the alerts are probably the most important. Alerts signal "red flags" to a human operator. Alerts fire when one or more conditions are met. Alerts can also signal more mundane events, information, or warnings, rather than errors. Metrics, diagnostics, and logs, do their job, providing different ways of reporting on current activities.

This module uses the same scenario, and code base, as the [Identify anomalies by routing data via IoT Hub to a built-in ML model in Azure Stream Analytics](https://docs.microsoft.com/learn/modules/data-anomaly-detection-using-azure-iot-hub/). It isn't necessary to complete the anomalies module to complete this one on monitoring. You'll gain valuable insights to the features of Azure IoT Hub by completing both modules, in any order. If you've completed the anomalies module, and still have the IoT Hub resource, you can start from unit 4 of this module.

The scenario we're using is that of a conveyor belt, monitored for vibration.

[![Conceptual art of conveyor belt](../media/vibrations-art2.png)](../media/vibrations-art2.png#lightbox)

## Learning objectives

In this module you will:

- Create an Azure IoT Hub and device identity, using the IoT Hub portal
- Create a device app to send telemetry to the IoT Hub, using Visual Studio or Visual Studio Code
- Learn about metrics, alerts, diagnostics, and logs, to monitor the telemetry sent to the IoT Hub
- Create an email alert, using the IoT Hub portal
- Create an Azure Function, using the IoT Hub portal
- Create an action to trigger the Azure Function, using the IoT Hub portal

## Prerequisites

- An introductory knowledge of Azure IoT
- Ability to navigate the Azure IoT portal
- Ability to use C#, or Node.js, at the beginner level
- Experience using Visual Studio, or Visual Studio Code, at the beginner level

## Learn the scenario

Suppose you manage a packaging facility. Packages are assembled for shipping, then placed on a conveyor belt that takes the packages and drops them off in mailing bins. Your metric for success is the number of packages leaving the conveyor belt.

The conveyor belt is monitored for vibration. The conveyor belt has three speeds: _stopped_, _slow_, and _fast_. The number of packages being delivered at slow speed is less than at the faster speed, though the vibration is also less at the slower speed. If the vibration becomes excessive, the conveyor belt has to be stopped and inspected. A broken conveyor wheel, for example, can exacerbate the vibrations, in a cyclical fashion.

There are a number of different types of vibration. _Natural vibration_, which is just the frequency a structure tends to oscillate. _Forced vibration_ is vibration caused by an external force. Such a force as the broken wheel example, or a weighty package placed improperly on the conveyor belt. There's also _increasing vibration_, which might happen if a design limit is exceeded.

Forced vibration is the dangerous one for our conveyor belt. Even if it starts at a low level this vibration can build so that the structure fails completely.

[![Graph of cyclical forced vibration](../media/vibration1.png)](../media/vibration1.png#lightbox)

Vibration is typically measured as an acceleration (meters per second squared, m/s<sup>2</sup>), though sometimes vibration is measured in g-forces.

With the goal of preventive maintenance, you decide to use Azure IoT Hub to manage the vibration telemetry.

## The first step

The first step to building this system is to create a custom IoT Hub.


### Remaining jobs

1. image alt text - done
1. lightbox utility - done
1. read end to end - done1
1. remove unused images - done
1. check images for PI - done
1. acrolinx again - done1 - done2
1. read code comments for irrelevant stuff - done
1. knowledge check text - done1
1. remove en-us - done
1. check heading capitalization (Email?) - done
1. image line cleanup - done

1. test and read, end to end - done1 -failed
1. verify/change choice of action group names - done
1. add node.js option - done
1. Upload new code to Github - C# and Node.js - done

1. badge artwork
1. test with sandbox



What does DPS stand for?

1.	Device Provisioning System
	Close, but no.

2.	Device Provisioning Service
	The service can be linked to one or more IoT Hubs.

3.	Device Provisioning Security
	Close, but no.

4.	Device Possession Service
	Close, but no.


What is the process of verifying X.509 certificates known as?

1.	Proof of Possession
	Proof of Possession of the CA certificate is provided to DPS by uploading a certificate generated from the CA certificate with the verification code that was just generated within DPS. This is how you provide proof that you own the CA Certificate.

2.	Generate Verification Code
	Generating a verification code is part of the process, but not the name for the complete process.

3.	Add certificate
	Adding a certificate to a DPS service does not verify the certificate.

4.	Enrollment
	Individual or group enrollments can be created, but this is not the verification process.

All devices connecting to Azure DPS will be configured with this Global Device Endpoint?

1.	global.azure-devices-provisioning.net
	All IoT devices connected to Azure use this endpoint.

2.	The setting for ID Scope
	Nope, this identifies the DPS service and IoT Hub.

3.	Your DPS service endpoint
	This does not apply to all devices.

4.	The setting for SecurityProviderX509
	No, this variable is use in the code, and is not related to a global endpoint.

Which allocation policy for Azure IoT DPS systems is the default?

1.	Lowest latency: This policy assigns devices to the linked IoT Hub which will result in the lowest latency communications between device and IoT Hub.
	Not the default. This might work well if several IoT Hubs are in your system.

2.	Evenly weighted distribution: This policy evenly distributes devices across the linked IoT Hubs.
	This is the default, and the right one to use with a single IoT Hub.

3.	Static configuration: This policy requires a desired IoT Hub be listed in the enrollment entry for a device to be provisioned.
	Not the default. This enables a specified IoT Hub to be used for any one device.


Each Group Enrollment requires just one Root X509 certificate. What single certificate is chained to the root certificate?

1.	A Leaf certificate
	No. Multiple Leaf certificates can be created for one Root certificate.

2.	An Intermediate certificate
	No. Multiple Intermediate certificates can be created for one Root certificate.

3.	A Self-signed certificate
	No. This is a mechanism for verifying the certificates.	

4.	A Verification certificate
	Generating a verification code helps ensure proof of possession.

Passwords in our sample code are hard-coded, certificates are stored locally. What system should be used for production-ready passwords and certificates?

1.	The password could be held in an Azure Key Vault, and the certificate pfx file stored in a Hardware Security Module.
	There are alternative secure mechanisms, but this approach is secure.

2.	The process in the sample is fine for production.
	No, it isn't.

3.	Both password and certificate could be held in a Hardware Security Module (HSM).
	A Hardware Security Module is not the best location for a password.

4.	Passwords and certificates are secure, and can be stored in the clear.
	Please, no!

5.	The certificate pfx file could be held in an Azure Key Vault, and the password stored in a Hardware Security Module.
	Not quite, the best storage for certificates and passwords are reversed in this answer.

X.509 certificates validate both your identify, and secures your data through encryption. What is one disadvantage of using these certificates?

1.	The need to distribute public keys, or fingerprints, when creating valid key pairs.
	There is no need to distribute public keys with X.509 certification.

2.	Authentication can be revoked.
	This is an advantage, not a disadvantage, of X.509 certificates.

3.	Lower level of security than public key encryption.
	No, the level of security is equal to, or greater than, public key encryption.

4.	Requires a public-key infrastructure.
	This requirement can increase the cost of initial deployment.

5. 	Use of these certificates is not scalable.
	X.509 certificates are highly scalable.

6.	Requires secret private keys for identity verification.
	This is an advantage, not a disadvantage, of X.509 certificates.

7.	Can be used for many purposes: access to servers, login attempts, single or multiple devices.
	This is an advantage, not a disadvantage, of X.509 certificates.

8.	With Leaf, Intermediate, and Root certificates, and several signing mechanisms, they are complex to understand and use.
	There is a complexity to security, but this is not unique to X.509 certificates, and cannot be considered much of a disadvantage.


Take a guess at the weaknesses of self-signed certificates?

1.	Low-level hash or cypher technologies might have been used to create the certificates.
	This may well be true of the free tools you might use to create the certificates. But this is not the only weakness.

2.	The lifetime of a self-signed certificate is often set at one year, which may interrupt your production process.
	Setting a short expiry time might well become a nuisance. But this is not the only weakness.

3.	Self-signed certificates are not trusted by other apps, operating systems, or cloud resources.
	Of course not, why would they? But this is not the only weakness.

4.	Self-signed certificates are sometimes referred to as "snake oil certificates", to express their untrustworthiness.
	The nickname is true, but nicknames are not in themselves a weakness.

5.	All the above.
	Not quite.

6.	1 to 3 of the above.
	Use CA certificates in a production environment.

7.	None of the above.
	Not in the real world.


Which of the following statements is true?

1.	A root, intermediate, or leaf certificate can be used to validate a device.
	Root and intermediate certificates cannot be used to validate devices.

2.	A root, intermediate, or leaf certificate can be used to sign other certificates.  Only a leaf certificate can be used to validate a device.
	Leaf certificates cannot be used to sign other certificates.

3.	A root certificate can only be used to sign other certificates. An intermediate, or leaf, certificate can be used to validate devices.
	Intermediate certificates cannot be used to validate devices.

4.	Root and intermediate certificates can only be used to sign other certificates. A leaf certificate can be used to validate multiple devices.
	A leaf certificate can only validate one device.

5.	A root, or intermediate, certificate can be used to sign other certificates. Only a leaf certificate can be used to validate a device.
	One root certificate signing multiple leaf certificates is a good scenario for a DPS Group Enrollment.



Intro
=====

An Azure IoT Hub can handle large volumes of telemetry data, sent from many sensor devices. You can individually set up each device, to be certain of its authenticity. However, with many devices, this would be onerous to say the least. The process of validating the authenticity of a device is known as "provisioning". In this module we investigate the IoT Device Provisioning Service (DPS). A service that enables the near-automatic provisioning of any number of devices.

This module builds on the "Remotely monitor and control devices with Azure IoT Hub" module - a fun introduction to IoT Hub programming, using the example of a temperature and humidity sensor in a cheese cave. It is not necessary to complete the introductory module before working on this module on security, though completing it will help your understanding of IoT Hub. The introductory module covers such concepts as Device Twins, and Direct Methods, which are not explained in detail in this module on security.

Security is a gnarly subject, there is more to it than you might think. Completing this module will give you a good foundation for making security decisions for your IoT-based projects.

Learning objectives

In this module you will:

Create a custom Azure IoT Hub, using the Azure portal
Create a DPS service to provision multiple devices, using the Azure portal
Create an app to send device telemetry to the custom IoT Hub, in C#
Learn about security certificates, and the tools used to create them
Create an individual enrollment for the DPS service
Create a group enrollment for the DPS service
Create and test multiple devices being provisioned by the DPS service

Prerequisites

An introductory knowledge of Azure IoT
Ability to navigate Azure IoT portal
Ability to use C#, at the beginner level
Experience using Visual Studio, or Visual Studio Code, at the beginner level

The scenario
------------

The "Remotely monitor and control devices with Azure IoT Hub" module had one sensor in one cheese cave. The sensor ensures the cheese is maturing nicely to the ideal temperature and humidity for your particular brand of cheese.

Suppose you are the manager of the cheese cave maturing process. Your first cheese from the one cave has been a huge success. Your company has expanded rapidly and now has 30 cheese caves. Each cave is used to mature your best-selling cheese, but each cave is also in different locations throughout the country. Some of these caves provide near-ideal conditions without much involvement of a temperature/humidity setting fan. Other caves are not quite so perfectly located, and require a fan to adjust the temperature and humidity, based on the telemetry output of a sensor.

If your cheese business carries on growing, you are going to need solutions that scale smoothly and effortlessly.

You decide on a single Azure IoT Hub to process the telemetry from all thirty sensors. You decide that commercial competition requires that your system is secure, you must be certain of each device before accepting its input. You decide to investigate Azure DPS as your security service.

Cheese making is a competitive business, and you want to keep your secrets well wrapped!

The first step
--------------
The first step is to build an IoT Hub, using the Microsoft Azure portal.

Unit 2: COPY - CREATE THE CHEESE CAVE HUB

In this unit, we will create an IoT Hub.

## Create a custom IoT Hub

1. Make sure you have activated the sandbox, using the button above. This creates a free temporary resource.
1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
1. Select **+ Create a resource**, from the top of the left-hand menu. In the **Search the Marketplace** search box, enter "IoT Hub".
1. Select **IoT Hub** from the search results, and click **Create**.
1. You will be required to enter a **Subscription** from the selection offered to you. A sandbox subscription will be **Concierge Subscription**, so choose that. For **Resource Group** enter <rgn>[sandbox resource group name]</rgn>. A resource group is like a folder, it is largely there to help you organize your resources.
1. The **Region** should be the geographical region closest to you, and finally enter a friendly name (say "CheeseCaveHub-&lt;your ID&gt;") for **IoT Hub Name**.
    >[!IMPORTANT]
    >Your hub names are publicly discoverable, so take this into account when entering names.
1. Select **Next: Size and scale** to view the capabilities of your hub, noting all the services we need are enabled. Open **Advanced Settings** to see the number of partitions. You can leave all entries at their default settings. Or, for peace of mind, you can change **Pricing and scale tier** to **F1: Free tier**, although you will not be charged if you leave this at **S1: Standard tier**, as the sandbox is free.

    > [!NOTE]
    > A single _partition_ has a maximum number of concurrent readers processing data. In our cheese cave scenario, we only have one reader (the back-end service app), so could get away with one partition. However, if high telemetry throughput is an issue, increasing the number of partitions, and number of concurrent connected readers, will aid in increasing efficiency.

1. Now, select **Review + create**, this option gives you a chance to verify your choices before clicking **Create**, and building the hub. Building your hub can take a few minutes.
1. When the IoT Hub is built, click **Go to resource** to go to the home page for your hub. Or search for it in **All Resources**, if you happen to miss the completion message.
1. It is a good idea to bookmark the home page of your IoT Hub.

CREATE DPS SERVICE?

### Create an Azure IoT Hub Device Provisioning Service

A Device Provisioning Service (DPS) can be linked to one, or multiple hubs. So, it is a separate resource, and is independent of any one IoT Hub.

1. In your Azure portal Home page, select **Create a resource**.

1. Type "provisioning" in the search box, and select **IoT Hub Device Provisioning Service**.

1. Create the resource, with a name such as "CheeseCave-DPS". Use the sandbox subscription and resource group options. And choose your **Location**.

1. Create the resource, and wait for it to deploy. Perhaps bookmark a link to the home page of this resource too.

Having created the hub and the provisioning service, let's take a step back and go over some theory. You might find this valuable in understanding the security resources.


Unit 3: Overview of DPS service and X.509 certs

This module uses X.509 certificates to validate devices, before they are allowed to communicate with the IoT Hub. Let's go over some background information about these certificates.

Introduction to X.509 certificates

The basis of the X.509 certificate is the concept of public/private key encryption. A _public_ key enables data to be encrypted. Use of the key distorts the text of the message into incomprehensible characters. A _private_ key is used to decrypt the message, back into its original text. The public key cannot be used to decrypt the message. This is a form of _asymmetric_ encryption. Asymmetric encryption is more secure than _symmetric_ encryption, where the same key is used to encrypt and decrypt a message. However, the private key needs to be kept secret.

To keep private keys secret, a _public key infrastructure_ (PKI) is needed to prevent the keys becoming lost or stolen. This is potentially a disadvantage of the public/private key system. However, using X.509 certificates with the Azure Device Provisioning Service (DPS), a public key infrastructure is built into the service. Users of the service do not even need to know their own private keys. The private keys are generated by helper tools that are publicly available. The keys are stored in the X.509 certificates, and a user does need to do much more than upload them to the Azure DPS.

To validate the authenticity of X.509 certificates, the certificates need to be _signed_. There are two ways of doing this. You can use an organization known as a _Certificate Authority_ (or, CA) that specializes in supplying signed certificates. This might be the right way to go in a production environment, though of course there can be a cost involved. The alternative is known as _self-signed_ certificates, where the user validates their own certificates. There is no cost to this second option, though as you would be relying on publicly available tools, this system is not recommended for production. For our purposes in this module, self-signed certificates will work fine.

The name "X.509" originates from the format the certificate is stored in.

With the X.509 certificates and the PKI, there is no need to distribute the public keys when creating key pairs. Another advantage is that the PKI can maintain a list of invalidated certificates, so authentication can be centrally revoked.

There is a bit more to the X.509 story that you need to know, as it is central to our sample.

Root, Intermediate, and Leaf certificates

There is perhaps a third way of signing certificates. That is, a certificate can be used to validate another certificate. Such a certificate is known as a _root certificate_, or sometimes a _trust anchor_. This one certificate is not used to validate any devices, for example, but is only used to validate a range of sub-ordinate certificates.

These subordinate certificates can be _intermediate certificates_. An intermediate certificate is again not used to validate devices, but only to validate other intermediate certificates, or validate _leaf_ certificates. We will not be using any intermediate certificates in our sample.

A leaf certificate, as its name suggests, is the end-entity certificate that is used to validate a device. Leaf certificates cannot be used to validate other certificates. The root certificate is used to validate any number of intermediate, or leaf, certificates.

In our sample, we will generate one root certificate for all our devices. From that root, we will generate one leaf certificate for each device that we will be connecting to the IoT Hub.

All these certificates will be self-signed.

Cryptography is a complex technology, that goes deep into mathematics, so is not for everyone. Follow the links on the Summary page of this module, if you are interested in a deeper introduction than we have given here. For the record, X.509 certification is the basis of the secure HTTPS protocol - for secure browsing of the internet.

Suffice to conclude that public/private key technology is state-of-the-art security, and by using X.509 certificates correctly, you can be confident you IoT Hub is secure. Secure against an invalid device supplying invalid data, and secure against a denial-of-service type attack. However, no security is perfect, and doing your own research is recommended.

An Azure Device Provisioning Service can be linked to one, or more, IoT Hubs, and can be thought of as a system for managing your certificates, and managing your enrollments.

Individual and Group Enrollments

An Azure DPS can contain a number of individual, or group, enrollments. In our scenario, the group enrollment provides the solution we are looking for. One enrollment group works with one root certificate, and any number of leaf certificates signed by this root. An enrollment maintains information on all the devices that have tried to register, and those that have succeeded.

Individual enrollments are best used for devices that have a unique configuration, and require greater security than the connection strings you may have used in other Learn modules or Azure samples. This is not what we are looking for in our scenario, where we have many sensors configured to provide an identical set of telemetry data.

Another concept you will see when we create an Azure DPS resource, is that of _allocation policy_. This is not something we delve into. Allocation policies only apply when you have multiple IoT Hubs handling telemetry from a huge number of devices, and want to direct the incoming data to one of these hubs based on a policy.

After creating your enrollments, and self-signed root certificate, there is one more process necessary to prove to the provisioning service that you own the root certificate.

Proof of Possession

When uploading certificates to Azure DPS, you will be asked to generate a verification code.

_Proof of Possession_ of a certificate is provided to DPS by uploading a _verification_ certificate generated from the root certificate with the verification code that you generated within DPS. The verification certificate is _chained_ to the root certificate.

This process is how you provide proof that you own the root certificate. There is no need to provide proof of possession of the leaf certificates, as  if you own the root, trust has been established so you must own all the leaf certificates generated from that root.

The next step, let’s create an Azure DPS resource, and all the necessary certificates.
 
Unit 4: Create group enrollment and Root certs

1. Open the Azure Cloud Shell, and select the **Bash** shell option. We need the Bash option, as the helper tools that you will download next are written for Bash.

1. Run the following script. It creates a certificate directory in the shell storage, and downloads some helper scripts to it. 

```cli
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
These helper scripts are downloaded from the Azure/azure-iot-sdk-c open source project hosted on GitHub. This is an open source project that’s a part of the Azure IoT SDK. The certGen.sh helper script will help demonstrate the purpose of CA Certificates without diving into the specifics of OpenSSL configuration that’s outside the scope of this module. If you need additional instructions on using these helper scripts, or for instructions on how to use PowerShell instead of Bash, refer to [CACertificateOverview](https://github.com/Azure/azure-iot-sdk-c/blob/master/tools/CACertificates/CACertificateOverview.md).

[!warning]
Do not use these helper scripts in a production environment, as they contain hard-coded passwords that expire after 30 days. These scripts are provided only for demonstration purposes.

1. Run the following command to generate root and intermediate certificates. We are only interested in the root certificate, which will be named `azure-iot-test-only.root.ca.cert.pem`.

```cli
 ./certGen.sh create_root_and_intermediate
```

1. We need to download the root certificate to your local machine, to upload it to Azure DPS. Type:

```cli
 download ~/certificates/certs/azure-iot-test-only.root.ca.cert.pem
```

### Configure Azure DPS to trust the root certificate

1. In the Azure portal, navigate to the cheese cave DPS resource you created earlier.

1. In the **Settings** section, click **Certificates**.

1. Click **Add**. For the **Certificate Name**, enter an understandable name such as "cheesecave-dps-root". The name does not have to be the same as the certificate filename.

1. For **Certificate .pem or .cer file**, navigate to and select the azure-iot-test-only.root.ca.cert.pem file that you downloaded.

1. Click **Save**.

After the root certificate has been uploaded, the **Certificates** pane will display the certificate with the status of **Unverified**. Before this CA Certificate can be used to authenticate devices to DPS, you will need to verify _Proof of Possession_ of the certificate.

1. In the **Certificates** pane, click on the certificate to open the **Certificate Details** pane.

1. Click **Generate Verification Code**.

1. Copy the **Verification Code** that is displayed above the **Generate Verification Code** button. There is a button to the right of the textbox to do this for you. Open a text editor, such as Notepad, and paste in the verification code.

Proof of Possession of the CA certificate is provided to DPS by uploading a verification certificate generated from the root certificate. The verification certificate contains the verification code you just generated. This is how you provide proof that you own the CA Certificate.

1. Leave the **Certificate Details** pane open while you generate the verification certificate. If you close the pane, you will invalidate the verification code, and will need to generate a new one.

1. Copy the following command to the text file containing the verification code, and change the <verification-code> to the actual code.

```cli
 ./certGen.sh create_verification_certificate <verification-code>
```

1. Back in the Azure Cloud Shell, and in the **certificates** directory, run the completed command. This generates a verification certificate that is chained to the root certificate. The generated certificate is named `verification-code.cert.pem`, and is located within the **./certs** directory of the Azure Cloud Shell.

1. Run the following command to download the verification certificate to your local machine. 

```cli
download ~/certificates/certs/verification-code.cert.pem
```

1. Change focus back to the **Certificate Details** pane of the Azure portal. For **Verification Certificate .pem or .cer file**, select the `verification-code.cert.pem` file.

1. Click **Verify**, and verify that in the **Certificates** pane, the status for the certificate is now displayed as **Verified**. You may need to use the refresh button at the top of the pane to see this change.

This is great progress, you have created a root certificate, and validated to Azure DPS that you own it. The next step is to create a **Group Enrollment**, and link it to the root certificate.

### Create a Group Enrollment in Azure DPS

1. In the Azure portal, with your DPS resource selected, locate the **Settings** section.

1. Click **Manage enrollments**, then **Add enrollment group**. Make sure you are adding a group, and not an individual, enrollment.

1. For **Group Name**, enter "cheesecave-devices".

1. Ensure that the **Attestation Type** is set to **Certificate**, and that the **Certificate Type** field is set to **CA Certificate**. These settings are the defaults.

1. In the **Primary Certificate** dropdown, select your CA certificate. This will be **cheesecave-dps-root**, if you used the suggested name.

1. Leave the **Secondary Certificate** dropdown set to **No certificate selected**. You are not required to have a secondary certificate.

1. Leave **Select how you want to assign devices to hubs** as **Evenly weighted distribution**. As you only have one IoT Hub associated with the enrollment, this setting is unimportant. If you have multiple IoT hubs, this setting will control which hub should receive this device enrollment.

1. Verify that your IoT Hub is selected in the **Select the IoT hubs this device can be assigned to** field. Leave the re-provisioning settings at their defaults.

1. Finally, click **Save**, and verify your new enrollment group appears in the **Enrollment Groups** pane.

A group enrollment is going to be very useful in handling remote devices at scale. The next few units create multiple leaf certificates, and multiple devices. 

Naming
======
cheesecave-dps-root
cheesecave-dps-leaf1...N
cheesecave-device1...N
cheesecave-hub

Unit 5: Create multiple Leaf certs  [	MAYBE COMBINE WITH UNIT 4 ]	

In this unit, we need to create one leaf certificate for each device that we want to send telemetry to the hub. Two is company, three is a crowd. So, let's create code for a "crowd" of devices. Remember, in our scenario description we stated that there were now 30 cheese caves, requiring 30 sensor devices. Let's limit this to three for the sake of explanation and testing!

1. In the Azure Cloud Shell, make sure you are in the **certificates** folder.

1. Run the following command:

```cli
 ./certGen.sh create_device_certificate cheesecave-device1
```
	
1. To download the created certificate to your local machine, type:
```cli
download ~/certificates/certs/new-device.cert.pfx
```

1. Create a new folder in your **Documents** folder, called "cheesecave certificates", or something similar.

1. Copy the **new-device-cert.pfx** file from its downloaded location into the cheesecave certificates folder, and rename it **new-device-cert1.pfx**.

1. In the Azure Cloud Shell, delete the **new-device-cert.pfx** file. This is important so that the tools can be used to create further certificates. You can delete the file, in the certificates folder, by typing `rm *.pfx`, and answering "y" or "n" for each file.

1. In the Azure Cloud Shell, create a second leaf certificate:

```cli
 ./certGen.sh create_device_certificate cheesecave-device2
```

1. Download the second certificate to your local machine, type:
```cli
download ~/certificates/certs/new-device.cert.pfx
```

1. Copy the **new-device-cert.pfx** file from its downloaded location into the cheesecave certificates folder, and rename it **new-device-cert2.pfx**.

1. In the Azure Cloud Shell, delete the **new-device-cert.pfx** file. This is important so that the tools can be used to create further certificates. You can delete the file, in the certificates folder, by typing `rm *.pfx`, and answering "y" or "n" for each file.

1. In the Azure Cloud Shell, create a third leaf certificate:

```cli
 ./certGen.sh create_device_certificate cheesecave-device3
```

1. Download the third certificate to your local machine, type:
```cli
download ~/certificates/certs/new-device.cert.pfx
```

1. Copy the **new-device-cert.pfx** file from its downloaded location into the cheesecave certificates folder, and rename it **new-device-cert3.pfx**.

Great, you now have a root certificate, a validation certificate, and three leaf certificates. The next step is to write some code to simulate each device.


Unit 6: Create the code for the sensor devices

In this unit, we create the code running on each sensor device. 

One of the goals is to make the code as identical as possible for each device, so minimalizing human involvement. The code will require one tweak as we prepare it for a second device, the path to the leaf certificate needs to be unique for each device. Unique in this case means changing a "1" to a "2" or "3". This change is so minor it could easily be automated in a production environment.

The code is written in C#, and you can choose Visual Studio, or Visual Studio Code, as your development environment.

	Project stuff
	Code stuff
	COPY FROM CHEESE CAVE CODE SETUP

	Repeat all the steps in this unit, but change the Leaf path from "xxx" to "xxx".

	Again, repeat all the steps in this unit, but change the Leaf path from "xxx" to "xxx".

Great, a bit of repetitive work, but we now have our crowd of devices. The next step is to set all three apps running, and test our DPS resource and IoT Hub handle the telemetry correctly.



Unit 7: Test your IoT Hub and DPS with multiple devices
	
In this unit we verify that all the pieces we have put in place work as expected. We will set all the device apps running, then check the provisioning service handles the registration correctly. Then we will check that the IoT Hub gets automatic updates to its list of connected IoT devices. Finally, we change some device twin settings in the portal, and verify that the correct device picks these changes up.

> [!TIP]
> With three console screens running, a Visual Studio instance to initiate the devices, and a browser view of the Azure portal, it can help to have multiple monitors. The more screen real estate you have available for testing, the easier you will find testing is!


1.	Start the three device apps running. Verify all three are sending telemetry.

1.	In the Azure portal for your DPS service, go to Metrics, and verify all three devices connected.

1. 	In the Azure portal for your IoT Hub, go to devices and see that all three have connected automatically.

1.	In the Azure portal for your IoT Hub, go to Metrics, and verify telemetry is received.

1.	Back in the IoT Devices, select cheesecave-device1.  Then, in the bar, select **Device Twin**.

1. 	Locate the **desired** section of the **properties** in the code that appears.

1.	Change the desired temperature to something different and noticeable: say "50.123". And click **Save**.

1.	Verify, in the console output, that the change is picked up quickly by the device.

If all this worked as expected, great work. You now know what needs to be done to provision devices at scale. We limited ourselves to three devices, but you can imagine, with some automation and tooling, how you could provision a large number of devices, with minimum human involvement.

To complete the module, let's summarize the goals, and finish with a knowledge check.





images
1.	3 console screens, showing registration IDs
2.	DPS metrics - number of devices assigned
3.	Hub metrics - telemetry messages received and/or device twin activity

Optionally:
	set device twin desired temperature, and send out
image:
1.	one device receiving device twin message



Unit 8: Summary

Completing this module should have given you some valuable insights into the dark world of cryptography and message security. If you are new to this world, you will appreciate the thought and design that has gone into X.509 certificates, and Azure DPS Group Enrollments. You will see how these technologies neatly maps the root and leaf X.509 certificates to an IoT Hub and its range of IoT devices. You will also appreciate how well these technologies make security user-friendly enough for those of us who don't want to know too much about the underlying math.

In this module, you.....



To delete old certs:
cd certs
rm new*
'y'
cd ..








