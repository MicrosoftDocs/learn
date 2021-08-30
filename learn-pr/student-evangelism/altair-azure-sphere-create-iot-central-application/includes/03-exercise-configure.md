In this exercise, you'll create an Azure Iot Central application and link it to your Azure Sphere tenant.

## Step 1: Create a new Azure IoT Central application

1. Open the IoT Central web portal by selecting this link [Azure IoT Central](https://azure.microsoft.com/services/iot-central?azure-portal=true).

1. Select **Build a solution**.

1. You'll need to sign with your Microsoft personal, work, or school account. If you don't have a Microsoft account, then you can create one for free by using the **Create one!** link.

1. Expand the sidebar menu by selecting on the **Menu** icon.

    :::image type="content" source="../media/menu.png" alt-text="Diagram that shows how to expand the sidebar menu.":::

1. Navigate to **Build**, select **Custom app**, and select **Create app**.

    :::image type="content" source="../media/new-application.png" alt-text="Screenshot that shows how to create custom app.":::

1. Specify the **Application name**, specify the **URL**.

1. Select the pricing plan, for now, select **Free**, you can migrate to a standard plan with 2 free devices after 7 days.

1. Select **Create**.

## Step 2: Establish trust between IoT Central and your Azure Sphere Tenant

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

1. From IoT Central, go to **Administration** > **Device Connection**.

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

After you complete these steps, any device claimed into your Azure Sphere tenant will automatically be enrolled in your Azure IoT Central application when it first connects.
