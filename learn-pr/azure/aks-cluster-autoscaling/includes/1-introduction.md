## Example scenario

Imagine you work for a growing video editing company that provides a cloud-based video rendering service. The service is experiencing increased demand from the recent international expansion. The application leverages the Horizontal Pod Autoscaler (HPA) for scaling purposes, but the cluster doesn't seem to be following up. While you could manually scale the application, it'd require someone to keep constant eye on it. Your manager has tasked you with finding a solution to scale the cluster automatically and free up some employee time.

Since AKS already provides scaling tools, you decide to look into a feature called the *cluster autoscaler* to see if it would be the right fit.

> [!IMPORTANT]
>
> - The exercises in this module use the [Azure Cloud Shell](/azure/cloud-shell/overview?WT.mc_id=deploycontainerapps_intro-learn-ludossan), which already has all the needed tooling installed. If you prefer to run the examples in your own terminal, you need to have the following tooling installed: [Azure CLI](/azure/aks/kubernetes-walkthrough?WT.mc_id=deploycontainerapps_intro-learn-ludossan) and [Kubectl](/azure/aks/kubernetes-walkthrough?WT.mc_id=deploycontainerapps_intro-learn-ludossan#connect-to-the-cluster). If you're on Windows, you also need to install [WSL](/windows/wsl/install-win10).
> - To complete the optional exercises in this module, you need to use your own subscription, which might incur charges. If you want to follow along, you can use a trial subscription or a subscription that you already have access to.
