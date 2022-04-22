As result of your data infrastructure’s diversity, your data is scattered across different data sources. Therefore, you’re spending significant time manually annotating, cataloging, and finding trusted sources.

You decide to use Microsoft Purview to scan the structured data that’s stored in the Amazon RDS. The data stores developed for different apps primarily use Microsoft SQL Server and PostgreSQL engines.

## Configure AWS for an Microsoft Purview account

Amazon RDS is a fully managed service and as such, Amazon manages all infrastructure components of data sets. Microsoft Purview can scan your RDS database, but only when it’s hosted in an Amazon Virtual Private Cloud (Amazon VPC). Create a target group, a load balancer, and an endpoint service in the same Amazon VPC to enable connectivity for Microsoft Purview. Also, note that:

- AWS PrivateLink requires the endpoint service to ensure proper connectivity to the Amazon RDS database.

- The load balancer distributes incoming traffic.

- The target group routes requests to the RDS database.

## Prerequisites for adding an Amazon RDS database as an Microsoft Purview data source

Before you add an Amazon RDS database as an Microsoft Purview data source, ensure that these prerequisites are met:

- You have Microsoft Purview Data Source Admin permission to register the Amazon RDS data source.

- Your Amazon RDS is running either Microsoft SQL database or PostgreSQL.

### Create a Microsoft account for secure access to AWS

Deploy Microsoft Purview scanner in a Microsoft account in AWS. Microsoft Purview Scanner needs access to your Amazon RDS, and for this purpose, you must create a dedicated role in the AWS portal. For the AWS role, provide the **Microsoft Account ID** and the **External ID** from Microsoft Purview.

To obtain the Microsoft Account ID and the External ID, in **Microsoft Purview Studio**, on the **Management pane**, create a new **Credentials** object. For the **Authentication method**, select **Role ARN**.

Obtain the **Role ARN** value from the created AWS role. You’ll need it in the next step to create an Microsoft Purview credential.

:::image type="content" alt-text="The New credential pane displaying authentication method, Microsoft account ID, and external ID." source="..media/4-new-credential.png" lightbox="../media/4-new-credential.png":::

### Create an Microsoft Purview credential for your Amazon RDS

Use Microsoft Purview Studio to create a credentials object needed to scan the data source from Amazon RDS. Ensure that there is an integration between Microsoft Purview and Azure Key vault, and then follow these steps:

1. To open the Management Center, in Microsoft Purview Studio, select the **Management** link, and then select **Credentials**.

1. Select **New**, and then, in the **New credential** pane:

    1. In the **Name** text box, enter a name for the credential object.

    1. In the **Description** text boxes, enter the description of the credential object.

    1. From the **Authentication method** drop-down list, select the **Role ARN** authentication method. 

    1. In the **Role ARN** text box, enter the value of the Role ARN obtained in the process of creation of the AWS Role for Microsoft.

### Deploy an Azure Multicloud Scanning Connector

To deploy an Azure Multicloud Scanning Connector:

1. Install the **Azure Multicloud Scanning Connector** in a separate VPC.

<!---->

9.  Use AWS PrivateLink to connect to the VPC where your RDS database resides.

:::image type="content" alt-text="Illustration depicting use AWS PrivateLink to connect to the VPC where the RDS database resides." source="..media/4-Amazon-vpc.png" lightbox="../media/4-Amazon-vpc.png":::

>[!Note]
>*Amazon VPC* is a virtual network in an AWS account. Use Amazon VPC to configure IP addresses to use for resources within Amazon VPC. Additionally, Amazon VPC hosts other network services such as load balancers or firewalls. AWS PrivateLink provides private connectivity between VPCs, AWS services (in this case Amazon RDS), and your on-premises networks.

## Configure AWS PrivateLink

Microsoft provides two methods you can use to configure AWS PrivateLink:

1. A CloudFormation template

1. A manual configuration for advanced setup

### Method \#1: Use a CloudFormation template

This method simplifies the process of implementation because the configuration is standardized in a YAML file that you download from this [Azure GitHub repository](https://github.com/Azure/Azure-Purview-Starter-Kit/tree/main/Amazon/AWS/RDS). You perform the template-configuration procedure in your AWS environment, and you’ll need AWS admin credentials to run it. During template deployment, provide the:

- Endpoint and port that contain the IP address and port for connection to the endpoint service.

- VPC ID to identify the VNet where the Amazon RDS instance is deployed.

- VPC IPv4 Classless Interdomain Routing (CIDR) that the VNet uses.

- Subnets that are associated with the VPC.

- Security group that’s associated with the RDS database.

As result of the template deployment in your AWS subscription, you’ll have created a target group, a load balancer, and an endpoint service.

### Method \#2: Use a manual configuration for advanced setup

This method gives you a higher level of customization, and you can use it for troubleshooting an AWS PrivateLink deployment. You must retrieve the IP address of the Amazon RDS instance and then enable RDS connection from the load balancer. This requires that you manually create a target group, load balancer, and endpoint service in the VPC where you’ve configured the RDS instance.

As result of provisioning of the AWS PrivateLink, you’ll get a **ServiceName** key. You’ll need this key to register an RDS database as an Microsoft Purview data source.

## Register an Amazon RDS source

Once you establish a connection, you should start sourcing your data by registering the data sources using Microsoft Purview Studio:

1. In Microsoft Purview Studio, from the **navigation** pane, select **Data map**.

1. On the **Sources** pane, select **Register**.

1. On the **Register sources** pane, select the **Database** tab.

1. From the available sources, select either **Amazon RDS (SQL)** or **Amazon RDS (PostgreSQL)**, and then select **Continue**.

    :::image type="content" alt-text="Register sources Amazon RDS (SQL) pane" source="../media/4-register-sources" lightbox="../media/4-register-sources":::

1. Provide the following information, and then select **Register**:

    - **Name**: Provide a meaningful name for your data source.

    - **Server name**: Enter the name of your RDS database instance.

    - **Port**: Provide the port that you’ll use to connect to the RDS database.

    - **Connect to private network via endpoint service**: Enter the **ServiceName** key that you obtained from creating the AWS PrivateLink.

    - **Collection** (optional): Provide a name for the collection if you intend to group multiple data sources into collections.

## Scan an Amazon RDS database

Before you begin scanning an Amazon RDS database’s data source, you must prepare your Microsoft Purview credentials. You can use credentials in the form of a username and a password and store them in the Azure Key Vault service.

### Create a credential object

You also need to create a credentials object in Microsoft Purview to use when you scan your Amazon RDS database. Create the credentials object in the Microsoft Purview Management area and configure it with the **SQL Authentication** method. The credentials object should contain the details for the Key Vault service that’s storing the authentication information.

>[!Tip]
>To create a credential object to use for scanning an Amazon RDS database, use the same procedure as the one described to **Prepare credentials in Azure Key Vault**.

### Create a scan rule set

Microsoft Purview provides default scan rule sets that group scan rules together. To set up different configurations based on your business needs, create a custom scan rule set by following these steps:

1. In Microsoft Purview Studio, select **Data Map**.

1. Select **Scan rule sets** and then select **+New**.

1. On the **New scan rule set** pane, from the **Source Type** drop-down list, select the data sources that the catalog scanner supports.

    >[!Tip]
    >You can create a scan rule set for each type of data source you intend to scan.

1. Provide a descriptive **Name** and then select **Continue.**

1. Select file types based on the data source and then select **Continue.**

1. Select classification rules from the offered categories and then select **Create** to finish creating the scan rule set.

### Set up a scan

To configure an Microsoft Purview scan for your Amazon RDS database, from the Microsoft Purview **Sources** pane, select the Amazon RDS data source. You also need to provide the scan’s name, select the database that you want to scan, and specify credentials for the multicloud scanning connector.

>[!Note]
>The scan rule can be part of an existing scan rule set or a new scan rule set. It should contain the file type for schema extraction and classification.

>[!Tip]
>To keep your Microsoft Purview account up to date, configure the scanning process to run immediately or schedule it to run on a periodic basis.

Using the scanning process, you can build your Microsoft Purview catalog with information about the state of the data store.
