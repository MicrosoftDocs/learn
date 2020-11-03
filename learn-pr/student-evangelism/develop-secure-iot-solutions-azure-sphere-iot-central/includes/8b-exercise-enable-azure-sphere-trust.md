## Step 2: Link your Azure Sphere tenant to Azure IoT Central

You need to set up a trust relationship between your Azure Sphere tenant and your Azure IoT Central application.

Devices claimed by your Azure Sphere tenant will be automatically enrolled when it first connects to your Azure IoT Central application.

### Download the tenant authentication CA certificate

1. If you're using Windows, open an **Azure Sphere Developer Command Prompt**. If you're using Linux, open your terminal.

2. Log in to your Azure Sphere tenant if you have not already done so.

   ```
   azsphere login
   ```

3. Make a note of the current directory, or change to the **Azure Sphere Learning path** directory. You'll need the name of this directory in the next step.

4. Download the certificate authority (CA) certificate for your Azure Sphere tenant:

   ```
   azsphere ca-certificate download --output CAcertificate.cer
   ```

   The output file must have the .cer extension.

### Upload the tenant CA certificate to Azure IoT Central and generate a verification code

1. In Azure IoT Central, go to **Administration** > **Device Connection** > **Manage primary certificate**.

2. Click the folder icon next to the **Primary** box and navigate to the directory where you downloaded the certificate. If you don't see the .cer file in the list, make sure that the view filter is set to **All files (*)**. Select the certificate and then click the gear icon next to the **Primary** box.

3. The **Primary Certificate** dialog box appears. The **Subject** and **Thumbprint** fields contain information about the current Azure Sphere tenant and primary root certificate.

4. Click the **Refresh** icon to the right of the **Verification Code** box to generate a verification code. Copy the verification code to the clipboard.

   ![The illustration shows how to verify a certificate.](../media/iot-central-certificate-verify.png)

### Verify the tenant CA certificate

1. Return to the command prompt.

2. Download a validation certificate that proves that you own the tenant CA certificate. Replace code in the command with the verification code from the previous step.

   ```
   azsphere ca-certificate download-proof --output ValidationCertification.cer --verificationcode <code>
   ```

3. The Azure Sphere Security Service signs the validation certificate with the verification code to prove that you own the CA.

### Use the validation certificate to verify the tenant's identity

1. Return to Azure IoT Central and click **Verify**.

2. When prompted, navigate to the validation certificate that you downloaded in the previous step and select it. When the verification process is complete, the **Primary Certificate** dialog box displays the **Verified** message. Click **Close** to dismiss the box.

   ![The illustration shows a verified certificate.](../media/iot-central-certificate-verified.png)


After you complete these steps, any device that is claimed into your Azure Sphere tenant will automatically be enrolled in your Azure IoT Central application when it first connects.

------

