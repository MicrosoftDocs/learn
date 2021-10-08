---
author: johndowns
ms.prod: learning-azure
ms.topic: include
ms.date: 10/04/2021
ms.author: jodowns
---
> [!WARNING]
> By default, Azure Pipelines obfuscates secret variable values in pipeline logs, but you need to follow good practices as well. Your pipeline steps have access to all variable values, including secrets. If your pipeline includes a step that doesn't handle a secure variable securely, there's a chance the secret variable might be shown in the pipeline logs.
