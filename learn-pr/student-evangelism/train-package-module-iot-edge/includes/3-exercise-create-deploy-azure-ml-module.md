First step: 

1. Login https://notebooks.azure.com/home/projects
2. Press upload button
3. Enter Azure/ai-toolkit-iot-edge as GitHub Repository
   - You can give a memorable name to this repo but you could also use the same name
   - You can keep the repository private if you want.

![An illustration showing how to upload GitHub repo](../media/upload-github-repo.png)

4. Note that the process of importing could take some time  

![An illustration showing importing repo](../media/import.png)

5. After this stage, press run on free compute as below.

![An illustration showing that running on Free Compute](../media/run-compute.png)

6. A new tab would be opened in the browser. Ensure that the notebook is running on free compute (as per the previous tab) to avoid charges.

![An illustration showing status of compute](../media/check-status.png)

7. Go to the new tab and you'll see the notebook is running with the project you just imported from the GitHub.

![An illustration showing notebook file](../media/notebook-file.png)

8. Now go to the folder **IoT Edge anomaly detection tutorial** and click on **00-anomaly-detection-tutorial.ipynb**. You'll run all the code cells step by step in the notebook. 

## Perform the following actions

**Specifying parameters**

![An illustration showing how to specify parameters](../media/specify-parameters.png)

**Loading azure iot extension**

![An illustration showing how to  load iot extension](../media/load-iot-extension.png)

**Login Azure**

![An illustration showing how to login azure](../media/login-azure.png)

**Setting the azure subscription**

![An illustration showing how to set azure subscription](../media/set-azure-account.png)

**Checking SDK version**

![An illustration showing how to check SDK version](../media/check-sdk.png)

**Creating machine learning workspace**

![An illustration showing how to create ml workspace](../media/create-ml-workspace.png)

**Loading Azure ML workspace**

![An illustration showing how to load ml workspace](../media/load-ml-workspace.png)

**Registering device to the IoT Hub**

![An illustration showing how to register device to IoT Hub](../media/register-edge-device.png)

**Getting the device connection string**

![An illustration showing how to show conn string](../media/show-conn-string.png)**Installing libraries**

![An illustration showing how to install libraries](../media/install-libraries.png)

**Loading and reading dataset**

![An illustration showing how to load dataset](../media/load-dataset.png)

**Loading features**

![An illustration showing how to load features](../media/load-features.png)

**Training the model**

![An illustration showing how to train the model](../media/train-model.png)

**Evaluating the accuracy**

![An illustration showing how to evaluate the accuracy](../media/evaluate-accuracy.png)

**Serializing and testing the model**

![An illustration showing test the model](../media/serialize-model-and-test.png)

**Registering the model to the cloud**

![An illustration showing register the model to the cloud](../media/register-model.png)

**Writing iot_score.py file**

![An illustration showing how to write iot_score.py](../media/write-iot-score-py.png)

**Creating the docker image**

![An illustration showing how to create docker image](../media/create-docker-image.png)

![An illustration showing how to list images](../media/list-images.png)

**Testing the model on Azure container Instance**

![An illustration showing how to test the model on ACI](../media/test-model-aci.png)

**Testing web service**

![An illustration showing how to test web service](../media/test-web-service.png)

**Loading Azure ML workspace**

![An illustration showing how to load ml workspace](../media/load-ml-workspace.png)

**Getting container details**

![An illustration showing how to get container details](../media/get-container-details.png)

**Deploying container to the Edge device**

![An illustration showing how to deploy container to the Edge device](../media/deploy-module-to-edge-device.png)