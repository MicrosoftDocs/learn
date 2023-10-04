---
uid: learn.wwl.build-azure-machine-learn-custom-skill-for-azure-cognitive-search.knowledge-check
title: Knowledge check
description: Knowledge check
durationInMinutes: 3
---
Use the following questions to check your knowledge of the concepts discussed in this module.
## quiz title: 

## Multiple Choice
Which of the following options is the only supported endpoint for use with Azure Cognitive Search custom AML skill?
( ) Real-time endpoint. {{Incorrect. You can create a real-time endpoint in Azure AI Machine Learning Studio, but it can't be used by the AmlSkill.}}
(x) Web service. {{Correct. The AmlSkill can use a web service as an endpoint.}}
( ) Batch endpoint. {{Incorrect. You can create a batch endpoint in Azure AI Machine Learning Studio, but it can't be used by the AmlSkill.}}

## Multiple Choice
Which is the correct custom skill you need to use to connect to an Azure Machine Learning model?
( ) #Microsoft.Skills.Vision.ImageAnalysisSkill. {{Incorrect. This skill is a built-in skill to perform OCR text extraction from images.}}
( ) #Microsoft.Skills.Custom.WebApiSkill. {{Incorrect. This skill is a custom skill, but it's used to connect to any REST endpoint.}}
(x) #Microsoft.Skills.Custom.AmlSkill. {{Correct. This skill is the custom skill you can use to connect directly to an AML endpoint.}}

## Multiple Choice
What's the best way to improve the performance of an AML skill when enriching documents?
(x) Use more powerful nodes in the Kubernetes inference cluster. {{Correct. The best way to improve efficiency is to improve the performance of your inference cluster.}}
( ) Increase the batch size of documents enriched. {{Incorrect. You can't increase the batch size in the custom AML skill. Only a single document can be enriched at a time.}}
( ) Reduce the complexity of the index properties being enriched. {{Incorrect. This option might have a small improvement in performance as the amount of data being processed is reduced. However, there's a better performance improvement.}}