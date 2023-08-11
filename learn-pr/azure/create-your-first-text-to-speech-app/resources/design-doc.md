# Design Document

## Title

Create your first Azure Cognitive Services Text to speech application

## Role(s)

- developer

## Level

- beginner

## Product(s)

- azure
- azure-cognitive-services

## Prerequisites

- Basic familiarity with development tools

## Summary

Microsoft's Azure Cognitive Services provide developers with APIs to create applications that take advantage of Azure's text to speech features. In this module, you'll learn how to use Azure Cognitive Services to create a text to speech application.

## Learning objectives

By the end of this module, you'll:

1. Create an Azure Cognitive Services account
1. Create a command-line application that converts text to speech
1. Create a command-line application that converts SSML to speech

## Chunk your content into subtasks

Identify the subtasks of *Create your first Azure Cognitive Services Text to speech application*

| Subtask | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
|---|---|---|---|---|
| Create an Azure Cognitive Services account | Exercise | 1 | Yes |
| Create a command-line text to speech app with TEXT file | Exercise | 2 | Yes |
| Create a command-line text to speech app with SSML file | Exercise | 3 | Yes |

## Outline the units

1. **Introduction**

    TBD

1. **Create an Azure Cognitive Services account**

    - Explain the need for an Azure Cognitive Services account
    - Show Azure portal screenshots

1. **Exercise - Create an Azure Cognitive Services account**

    1. Set RESOURCEGROUP to sandbox resource group

    1. Set LOCATION as LOCATION=$(az group show --name $RESOURCEGROUP | jq -r '.location')

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

1. **Create a text to speech application using a text file**

    1. Explain the difference between TEXT and SSML

    1. Get the list of languages from <https://learn.microsoft.com/en-us/azure/cognitive-services/speech-service/language-support#neural-voices>

1. **Exercise - Create a text to speech application using a text file**

    1. Scaffold .NET Core console application

       ```bash
       mkdir text to speech
       cd text to speech
       dotnet new console
       ```

    1. Add the Azure Cognitive Services Speech library

       ```bash
       dotnet add package Microsoft.CognitiveServices.Speech
       ```

    1. Edit the `Program.cs` file in the editor:

       ```bash
       code Program.cs
       ```

    1. Open the _Program.cs_ file in the editor

    1. Replace the code

       ```csharp
       using System;
       using System.IO;
       using System.Text;
       using System.Threading.Tasks;
       using Microsoft.CognitiveServices.Speech;
       using Microsoft.CognitiveServices.Speech.Audio;
       ```

    1. Hard code the language string in the code

    1. Create TEXT file for app to process

    1. Run your application

       ```bash
       dotnet run
       ```

1. **Create a text to speech application using an SSML file**

    1. Explain basic SSML

    1. See [Improve synthesis with Speech Synthesis Markup Language (SSML)](https://learn.microsoft.com/azure/cognitive-services/speech-service/speech-synthesis-markup)

    1. See [Speech service phonetic sets](https://learn.microsoft.com/en-us/azure/cognitive-services/speech-service/speech-ssml-phonetic-sets)

1. **Exercise - Create a text to speech application using a SSML file**

    1. Create SSML file that specifies the language code

    1. Remove the hard coded the language string from the code

    1. Update app to use the SSML API

1. **Summary**

    In this module you created your first Azure Cognitive Services Text to speech application, where you created Azure Cognitive Services account, then created an application that used both TEXT and SSML to turn text into speech.

## Notes

- [Introduction to text to speech](https://learn.microsoft.com/learn/modules/intro-to-text-to-speech/)

- [Quickstart: Create a Cognitive Services resource using the Azure Command-Line Interface (CLI)](https://learn.microsoft.com/cognitive-services/cognitive-services-apis-create-account-cli)

- [Get started with text to speech](https://learn.microsoft.com/azure/cognitive-services/speech-service/get-started-text-to-speech)

- [Language and voice support for the Speech service](https://learn.microsoft.com/azure/cognitive-services/speech-service/language-support)

- [Improve synthesis with Speech Synthesis Markup Language (SSML)](https://learn.microsoft.com/azure/cognitive-services/speech-service/speech-synthesis-markup)

- [Speech service phonetic sets](https://learn.microsoft.com/en-us/azure/cognitive-services/speech-service/speech-ssml-phonetic-sets)
