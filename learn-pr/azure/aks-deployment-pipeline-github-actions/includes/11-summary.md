You're now able to automate application image building and deployment by using CI/CD with GitHub Actions. You created a workflow that triggers when a developer on your team pushes a code change to the main branch. The workflow builds and pushes the application image to the Contoso Azure Container Registry instance.

Then, when someone on your development team creates a release from that push, a new pipeline triggers and deploys the application to your Azure Kubernetes Service (AKS) cluster without manual effort. This solution means your team doesn't have to spend time and effort on manually building and deploying application images for every new feature on the Contoso Video website.

## Clean up resources

In this module, you created resources in your Azure subscription. Use the following procedures to clean up these resources so there's no continued charge against your account.

### Azure resources

1. In the [Azure portal](https://portal.azure.com?azure-portal=true), search for and select *resource groups*, and then select the resource group you used for this module from the list.

1. On the **Overview** page, select **Delete resource group**.

1. To confirm the deletion and delete all the resources you created in this module, enter the name of the resource group, and select **Delete**.

1. Repeat the preceding steps for the corresponding resource group that starts with **MC_mslearn-gh-pipelines**.

1. Go to [App registrations](https://ms.portal.azure.com/#view/Microsoft_AAD_RegisteredApps/ApplicationsListBlade) and select your app from the list.

1. On the **Overview** page, select **Delete**.

1. On the **Delete app registration** page, select **Delete**, which also deletes the federated credentials.

### GitHub

1. Go to your fork of the Contoso Video repository.

1. Select the **Settings** tab.

1. Scroll down and select the red **Delete this repository** button. To confirm the deletion, enter the full name of the repository.

1. To delete the PAT you created, select your profile photo, then select **Settings**.

1. Select **Developer settings**.

1. Select **Personal access tokens**.

1. Select **Delete**. When the pop-up window appears, select **I understand, delete this token**.

## Learn more

To learn more about AKS and GitHub Actions, see the following articles and Microsoft Learn modules:

- [AKS documentation](/azure/aks/?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [Introduction to AKS](/training/modules/intro-to-azure-kubernetes-service/?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [Integrate Azure Container Registry with AKS](/azure/aks/cluster-container-registry-integration?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [Deploy an AKS cluster](/azure/aks/tutorial-kubernetes-deploy-cluster?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [Introduction to GitHub](/training/modules/introduction-to-github/)
- [Automating tasks by using GitHub Actions](/training/modules/github-actions-automate-tasks/)
- [CI with GitHub Actions](/training/modules/github-actions-ci/)
- [What is a Docker image](https://docs.docker.com/storage/storagedriver/#images-and-layers)
- [Helm official website](https://helm.sh)
- [Helm official docs to create charts](https://helm.sh/docs/chart_template_guide/getting_started/)
- [Azure Helm docs](/azure/aks/kubernetes-helm)
