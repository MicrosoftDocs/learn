You can use Azure Batch to execute large-scale, high-intensity computation jobs efficiently in Azure.

Imagine you're a software developer at a non-profit organization whose mission is to give every human on the planet access to clean water. To reach this goal, every citizen is asked to take a picture of their water purification meter and text it to you. Each day, you have to scan pictures from over 500,000 households, and record each reading against the sender phone number. The data is used to detect water quality trends and to dispatch the mobile water quality team to investigate the worst cases across each region. Time is of the essence, but processing each image with Optical Character Recognition (OCR) is time-intensive. With Azure Batch, you can scale out the amount of compute needed to handle this task on a daily basis, saving your non-profit the expense of fixed resources.

In this module, you'll learn about using Azure Batch to create and run parallel tasks with the Azure CLI, and how to use the CLI to check the status of Batch jobs and tasks. This module also describes how to use the standalone Batch Explorer tool to monitor ongoing jobs.

By the end of this module, you'll be able to create, execute, and monitor batch jobs.

## Learning objectives

In this module, you will:

- Create a Batch job in the Azure CLI
- Run a Batch job in the Azure CLI
- Check the status and results of a Batch job in the Azure CLI
- Monitor a Batch job with Batch Explorer

## Prerequisites

- Familiarity with Azure and the Azure CLI

>[!IMPORTANT]
>The exercises in this module are optional. To complete the exercises, you will need your own Azure subscription.
