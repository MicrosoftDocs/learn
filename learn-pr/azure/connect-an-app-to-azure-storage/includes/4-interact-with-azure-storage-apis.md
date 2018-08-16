## Motivation

You know what kind of app you want to build and you want to begin adding functionality as soon as possible. In order to do this you need to know how to connect to and utilise Azure Storage to allow you to build the business functionality into your app. This is a common need for developers which has resulted in libraries being developed to expedite connecting to and using Azure Storage. These are commonly called *client libraries* and is generally the easiest way to interact with Azure Storage. In this module you will learn how to add the appropriate client library as a reference in your .NET application.

## Application Programming Interface (API)

Azure Storage exposes services using a set a of application programming interfaces (APIs) over the internet using REST (Representational State Transfer) protocols. These APIs are fully documented at [Azure Storage Services REST API Reference](https://docs.microsoft.com/en-us/rest/api/storageservices/). While it is possible to interact directly with those APIs, Azure Storage access is generally performed using a client library. This saves significant work for application developers as the API work is performed by well tested client libraries, that are available in a variety of languages and technical stacks.

## Language Support

There are a number of client libraries for accessing Azure Storage that support a number of languages. This [SDK Tools Documentation page](https://docs.microsoft.com/en-us/azure/#pivot=sdkstools) contains links to the client libraries or SDKs for all the currently supported languages. These include .Net, Java, Python, Node.js, and Go.
