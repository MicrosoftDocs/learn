---
author: mumian
ms.topic: include
ms.date: 10/04/2021
ms.author: jgao
---
> [!WARNING]
> By default, GitHub Actions obfuscates secret variable values in workflow logs, but you need to follow good practices as well. Your workflow steps have access to the values of secrets. If your workflow includes a step that doesn't handle a secret securely, there's a chance the secret value might be shown in the workflow logs. You should always carefully review the any changes to a workflow definition file to verify the secrets won't be mishandled.