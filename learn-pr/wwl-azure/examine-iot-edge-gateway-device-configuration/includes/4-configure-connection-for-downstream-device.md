In a transparent gateway scenario, one or more devices can pass their messages through a single gateway device that maintains the connection to IoT Hub. A downstream device can be any application or platform that has an identity created with the Azure IoT Hub cloud service. In many cases, these applications use the Azure IoT device SDK. A downstream device could even be an application running on the IoT Edge gateway device itself.

The sections below describe common problems with downstream device connections and guide you in setting up your downstream devices by:

 -  Explaining transport layer security (TLS) and certificate fundamentals.
 -  Explaining how TLS libraries work across different operating systems and how each operating system deals with certificates.
 -  Providing samples in Bash and PowerShell to help get you started.

## Prerequisites

You will need to have the **azure-iot-test-only.root.ca.cert.pem** certificate file that was generated for your transparent gateway available on your downstream device. Your downstream device uses this certificate to validate the identity of the gateway device.

## Prepare a downstream device

A downstream device can be any application or platform that has an identity created with the Azure IoT Hub cloud service. In many cases, these applications use the Azure IoT device SDK. A downstream device could even be an application running on the IoT Edge gateway device itself. However, another IoT Edge device cannot be downstream of an IoT Edge gateway.

> [!NOTE]
> IoT devices that have identities registered in IoT Hub can use module twins to isolate different process, hardware, or functions on a single device. IoT Edge gateways support downstream module connections using symmetric key authentication but not X.509 certificate authentication.

To connect a downstream device to an IoT Edge gateway, you need two things:

 -  A device or application that's configured with an IoT Hub device connection string appended with information to connect it to the gateway. This step is explained in Authenticate a downstream device to Azure IoT Hub.
 -  The device or application has to trust the gateway's root CA certificate to validate the TLS connections to the gateway device. This step is explained in detail in the rest of this article. This step can be performed one of two ways: by installing the CA certificate in the operating system's certificate store, or (for certain languages) by referencing the certificate within applications using the Azure IoT SDKs.

## Transport layer security and certificate fundamentals

The challenge of securely connecting downstream devices to IoT Edge is just like any other secure client/server communication that occurs over the Internet. A client and a server securely communicate over the Internet using Transport layer security (TLS). TLS is built using standard Public key infrastructure (PKI) constructs called certificates. TLS is a fairly involved specification and addresses a wide range of topics related to securing two endpoints. This section summarizes the concepts relevant for you to securely connect devices to an IoT Edge gateway.

When a client connects to a server, the server presents a chain of certificates, called the server certificate chain. A certificate chain typically comprises a root certificate authority (CA) certificate, one or more intermediate CA certificates, and finally the server's certificate itself. A client establishes trust with a server by cryptographically verifying the entire server certificate chain. This client validation of the server certificate chain is called server chain validation. The client cryptographically challenges the service to prove possession of the private key associated with the server certificate in a process called proof of possession. The combination of server chain validation and proof of possession is called server authentication. To validate a server certificate chain, a client needs a copy of the root CA certificate that was used to create (or issue) the server's certificate. Normally when connecting to websites, a browser comes pre-configured with commonly used CA certificates so the client has a seamless process.

When a device connects to Azure IoT Hub, the device is the client and the IoT Hub cloud service is the server. The IoT Hub cloud service is backed by a root CA certificate called Baltimore CyberTrust Root, which is publicly available and widely used. Since the IoT Hub CA certificate is already installed on most devices, many TLS implementations (OpenSSL, Schannel, LibreSSL) automatically use it during server certificate validation. A device that may successfully connect to IoT Hub may have issues trying to connect to an IoT Edge gateway.

When a device connects to an IoT Edge gateway, the downstream device is the client and the gateway device is the server. Azure IoT Edge allows operators (or users) to build gateway certificate chains however they see fit. The operator may choose to use a public CA certificate, like Baltimore, or use a self-signed (or in-house) root CA certificate. Public CA certificates often have a cost associated with them, so are typically used in production scenarios. Self-signed CA certificates are preferred for development and testing. The transparent gateway setup articles listed in the introduction use self-signed root CA certificates.

When you use a self-signed root CA certificate for an IoT Edge gateway, it needs to be installed on or provided to all the downstream devices attempting to connect to the gateway.

:::image type="content" source="../media/m06-l03-edge-gateway-downstream-device-gateway-setup-6750e62a.png" alt-text="Diagram that shows the certificate chain to leaf devices when using a self-signed root CA certificate for an IoT Edge gateway.":::


## Provide the root CA certificate

To verify the gateway device's certificates, the downstream device needs its own copy of the root CA certificate. If you used the scripts provided in the IoT Edge git repository to create test certificates, then the root CA certificate is called azure-iot-test-only.root.ca.cert.pem. If you haven't already as part of the other downstream device preparation steps, move this certificate file to any directory on your downstream device. You can use a service like Azure Key Vault or a function like Secure copy protocol to move the certificate file.

## Install certificates in the OS

Installing the root CA certificate in the operating system's certificate store generally allows most applications to use the root CA certificate. There are some exceptions, like NodeJS applications that don't use the OS certificate store but rather use the Node runtime's internal certificate store. If you can't install the certificate at the operating system level, you will need to use the Azure IoT SDKs to install certificates.

### Ubuntu

The following commands are an example of how to install a CA certificate on an Ubuntu host. This example assumes that you're using the **azure-iot-test-only.root.ca.cert.pem** certificate from the prerequisites articles, and that you've copied the certificate into a location on the downstream device.

```bash
sudo cp <path>/azure-iot-test-only.root.ca.cert.pem /usr/local/share/ca-certificates/azure-iot-test-only.root.ca.cert.pem.crt
sudo update-ca-certificates

```

You should see a message that says, "Updating certificates in /etc/ssl/certs... 1 added, 0 removed; done."

### Windows

The following steps are an example of how to install a CA certificate on a Windows host. This example assumes that you're using the **azure-iot-test-only.root.ca.cert.pem** certificate from the prerequisites articles, and that you've copied the certificate into a location on the downstream device.

You can install certificates using PowerShell's Import-Certificate as an administrator:

```PowerShell
import-certificate  <file path>\azure-iot-test-only.root.ca.cert.pem -certstorelocation cert:\LocalMachine\root

```

You can also install certificates using the certlm utility:

1.  In the Start menu, search for and select **Manage computer certificates**. A utility called **certlm** opens.
2.  Navigate to **Certificates - Local Computer** &gt; **Trusted Root Certification Authorities**.
3.  Right-click **Certificates** and select **All Tasks** &gt; **Import**. The certificate import wizard should launch.
4.  Follow the steps as directed and import certificate file `<path>/azure-iot-test-only.root.ca.cert.pem`. When completed, you should see a "Successfully imported" message.

Typically applications use the Windows provided TLS stack called Schannel to securely connect over TLS. Schannel requires that any certificates be installed in the Windows certificate store before attempting to establish a TLS connection.
