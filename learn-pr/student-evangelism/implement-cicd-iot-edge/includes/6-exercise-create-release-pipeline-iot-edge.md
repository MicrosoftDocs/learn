## Create a new release pipeline

Deployments to devices need to be done under tight control in production environments. To achieve this, you'll create a release pipeline that deploys to QA devices and smoke tests the edge runtime in a containerized device. This is accomplished by running an instance of [azure-iot-edge-device-container](https://github.com/toolboc/azure-iot-edge-device-container), which is configured as a QA device. Then you'll probe the IoT hub to ensure that the QA device receives the desired deployment configuration and is able to successfully run all configured modules. This test is contained in [edgeSmokeTest.sh](https://github.com/MicrosoftDocs/mslearn-oxford-implement-cicd-iot-edge/blob/master/scripts/edgeSmokeTest.sh).

1. To begin creating a release pipeline, navigate to **Pipelines** > **Releases**. Then create a new pipeline with an **empty job** and save it.

2. Now head back to **Releases** > **New** and select **Import a pipeline**. Download the [release-pipeline.json](https://github.com/MicrosoftDocs/mslearn-oxford-implement-cicd-iot-edge/blob/master/release-pipeline.json) file located in the root of this repository and import it. The import should finish successfully as shown below.

   ![The illustration shows the release pipeline.](../media/import-release.png)

3. You'll need to fix a few things before you can successfully run the release pipeline, specifically Azure subscription endpoints, agent pools, variable settings, and artifact source.

4. Select **Tasks** > **Create Deployment**. Provide the appropriate Azure subscription and Azure Container Registry name for the **Azure IoT Edge - Push module images** task.

   ![The illustration shows issues in the deployment task.](../media/task-settings.png)

5. Provide the appropriate Azure subscription and Azure Container Registry name for the **Azure IoT Edge - Deploy to IoT Edge devices** task.

6. Navigate to **Tasks** > **Smoke Test**. Provide the appropriate Azure subscription and Azure Container Registry name for the **Remove all registered QA devices** and **Smoke Test** tasks.

   ![The illustration shows issues in the smoke test task.](../media/task-settings-smoke-test.png)

7. To fix the agent pools, select **Tasks** > **Create Deployment** > **Agent Job** and change the agent pool. Repeat the same step by selecting  **Tasks** > **Smoke Test** > **Agent Job** and change the agent pool to **Hosted Ubuntu 1604**.

8. Now you should be able to save the release pipeline. It's highly recommended to save at this point if Azure DevOps allows.

9. Navigate to the **Variables** tab. You'll need to modify all variables in brackets (<>).

   ![The illustration shows variables to be modified in the pipeline.](../media/release-pipeline-variables.png)

10. You can use the same values for `acr.host`, `acr.user`, `acr.password`, and `appinsights.instrumentationkey` that were used in the CI build definition earlier.

11. `iothub_name` is the name of the IoT hub you created. Navigate to the Azure portal, go to resource group you created, and make a copy of the IoT hub name.

12. For the additional variables, you need to create a service principal by performing the following steps.

    1. Go to the Azure portal.

    2. Open Azure Cloud Shell.

    3. Run `az account list` to see available subscriptions, and set the appropriate subscription with:

       ```
       az account set --subscription <subscriptionid>
       ```

    4. Create a service principal for your subscription with the Azure CLI:

       ```
       az ad sp create-for-rbac --name <name>
       ```

    5. You should see output similar to below.

       ```
       {
       "appId": "12345678-1234-1234-1234-1234567890ab",
       "displayName": "azure-iot-edge-device-container-sp",
       "name": "http://azure-iot-edge-device-container-sp",
       "password": "MyPassword",
       "tenant": "abcdefgh-abcd-abcd-abcd-abcdefghijkl"
       }
       ```

    6. Make note of the `name`, `password`, and `tenant` values, as these values will be used for `spAppURl`, `spPassword`, and `tenant` respectively.

    7. Provide all parameters as required in **Variables**.

13. Now go back to **Pipeline** and add an artifact.

    ![The illustration shows how to add an artifact.](../media/add-artifact.png)

14. Next, select your CI build pipeline as the source type and configure it to obtain the latest version.

15. Once you have configured everything appropriately, select **Save**.

16. Navigate to **Pipelines** > **Releases**. Then select the newly created release pipeline and select **Create a release**.

    ![The illustration show how to create a new release pipeline.](../media/create-new-release.png)

17. The new release pipeline should begin running.
