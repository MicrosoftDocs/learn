Creating a web application with artificial intelligence (AI) doesn't need to involve a lot of code or creating services from scratch. Let's imagine we wanted to create a website that can translate text for the user.

For the front end, we want something that will allow us to integrate our services without having to jump through a lot of hoops. A framework like Flask is a perfect choice. Flask is described by its creators as a "micro-framework", meaning it provides the core services required, such as routing and templating, but otherwise allows you to use whatever backend services your application needs. It's also lightweight, making it quick to set up and deploy. We don't need a database or anything fancy. We just need a framework to create our UI, and be able to call the back-end service.

For the back end, rather than creating a machine learning model on your own, you can use a collection of AI services (known as [Azure Cognitive Service](https://docs.microsoft.com/azure/cognitive-services?WT.mc_id=python-11210-chrhar&azure-portal=true)). These services can either be accessed via an SDK or an HTTP call. We can use the [Translator service](https://docs.microsoft.com/azure/cognitive-services/translator?WT.mc_id=python-11210-chrhar&azure-portal=true) to meet our primary goal of translating text.

In this module, we're going to explore Flask and the Translator service. We'll see how we can create a web application to translate text into various languages.

## Learning objectives

In this module, you'll build a website using Flask and Cognitive Services to translate text.

- Learn how to set up a Flask development environment
- Learn how to use Flask to build a form
- Learn how to use the Translator service to translate text

## Prerequisites

- Python 3.6 or later and VS code installed on your computer. Follow the steps in the [Install Python 3](https://docs.microsoft.com/learn/modules/python-install-vscode/3-exercise-install-python3?azure-portal=true) module. At the top of the article, choose the instructions for your configuration: Windows, Linux, or macOS.
- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true)
