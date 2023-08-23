# Design Document

## Title

Create your first Azure AI speech to text application

<a name='roles'></a>

## Roles

- developer

## Level

- beginner

<a name='products'></a>

## Products

- Azure
- Azure-cognitive-services

## Prerequisites

- Basic familiarity with development tools

## Summary

Microsoft's Azure AI services provide developers with APIs to create applications that take advantage of Azure's speech to text features.

## Learning objectives

By the end of this module, you'll:

1. Create an Azure AI services account
1. Create a command-line application that converts speech to text
1. Update your command-line application to use a Recognizer to process all audio

## Chunk your content into subtasks

Identify the subtasks of *Create your first Azure Cognitive Services speech to text application*

| Subtask | How will you assess it: **Exercise or Knowledge check**? | Which learning objectives does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
|---|---|---|---|---|
| Create an Azure AI services account | Exercise | 1 | Yes |
| Create a command-line speech to text app | Exercise | 2 | Yes |
| Update the command-line speech to text app | Exercise | 3 | Yes |

## Outline the units

1. **Introduction**

    TBD

1. **Create an Azure AI services account**

    - Explain the need for an Azure AI services account
    - Show Azure portal screenshots

1. **Exercise 1 - Create an Azure AI services account**

    1. Set RESOURCEGROUP to sandbox resource group

    1. Set LOCATION as LOCATION=$(az group show --name $RESOURCEGROUP | jq -R '.location')

    1. Set ACCOUNT to an account name

    1. Create the account:

       ```dotnetcli
       az cognitiveservices account create \
           --name $ACCOUNT \
           --resource-group $RESOURCEGROUP \
           --kind SpeechServices \
           --sku F0 \
           --location $LOCATION \
           --yes
       ```

    1. List the keys:

       ```dotnetcli
       az cognitiveservices account keys list \
           --name $ACCOUNT \
           --resource-group $RESOURCEGROUP
       ```

    1. Copy the keys, which you'll use later:

       ```
       {
           "key1": "0123456789abcdef0123456789abcdef",
           "key2": "fedcba9876543210fedcba9876543210"
       }
       ```

1. **Create a single-shot recognition speech to text application**

    A single-shot recognition speech to text application recognizes a single utterance. The end of a single utterance is determined by listening for silence at the end or until a maximum of 15 seconds of audio is processed.

1. **Exercise - Create a single-shot recognition speech to text application**

    1. Scaffold .NET Core console application

       ```bash
       mkdir speech to text
       cd speech to text
       dotnet new console
       ```

    1. Download a sample WAVE file for this exercise

       ```bash
       curl https://SOME-URL/file.wav -o file.wav
       ```

    1. Add the Azure AI Speech library

       ```bash
       dotnet add package Microsoft.CognitiveServices.Speech
       ```

    1. Open the code editor

       ```bash
       code .
       ```

    1. Open the *Program.cs* file in the editor

    1. Replace the code

       ```csharp
       using System;
       using System.IO;
       using System.Text;
       using System.Threading.Tasks;
       using Microsoft.CognitiveServices.Speech;
       using Microsoft.CognitiveServices.Speech.Audio;
       ```

    1. Run your application

       ```bash
       dotnet run
       ```

1. **Create a continuous recognition speech to text application**

    Continuous recognition allows your application to control when it should stop recognizing. It requires you to subscribe to the Recognizing, Recognized, and Canceled events to get the recognition results.

1. **Exercise - Create a continuous recognition speech to text application**

    1. Update the code as necessary

1. **Summary**

    In this module you created your first Azure AI speech to text application

## Notes

- [Quickstart: Create a Azure AI services resource using the Azure CLI](https://learn.microsoft.com/cognitive-services/cognitive-services-apis-create-account-cli)

- [Language and voice support for the Speech service](https://learn.microsoft.com/azure/cognitive-services/speech-service/language-support)

- [Get started with speech to text](https://learn.microsoft.com/azure/cognitive-services/speech-service/get-started-speech-to-text)
