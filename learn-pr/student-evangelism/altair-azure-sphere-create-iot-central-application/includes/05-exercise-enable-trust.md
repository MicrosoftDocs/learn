In this unit, you'll enable trust between your Azure IoT Central application and Azure Sphere and do related tasks.

After you enable trust, any device claimed into your Azure Sphere tenant will automatically be enrolled in your Azure IoT Central application when it first connects.

## Create a trust relationship

1. If you're using Windows, open a Windows PowerShell command line. If you're using Linux, open a terminal.

2. Sign in to your Azure Sphere tenant:

   ```azsphere
   azsphere login
   ```

3. Make a note of the current folder. You'll need the name of this folder in the next step.

4. Download the Azure Sphere tenant's CA certificate:

   ```azsphere
   azsphere ca-certificate download --destination CAcertificate.cer
   ```

   The output file must have the .cer extension.

## Create an enrollment group

1. From the Azure IoT Central web portal, select the menu button on the upper-left corner of the screen to expand the sidebar menu.

1. Select **Administration** > **Device Connection**.

1. Select **+ New**.

1. Name the enrollment group **Azure Sphere**.
1. Leave group type set to **IoT devices**.
1. In the **Attestation type** dropdown list, select **Certificates (X.509)**.
1. Select **Save**.

## Upload the Azure Sphere tenant's CA certificate to Azure IoT Central and generate a verification code

1. Select **+ Manage primary**.

2. Select the folder icon next to the **Primary** box and browse to the folder where you downloaded the certificate. If you don't see the *.cer* file in the list, ensure that the view filter is set to **All files (*)**. Select the certificate, and then select the gear icon next to the **Primary** box.

3. The **Primary certificate** dialog appears. The **Subject** and **Thumbprint** boxes contain information about the current Azure Sphere tenant and primary root certificate. Select **Generate verification code**.

5. Copy the verification code to the clipboard.

    :::image type="content" source="../media/verify-certificate.png" alt-text="Screenshot that shows the dialog box for managing a primary certificate.":::

## Verify the tenant CA certificate

1. Return to the PowerShell command line or Linux terminal.

2. Download a validation certificate. Replace `<code\>` in the following command with the verification code from the previous step:

   ```azsphere
   azsphere ca-certificate download-proof --destination ValidationCertification.cer --verification-code <code>
   ```

3. The Azure Sphere Security Service signs the validation certificate with the verification code to prove that you own the CA certificate.

## Use the validation certificate to verify the tenant's identity

1. Return to Azure IoT Central and select **Verify**.

2. When you're prompted, select the validation certificate that you generated in the previous step. When the verification process is complete, the **Primary certificate** dialog displays the **Verified** message.

    :::image type="content" source="../media/certificate-verified.png" alt-text="Screenshot that shows a verified certificate.":::

3. Select **Close** to close the dialog.    

4. Select **Save**.



