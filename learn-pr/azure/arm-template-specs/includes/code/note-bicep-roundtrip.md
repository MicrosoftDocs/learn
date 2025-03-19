---
author: mumian
ms.topic: include
ms.date: 06/14/2021
ms.author: jgao
---
> [!IMPORTANT]
> When you publish a Bicep file as a template spec, your Bicep code is converted to a JSON template. The process of converting your Bicep code to JSON removes some of the information in your Bicep file. For example, your comments, symbolic names for resources, and the order in which you define your resources might be missing or different in JSON. This means you can't easily publish a Bicep file as a template spec and then get the original Bicep file back (also called _roundtripping_). It's a good idea to keep a copy of your original Bicep code in a code repository like Git, especially when you work with template specs.