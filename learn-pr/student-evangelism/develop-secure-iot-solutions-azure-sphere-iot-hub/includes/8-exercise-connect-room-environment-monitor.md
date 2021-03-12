In this exercise, we'll build a high-level Azure Sphere application that connects and sends environment telemetry to Azure IoT Hub.

## Step 1: Sign into the Azure web portal

You need an Azure account for this learning module. If you do not have an Azure account, then create a free account. If you are a student, then sign up for a free [Azure for Students account](https://azure.microsoft.com/free/students?azure-portal=true)  (no credit card required). Otherwise, sign up for a [free Azure account](https://azure.microsoft.com/free?azure-portal=true).

From your web browser, navigate to [https://portal.azure.com](https://portal.azure.com?azure-portal=true) and sign in.

## Step 2: Prepare Azure resources

You can prepare Azure cloud resources with the Azure CLI, the Azure portal (a web interface), or deployment templates. For this module, you'll use an Azure deployment template. Select **Deploy to Azure** to deploy a Device Provisioning Service (**DPS**) and a linked Azure IoT Hub.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoftDocs%2FAzure-Sphere-Developer-Learning-Path%2Fmaster%2Fdocs%2Fdocs_vs_code_iot_hub%2FLab_2_Send_Telemetry_to_Azure_IoT_Hub%2Fsetup%2Fazuredeploy.json?azure-portal=true)

1. Select or create a new resource group.

2. Choose the site located closest to you.

3. Select the tier for Azure IoT Hub. The default tier is **F1**, which is free. You can only have one free IoT Hub per subscription. If you already have a free IoT Hub, then either select **S1** ([pricing](https://azure.microsoft.com/pricing/details/iot-hub?azure-portal=true)) or delete your existing free IoT Hub before proceeding.

4. Select **Next** > **Deploy**. The deployment will take three to four minutes to complete.

5. When the deployment has completed, select **Go to resource group**. You will see two services listed in the Azure portal: the Device Provisioning Service (DPS) and IoT Hub. Appended to the resource names is a random string to ensure that the names are globally unique. 

   > [!TIP]
   > If you don't see the two services listed then click the fresh button.

   :::image type="content" source="../media/azure-iot-resources.png" alt-text="The illustration shows IoT Hub resources." lightbox="../media/azure-iot-resources.png":::

Don't close the Azure Web portal. You will need to access it again.

## Step 3: Establish trust between your Azure Sphere tenant and DPS

You need to establish a trust relationship between your Azure Sphere tenant and your Device Provisioning Service.

Devices claimed by your Azure Sphere tenant are automatically enrolled with the linked IoT Hub by the Device Provisioning Service when the device first connects.

### Download the Azure Sphere tenant authentication CA certificate

1. If you're using Windows, open a Windows **PowerShell command line**. If you're using Linux, open **Terminal**.

2. Log in to your Azure Sphere tenant if you have not already done so.

   ```
   azsphere login
   ```

3. Make a note of the current directory or change to the **Azure-Sphere** directory. You'll need the name of this directory in the next step.

4. Download the certificate authority (CA) certificate for your Azure Sphere tenant:

   ```
   azsphere ca-certificate download --destination-file CAcertificate.cer
   ```

   The output file must have the .cer extension.

### Upload the Azure Sphere tenant certificate to DPS

1. Switch back to the Azure portal.

2. Select **DPS** > **Certificates** > **+ Add**.

   :::image type="content" source="../media/dps-certificate-add.png" alt-text="The illustration shows add certificate." lightbox="../media/dps-certificate-add.png":::

3. Name your certificate, and then select the **CAcertificate.cer** file you downloaded in the previous step to upload into the device provisioning service.

   :::image type="content" source="../media/dps-certificate-upload.png" alt-text="The illustration shows how to upload a certificate." lightbox="../media/dps-certificate-upload.png":::

4. Then select **Save**.

### Verify the uploaded certificate

1. Select the certificate you just uploaded to display the certificate details.

2. From the certificate details panel, scroll down and select **Generate Verification Code**.

3. Copy the verification code to the clipboard.

   :::image type="content" source="../media/dps-certificate-verify.png" alt-text="The illustration shows how to copy the verification certificate." lightbox="../media/dps-certificate-verify.png":::

### Verify the tenant CA certificate

1. Return to the PowerShell Command Line or Linux Terminal.

2. Download a validation certificate that proves that you own the tenant CA certificate. Replace **<code\>** in the command with the verification code from the previous step.

   ```
   azsphere ca-certificate download-proof --destination-file ValidationCertification.cer --verification-code <code>
   ```

3. The Azure Sphere Security Service signs the validation certificate with the verification code to prove that you own the Certificate Authority (CA).

### Upload the verification certificate

1. Return to the Azure portal.

2. Select the **Verification Certificate** file selector icon.

3. From the file manager, select the **ValidationCertification.cer** certificate that you generated in the previous step.

4. Select **Verify**.

   :::image type="content" source="../media/dps-certificate-verify-upload.png" alt-text="The illustration shows upload the verification certificate." lightbox="../media/dps-certificate-verify-upload.png":::

## Step 4: Create a DPS enrollment group

From the Azure portal:

1. Select **Manage Enrollments** from the device provisioning service sidebar menu.

2. Select **+ Add enrollment group**, and name the enrollment group.

3. Select the primary certificate you just uploaded.

   :::image type="content" source="../media/dps-enrollment-group-add.png" alt-text="The illustration shows how to save the certificate.":::

4. Then select **Save**.

## Step 5: Configure Azure IoT Explorer

This learning module uses [Azure IoT Explorer](https://docs.microsoft.com/azure/iot-pnp/howto-use-iot-explorer?azure-portal=true) to work with Azure IoT Hub devices. You should have already installed Azure IoT Explorer in the previous exercise.

You need the connection string for your IoT Hub.

1. From the Azure web portal.
1. Select the IoT Hub you created at the beginning of this unit.

    :::image type="content" source="../media/azure-iot-resources.png" alt-text="The illustration shows resources created for this learning module." lightbox="../media/azure-iot-resources.png":::

1. Select **Shared access policies**, then **iothubowner**.
1. Copy the **Connection string--primary key** to the clipboard.

   :::image type="content" source="../media/iot-hub-connection-string.png" alt-text="The illustration shows IoT Hub resources created for this learning module." lightbox="../media/iot-hub-connection-string.png":::

1. Start Azure IoT Explorer.
1. Select **+ Add connection**.
1. Paste your IoT Hub connection string in the connection string dialogue box.
1. Then select **Save**

    :::image type="content" source="../media/iot-explorer-connection-string.png" alt-text="The illustration shows how to set the IoT Explorer connection string." lightbox="../media/iot-explorer-connection-string.png":::

1. Select **Home**.
1. Select **IoT Plug and Play Settings**.

   :::image type="content" source="../media/iot-explorer-pnp-settings.png" alt-text="The illustration shows how to set the IoT Explorer Plug and Play public repository." lightbox="../media/iot-explorer-pnp-settings.png":::

1. Select **+ Add**.
1. Select **Public repository**.
1. Then select **Save**.
