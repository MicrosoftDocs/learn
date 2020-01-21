Imagine you're a professional web developer and your client is a travel agency. To motivate its customers to stay in touch, the agency wants its website to include a service that translates road signs and billboards in real time. The customer, exploring a foreign land, snaps a picture of a sign she can't read, in a language she doesn't understand. She uploads the picture to the service, and it responds with a translation in her native language. No typing, no forms to fill out—just "Here's a picture, tell me what it says."

To meet the client's requests, the website must support the following features:
- Uploading of photos
- Extraction of text from these photos
- Translation of the extracted text into the user's native language

Just a few years ago, such a feature list would have been unthinkable for most small businesses. Extracting text from photos and translating text into other languages is typically performed using machine learning and artificial intelligence (AI). Where would these capabilities come from? Today, these features and more are readily available in [Azure Cognitive Services](https://azure.microsoft.com/services/cognitive-services/). It's Microsoft's portfolio of more than 20 services and APIs designed to make AI and machine learning available to anyone who can lay down a few lines of code.

One of these services is the [Computer Vision API](https://azure.microsoft.com/services/cognitive-services/computer-vision/), which can not only extract text from photos, but also identify objects in photos, find faces in photos and predict their age and gender, and more. Another is the [Translator Text API](https://azure.microsoft.com/services/cognitive-services/translator-text-api/), which can translate text between dozens of the world's written languages.

Using these services, you will produce a website written in [Python](https://devblogs.microsoft.com/python/)—already among the world's most popular languages—and the [Flask](http://flask.pocoo.org/) framework for Python web applications. This site will translate signage in photos, which is a feature your client can build upon to attract new customers and retain existing ones.

## Learning objectives

In this module, you build a website named "Contoso Travel" step by step. First, you will prepare a development environment that supports applications written in Python and Flask. Then you will learn the basics of Flask. Next, you will build the website and employ Azure Cognitive Services to do the heavy lifting of extracting and translating text. Finally, after testing the website locally, you will deploy it to Azure for the whole world to enjoy. Along the way, you will learn:

- How to set up a Flask development environment
- How to use Flask to build a page that accepts photo uploads
- How to use the Computer Vision API to extract text from photos
- How to use the Translator Text API to translate text extracted from photos
- How to deploy the application to Azure

## Prerequisites

None.

Sound like fun? Then let's get started.