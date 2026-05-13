In this exercise, we'll build a high-level Azure Sphere application that connects and sends environment telemetry to Azure IoT Hub.

## Step 1: Sign into the Azure web portal

You need an Azure account for this learning module. If you do not have an Azure account, then create a free account. If you are a student, then sign up for a free [Azure for Students account](https://azure.microsoft.com/free/students/?cid=msft_learn)  (no credit card required). Otherwise, sign up for a [free Azure account](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn).

From your web browser, navigate to [https://portal.azure.com](https://portal.azure.com?azure-portal=true) and sign in.

## Step 2: Prepare Azure resources

You can prepare Azure cloud resources with the Azure CLI, the Azure portal (a web interface), or deployment templates. For this module, you'll use an Azure deployment template. Select **Deploy to Azure** to deploy a Device Provisioning Service (**DPS**) and a linked Azure IoT Hub.

[![Deploy to Azure.](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoftDocs%2FAzure-Sphere-Developer-Learning-Path%2Fmaster%2Fdocs%2Fdocs_vs_code_iot_hub%2FLab_2_Send_Telemetry_to_Azure_IoT_Hub%2Fsetup%2Fazuredeploy.json?azure-portal=true)

> [!NOTE]
> The deployment template above is hosted in the [`MicrosoftDocs/Azure-Sphere-Developer-Learning-Path`](https://github.com/MicrosoftDocs/Azure-Sphere-Developer-Learning-Path?azure-portal=true) repository, which is in maintenance mode. The template is still functional but uses older Azure resource API versions and may show warnings during deployment — this is expected for the lab.
>
> DPS is a billable Azure service. This lab uses only a small number of provisioning operations, but review your subscription and the current Azure IoT pricing before running repeated tests.

1. Select or create a resource group in the Azure region closest to you. This template deploys all resources to the resource group's location, so the resource group's region determines where IoT Hub and DPS are deployed.

1. Select the tier for Azure IoT Hub. The default tier is **Free** (SKU code `F1`), which allows up to 8,000 messages per day at no cost. You can only have one Free-tier IoT hub per subscription. If you already have a Free-tier IoT hub, either select **S1** ([pricing](https://azure.microsoft.com/pricing/details/iot-hub?azure-portal=true)) or delete your existing Free-tier IoT hub before proceeding.

1. Select **Next** > **Deploy**. The deployment will take three to four minutes to complete.

1. When the deployment has completed, select **Go to resource group**. You will see two services listed in the Azure portal: the Device Provisioning Service (DPS) and IoT Hub. Appended to the resource names is a random string to ensure that the names are globally unique. 

   > [!TIP]
   > If you don't see the two services listed, click the **Refresh** button.

   :::image type="content" source="../media/azure-iot-resources.png" alt-text="The illustration shows IoT Hub resources." lightbox="../media/azure-iot-resources.png":::

Don't close the Azure portal. You will need to access it again.

## Step 3: Establish trust between your Azure Sphere catalog and DPS

You need to establish a trust relationship between your Azure Sphere catalog and your Device Provisioning Service.

After the Azure Sphere catalog CA certificate has been uploaded and verified in DPS and a DPS enrollment group has been created, devices claimed into that Azure Sphere catalog can authenticate to DPS using their Azure Sphere device certificate and are automatically provisioned to the linked IoT hub the first time they connect. The Azure Sphere device's per-device certificate is issued by the verified catalog CA, so DPS uses the enrollment group to register the device with IoT Hub without any per-device manual enrollment.

### Download the Azure Sphere catalog authentication CA certificate

1. If you're using Windows, open a Windows **PowerShell command line**. If you're using Linux, open **Terminal**.

2. Sign in to Azure if you have not already done so.

   ```
   az login
   ```

3. Change to a directory where you have write permission. You'll upload the certificate file from this directory in a later step.

4. Download the certificate authority (CA) certificate for your Azure Sphere catalog. Replace the placeholders with the resource group and Azure Sphere catalog that contain your claimed device.

   ```
   az sphere ca-certificate download --resource-group <resource-group> --catalog <catalog-name> --output-file CAcertificate.cer
   ```

   The output file must have the .cer extension.

   > [!TIP]
   > Using the legacy Azure Sphere CLI? Run `azsphere login`, then `azsphere ca-certificate download --destination CAcertificate.cer`. The current Azure Sphere Integrated CLI uses `az login` and `az sphere ... --output-file`. See the [`az sphere ca-certificate` reference](/azure-sphere/reference/cli/azsphere-ca-certificate?azure-portal=true).

### Upload the Azure Sphere catalog certificate to DPS

1. Switch back to the Azure portal.

2. In your DPS instance, under **Settings**, select **Certificates** > **+ Add**.

   :::image type="content" source="../media/dps-certificate-add.png" alt-text="The illustration shows add certificate." lightbox="../media/dps-certificate-add.png":::

3. Name your certificate, and then select the **CAcertificate.cer** file you downloaded in the previous step to upload into the device provisioning service.

   :::image type="content" source="../media/dps-certificate-upload.png" alt-text="The illustration shows how to upload a certificate." lightbox="../media/dps-certificate-upload.png":::

4. Then select **Save**.

### Verify the uploaded certificate

1. Select the certificate you just uploaded to display the certificate details.

2. From the certificate details panel, scroll down and select **Generate Verification Code**.

3. Copy the verification code to the clipboard.

   :::image type="content" source="../media/dps-certificate-verify.png" alt-text="The illustration shows how to copy the verification certificate." lightbox="../media/dps-certificate-verify.png":::

### Verify the catalog CA certificate

1. Return to the PowerShell Command Line or Linux Terminal.

2. Download a validation certificate that proves that you own the catalog CA certificate. Replace **<code\>** in the command with the verification code from the previous step, and replace the resource group and catalog placeholders with your values.

   ```
   az sphere ca-certificate download-proof --resource-group <resource-group> --catalog <catalog-name> --output-file ValidationCertification.cer --verification-code <code>
   ```

3. The Azure Sphere Security Service signs the validation certificate with the verification code to prove that you own the Certificate Authority (CA).

   > [!TIP]
   > Using the legacy Azure Sphere CLI? Run `azsphere ca-certificate download-proof --destination ValidationCertification.cer --verification-code <code>`.

### Upload the verification certificate

1. Return to the Azure portal.

2. Select the **Verification Certificate** file selector icon.

3. From the file manager, select the **ValidationCertification.cer** certificate that you generated in the previous step.

4. Select **Verify**.

   :::image type="content" source="../media/dps-certificate-verify-upload.png" alt-text="The illustration shows upload the verification certificate." lightbox="../media/dps-certificate-verify-upload.png":::

## Step 4: Create a DPS enrollment group

From the Azure portal:

1. In your Device Provisioning Service instance, under **Settings**, select **Manage enrollments**. Select the **Enrollment groups** tab if tabs are shown, and then select **+ Add enrollment group** or **Add enrollment group**.

2. Enter a descriptive name for the enrollment group.

3. For attestation, select **X.509** or **Certificate** as the attestation type and **CA certificate** as the certificate type, and then select the verified catalog CA certificate that you uploaded and verified in Step 3 as the primary certificate. Don't create an individual enrollment for this lab; the enrollment group is what lets DPS trust all devices claimed into the Azure Sphere catalog.

   The enrollment-group form includes the X.509 certificate attestation settings:

   :::image type="content" source="../media/dps-enrollment-group-add.png" alt-text="The illustration shows the add enrollment group page.":::

4. If the portal shows an **IoT hubs** step, select **Next: IoT hubs**. Ensure the linked IoT hub appears. For a single linked hub, accept the default hub selection and allocation policy unless your scenario requires otherwise.

5. Select **Review + create** or **Save**, review the enrollment group settings, and then select **Create** or **Save**.

## Step 5: Configure Azure IoT Explorer

This learning module uses [Azure IoT Explorer](/azure/iot/howto-use-iot-explorer?azure-portal=true) to work with Azure IoT Hub devices. You should have already installed Azure IoT Explorer in the previous exercise.

> [!NOTE]
> The Azure IoT Explorer GitHub repository is no longer actively developed — only critical fixes may be considered. Existing released installers remain available and are fully sufficient for this module. Use Azure IoT Explorer version 0.13.x or later so it can resolve models from repositories based on the Azure IoT Plug and Play model repository.

You need the connection string for your IoT Hub.

1. In the Azure portal, select the IoT Hub you created at the beginning of this unit.

    :::image type="content" source="../media/azure-iot-resources.png" alt-text="The illustration shows resources created for this learning module." lightbox="../media/azure-iot-resources.png":::

1. Select **Shared access policies**, then **iothubowner**.
1. Copy the **Connection string--primary key** to the clipboard.

   :::image type="content" source="../media/iot-hub-connection-string.png" alt-text="The illustration shows IoT Hub resources created for this learning module." lightbox="../media/iot-hub-connection-string.png":::

   > [!NOTE]
   > Shared access policies (SAS) such as `iothubowner` are still created by default on every new IoT hub and are convenient for development and learning scenarios like this lab. For production service access where supported, Microsoft recommends using [Microsoft Entra ID](/azure/iot-hub/authenticate-authorize-azure-ad?azure-portal=true) authentication with role-based access control. DPS links to IoT Hub by using an IoT Hub shared access policy. If you disable shared access policies on the linked IoT hub, DPS can no longer enroll devices to that hub and provisioning will fail. Keep at least the shared access policy used by DPS enabled on the IoT hub; DPS-based provisioning requires this SAS-policy link even in designs that otherwise prefer Microsoft Entra ID.

1. Start Azure IoT Explorer.
1. Select **+ Add connection**.
1. Paste your IoT Hub connection string in the connection string dialogue box.
1. Then select **Save**

    :::image type="content" source="../media/iot-explorer-connection-string.png" alt-text="The illustration shows how to set the IoT Explorer connection string." lightbox="../media/iot-explorer-connection-string.png":::

1. Select **Home**.
1. Select **IoT Plug and Play Settings**.

   :::image type="content" source="../media/iot-explorer-pnp-settings.png" alt-text="The illustration shows how to set the IoT Explorer Plug and Play public repository." lightbox="../media/iot-explorer-pnp-settings.png":::

1. Ensure **Public repository** is listed as a model source. If it isn't listed, select **+ Add**, select **Public repository**, and then select **Save**.

> [!NOTE]
> The IoT Plug and Play public model repository at `devicemodels.azure.com` continues to serve existing models. The associated GitHub repository [`Azure/iot-plugandplay-models`](https://github.com/Azure/iot-plugandplay-models?azure-portal=true) is now archived (read-only) and Microsoft has not accepted new model submissions since February 2024, when the Azure Certified Device program was retired. The model used by this lab (`dtmi:com:example:azuresphere:labmonitor;1`) is already published and continues to be served.
