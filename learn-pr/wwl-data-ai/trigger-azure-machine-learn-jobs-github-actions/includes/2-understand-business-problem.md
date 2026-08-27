The Proseware diabetes classification model started in a Jupyter notebook on one laptop. When the team grows — data scientists, ML engineers, and reviewers — that approach breaks down. You need a place where everyone works from the same code, can review each other's changes, and can trace every model back to the code that produced it.

## What belongs in Git

A Git repository is the right home for the assets that define your model and its training process:

- **Training and preprocessing scripts** — the Python files that run data preparation and model training
- **Job and component definitions** — YAML files that describe Azure Machine Learning command jobs and pipeline components
- **Environment and dependency files** — `requirements.txt`, `conda.yml`, or Azure Machine Learning environment definitions
- **Configuration files** — workspace names, resource group names, compute names, and other references your automation uses

## What doesn't belong in Git

Some assets belong in purpose-built services, not in a repository:

- **Datasets and raw data** — use Azure Machine Learning data assets or Azure Data Lake Storage; data files are large and versioned separately from code
- **Trained model artifacts** — register named and versioned model assets in Azure Machine Learning
- **Training run outputs and logs** — Azure Machine Learning stores these with the job
- **Secrets and credentials** — use GitHub secrets or Azure Key Vault; putting credentials in a repository exposes them to anyone with read access

> [!TIP]
> A useful test: if the file is text-based and defines *how* the model is produced, it belongs in Git. If it's a large binary or a sensitive value, it belongs in a purpose-built store.

## Why source control matters for machine learning

When each training definition lives in Git, your team works from the same version of the code. A reviewer sees exactly what changed between runs. If a change degrades model performance, you can return to the previous commit. The recorded code and environment definitions also help you reproduce a training run.

This traceability is the foundation for everything that follows — branch-based development, automated validation, and an audit trail that connects every model version to the change that produced it.

> [!TIP]
> Choose one project asset. Would you store it in Git, Azure Machine Learning, or a secret store? Explain why.
