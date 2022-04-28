Machine learning requires large quantities of data to train effective models. Some of this data can contain individuals' or companies’ sensitive information that must be secured to remain private. Security challenges surrounding machine learning are not just limited to data, and the setup of creating a secure work environment can be daunting. Azure Machine Learning (Azure ML) provides several mechanisms that offers granular control of the network environment, resources used within it, and the data being accessed. Proper measures can protect both from outside attackers and from internal issues like negligence or immature processes.

Many attacks on machine learning systems involve accessing models through insecure networks to steal or manipulate data to affect model performance and access sensitive data. By building better, more secure training data stores, locking down machine learning platforms, and controlling access to inputs and outputs, we can ensure data remains protected. These features are useful for data scientists, administrators, and operations engineers who want to create secure configurations compliant with their companies’ policies.

> [!WARNING] 
>
> This module will give an understanding of the attack vectors to consider and the security tools available with Azure Machine Learning, but it is not a complete course in security. You should thoroughly read the Azure ML documentation and work with qualified cloud security experts before considering your architecture secure.

## Prerequisites

- A basic familiarity with Azure

## Learning objectives

In this module, you will:

- Apply and understand Role-Based Access Control in Azure Machine Learning
- Describe how secrets are managed in Azure Machine Learning
- Use an Azure Machine Learning workspace with Azure Virtual Network