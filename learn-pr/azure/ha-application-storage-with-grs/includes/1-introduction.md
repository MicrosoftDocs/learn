Azure Storage helps provide a safe, secure repository for your application data. If access to the data is critical to the well-being of your system, you need to make sure that it's highly available. To achieve this goal, you should use geo-redundant storage. Using geo-redundant storage ensures high availability by storing synced copies of the data in two or more Azure regions. If your connection to one Azure region fails, you can fail over to another region and still access your data.

Imagine that you're the solution architect for your company's organization. Your role is to work with company developers to develop a healthcare application that allows doctors and consultants in the field to upload images from visits with patients. These images contain essential clinical information, and they must be available even if an Azure region fails. The developers want to use the built-in capabilities that Azure provides for storage replication. Your goal is to ensure that the deployed system is highly available and accessible to the staff and always secure.

In this module, learn how to make your application data highly available by using read-access geo-redundant storage (RA-GRS).

## Learning objectives

In this module, you'll:

- Identify the key features of RA-GRS.
- Identify the application design considerations for using RA-GRS.
- Implement the Circuit Breaker pattern in a sample application.

## Prerequisites

- Basic knowledge of Azure storage accounts
- Familiarity with C#
- Ability to install software locally (Visual Studio, Fiddler, Git)
