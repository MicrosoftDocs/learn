In this exercise, you generate an X.509 CA certificate using OpenSSL within the Azure Cloud Shell, then you create an enrollment group in your Device Provisioning Service (DPS) instance for IoT devices to provision using X.509 authentication.

This X.509 CA certificate is used to sign the device certificates for each device in this enrollment group. The enrollment group in DPS only needs a copy of this top CA certificate. When a device connects to DPS for provisioning, it presents its certificate chain of authority that shows its device certificate, any intermediate certificates, and the top CA certificate.

### Task 1: Generate root and intermediate CA certificates

In this section, you generate an X.509 CA certificate using OpenSSL. This certificate is used to configure a group enrollment within DPS.

1. In the Azure sandbox, create a directory named **certificates** and then move into a new directory using the following commands:

   ```azurecli
   mkdir certificates
   cd certificates
   ```

2. Download a helper script and two OpenSSL configuration files that you use to create X.509 certificates. 

   Download files

   ```azurecli
   curl https://raw.githubusercontent.com/Azure/azure-iot-sdk-c/main/tools/CACertificates/certGen.sh --output certGen.sh
   curl https://raw.githubusercontent.com/Azure/azure-iot-sdk-c/main/tools/CACertificates/openssl_device_intermediate_ca.cnf --output openssl_device_intermediate_ca.cnf
   curl https://raw.githubusercontent.com/Azure/azure-iot-sdk-c/main/tools/CACertificates/openssl_root_ca.cnf --output openssl_root_ca.cnf
   ```

   Update script permissions so a user can read, write, and execute it.

   ```sh
   chmod 700 certGen.sh
   ```

   The helper script and supporting files are hosted in the **Azure/azure-iot-sdk-c** open source project hosted on GitHub, which is a component of the Azure IoT Device SDK. The **certGen.sh** helper script provides you with a chance to see how CA certificates are used without diving too deeply into the specifics of OpenSSL configuration (which is outside the scope of this module).

   For more instructions on using this helper script, and for instructions on how to use PowerShell instead of Bash, see: [Managing test CA certificates for samples and tutorials](https://github.com/Azure/azure-iot-sdk-c/blob/master/tools/CACertificates/CACertificateOverview.md)

   > [!WARNING]
   > Certificates created by this helper script **MUST NOT** be used for production. They contain hard-coded passwords ("*1234*"), expire after 30 days, and are provided for demonstration purposes only. When using CA certificates in production, be sure to apply your company's security best practices for certificate creation and lifetime management.

   If you are interested, you can quickly read the contents of the script file that you downloaded by using the `cat` command.

   ```sh
   cat certGen.sh
   ```

3. Enter the following command to generate the root and intermediate certificates:

   ```sh
   ./certGen.sh create_root_and_intermediate
   ```

   Notice that you ran the script with the **create_root_and_intermediate** option. This command assumes that you are running the script from within the **~/certificates** directory.

   This command generated a root CA certificate named **azure-iot-test-only.root.ca.cert.pem** and placed it within a **./certs** directory (under the certificates directory that you created).

### Task 2: Create a group enrollment (X.509 certificate) in DPS

1. In the Azure sandbox, upload your CA certificate to your Device Provisioning Service instance. The certificate name is `groupCA-sensors`. The `verified true` command parameter allows the certificate to be verified automatically on upload, bypassing the need for an extra step for certificate proof of possession generation.

   ```azurecli
   az iot dps certificate create --dps-name dps-$suffix --certificate-name groupCA-sensors --path ~/certificates/certs/azure-iot-test-only.root.ca.cert.pem --verified true
   ```

2. Create an enrollment group in your DPS instance.

   ```azurecli
   az iot dps enrollment-group create --dps-name dps-$suffix --enrollment-id enrollgroup-sensors --root-ca-name groupCA-sensors --iot-hubs hub-$suffix.azure-devices.net --initial-twin-properties "{'telemetryDelay':'1'}" --allocation-policy static
   ```

   This command creates an enrollment group with the following parameters:

   | Parameter | Description |
   | --------- | ----------- |
   | `--dps-name` | The DPS identifier. |
   | `--enrollment-id` | The name of the new enrollment group. |
   | `--root-ca-name` | Sets the attestation method for the enrollment group to be X.509 CA-signed certificates, and points to the CA certificate that you uploaded to DPS. |
   | `--iot-hubs` | Configures DPS to provision the devices in this enrollment group to the IoT hub that you created and linked to DPS at the beginning of this module. |
   | `--initial-twin-properties` | Sets a desired property that all devices in this enrollment group receive once they're provisioned. The devices use the **properties.desired.telemetryDelay** property to set the time delay for reading and sending telemetry to IoT Hub. |
   | `allocation-policy` | Used to determine how a device is assigned to an IoT Hub. A static policy allows you to designate a single IoT hub that you want to assign devices to. |

## Check your work

1. Verify that the root CA **azure-iot-test-only.root.ca.cert.pem** file was created in the /certs folder.

   ```azurecli
   dir ~/certificates/certs/
   ```

2. Verify that the CA certificate was uploaded to your Device Provisioning Service (DPS) instance.

   ```azurecli
   az iot dps certificate show --certificate-name groupCA-sensors --dps-name dps-$suffix
   ```

   Examine the command return information. Verify that the CA certificate name is `groupCA-sensors` as shown here.

      ```azurecli
      "name": "groupCA-sensors"
      ```

3. Examine this command return information to verify that the DPS enrollment group was created with the parameters that you specified in the `az iot dps certificate create` statement in task 2, step 2.

   ```azurecli
   az iot dps enrollment-group show --dps-name dps-$suffix --enrollment-id enrollgroup-sensors
   ```
