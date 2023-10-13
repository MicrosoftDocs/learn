After you've created infrastructure for your new SAP system using Azure Center for SAP solutions, you need to install the SAP software on your SAP system. However, before you can do this installation, you need to get and upload the SAP installation media for use with Azure Center for SAP solutions.

Supplemental options for this lesson include:

- An Interactive Guide with clickable simulations is available for [Task 2: Install the SAP software](https://mslearn.cloudguides.com/guides/Azure%20Center%20for%20SAP%20solutions%20-%20Deploy%20an%20SAP%20system#) - (start at 4:29). The clickthrough simulates the ACSS SAP software installation experience in the U.S. version of the Azure portal (currently English only).
- If SAP software will be installed outside of Azure Center for SAP solutions use the article: [Install SAP through outside method](/azure/sap/center-sap-solutions/install-software#install-sap-through-outside-method)
- To upload media by a *scripted method*, see [Install SAP through outside method](/azure/sap/center-sap-solutions/install-software#install-sap-through-outside-method).

> [!NOTE]
> An SAP subscription with access to download SAP media is required to complete the SAP software installation.

## Get SAP installation media

To prepare for SAP installation, you can upload the SAP components to your Azure Storage account manually.

### Manually set up an Azure Storage account for the SAP components

> [!NOTE]
> Don't change the folder name structure for any steps in this process, or the installation process will fail.

1. Create a new Azure Storage account for storing the software components.
1. Grant the roles **Storage Blob Data Reader** and **Reader and Data Access** to the user-assigned managed identity, which you used during infrastructure deployment.
1. Create a container within the storage account. You can choose any container name, such as `sapbits`.
1. Create a folder within the container, named `sapfiles`.
1. Go to the `sapfiles` folder.
1. Create two sub-folders named `archives` and `boms`.
1. In the `boms` folder, create four sub-folders with names as listed in step 7 of [Set up storage account manually](/azure/sap/center-sap-solutions/get-sap-installation-media#set-up-storage-account-manually), depending on the SAP version that you're using. For example, for *S/4HANA 2022 ISS 00*, create folders named:

    - **HANA_2_00_071_v0001ms**
    - **S42022SPS00_v0001ms**
    - **SWPM20SP15_latest**
    - **SUM20SP17_latest**

### Upload the SAP software files to the storage account

1. Upload the [YAML files](/azure/sap/center-sap-solutions/get-sap-installation-media#upload-sap-media) to the folders with the same name. Make sure to use the files that correspond to the SAP version that you're using. For example, for *S/4HANA 2022 ISS 00*, upload:

    - [S42022SPS00_v0001ms.yaml](https://raw.githubusercontent.com/Azure/SAP-automation-samples/main/SAP/S42022SPS00_v0001ms/S42022SPS00_v0001ms.yaml)
    - [HANA_2_00_071_v0001ms.yaml](https://raw.githubusercontent.com/Azure/SAP-automation-samples/main/SAP/HANA_2_00_071_v0001ms/HANA_2_00_071_v0001ms.yaml)

1. Depending on your SAP version, go to the folder **S41909SPS03_v0011ms**, **S42020SPS03_v0003ms**, or **S4HANA_2021_ISS_v0001ms** (or, for the *S/4HANA 2022 ISS 00* example, **S42022SPS00_v0001ms**).
1. Create a subfolder named **templates**.
1. Download the files listed in step 4 of [Upload SAP media](/azure/sap/center-sap-solutions/get-sap-installation-media#upload-sap-media) depending on your SAP version. For example, for *S/4HANA 2022 ISS 00*, download:

    - [S42022SPS00_v0001ms-app-inifile-param.j2](https://raw.githubusercontent.com/Azure/SAP-automation-samples/main/SAP/S42022SPS00_v0001ms/templates/S42022SPS00_v0001ms-app-inifile-param.j2)
    - [S42022SPS00_v0001ms-dbload-inifile-param.j2](https://raw.githubusercontent.com/Azure/SAP-automation-samples/main/SAP/S42022SPS00_v0001ms/templates/S42022SPS00_v0001ms-dbload-inifile-param.j2)
    - [S42022SPS00_v0001ms-ers-inifile-param.j2](https://raw.githubusercontent.com/Azure/SAP-automation-samples/main/SAP/S42022SPS00_v0001ms/templates/S42022SPS00_v0001ms-ers-inifile-param.j2)
    - [S42022SPS00_v0001ms-generic-inifile-param.j2](https://raw.githubusercontent.com/Azure/SAP-automation-samples/main/SAP/S42022SPS00_v0001ms/templates/S42022SPS00_v0001ms-generic-inifile-param.j2)
    - [S42022SPS00_v0001ms-pas-inifile-param.j2](https://raw.githubusercontent.com/Azure/SAP-automation-samples/main/SAP/S42022SPS00_v0001ms/templates/S42022SPS00_v0001ms-pas-inifile-param.j2)
    - [S42022SPS00_v0001ms-scs-inifile-param.j2](https://raw.githubusercontent.com/Azure/SAP-automation-samples/main/SAP/S42022SPS00_v0001ms/templates/S42022SPS00_v0001ms-scs-inifile-param.j2)
    - [S42022SPS00_v0001ms-scsha-inifile-param.j2](https://raw.githubusercontent.com/Azure/SAP-automation-samples/main/SAP/S42022SPS00_v0001ms/templates/S42022SPS00_v0001ms-scsha-inifile-param.j2)
    - [S42022SPS00_v0001ms-web-inifile-param.j2](https://raw.githubusercontent.com/Azure/SAP-automation-samples/main/SAP/S42022SPS00_v0001ms/templates/S42022SPS00_v0001ms-web-inifile-param.j2)

1. Upload all the files that you downloaded to the `templates` folder.
1. Go back to the `sapfiles` folder, then go to the `archives` subfolder.
1. Download all packages in step 7 of [Upload SAP media](/azure/sap/center-sap-solutions/get-sap-installation-media#upload-sap-media) that aren't labeled as `download: false` from the main BOM URL. Choose the packages based on your SAP version. You can use the URL mentioned in the BOM to download each package. Make sure to download the exact package versions listed in each BOM. For example, for *S/4HANA 2022 ISS 00*, download:

    - [S42022SPS00_v0001ms.yaml](https://github.com/Azure/SAP-automation-samples/blob/main/SAP/S42022SPS00_v0001ms/S42022SPS00_v0001ms.yaml)
    - [HANA_2_00_071_v0001ms.yaml](https://github.com/Azure/SAP-automation-samples/blob/main/SAP/HANA_2_00_071_v0001ms/HANA_2_00_071_v0001ms.yaml)

1. Repeat the previous step for the main and dependent BOM files.
1. Upload all the packages that you downloaded to the `archives` folder. Don't rename the files.
1. Optionally, install other packages that aren't required, by following these steps:

    1. Download the package files.
    1. Upload the files to the `archives` folder.
    1. Open the `S41909SPS03_v0011ms` or `S42020SPS03_v0003ms` or `S4HANA_2021_ISS_v0001ms` (or, for the *S/4HANA 2022 ISS 00* example, the `S42022SPS00_v0001ms`) YAML file for the BOM.
    1. Edit the information for each optional package to `download:true`.
    1. Save and reupload the YAML file. Make sure you only have one YAML file in the subfolder (`S41909SPS03_v0011ms`, `S42020SPS03_v0003ms`, or `S4HANA_2021_ISS_v0001ms`, or, for the example,  `S42022SPS00_v0001ms`) of the `boms` folder.

Now you can install the SAP software through Azure Center for SAP solutions.

## Install SAP with Azure Center for SAP solutions

To install the SAP software directly, use the Azure Center for SAP solutions installation wizard.

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Search for and select **Virtual Instance for SAP solutions**.
1. Select your Virtual Instance for SAP solutions instance.
1. On the **Overview** page for the Virtual Instance for SAP solutions resource, select **Install SAP software**.
1. In the **Prerequisites** tab of the wizard, review the prerequisites. Then, select **Next**.
1. On the **Software** tab, provide information about your SAP media:

    1. For **Have you uploaded the software to an Azure storage account?**, select **Yes**.
    1. For **Software version**, use the **SAP S/4HANA 1909 SPS03** or **SAP S/4HANA 2020 SPS 03** or **SAP S/4HANA 2021 ISS 00** or **S/4 HANA 2022 ISS 00** . Please note only those versions will light up which are supported with the OS version that was used to deploy the infrastructure previously. 
    1. For **BOM directory location**, select **Browse** and find the path to your BOM file. For example, `https://<your-storage-account>.blob.core.windows.net/sapbits/sapfiles/boms/S41909SPS03_v0010ms.yaml`.
    1. For High Availability (HA) systems only, enter the client identifier for the STONITH Fencing Agent service principal for **Fencing client ID**.
    1. For High Availability (HA) systems only, enter the password for the Fencing Agent service principal for **Fencing client password**.
    1. Select **Next**.

1. On the **Review + install** tab, review the software settings.
1. Select **Install** to proceed with installation.
1. Wait for the installation to complete. The process takes approximately three hours. You can see the progress, along with estimated times for each step, in the wizard.
1. After the installation completes, sign in with your SAP system credentials. To find the SAP system and HANA DB credentials for the newly installed system, see [Manage a Virtual Instance for SAP solutions](/azure/sap/center-sap-solutions/manage-virtual-instance).
