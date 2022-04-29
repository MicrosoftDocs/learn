A set of Azure IoT Provisioning Service SDKs is provided so that developers can use a convenience layer for writing clients that talk to the provisioning service. The SDKs also provide samples for common scenarios and a set of tools to simplify security attestation in development. The DPS SDKs provide support for managing the provisioning service and for managing device provisioning.

## Device Provisioning Service SDK overview

The Device Provisioning Service SDKs support the following dev languages:

 -  C\#
 -  C
 -  Java
 -  Node.js
 -  Python

The Azure Provisioning device and service SDKs for C\# can be downloaded from NuGet as follows:

 -  Provisioning Device Client SDK
 -  Provisioning Service Client SDK

### Features of the Provisioning Device SDK

The Provisioning Device SDK supports the following protocols: MQTT, MQTT-WS, AMQP, AMQP-WS, and HTTPS.

:::row:::
  :::column:::
    **Features**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    TPM Individual Enrollment
  :::column-end:::
  :::column:::
    This SDK supports connecting your device to the Device Provisioning Service via individual enrollment using Trusted Platform Module. TPM over MQTT (and MQTT-WS) is currently not supported by the Device Provisioning Service.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    X.509 Individual Enrollment
  :::column-end:::
  :::column:::
    This SDK supports connecting your device to the Device Provisioning Service via individual enrollment using X.509 root certificate.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    X.509 Enrollment Group
  :::column-end:::
  :::column:::
    This SDK supports connecting your device to the Device Provisioning Service via individual enrollment using X.509 leaf certificate.
  :::column-end:::
:::row-end:::


> [!NOTE]
> WebSocket support for MQTT/AMQP is limited to .NET Framework 4.x.

### Features of the Provisioning Service SDK

The Provisioning Service SDK can be used to programmatically enroll devices.

:::row:::
  :::column:::
    **Feature**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    CRUD Operation with TPM Individual Enrollment
  :::column-end:::
  :::column:::
    ️Programmatically manage device enrollment using TPM with the service SDK.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Bulk CRUD Operation with TPM Individual Enrollment
  :::column-end:::
  :::column:::
    Programmatically bulk manage device enrollment using TPM with the service SDK.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    CRUD Operation with X.509 Individual Enrollment
  :::column-end:::
  :::column:::
    Programmatically manage device enrollment using X.509 individual enrollment with the service SDK.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    CRUD Operation with X.509 Group Enrollment
  :::column-end:::
  :::column:::
    Programmatically manage device enrollment using X.509 group enrollment with the service SDK.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Query enrollments
  :::column-end:::
  :::column:::
    Programmatically query registration states with the service SDK.
  :::column-end:::
:::row-end:::


## Additional tool support

In addition to the sample code included with the SDKs that can be used for reference, Microsoft provides some additional tooling that may be useful during testing.

### Trusted Platform Module (TPM) simulator

TPM can refer to a standard for securely storing keys to authenticate the platform, or it can refer to the I/O interface used to interact with the modules implementing the standard. TPMs can exist as discrete hardware, integrated hardware, firmware-based, or software-based. In production, TPM is located on the device, either as discrete hardware, integrated hardware, or firmware-based. In the testing phase, a software-based TPM simulator is provided to developers.

> [!NOTE]
> This simulator is only available for developing on Windows platform for now.

Steps for using the TPM simulator are:

1.  Prepare the development environment and clone the GitHub repository: `git clone https://github.com/Azure/azure-iot-sdk-java.git`
2.  Navigate to the TPM simulator folder under `azure-iot-sdk-java/provisioning/provisioning-tool/tpm-simulator/`.
3.  Run Simulator.exe prior to running any client application for provisioning device.
4.  Let the simulator run in the background throughout the provisioning process to obtain registration ID and Endorsement Key. Both values are only valid for one instance of the run.

### X.509 certificate generator

X.509 certificates can be used as an attestation mechanism to scale production and simplify device provisioning. There are several ways to obtain an X.509 certificate:

 -  For production environment, we recommend purchasing an X.509 CA certificate from a public root certificate authority.
 -  For testing environment, you can generate an X.509 root certificate or X.509 certificate chain using:
    
     -  OpenSSL: You can use scripts for certificate generation:
        
         -  Node.js
         -  PowerShell or Bash
     -  Device Identity Composition Engine (DICE) Emulator: DICE can be used for cryptographic device identity and attestation based on TLS protocol and X.509 client certificates.

#### Using X.509 certificate generator with DICE emulator

The SDKs provide an X.509 certificate generator with DICE emulator, located in the Java SDK. This generator works cross-platform. The generated certificate can be used for development in other languages.

Currently, while the DICE Emulator outputs a root certificate, an intermediate certificate, a leaf certificate, and associated private key. However, the root certificate or intermediate certificate cannot be used to sign a separate leaf certificate. If you intend to test group enrollment scenario where one signing certificate is used to sign the leaf certificates of multiple devices, you can use OpenSSL to produce a chain of certificates.

To generate X.509 certificate using this generator:

1.  Prepare the development environment and clone the GitHub repository: `git clone https://github.com/Azure/azure-iot-sdk-java.git`
2.  Change the root to azure-iot-sdk-java.
3.  Run `mvn install -DskipTests=true` to download all required packages and compile the SDK.
4.  Navigate to the root for X.509 Certificate Generator in `azure-iot-sdk-java/provisioning/provisioning-tools/provisioning-x509-cert-generator`.
5.  Build with `mvn clean install`
6.  Run the tool using the following commands:
    
    ```
    cd target
    java -jar ./provisioning-x509-cert-generator-{version}-with-deps.jar
    
    ```
7.  When prompted, you may optionally enter a Common Name for your certificates.
8.  The tool locally generates a Client Cert, the Client Cert Private Key, Intermediate Cert, and the Root Cert.

Client Cert is the leaf certificate on the device. Client Cert and the associated Client Cert Private Key are needed in device client. Depending on what language you choose, the mechanism to put this in the client application may be different.

The root certificate or intermediate can be used to create an enrollment group or individual enrollment programmatically or using the portal.
