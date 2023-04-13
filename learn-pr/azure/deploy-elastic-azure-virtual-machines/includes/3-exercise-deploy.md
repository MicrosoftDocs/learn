
Deploying Elastic on Azure VMs provides a high level of flexibility and control of the underlying infrastructure. The Elasticsearch (self-managed) template available in the Azure Marketplace offers a way to get started quickly using best practices.

Recall that the start-up retailer you work for currently uses Elastic on-premises to manage sales transactions. They would like to migrate to Azure VMs to improve data accessibility for remote workers and other departments while reducing the burden of maintaining infrastructure. Here, you'll go through the steps for deploying an Elastic workload on Azure VMs.

1. From the Azure Marketplace, search for and choose the Elasticsearch (self-managed) template.

    :::image type="content" source="../media/marketplace.png" alt-text="A screenshot of the Elasticsearch (Self-Managed) template on Azure Marketplace.":::

1. Select **Create**.

1. Fill in the **Basics**. 
    1. Choose your Azure subscription
    1. Create a new Resource group named elastic-on-azure-vm-rg
    1. Select the region closest to you
    1. Enter a valid Ubuntu username to access the VMs in your cluster
    1. Choose Password for the authentication type and enter your password

1. Enter the **Cluster Settings**.
    1. Choose the default Elasticsearch version, which will be the most recent.
    1. Name your cluster es-on-azure
    1. Use the default settings for the virtual network configuration

    :::image type="content" source="../media/cluster-settings.png" alt-text="A screenshot of the Cluster Settings menu in the Azure portal.":::

1. Set the **Number of data nodes** to *3*, and set **Data nodes are master eligible** to *Yes*.

    :::image type="content" source="../media/nodes-configuration.png" alt-text="A screenshot of the Nodes Configuration menu in the Azure portal.":::

1. Add **Kibana & Logstash**.
    1. Select the options to install Kibana and Logstash

    :::image type="content" source="../media/kibana-logstash.png" alt-text="A screenshot of the Kibana & Logstash menu in the Azure portal.":::

1. Enter the security details
    1. Create account names and passwords for Elastic, Kibana, Logstash, Beats, APM, and remote monitoring

    :::image type="content" source="../media/security.png" alt-text="A screenshot of the Security menu in the Azure portal.":::

1. Select **Review + create** to deploy the Elasticsearch cluster.
