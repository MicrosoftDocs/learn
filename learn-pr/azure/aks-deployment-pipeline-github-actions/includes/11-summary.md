Your company was experiencing a huge delay in simple day-to-day operations such as deployments and image builds. You thought it'd be a good idea to solve this problem using CI/CD with GitHub Actions.

By using these concepts you were able to make image building and application deployment completely automatic. First you created a workflow that was triggered whenever someone pushed to the main branch, building and pushing the application image to the company's ACR. Then, whenever someone created a release out of that push, a new pipeline would trigger and deploy the application to the AKS cluster without human interference.

Without this solution, your team would still be losing time by manually building and deploying application images at every new feature on the website. In the long-run, you've saved the company thousands of dollars in time.

## Clean up resources

In this module, you created resources by using your Azure subscription. The following steps show you how to clean up these resources so that there's no continued charge against your account.

1. Open the Azure portal.

    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com?azure-portal=true)

1. Select **Resource groups** on the left.

1. Find the resource group starting with **mslearn-gh-pipelines**, or the resource group name you used, and select it.

1. On the **Overview** tab of the resource group, select **Delete resource group**.

1. Enter the name of the resource group to confirm. Select **Delete** to delete all of the resources you created in this module.

1. Do the same with the other resource group starting with **MC_mslearn-gh-pipelines**

1. Go to your GitHub account and find your fork of Contoso's website

1. Delete it by going to the settings tab, scrolling down until you see a red button with "Delete this repository"

1. Click it and type the full name of the repository to confirm deletion

## Learn more

To learn more about Azure Kubernetes Service and GitHub Actions, see the following articles and Microsoft Learn Modules:

- [AKS documentation on Microsoft Docs](https://docs.microsoft.com/azure/aks/?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [Introduction to AKS](https://docs.microsoft.com/learn/modules/intro-to-azure-kubernetes-service/?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [Integrate Azure Container Registry with AKS](https://docs.microsoft.com/azure/aks/cluster-container-registry-integration?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [Deploy an AKS cluster](https://docs.microsoft.com/azure/aks/tutorial-kubernetes-deploy-cluster?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [Introduction to GitHub](https://docs.microsoft.com/en-us/learn/modules/introduction-to-github/)
- [Automation of tasks using GitHub Actions](https://docs.microsoft.com/en-us/learn/modules/github-actions-automate-tasks/)
- [CI With GitHub Actions](https://docs.microsoft.com/en-us/learn/modules/github-actions-ci/)
- [What is a Docker image](https://docs.docker.com/storage/storagedriver/#images-and-layers)
- [Helm official website](https://helm.sh)
- [Azure Helm docs](https://docs.microsoft.com/en-us/azure/aks/kubernetes-helm)
