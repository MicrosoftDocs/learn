In this exercise, you deploy a new revision of your container app and configure traffic splitting between two labeled revisions.

The following Azure resources must be available in your Resource group named RG1:

- A Container registry instance that contains one image.
- A Virtual network with subnets.
- A Service Bus Namespace
- A Managed Identity
- A Private endpoint
- A Container App
- A Container Apps Environment

You've been asked to configure traffic splitting for your Container Apps to meet the following requirements:

- You need to create a new revision of the container app that uses a suffix of v2.
- You must ensure that 25 percent of requests to your app are directed to the v2 revision.
- You must label the revisions "current" and "updated" and ensure that requests to the "---updated" revision are directed to the v2 revision.

You complete the following tasks during this exercise:

1. Set revision management to multiple.

1. Create a new revision with a v2 suffix.

1. Configure labels on the revisions.

1. Configure a traffic percentage on the revisions.

1. Verify the configuration.

## Set revision management to multiple

1. In the Azure portal, open your container app resource.

1. On the left side menu, under Application, select **Revisions and replicas**.

1. At the top of the Revisions and replicas page, select **Choose revision mode**.

1. To switch from single to multi-revision mode, select **Confirm**.

1. On the Revisions and replicas page, wait for the **Revision Mode** setting to update.

    The Revision Mode will be set to **Multiple** after the update. Also, on the left-side menu, the section title changes from Application to Revisions.

## Create a new revision with a v2 suffix

1. In the Azure portal, ensure that you have the Revisions and replicas page of your container app resource open.

1. At the top of the page, select **+ Create new revision**.

1. On the Create and deploy new revision page, complete the following steps:

    - Name / suffix: Enter **v2**
    - Under Container image, select your container image. For example, aca-apl2003.

1. Select **Create**.

1. Wait for the deployment to be completed.

## Configure labels on the revisions

1. On the left-side menu, under Settings, select **Ingress**.

1. If Ingress isn't enabled, select **Enabled**.

1. On the Ingress page, specify the following information:

    - Ingress traffic: select **Accepting traffic from anywhere**.

    - Ingress type: select **HTTP**.

    - Client certificate mode: ensure that **Ignore** is selected.

    - Transport: ensure that **Auto** is selected.

    - Insecure connections: ensure that Allowed is **NOT** checked.

    - Target port: enter **5000**

    - IP Security Restrictions Mode: ensure that **Allow all traffic** is selected.

1. At the bottom of the Ingress page, select **Save**, and then wait for the update to complete.

1. On the left-side menu, under Revisions, select **Revisions and replicas**.

1. For the v2 revision, under Label, enter **updated**

1. For the other revision, enter **current**

1. At the top of the page, select **Save**.

## Configure a traffic percentage on the revisions

1. Ensure that you have the Revisions and replicas page open.

1. For the v2 revision, under Traffic, enter **25** as the percentage.

1. For the other revision, under Traffic, enter **75** as the percentage.

1. At the top of the page, select **Save**.

## Check your work

1. Ensure that you have your Container App open in the Azure portal.

1. On the left-side menu, under Application, select **Revisions and replicas**.

1. Verify that your revisions are configured as follows:

    ![Screenshot of a Container App revisions configured with labels for traffic-splitting.](../media/container-app-traffic-split-percentage-labels.png)
