The Mojifier is a Slack bot which detects and then replaces faces in images with emojis  that match their emotion. For example:  

![Sample Mojified face. A picture of a man's face is on the left, with an arrow pointing to his face with an emoji overlaid on it on the right.](../media/example-mojify-image.png)

It's designed to work from Slack as a custom command. While you can name the command what you like, this module will refer to it as `mojify`. To execute the command, enter `/mojify <image to mojify>`.

The Mojifier then will:

  1. Calculate the emotion of any people in the image
  2. Match emotions to emojis
  3. Replaces faces in the image with emojis
  4. Post the updated image to Slack as a reply

This should result in your newly mojified image appearing in Slack, like so: 

![Invoking the Slack Mojifier app to add an emoji to an image on a URL. The Mojifier has responded to the URL with an image.](../media/8.slack-type-mojify.png)

The Mojifier is written using TypeScript, [Azure Functions](https://azure.microsoft.com/services/functions?azure-portal=true) and [Azure AI services](https://azure.microsoft.com/services/cognitive-services?azure-portal=true). You use these to make your own version of The Mojifier.

## Learning objectives

In this module, you will:

- Classify the emotion of any people in the image
- Match emotions to emojis
- Replaces faces in the image with emojis
- Post the updated image to Slack as a reply

## Tools you'll use

<a name='azure-cognitive-services'></a>

### Azure AI services

Azure AI services are a set of high-level APIs you can use to quickly add advanced artificial intelligence (AI) functionality into an app. If you know how to make an HTTP request, then you should be able to use Azure AI services.

### Azure Functions

Azure Functions lets you host code snippets that can respond to events or HTTP requests. Azure automatically handles scaling issues, and you only pay for what you use. We'll cover any costs for you in the Microsoft Learn environment.

> [!NOTE]
> All code for The Mojifier is available on [GitHub](https://github.com/MicrosoftDocs/mslearn-the-mojifier?azure-portal=true).
