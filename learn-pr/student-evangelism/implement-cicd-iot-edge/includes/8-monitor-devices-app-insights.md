Integration testing is important for IoT Edge solutions which rely on services to accomplish desired functionality. You'll set up a scalable deployment of QA Devices using an Azure Kubernetes cluster. This allows for an ability to deploy a theoretically limitless number of devices into an isolated environment for testing. In addition, you'll be able to monitor these devices using the dockerappinsights module which is configured in [deployment.template.json](https://github.com/aysemutlu/mslearn-oxford-implement-cicd-iot-edge/blob/master/EdgeSolution/deployment.template.json). Completion of this exercise will require configuration of an Azure Kubernetes Service.

## Create an AKS cluster

To create an AKS cluster, complete the following steps:

1. On the Azure portal menu or from the **Home** page, select **Create a resource**.
2. Select **Containers** > **Kubernetes Service**.
3. On the **Basics** page, configure the following options:
   - Select an Azure **Subscription**
   - Select or create an Azure **Resource group**
   - Enter a **Kubernetes cluster name**
   - Select a **Region**, **Kubernetes version**, and **DNS name prefix** for the AKS cluster.
   - Select a VM **Node size** for the AKS nodes.
   - Select **Next: Scale** when complete.
4. Click **Next**.
5. On the **Authentication** page, configure the following options:
   - Create a new service principal by leaving the **Service Principal** field with **(new) default service principal**. Or you can choose *Configure service principal* to use an existing one. If you use an existing one, you'll need to provide the SPN client ID and secret.
   - Enable the option for Kubernetes role-based access controls (RBAC). This will provide more fine-grained control over access to the Kubernetes resources deployed in your AKS cluster.

6. Click **Review + create** and then **Create** when validation completes.

It takes a few minutes to create the AKS cluster. When your deployment is complete, click **Go to resource**.

## Adding a scalable integration test to a release pipeline

1. Navigate to Release pipeline.

2. Add a new stage after the **Smoke Test**.

3. Select the **Deploy an application to a Kubernetes cluster by using its Helm chart** template and apply.

   ![The illustration shows adding smoke test by choosing a template.](../media/integration-test.png)

4. Rename this stage to "Integration".

5. Navigate to **Tasks** > Integration.

6. You'll notice that the "Helm init" and "Helm upgrade" tasks require some additional configuration.

7. Provide Azure subscription, resource group and kubernetes cluster which you created in the previous step for **helm init** and helm **upgrade**.

8. Next, you'll configure the Agent job to run on the "Hosted Ubuntu 1604" agent pool.

9. Next, you'll configure the "Helm init" task to upgrade / install tiller.

   ![The illustration shows how to update/install tiller.](../media/upgrade-tiller.png)

10. Next, you'll configure the "Helm upgrade" task to deploy the helm chart for the "azure-iot-edge-device-container". Begin by adding a new "Bash" task right before the "Helm upgrade" task. Configure the type to "inline" and add the following:

    ```
    helm repo add azure-iot-edge-device-container https://toolboc.github.io/azure-iot-edge-device-container
    helm repo list
    helm repo update
    ```


10. Next, you'll configure the Helm Upgrade task. 

    - Set the Namespace value to **iot-edge-qa**

    - Set the Command to **upgrade**

    - Set Chart Type to **Name**

    - Set the Chart Name to **azure-iot-edge-device-container/azure-iot-edge-device-container**

    - Set the Release Name to **iot-edge-qa**

    - Set Values to: 

      ```
      spAppUrl=$(spAppUrl),spPassword=$(spPassword),tenantId=$(tenantId),subscriptionId=$(subscriptionId),iothub_name=$(iothub_name),environment=$(environment),replicaCount=2 
      ```
    
    - Ensure that "Install if release not present", "Recreate Pods", "Force", and "Wait" checkboxes are checked.
    
11. Start a new release and when complete, view your AKS cluster Dashboard.

12. Go to the Azure portal and open Azure Cloud Shell.

13. Run the following command.

    ```
    az aks browse --resource-group <kube-cluster-resource-group> --name <kube-cluster-name>
    ```

14. You'll notice that QA devices have been deployed to the cluster.

### Monitoring devices with App Insights

Monitoring allows us to perform long running tests against edge modules and provide real-time alerts using Application Insights. Our EdgeSolution includes a dockerappinsights module which is configured in [deployment.template.json](https://github.com/aysemutlu/mslearn-oxford-implement-cicd-iot-edge/blob/master/EdgeSolution/deployment.template.json). This module monitors the docker host of each containerized IoT Edge device.

Make sure that the device has been deployed and is running, you can monitor the device by viewing the Application Insights resource deployed.

1. Go to the resource group you created in the beginning of the module.
2. Open Application Insight resource.
3. Navigate to **Metrics Explorer** under Investigate.
4. To configure a chart, select **Add Chart** > Edit Chart and add the following to monitor Block IO for all Edge modules.




