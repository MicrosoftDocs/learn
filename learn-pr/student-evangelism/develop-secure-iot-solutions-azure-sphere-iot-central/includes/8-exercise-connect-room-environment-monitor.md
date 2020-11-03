In this exercise, we'll build a high-level Azure Sphere application that connects and sends environment telemetry to Azure IoT Central.

------

## Step 1: Create a new Azure IoT Central application

1. Open this link in a new window: [Azure IoT Central](https://azure.microsoft.com/services/iot-central?azure-portal=true).

2. Click **Build a solution**.

3. You'll need to sign with your Microsoft personal, work, or school account. If you do not have a Microsoft account, then you can create one for free by using the **Create one!** link.

4. Expand the sidebar menu by clicking on the **Menu** icon.

   ![The illustration shows how to expand the sidebar menu.](../media/iot-central-burger-menu.png)

5. Navigate to **Build** and click **+ New application** to create a new Azure IoT Central application.

6. Select **Custom app**.

   ![The illustration shows how to create custom app.](../media/iot-central-new-application.png)

### Create a new application

1. Specify the **Application name**, specify the **URL**, select the **Free** pricing plan, and complete the registration form.

   ![The illustration shows how to create a new application.](../media/iot-central-new-application.png)

2. Click **Create**.

### Create a new device template

A device template is a blueprint that defines the characteristics and behaviors of a type of device that connects to an Azure IoT Central application.

1. Navigate to **Device templates**, then **+ New**.

2. Click the **IoT device** template type.

   ![The illustration shows how to create IoT device templates.](../media/iot-central-new-iot-device-template.png)

3. Create an **IoT device** template.

   1. Select **IoT device**.
   2. Click **Next:Customize**.
   3. Name your template **Azure Sphere**.
   4. Click **Next: Review**.
   5. Click **Create**.

### Import a capability model

1. Click **Import capability model**.
2. Navigate to the folder that you cloned the Azure Sphere Developer Learning Path into.
3. Navigate to the **iot_central** folder.
4. Select **Azure_Sphere_Developer_Learning_Path.json** and open it.

### Create a device visualization view

1. Navigate to **Device templates** and click **Views**.

   ![The illustration shows how to create a view.](../media/iot-central-create-a-view.png)

2. Select **Visualizing the device**.

   ![The illustration shows how add tile status.](../media/iot-central-add-tile-status.png)

3. Select **Humidity**, **Pressure**, and **Temperature** telemetry items.

   ![The illustration shows telemetry items.](../media/iot-central-add-tile-environment.png)

4. Click **Add tile**.

5. Click **Save** to save the view.

### Create a properties form

1. Navigate to **Device templates** and click **Views**.

2. Click the **Editing device and cloud data** option.

   ![The illustration shows how to edit device and cloud data.](../media/iot-central-view-properties-create.png)

3. Expand the **Properties** section.

4. Select all properties. 

   ![The illustration shows the properties section.](../media/iot-central-add-tile-form.png)

5. Click **Add section**.

6. Click **Save** to save the form.

### Publish the device template

1. Click **Publish** to publish the template. Publishing the template makes it available for devices. 

   ![The illustration shows how to publish a device template.](../media/iot-central-template-publish.png)

2. Confirm and click **Publish**.

------

## Step 2: Download the tenant authentication CA certificate

1. If you're using Windows, open an **Azure Sphere Developer Command Prompt**. If you're using Linux, open your terminal.

2. Log in to your Azure Sphere tenant if you have not already done so.

   ```bash
   azsphere login
   ```

3. Make a note of the current directory, or change to the **Azure Sphere Learning path** directory. You'll need the name of this directory in the next step.

4. Download the certificate authority (CA) certificate for your Azure Sphere tenant:

   ```bash
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

   ```bash
   azsphere ca-certificate download-proof --output ValidationCertification.cer --verificationcode <code>
   ```

3. The Azure Sphere Security Service signs the validation certificate with the verification code to prove that you own the CA.

### Use the validation certificate to verify the tenant's identity

1. Return to Azure IoT Central and click **Verify**.

2. When prompted, navigate to the validation certificate that you downloaded in the previous step and select it. When the verification process is complete, the **Primary Certificate** dialog box displays the **Verified** message. Click **Close** to dismiss the box.

   ![The illustration shows a verified certificate.](../media/iot-central-certificate-verified.png)


After you complete these steps, any device that is claimed into your Azure Sphere tenant will automatically be enrolled in your Azure IoT Central application when it first connects.
