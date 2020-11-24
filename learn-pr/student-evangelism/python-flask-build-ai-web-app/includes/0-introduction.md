It can sometimes be confusing to determine which web framework to use when creating an application. Each one has its own advantages, tooling, and scenarios for which its best suited. Let's look at a specific example, and then select an appropriate option.

Imagine you are tasked with creating an application which will translate text to various languages. Rather than creating a machine learning model on your own, you've decided to use [Azure Cognitive Service](https://docs.microsoft.com/azure/cognitive-services?WT.mc_id=python-11210-chrhar)'s [Translator service](https://docs.microsoft.com/azure/cognitive-services/translator?WT.mc_id=python-11210-chrhar). The Translator service is accessed via an HTTP call. As a result, we don't need a database or anything fancy; we just need a service to host our application.

This is where a framework like Flask is a perfect choice! Flask is described by its creators as a "micro-framework", meaning it provides the core services required (routing, templating, etc.), but otherwise allows you to use whatever backend services your application needs. It's also lightweight, making it quick to setup and deploy.

In this module we are going to explore Flask and the Translator service, and see how we can create a web application to translate text into various languages.

## Learning objectives

In this module, you will build a website using Flask and Cognitive Services to translate text.

- Learn how to set up a Flask development environment
- Learn how to use Flask to build a form
- Learn how to use the Translator service to translate text

## Prerequisites

- Python 3.6 or later and VS code installed on your computer. Follow the steps in the [Install Python 3](https://docs.microsoft.com/learn/modules/python-install-vscode/3-exercise-install-python3?azure-portal=true) module. At the top of the article, choose the instructions for your configuration: Windows, Linux, or macOS.
- [Visual Studio Code](https://code.visualstudio.com)
