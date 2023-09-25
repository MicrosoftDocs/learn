For security reasons, most web browsers restrict resource access to a single domain. This means that a web application that is running in one domain can't access resources that are held in another domain. This is known as Same Origin Policy. However, sometimes it is necessary for a web app to request resources that are held in another domain. Cross-Origin Resource Sharing (CORS) provides a way to share resources across domains securely.

Suppose you're the lead developer for a major utilities company. Your team has developed a web application to allow remote engineers to log job times, and view job specifications. Many of the job specifications documents are kept in Azure Storage, and your company would like to implement CORS rules to enable access to these documents.

By the end of this module, you'll see how to use CORS to allow your web application to access information held in Azure Storage.

## Learning objectives

In this module, you will:

- Understand Cross-Origin Resource Sharing (CORS) concepts and terminology
- Configure CORS rules for your Azure Storage services

## Prerequisites

  - Familiarity with Azure Storage
  - Familiarity with the Azure CLI and PowerShell
