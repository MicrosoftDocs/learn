Creating a web application with artificial intelligence (AI) doesn't need to involve a lot of code or creating services from scratch. Let's imagine we wanted to create a website that can translate text for the user.

For the front end, we want something that will allow us to integrate our services without having to jump through a lot of hoops. A framework like Flask is a perfect choice. Flask is described by its creators as a "micro-framework", meaning it provides the core services required, such as routing and templating, but otherwise allows you to use whatever backend services your application needs. It's also lightweight, making it quick to set up and deploy. We don't need a database or anything fancy. We just need a framework to create our UI, and be able to call the back-end service.

For the back end, rather than creating a machine learning model on your own, you can use a collection of AI services (known as [Azure Cognitive Service](/azure/cognitive-services?azure-portal=true&WT.mc_id=python-11210-chrhar)). These services can either be accessed via an SDK or an HTTP call. We can use the [Translator service](/azure/cognitive-services/translator?azure-portal=true&WT.mc_id=python-11210-chrhar) to meet our primary goal of translating text.

In this module, we're going to explore Flask and the Translator service. We'll see how we can create a web application to translate text into various languages.

## Learning objectives

In this module, you'll build a website using Flask and Azure AI services to translate text.

- Learn how to set up a Flask development environment
- Learn how to use Flask to build a form
- Learn how to use the Translator service to translate text

## Prerequisites

- An Azure account. [Create Your Azure Free Account](https://azure.microsoft.com/free/).
- Visual Studio Code installed on your computer. [Download Visual Studio Code](https://code.visualstudio.com/Download)
- Python 3.6 or later installed on your computer. [Instructions for installing Python](https://code.visualstudio.com/docs/python/python-tutorial#_install-a-python-interpreter)
- The Python extension for Visual Studio Code installed on your computer. [Python extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
