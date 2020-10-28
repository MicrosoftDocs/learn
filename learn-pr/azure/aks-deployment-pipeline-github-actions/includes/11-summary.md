Your company was experiencing a huge delay in simple day-to-day operations like deployments and image builds. You thought it would be a good idea to solve this problem by using CI/CD with GitHub Actions.

By using these concepts, you were able to automate image building and application deployment. First, you created a workflow that triggers when a developer on your team pushes a code change to the main branch. The workflow builds and pushes the application image to the company's Azure Container Registry instance. Then, when someone on your team creates a release out of that push, a new pipeline triggers and deploys the application to the AKS cluster without manual effort.

Without this solution, your team would be losing time by manually building and deploying application images for every new feature on the website. In the long run, you've saved the company thousands of dollars in time.

## Clean up resources

In this module, you created resources by using your Azure subscription. The following steps show you how to clean up these resources so that there's no continued charge against your account.

1. Go to the Azure portal.

    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com?azure-portal=true)

1. In the left menu, select **Resource groups**.

1. Select the resource group name that starts with **mslearn-gh-pipelines** or the resource group name you used.

1. On the **Overview** tab, select **Delete resource group**.

1. To confirm the deletion, enter the name of the resource group. To delete all the resources you created in this module, select **Delete**.

1. Repeat the steps for the resource group name that starts with **MC_mslearn-gh-pipelines**.

1. Go to your GitHub account and find your fork of the Contoso website.

1. To delete the fork, select the **Settings** tab.

1. Scroll down and select the red **Delete this repository** button. To confirm the deletion, enter the full name of the repository.

## Learn more

To learn more about Azure Kubernetes Service and GitHub Actions, see the following articles and Microsoft Learn modules:

- [AKS documentation on Microsoft Docs](https://docs.microsoft.com/azure/aks/?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [Introduction to AKS](https://docs.microsoft.com/learn/modules/intro-to-azure-kubernetes-service/?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [Integrate Azure Container Registry with AKS](https://docs.microsoft.com/azure/aks/cluster-container-registry-integration?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [Deploy an AKS cluster](https://docs.microsoft.com/azure/aks/tutorial-kubernetes-deploy-cluster?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [Introduction to GitHub](https://docs.microsoft.com/en-us/learn/modules/introduction-to-github/)
- [Automating tasks by using GitHub Actions](https://docs.microsoft.com/en-us/learn/modules/github-actions-automate-tasks/)
- [CI with GitHub Actions](https://docs.microsoft.com/en-us/learn/modules/github-actions-ci/)
- [What is a Docker image](https://docs.docker.com/storage/storagedriver/#images-and-layers)
- [Helm official website](https://helm.sh)
- [Helm official docs to create charts](https://helm.sh/docs/chart_template_guide/getting_started/)
- [Azure Helm docs](https://docs.microsoft.com/en-us/azure/aks/kubernetes-helm)
