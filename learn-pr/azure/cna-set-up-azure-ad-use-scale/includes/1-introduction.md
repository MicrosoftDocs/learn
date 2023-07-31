Resilient, flexible, and scalable security controls are particularly important when implementing cloud-native applications. To provide this functionality, you can leverage authentication and authorization functionality offered by Azure Active Directory (Azure AD).

## Scenario: Set up apps for authentication

Suppose you work for Adatum Corporation, which is a manufacturer of devices such as refrigerators and air-conditioning units. You lead a small development team, and you've been tasked with building a multiple-feature app for smart refrigerators.

Your team has developed a refrigerator-inventory service that businesses can use to easily identify what items they need to restock. They can also set up this service to automatically reorder required items. For this purpose, you used an Azure Kubernetes Service (AKS) cluster-hosted Node.js app. This app processes messages from refrigerators and sends them to a management web app, with Azure Database for PostgreSQL serving as the data store.

While your application satisfied all the requirements specified at that time, its use cases didn't account for the need to accommodate multitenant scenarios, where different businesses might need to have their own display of their respective inventories and be able to access them securely.

In this module, you'll explore how Azure AD helps you to address this need. While Azure AD natively supports multi-tenancy, integrating it into your existing application will require some changes to individual application components and data stores.

## Prerequisites

* Basic familiarity with Azure
* Basic understanding of cloud computing
* Basic familiarity with programming concepts

## Learning objectives

After completing this module, you'll know more about how to:

* Describe the characteristics and functionality of Azure AD.
* Implement Azure AD authentication for cloud-native applications.
