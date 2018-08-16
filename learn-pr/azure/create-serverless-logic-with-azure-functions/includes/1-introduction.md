## Motivation

You work for an escalator company that has large investments in IoT technology. You oversee the processing of temperature sensor data from the drive gears of escalators. You need to transform incoming data to include a flag indicating the overall health of the drive gear based on the temperature. In downstream systems, this will determine whether proactive maintenance is required.

<!-- --- IMAGE SIMILAR TO https://courses.cit.cornell.edu/arch262/notes/images/13b-escalator05.jpg -->

Your company receives sensor telemetry from different sources, and at different rates based on customer systems. Sources may include batch file upload, a scheduled database pull, a message on a queue, or incoming data from an event hub. You need to develop a reusable service that can be executed on-demand at the receipt of temperature data from any source.

Developing and hosting a service like this used to require servers and infrastructure. With Azure Functions you get serverless compute which allows you to choose your language, write the code, and have your logic executed when you need it, without the need to provision and scale infrastructure.

You can focus on building great apps, not provisioning or maintaining servers.

## Learning Objectives

* Decide if Serverless computing is right for your business need
* Create an Azure Functions App in the Azure portal
* Execute a function using triggers
* Monitor and test your Azure Function from the Azure portal

## Audience

Software developers new to serverless and Azure Functions

## Pre-requisites

* Azure account. [Create your free account](http://azure.microsoft.com/Account/Free) now. If you don't have one. Then, [launch the Azure portal](https://azure.microsoft.com/features/azure-portal/) and sign in.
