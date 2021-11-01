Azure Blob Storage allows developers to host static websites by uploading the source files to a storage container.

In the scenario of the amusement park application, the web project doesn't include any backend service and can be packaged into static HTML and JavaScript files. To make this application accessible for users through the internet, these files must be hosted as a website.

Here, you'll learn more about what Azure Storage is and how it supports hosting static websites.

## Azure Blob Storage
Azure Blob Storage is a cloud storage solution designed for storing massive amounts of unstructured data. Examples of unstructured data include text and binary files, which don't adhere to any data model in particular.

The objects in blob storage can be accessed via the Azure Storage REST API, Azure PowerShell, Azure CLI, or an Azure Storage client library. The client library is available in the following languages: .NET, Java, Node.js, Python, Go, PHP, and Ruby.

## Hosting static websites on Azure Blob Storage
Azure Blob Storage allows users to host a static website directly using the files stored in the *$web* container within the storage. This feature is convenient for serving static files (HTML, CSS, JavaScript, and image assets) which don't require an extra web server to be rendered.

Using static website hosting on Azure Blob Storage is free of charge. Users are only billed for the data storage and operations costs on Azure Blob Storage. Additionally, you can link your custom domain name to the static website url that is provided by default.
