Companies lay the foundations towards data security by embedding data classification into an organizations information security process. Data classification helps to ensure that a company's customer data is understood, appropriately used, and secured.

Your company wants to refine outdated information security policies. With the aim of working towards regulatory requirements for customer data migrated to the cloud. As part of establishing a stronger information security procedure, there's a need to formalize the process for data classification. Your manager has asked you to look at how you could do this on the Azure platform, and which tools can be used to identify and classify data.

In this unit, you'll explore data classification in Azure and how to identify and classify data using an Azure SQL Database.

## Environment setup

<!-- Activate the sandbox -->
[!INCLUDE [azure-sandbox-activate](../../../includes/azure-sandbox-activate.md)]

Run the following commands in the Cloud Shell. This will create an Azure SQL Database to use in the next exercise.

1. Run the following commands to save environment variables that will be used in the az cli calls later.

    ```bash
    export RESOURCEGROUP=<rgn>[sandbox resource group name]</rgn>
    export LOCATION=$(az group show --name $RESOURCEGROUP | jq -r '.location')
    export SERVERNAME=server$RANDOM
    ```

1. Copy the ARM and parameter json templates that create an Azure SQL Database.

    ```bash
    curl https://raw.githubusercontent.com/... > deploy.json
    curl https://raw.githubusercontent.com/... > parameters.json
    ```

    <!-- TODO replace with live github repo -->

1. Run the following command to create a new Azure SQL Database server.

    ```azurecli
    az group deployment create \
        --name dataDeployment \
        --resource-group $RESOURCEGROUP \
        --template-file deploy.json \
        --parameters @parameters.json \
        --parameters resourceGroupName=$RESOURCEGROUP location=$LOCATION serverName=$SERVERNAME
    ```

    > [!NOTE]
    > This can take up to five minutes to complete, continue with this unit while the database is created.

### Data Classification in the Azure Cloud Platform

Data classification is a way for an organization to understand and assign relative values to their data. The data classification process provides a way for organizations to categorize data by its business impact and sensitivity level, so the risks associated with the data can be determined. Once the process is complete, organizations manage data in ways to reflect its value to them, rather than treating all data the same. Data classification is a prudent, considered approach, that enables an organization to focus its efforts on protecting the right data. This is only possible if an appropriate value is given to the different types of data.

There has been some refinement to the data classification in cloud computing, but the foundations remain the same. For data classification to be a success, it requires an organization to have awareness of its needs and an understanding of where their data assets live.

A significant part of any data security process is to ensure access to data is controlled through authorization and authentication:

![Screenshot showing authentication and authorization process](../media/1-authentication-authorization.png)

**Authentication**: is the process of identifying a user but doesn't assign access. It simply verifies the user is who they say they are.

**Authorization**: provides an individual authenticated user access to data, that could be a data set, file, or other object. Authenticated users are assigned permissions to use the data. Access is validated based on a combination of the users need, security, risk policies, and job role.

## Roles and responsibilities in the cloud

When your organization has adopted a cloud service provider, it needs to understand who has the role and responsibility for the classification of data. There are three primary cloud models, Software as a service (SaaS), Platform as a service (PaaS) and Infrastructure as a service (IaaS). Below is a cloud responsibility matrix displaying where the responsibility typically lies:

![Screenshot showing cloud responsibility matrix](../media/1-cloud-responsibility-matrix.png)

The above image shows that whatever service model is being used, your company remains responsible for classifying their data. In some instances, such as security, the responsibility is shared with Microsoft. It is however, crucial to understand the roles for data processing and classification purposes. For example, for compliance with the General Data Protection Regulation (GDPR) in relation to data of European Union (EU) citizens the obligations for an organization vary dependant on three roles:

- **Controller**: Exercises overall control of the purpose and means of processing personal data. Must comply with all principles of the GDPR.

- **Joint-Controller**: As above but where two or more controllers determine the purpose and means of processing data.

- **Processor**: Has no purpose for processing data and acts on client instructions (including making technical decisions on how to process data). Have certain direct obligations under GDPR.

Your organization is a data controller and in using Azure, Microsoft is classified as a processor of personal data for GDPR purposes. Microsoft do make certain commitments to it's customers for GDPR purposes to reflect the terms required of processors in Article 28 of the GDPR. Data classification remains the sole responsibility of the controller and an organizations data protection officer (DPO) has overall accountability.

## Compliance considerations

Whatever cloud solution your company chooses, having the ability to manage regulatory compliance, for example, GDPR or ISO27001, or other data protection rules, is essential. When moving to the cloud, organizations should be aware of their data classification obligations.

Microsoft Azure has a variety of tools and services to assist with your organizations compliance efforts. Most Azure data services offer encryption-at-rest protection by default, your data protection office can access Microsoft compliance resources and tools using [Trust Center](https://www.microsoft.com/en-us/trustcenter) and your administrators can access detailed threat protection and security information directly in the portal using Azure Security Center or enhanced auditing capabilities for services such as Azure SQL in Advanced Data Security.

## Data Classification Process

A data classification process needs to be simple and effective to implement. There's a clear purpose for classifying data. It's to ensure that there is no unauthorized disclosure, or misuse, of data. Using the assigned classification the data can be assigned to an appropriate retention policy.

There are various models available, but a model commonly used for data classification is **PLAN**, **DO**, **CHECK**, and **ACT**. The figure below highlights the flow of tasks:

![Screenshot data classification process model of PLAN, DO, CHECK, and ACT](../media/1-data-classification-model.png)

- **PLAN** - Identify the organizations data assets, develop data protection policies, and employ or assign a data owner (custodian) for the data classification program.
- **DO** - Following agreement on data classification policies, implement the program and enable enforcement technologies as required for confidential data.
- **CHECK** - Verify the methods and tools selected are successfully addressing classification policies, typically done by validating or checked reports.
- **ACT** - The final step of the process purpose built to enable revision by reviewing the status of data access. Any data or files that require revision go through a revision and classification methodology for addressing new risks or adopting change.

Your company already stores customer details, financial information and intellectual property in Azure SQL Database. You have been designated as the data owner for this system, as such, the responsibility lies with you to ensure this data is appropriately classified and protected. Using the PDCA method:

- You need to identify the data your company has stored and, as the data owner, own the data classification for it.
- You have agreed a classification of Highly Confidential, Confidential - GDPR, Confidential, General, and Public. You must now implement this and classify the data your company has in an Azure SQL Database.
- You need to verify the selected classifications are appropriate and review for any further vulnerabilities.
- You noticed some commercially sensitive business data has not been classified, now you must revise the classifications to ensure this data is protected.

## Walk through of data stewardship

Data stewardship's key is to establish a clear chain of command for all data assets. Any data governance program needs a combination of people, process, and technology to be effective. Consider some of the key roles that your organization needs to support a data ownership process:

**Data Asset Owner**: The original data creator. Can assign a steward and delegate ownership. Marks data with a classification upon creation and has responsibility to understand confidentiality. Owners can delegate responsibilities to a data steward after data is classified.

> [!NOTE]
> For personal data, it's important to establish clear and concise organizational policies for usage of personal devices or software is in accordance with any guidelines for data classification.

**Data Asset Custodian**: Gets assigned by the asset owner. Manages data in accordance with organizational policy. Stewards take overall ownership of assets ensure appropriate access control is in place.

**Data Asset Administrator**: Responsible for maintaining data integrity. Administrators provide management services without access to underlying data assets.

**Data Asset Users**: Anyone using the data or file.

### Discover and classify data using Azure SQL Database

Azure SQL Database has advanced capabilities built in through a feature called Data discovery and classification, as part of Advanced Data Security (ADS). Data discovery and classification enables the discovery, classification, labeling, and protection of sensitive data stored in your databases. Discovering and classifying sensitive data can play a pivotal role in keeping organizational data secure.

> [!NOTE]
> The above applies to Azure SQL Database, Azure SQL Data Warehouse, and the latest versions of on-premise SQL Server Databases.

## Understanding taxonomies

A data taxonomy is the classification of data split into categories and subcategories with the main goal to create a unified view of data within the organization. A taxonomy has a common set of terminology and semantics that can be used in all the systems a company has.

Encompassed in SQL data discovery and classification, are a set of built-in information types, discovery logic, and also sensitivity labels. This allows you to define a custom taxonomy for a concise set of data, tailored specifically for your organization.

## Azure SQL Database classification capabilities

The capabilities in Azure SQL Database introduce an information protection paradigm designed to protect data, rather than just the database:

- **Discovery & recommendations** - The classification engine in SQL Database will scan the database and identify columns that contain potentially sensitive data. Once complete, it provides a simple way for you to review and implement the appropriate classification in the Azure portal.
- **Labeling** - The SQL engine has been enhanced with new classification metadata attributes so that sensitivity labels can be added to columns, this metadata can supplement protection scenarios and auditing.
- **Query result set sensitivity** - Another feature introduced in Azure SQL Database, for auditing purposes, will calculate the sensitivity of a query result in real time.
- **Visibility** - In a move towards meeting compliance, and auditing requirements, the classification of the database is available for viewing either via a detailed dashboard or a downloadable Excel report.

Azure SQL Database also provides the capability for automated data classification using Transact-SQL (T-SQL) or Azure REST APIs. When using T-SQL, it's important to remember any sensitivity labels added to a column are not validated against the organizational information protection policy.

There are two main T-SQL functions and a system table for data classification:

- `ADD SENSITIVITY CLASSIFICATION` - Adds classification metadata to the selected column(s). Example statement is:

    `ADD SENSITIVITY CLASSIFICATION TO {schema_name}.{table_name}.{column_name} WITH ( LABEL='{sensitivity_label', INFORMATION_TYPE='{classification_information_type}'`

- `DROP SENSITIVITY CLASSIFICATION` - Drops classification metadata from the selected column(s). Example statement is:

    `DROP SENSITIVITY CLASSIFICATION FROM {schema_name}.{table_name}.{column_name}`

- `sys.sensitivity_classifications` - a system table to view all classifications in the database. Requires either Owner, Contributor, Reader, SQL Security Manager, or User Access Administrator roles to be able to read the data classifications.

## Understanding taxonomies

A data taxonomy is the classification of data split into categories and subcategories with the main goal to create a unified view of data within the organization. A taxonomy has a common set of terminology and semantics that can be used in all the systems a company has.

Encompassed in SQL data discovery and classification, are a set of built-in information types, discovery logic, and also sensitivity labels. This allows you to define a custom taxonomy for a concise set of data, tailored specifically for your organization.

## Dynamic Data masking

Azure SQL Database has another feature to aid limiting sensitive data exposure, Dynamic Data Masking. It prevents unauthorized access to sensitive data to non-privileged users. Dependent on the organizations requirements, data stored in SQL Database is masked using policy-based security features that hide the sensitive data in the result set of a query. The data in the database remains unchanged.
Azure SQL Database also provides the capability for automated data classification using Transact-SQL (T-SQL) or Azure REST APIs. When using T-SQL, it's important to remember any sensitivity labels added to a column are not validated against the organizational information protection policy. If you wanted to see all the current classifications they are stored in the  `sys.sensitivity_classifications` system table.

**Advanced Data Security (ADS)**
The advanced data security feature of Azure SQL provides a one stop shop for your organizations security and compliance efforts with SQL server. ADS, when enabled, includes data discovery and classification, threat protection and a vulnerability assessment features. In a single pane of glass in the portal, the **Advanced Data Security** heading in the Azure SQL Database pane, you can:

- Discover, classify, label, and protect the data stored in the SQL Database with SQL Data Discovery and Classification
- Gain visibility, monitor, and remediate your database security posture with Vulnerability Assessment.
- Monitor your database for suspicious activities (including SQL injection) and get security alerts with Threat Protection.

> [!NOTE]
> ADS is not enabled by default. Once enabled ADS comes at an additional cost of $15 USD per server per month (converted to subscription currency as required). A 30 day free trial is available.