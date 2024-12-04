When you want to implement a responsible AI system that uses Large Language Models (LLMs), you can use two key security tools available in Azure Databricks: Unity Catalog and Mosaic AI.

## Secure and govern your assets with Unity Catalog

Use **Unity Catalog** for data and AI governance in Databricks, by having access to a centralized platform to govern and secure data and AI assets.

Unity Catalog ensures compliance by managing LLMs and tracking the end-to-end lineage of your AI system data. Additionally, Unity Catalog governs vector indexes in Vector Search for document retrieval and supports cross-workspace asset usage for modern MLOps.

This comprehensive governance framework helps maintain data integrity and security across various AI workflows.

Key features of Unity Catalog include:

- **Centralized governance**: Securely manage and govern data and AI assets from a single platform.
- **Data lineage tracking**: Track the end-to-end lineage of AI system data to maintain transparency and accountability.
- **Vector index governance**: Govern vector indexes in Vector Search for efficient document retrieval.
- **Cross-workspace asset usage**: Facilitate asset usage across different workspaces to support modern MLOps practices.

## Track and manage models with Mosaic AI

You can enhance the scalability and security of consuming your LLMs by using **Mosaic AI**'s **Model Serving** capabilities.

Mosaic AI includes guardrail systems like **Safety Filter** and **Llama Guard**, which help ensure the safe deployment of AI models. Performance evaluation is streamlined with **MLflow Experiment Tracking** and `mlflow.evaluate`, enabling continuous monitoring and improvement of model performance.

> [!Tip]
> Learn more about [MLflow’s LLM evaluation functionality](https://mlflow.org/docs/latest/llms/llm-evaluate/index.html?azure-portal=true).

Key features of Mosaic AI include:

- **Scalable inference**: Securely scale LLM inference with Model Serving.
- **Guardrail systems**: Implement safety measures with systems like Safety Filter and Llama Guard from the Marketplace.
- **Performance evaluation**: Use MLflow Experiment Tracking and `mlflow.evaluate` for comprehensive performance evaluation and monitoring.

By integrating Unity Catalog and Mosaic AI, Azure Databricks provides a robust security framework that supports responsible AI implementation for LLMs. These tools ensure data governance, compliance, secure model deployment, and continuous performance evaluation, enabling organizations to build and deploy AI solutions with confidence.
