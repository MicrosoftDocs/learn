This unit describes Azure IoT Hub Device Provisioning Service SDKs. It also describes the Trusted Platform Module (TPM) simulator and X.509 generator tools that you can use to test the SDKs.

## Azure IoT Hub Device Provisioning Service SDKs

Azure IoT Hub includes a set of Device Provisioning Service SDKs that developers can use to create programs that communicate with the provisioning service. The DPS SDKs help to provision devices to your IoT hubs. The DPS SDKs provide samples for common scenarios and a set of tools to simplify security attestation in development.

There are three categories of software development kits (SDKs) for working with DPS:

* DPS device SDKs
* DPS service SDKs
* DPS management SDKs

Each DPS SDK category is described in the following sections.

### DPS device SDKs

[DPS device SDKs](/azure/iot-dps/libraries-sdks#device-sdks) provide data plane operations for devices. You use the device SDK to provision a device through DPS.

The DPS device SDKs provide implementations of the Register API and others that devices call to provision through DPS. The device SDKs can run on general MPU-based computing devices such as a PC, tablet, smartphone, or Raspberry Pi. The SDKs support development in C and in modern managed languages including in C#, Node.JS, Python, and Java.

#### Embedded device SDKs

These SDKs were designed and created to run on devices with limited compute and memory resources and are implemented using the C language. FreeRTOS and Bare Metal RTOS are supported.

### DPS service SDKs

[DPS service SDKs](/azure/iot-dps/libraries-sdks#service-sdks) provide data plane operations for backend apps. You can use the service SDKs to create and manage individual enrollments and enrollment groups, and to query and manage device registration records.

The DPS service SDKs help you build backend applications to manage enrollments and registration records in DPS instances. .NET, Java, and Node.js platforms are supported.

### DPS management SDKs

[DPS management SDKs](/azure/iot-dps/libraries-sdks#management-sdks) provide control plane operations for backend apps. You can use the management SDKs to create and manage DPS instances and metadata. For example, to create and manage DPS instances in your subscription, to upload and verify certificates with a DPS instance, or to create and manage authorization policies or allocation policies in a DPS instance. .NET, Java, Node.js, and Python platforms are supported.

## Additional tool support

In addition to the sample code included with the SDKs that can be used for reference, Microsoft provides some additional tooling that may be useful during testing.

### Trusted Platform Module (TPM) simulator

TPM can refer to a standard for securely storing keys to authenticate the platform, or it can refer to the I/O interface used to interact with the modules implementing the standard. TPMs can exist as discrete hardware, integrated hardware, firmware-based, or software-based. In production, TPM is located on the device, either as discrete hardware, integrated hardware, or firmware-based. In the testing phase, a software-based TPM simulator is provided to developers.

This [simulator](/azure/iot-dps/quick-create-simulated-device-tpm) is available for developing for the Windows platform. C, C#, Node.js, Python, and Java platforms are supported.

### X.509 certificate generator

X.509 certificates can be used as an attestation mechanism to scale production and simplify device provisioning. There are several ways to obtain an X.509 certificate:

* For production environment, we recommend purchasing an X.509 CA certificate from a public root certificate authority.
* For testing environment, you can generate an X.509 root certificate or X.509 certificate chain using:
  * OpenSSL: You can use scripts for certificate generation:
    * Node.js
    * PowerShell or Bash
  * Device Identity Composition Engine (DICE) Emulator: DICE can be used for cryptographic device identity and attestation based on TLS protocol and X.509 client certificates.

#### Use an X.509 certificate generator with DICE emulator

The SDKs provide an X.509 certificate generator with DICE emulator, located in the Java SDK. This generator works cross-platform. The generated certificate can be used for development in other languages.

While the DICE Emulator outputs a root certificate, an intermediate certificate, a leaf certificate, and associated private key, the root certificate or intermediate certificate cannot be used to sign a separate leaf certificate. If you intend to test group enrollment scenario where one signing certificate is used to sign the leaf certificates of multiple devices, you can use OpenSSL to produce a chain of certificates.

To generate X.509 certificate using this generator:

1. Prepare the development environment and clone the GitHub repository:   `git clone https://github.com/Azure/azure-iot-sdk-java.git`
2. Change the root to azure-iot-sdk-java.
3. Run `mvn install -DskipTests=true` to download all required packages and compile the SDK.
4. Navigate to the root for X.509 Certificate Generator in `azure-iot-sdk-java/provisioning/provisioning-tools/provisioning-x509-cert-generator`.
5. Build with `mvn clean install`
6. Run the tool using the following commands:

   ```azurecli
    cd target
    java -jar ./provisioning-x509-cert-generator-{version}-with-deps.jar
    
   ```

7. When prompted, you may optionally enter a **Common Name** for your certificates.
8. The tool locally generates a Client Cert, the Client Cert Private Key, Intermediate Cert, and the Root Cert.

Client Cert is the leaf certificate on the device. Client Cert and the associated Client Cert Private Key are needed in device client. Depending on what language you choose, the mechanism to put this in the client application may be different.

The root certificate or intermediate can be used to create an enrollment group or individual enrollment programmatically or using the portal.
