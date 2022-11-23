Imagine you're a machine learning engineer at Proseware, a young start-up working on a new health care app. The diabetes classification model, created by the data scientists is the first model to be integrated with the app. After you talk to the larger team, it turns out that the goal is to have multiple models integrated with the web app.

When the diabetes classification model proves to be successful, Proseware wants to add more machine learning models, so that practitioners can faster diagnose patients for various diseases. For every new model, the data science team will need to be able to experiment in a safe environment. Once the new model is accurate enough to be integrated with the web app, it should be tested before deploying it to an endpoint that will be called from the web app.

Together with the team, you decide it's best to use different environments:

- **Development** for experimentation.
- **Staging** for testing.
- **Production** for deploying the model to the production endpoint.

For each environment, you'll create a separate Azure Machine Learning workspace. By keeping the workspaces separate for each environment, you'll be able to protect data and resources. For example, the development workspace won't contain any personal data from patients. And the data scientists will only have access to the development workspace, as they only need an environment for experimentation, and don't need access to any of the production code or resources.

As a machine learning engineer, you do need to ensure that whatever the data scientists build, will be easily moved across environments. Once a new model is ready to be deployed, you want the model to be trained and tested in the staging environment. After testing the code, the model, and the deployment, you want to deploy the model in the production environment. Parts of this process can be automated to speed up the process.

To work with environments, you'll want to:

- Create **environments** in your GitHub repository. 
- Store credentials to each Azure Machine Learning workspace as an environment **secret** in GitHub.
- Add **required reviewers** to environments for **gated approval**.
- Use environments in your GitHub Actions workflows.