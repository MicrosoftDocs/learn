Proseware is a young start-up, aiming to improve health care. One team at Proseware is working on a new web application that will help practitioners diagnose patients more quickly. Research has shown that diabetes is one of the diagnoses that is common, and easily detected when a certain pattern in the medical data of a patient is evident.

To launch the new web app for practitioners that will help them with diagnosing patients, the first feature to be rolled out in the app is a diabetes detector. The feature will enable a practitioner to collect medical data from a patient, fill it in the app, and learn whether there's a high chance of that patient having diabetes yes or no. The practitioners will use those insights with their expertise to give their patients advice on next steps.

The data science team has created a classification model that accurately predicts whether someone has diabetes or not based on anonymized data. The model training is defined in a Jupyter notebook. It's now up to you as a machine learning engineer to take the work from the data science team and bring it to production.

To operationalize the model, you’ll want to:

- Convert the model training to a **robust** and **reproducible** pipeline.
- Test the code and the model in a **development** environment.
- Deploy the model in a **production** environment.
- **Automate** the end-to-end process.

Though a Jupyter notebook is ideal for experimentation, it’s not a good fit for production workloads. Your first task will be to convert the notebooks to scripts and to run the model training as an Azure Machine Learning job, so that the workflow can easily be triggered and automated.
