Cloud-native applications are modular in nature, with loosely coupled, self-contained components. You can develop each of these components independently by using an arbitrary combination of technology stacks, while still allowing for their interaction via well-defined programming interfaces. These benefits include the ability to secure access by relying on Azure Active Directory (Azure AD) for authentication and authorization.

## Scenario: Set up apps for authentication

Suppose you work for Adatum Corporation, which is a manufacturer of devices such as refrigerators and air conditioning units. You lead a small development team, and you've been tasked with building a multiple-feature app for smart fridges. 

Your team has developed a refrigerator inventory service that businesses can use to easily identify what items they need to restock. They can also set up this service to automatically reorder required items. For this purpose, you used an AKS cluster-hosted Node.js app, which processes messages from refrigerators and sends them to a management web app, with the Azure Database for PostgreSQL serving as the data store. 

While your application satisfied all requirements stipulated at that time, its use cases didn't account for the need to accommodate multitenant scenarios, where different businesses might need to have their own view of their respective inventories and be able to access them securely. 

In this module, you'll explore how Azure AD helps you to address this need. While Azure AD natively supports multitenancy, integrating it into your existing application will require some changes to individual application components and data stores.

## Prerequisites

* Basic familiarity with Azure
* Basic understanding of cloud computing
* Basic familiarity with programming concepts

## Learning objectives

After completing this module, you'll be able to:

* Describe the characteristics and functionality of Azure AD
* Implement Azure AD authentication for cloud-native applications

