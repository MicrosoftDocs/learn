Azure Storage provides a safe and secure repository for your application data. If access to the data is critical to the well-being of a system, you also need to make sure it's also highly available. To achieve this goal, you should use geo-redundant storage. Using geo-redundant storage ensures high-availability by storing synchronized copies of the data in various Azure regions. If your connection to an Azure region fails, you can fail over to an accessible region and still access your data.

Imagine that you're the solution architect for your company's healthcare organization. Your role is to work with company developers to develop an application that allows doctors and consultants in the field to upload images from visits with patients. These images contain essential clinical information, and they need to be available even if an Azure region fails. The developers want to use the built-in capabilities that Azure provides for storage replication. Your goal is to ensure that the deployed system is highly available and accessible to the staff and secure at all times.

To make your application and data highly available, you'll use read-access geo-redundant storage (RA-GRS).

## Learning objectives

In this module, you will:

- Identify the key features of RA-GRS.
- Identify the application design considerations for using RA-GRS.
- Implement the Circuit Breaker pattern in a sample application.

## Prerequisites

- Basic knowledge of Azure storage accounts
- Familiarity with C#
- Ability to install software locally (Visual Studio, Fiddler, Git)
