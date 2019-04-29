Your company has undergone a data centralization project as part of their move to the Microsoft Azure platform. The result of this project has left data stored in different cloud services. Your company has decided to use Azure SQL Database to discover and identify this data. You'll evaluate this data to ensure it's classified appropriately to work towards meeting regulatory and business requirements.

Your IT manager has asked you to provide some suggestions on how to refine your information security policies for data classification. They'd like to align to a new model following the company's move to Azure.

In this unit, you'll explore data classification in Microsoft Azure and the steps to identify and classify data using Azure SQL Database.

## Data Classification in the Azure Cloud Platform

Data classification is one of the fundamental ways for an organization to understand and assign relative values to their data. The data classification process provides a way for organizations to categorize data by its business impact and sensitivity level, so the risks associated with the data can be determined. Once the process is complete, organizations manage data in ways to reflect its value to them, rather than treating all data the same. Data classification is a prudent, considered approach, that enables an organization to focus its efforts on protecting data. This is only possible if an appropriate value is given to the different types of data.

There has been some refinement to the data classification in cloud computing, but the foundations remain the same. For data classification to be a success, it requires an organization to have awareness of its needs and a deep understanding of where their data assets live.

A significant part of any data security process is to ensure access to data is controlled through authorization and authentication:

![Screenshot showing authentication and authorization process](../media/1-authentication-authorization.png)

**Authorization**

Authorization provides an individual authenticated user access to data, that could be a data set, file, or other object. Authenticated users are assigned permissions to use the data. Access is validated based on a combination of the users need, security, risk policies, and job role.

**Authentication**

Authentication is a process of identifying a user but doesn't assign access. It simply verifies the user is who they say they are. Authentication consists of a minimum of two parts:

- **User ID or username** - A unique identifier used to identify an individual user.
- **Token** - Typically a password used to verify that the individual user identifier is valid.

## Roles and responsibilities in the cloud

When your organization has adopted a cloud service provider, it's vital to understand who has the role and responsibilities for data classification. There are three primary cloud models, Software as a service (SaaS), Platform as a service (PaaS) and Infrastructure as a service (IaaS). Below is a cloud responsibility matrix displaying where the responsibility typically lies:

![Screenshot showing cloud responsibility matrix](../media/1-cloud-responsibility-matrix.png)

The above shows that whatever service is being used an organization remains responsible for classifying their own data. More information on Microsoft's commitments around data classification to its customers can be found in the [Microsoft Trust Center](https://www.microsoft.com/en-us/trustcenter/default.aspx).

## Compliance considerations

A critical part of any cloud service is to ensure compliance with regulations. For example, FedRAMP, U.S. HIPAA, or other data protection rules. When moving to the cloud, organizations should be aware of their data classification obligations. Most cloud service providers offer a range of features to support their customers compliance obligations.

## Data Classification Process

A data classification process needs to be simple and effective to implement. There's a clear purpose for classifying data. It's to ensure no unauthorized disclosure, or misuse, of data. Using the assigned classification the data can be assigned to an appropriate retention policy.

There are various models available, but a model commonly used for data classification is PLAN, DO, CHECK, and ACT. The figure below highlights the flow of tasks:

![Screenshot data classification process model of PLAN, DO, CHECK, and ACT](../media/1-data-classification-model.png)

- **PLAN** - Identify the organizations data assets, develop data protection policies, and employ or assign a data owner (custodian) for the data classification program.
- **DO** - Following agreement on data classification policies, implement the program and enable enforcement technologies as required for confidential data.
- **CHECK** - Verify the methods and tools selected are successfully addressing classification policies, typically done by validating or checked reports.
- **ACT** - The final step of the process purpose built to enable revision by reviewing the status of data access. Any data or files that require revision go through a revision and classification methodology for addressing new risks or adopting change.

## Walk through of data stewardship

A vital part of data classification is data ownership. It's key to establish a clear chain of command for all data assets. Any data governance program needs a combination of people, process, and technology to be effective. Let's consider some of the key roles for a data ownership process:

**Data Asset Owner**: The original data creator. Can assign a steward and delegate ownership. Marks data with a classification upon creation and has responsibility to understand confidentiality. Owners can delegate responsibilities to a data steward after data is classified.

> [!NOTE]
> For personal data, it's important to establish clear and concise organizational policies for usage of personal devices or software is in accordance with any guidelines for data classification.

**Data Asset Custodian**: Gets assigned by the asset owner. Manages data in accordance with organizational policy. Stewards take overall ownership of assets ensure appropriate access control is in place.

**Data Asset Administrator**: Responsible for maintaining data integrity. Administrators provide management services without access to underlying data assets.

**Data Asset Users**: Anyone using the data or file.

## Discover and classify data using Azure SQL Database

Azure SQL Database has advanced capabilities built in through a feature called Data discovery and classification, as part of the Advanced Data Security (ADS) feature. The data discovery and classification offering enables the discovery, classification, labeling, and protection of sensitive data stored in your databases. Discovering and classifying sensitive data can play a pivotal role in keeping organizational data secure.

> [!NOTE]
> The above applies to Azure SQL Database, Azure SQL Data Warehouse, and the latest versions of SQL Server Databases.

## Summary of Azure SQL Database capabilities

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

See the [reference docs](<https://docs.microsoft.com/en-us/rest/api/sql/sensitivitylabels>) for the operations available in the Azure REST API.

## Understanding taxonomies

Taxonomies are an important part of the data classification process. A data taxonomy is the classification of data split into categories and subcategories with the main goal to create a unified view of data within the organization. A taxonomy has a common set of terminology and semantics that can be used in all the systems a company has.

Encompassed in SQL data discovery and classification, are a set of built-in information types, discovery logic, and also sensitivity labels. This allows you to define a custom taxonomy for a concise set of data, tailored specifically for your organization.

## Dynamic Data masking

Azure SQL Database has another feature to aid limiting sensitive data exposure, Dynamic Data Masking. Dynamic Data Masking prevents unauthorized access to sensitive data to non-privileged users. Dependent on the organizations requirements data stored in SQL Database is masked using policy-based security features that hide the sensitive data in the result set of a query. The data in the database remains unchanged.

Let's try out what we have learned by using Azure SQL Database to discover and classify data.
