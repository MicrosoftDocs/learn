Azure Machine Learning is a cloud service for managing machine learning project lifecycles. Machine Learning professionals, data scientists, and engineers can use Azure Machine Learning to train and deploy models and manage machine learning operations (MLOps).

When monitoring an Azure Machine Learning environment, it's important to have visibility of all resources that might affect performance, issues, and AI model quality. Monitoring of Azure Machine Learning is comprised of the following areas:

- Azure Machine Learning performance: Compute resources provide the infrastructure needed to run a machine learning workflow and can affect Azure Machine Learning runs, experiments, and overall performance. This is traditionally an area for operators and administrators.
- Workflow issues: Throughout the machine learning lifecycle, issues and errors might occur when deploying new models, when running a job, etc. Both administrators and Machine Learning professionals might be interested in this area.
- Machine Learning Models: Data drift, model prediction drift, data quality, and feature attribution drift can lead to outdated models causing your AI systems to become obsolete. Machine Learning professionals and data scientists are the traditional owners of this monitoring.

Azure Monitor is the primary tool for managing an Azure Machine Learning environment. Azure Monitor provides built-in capabilities to monitor Azure Machine Learning's performance and workflow issues. You can also expand these capabilities for your own needs. AI model management relies on production inference data collection. This analysis is part of Azure Machine Learning model monitoring.
