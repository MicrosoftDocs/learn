To keep the no-show model reliable as it evolves, Proseware's team follows a **machine learning operations** (**MLOps**) process that spans everything from initial setup to ongoing monitoring.

:::image type="content" source="../media/01-01-architecture.png" alt-text="Diagram of machine learning operations architecture.":::

> [!NOTE]
> This diagram is a simplified representation of an MLOps architecture. To explore a more detailed set of implementations, see the [MLOps v2 solution accelerator](https://github.com/Azure/mlops-v2).

The architecture includes:

- **Setup**: Create the Azure resources the solution needs.
- **Model development (inner loop)**: Explore data, and train and evaluate candidate models.
- **Continuous integration**: Package and register the model.
- **Model deployment (outer loop)**: Deploy the model to an endpoint.
- **Continuous deployment**: Test the deployment and safely promote it to production.
- **Monitoring**: Track the endpoint's operational health and the model's predictions over time.

Registering a model is the hinge point between the first three stages and the last three. After the data science team trains and registers a model, the rest of this module focuses on that second half of the cycle: taking a registered model through deployment, safe promotion, automation, and monitoring.

## Decide what to automate

You could perform each of these later stages manually in Azure Machine Learning studio. However, because Proseware plans to retrain and redeploy the no-show model regularly, the team automates registration, deployment, and testing with **GitHub Actions**, triggering the workflow whenever a new model version is ready. Automating these repetitive steps frees the team to focus on reviewing model quality rather than repeating deployment commands by hand.

> [!NOTE]
> Automation is central to MLOps, but it doesn't replace human judgment. It's a best practice to keep a person in the loop for decisions such as promoting a new model version to full production traffic or investigating a monitoring alert.

The next unit shows how a protected GitHub environment turns that review point into an enforceable deployment gate.