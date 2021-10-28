In this unit, you'll enable trust between your IoT Central application and Azure Sphere.

After you enable trust, any device claimed into your Azure Sphere tenant will automatically be enrolled in your Azure IoT Central application when it first connects.

Follow these steps to enable trust.

1. If you're using Windows, open a Windows **PowerShell command line**. If you're using Linux, open **Terminal**.

2. Sign into your Azure Sphere tenant.

   ```azsphere
   azsphere login
   ```

3. Make a note of the current folder. You'll need the name of this folder in the next step.

4. Download the Azure Sphere tenant certificate authority (CA) certificate:

   ```azsphere
   azsphere ca-certificate download --destination CAcertificate.cer
   ```

   The output file must have the .cer extension.

### Create an Enrollment Group

1. From IoT Central web portal, select the hamburger button on the top-left corner of the screen to expand the sidebar menu.

1. Select **Administration**, then **Device Connection**.

1. Select **+ New**.

1. Name the enrollment group **Azure Sphere**.
1. Leave group type set to **IoT devices**.
1. Select Certificates (X.509) from the Attestation type dropdown.
1. Select Save.

### Upload the Azure Sphere tenant CA certificate to Azure IoT Central and generate a verification code

1. Select **+ Manage primary**.

2. Select the folder icon next to the **Primary** box and navigate to the folder where you downloaded the certificate. If you don't see the .cer file in the list, ensure the view filter is set to **All files (*)**. Select the certificate and then select the gear icon next to the **Primary** box.

3. The **Primary Certificate** dialog box appears. The **Subject** and **Thumbprint** fields contain information about the current Azure Sphere tenant and primary root certificate.

4. Select the **Generate verification code**.

5. Copy the verification code to the clipboard.

    :::image type="content" source="../media/verify-certificate.png" alt-text="Screenshot that shows how to verify a certificate.":::

### Verify the tenant CA certificate

1. Return to the PowerShell Command Line or Linux Terminal.

2. Download a validation certificate that proves you own the Azure Sphere tenant CA certificate. Replace **<code\>** in the command with the verification code from the previous step.

   ```azsphere
   azsphere ca-certificate download-proof --destination ValidationCertification.cer --verification-code <code>
   ```

3. The Azure Sphere Security Service signs the validation certificate with the verification code to prove that you own the Certificate Authority (CA).

### Use the validation certificate to verify the tenant's identity

1. Return to Azure IoT Central and select **Verify**.

2. When prompted, select the validation certificate that you generated in the previous step. When the verification process is complete, the **Primary Certificate** dialog box displays the **Verified** message.

3. Select **Close** to dismiss the box.

    :::image type="content" source="../media/certificate-verified.png" alt-text="Screenshot that shows a verified certificate.":::

4. Select **Save**.



