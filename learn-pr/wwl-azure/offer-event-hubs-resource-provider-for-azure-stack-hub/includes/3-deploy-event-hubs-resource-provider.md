Before you can install Event Hubs on Azure Stack Hub, you must download the resource provider and its dependent packages using the Marketplace Management feature. This topic walks you through the process of downloading items from the Azure Marketplace.

> [!NOTE]
> The download process can take 60 minutes to 2 hours, depending on the network latency and existing packages on your Azure Stack Hub instance. This procedure is fully documented to show the steps involved.

For a connected scenario, you download the items from the Azure Marketplace directly to the Azure Stack Hub Marketplace:

1.  Sign in to the Azure Stack Hub administrator portal.
2.  Select **Marketplace Management** on the left.
3.  Select **Resource providers**.
4.  Select **+ Add from Azure**.
5.  Search for "Event Hubs" using the search bar.
6.  Select the "Event Hubs" row on the search results.
7.  On the "Event Hubs" download page, select the Event Hubs version you wish to install, then select **Download** at the bottom of the page.

Notice that additional software packages are downloaded along with Event Hubs, including:

 -  Microsoft Azure Stack Hub Add-On RP Windows Server INTERNAL ONLY
 -  PowerShell Desired State Configuration

## Installation

1.  If you haven't already, sign in to the Azure Stack Hub administrator portal, select **Marketplace Management** on the left, select **Resource providers**.
2.  Once Event Hubs and other required software have been downloaded, **Marketplace Management** shows the "Event Hubs" packages with a status of "Not Installed". There may be other packages that show a status of "Downloaded". Select the "Event Hubs" row you wish to install.

3.  The Event Hubs install package page shows a blue banner across the top. Select the banner to start the installation of Event Hubs.

### Install prerequisites

1.  Next you're transferred to the install page. Select **Install Prerequisites** to begin the installation process.

2.  Wait until the installation of prerequisites succeeds. You should see a green checkmark next to **Install prerequisites** before proceeding to the next step.

### Prepare secrets

1.  Under the **Prepare secrets** step, select **Add certificate**, and the **Add a certificate** panel will appear.

2.  Select the browse button on **Add a certificate**, just to the right of the certificate filename field.
3.  Select the .pfx certificate file you procured when completing the prerequisites.
4.  Enter the password you provided to create a secure string for Event Hubs SSL Certificate. Then select **Add**.

### Install resource provider

1.  When the installation of the certificate succeeds, you should see a green checkmark next to **Prepare secrets** before proceeding to the next step. Now select the **Install** button next to **3 Install resource provider**.

2.  Next you'll see the following page, which indicates that Event Hubs resource provider is being installed.

3.  Wait for the installation complete notification. This process usually takes one or more hours, depending on your Azure Stack Hub type.

4.  Verify that the installation of Event Hubs has succeeded, by returning to the **Marketplace Management, Resource Providers** page. The status of Event Hubs should show "Installed".
