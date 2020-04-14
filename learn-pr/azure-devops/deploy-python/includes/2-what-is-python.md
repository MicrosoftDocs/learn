## What is Python?

**Python** is an interpreted programming language designed to be easy to use and understand. Python includes strong native support for object-oriented programming, which enables developers to develop applications that scale in size and complexity, which makes it an ideal candidate for modern applications. You can learn more about the details on the [official Python site](https://www.python.org/?azure-portal=true).

## What is Django?

**Django** is a framework designed to make the development of web applications in Python practical. It offers a collection of modules and conventions that enable Python developers to efficiently build and maintain web applications using a variety of development tools and deployment targets. You can learn more about the details on the [official Python site](https://www.djangoproject.com/?azure-portal=true).

> [!NOTE]
> This module is based on a Python project that makes use of Django, although its contents should generally apply to a broad array of Python scenarios that may use other frameworks (or none at all).

## Python and Azure

Azure provides first-class support for Python. This means that developers can take their existing codebase and, in most cases, deploy it to Azure as-is. As far as Azure is concerned, hosting Python solutions is comparable to hosting .NET solutions, assuming that the proper dependencies are configured. Azure also provides the means to configure environment variables for application settings, which means you can continue to load settings and secrets using standard Python mechanisms.

Once deployed to Azure, Python applications can connect to resources within Azure, across VPN connections, and anywhere else accessible via the internet. This includes consuming databases, document stores, and all the other resources and services Python developers rely on to be successful.

## Python and Azure DevOps

Python developers will find a welcoming environment in Azure DevOps. Although it provides a wide range of features for managing the entire software lifecycle, developers can optionally cherry pick the features desired to make their process as efficient as possible. Even if just using Azure Pipelines to build and deploy source code pulled in from GitHub or another repo, Python is supported via a variety of build, test, and deploy tasks. And if those aren't available, you can always execute arbitrary scripts to fill gaps as needed.

Pipeline jobs are run by agents managed by Azure DevOps. While you have the complete flexibility to create your own, the vast majority of jobs can be run entirely on Microsoft-hosted agents that include images for Windows, Linux, and Mac. These agents include common versions of Python, pip, PyPy, and Selenium web drivers for the browsers native to that platform. The exact software and versions available on each platform image vary, but the details are kept up to date at [Microsoft-hosted agents](/azure/devops/pipelines/agents/hosted?azure-portal=true).
