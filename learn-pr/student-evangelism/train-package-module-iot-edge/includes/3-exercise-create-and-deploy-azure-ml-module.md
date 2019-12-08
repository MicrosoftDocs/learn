First step: 

1. Login https://notebooks.azure.com/home/projects
2. Press upload button
3. Enter Azure/ai-toolkit-iot-edge as Github Repository
   - You can give a memorable name to this repo but you could also use the same name
   - You can keep the repository private if you want.

![An illustration showing how to upload github repo](/home/aysmtl/Documents/train-package-module-iot-edge/media/upload-github-repo.png)

4. Note that the process of importing could take some time  

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/import.png)

5. After this stage, press run on free compute as below.

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/run-compute.png)

6. A new tab would be opened in the browser. Ensure that the notebook is running on free compute (as per the previous tab) to avoid charges.

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/check-status.png)

7. Go to the new tab and you will see the notebook is running with the project you just imported from the Github.

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/notebook-file.png)

8. Now go to the folder **IoT Edge anomaly detection tutorial** and click on **00-anomaly-detection-tutorial.ipynb**. You will run all the code cells step by step in the notebook. 

## Perform the following actions

**Specifying parameters**

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/specify-parameters.png)

**Loading azure iot extension**

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/load-iot-extension.png)

**Login Azure**

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/login-azure.png)

**Setting the azure subscription**

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/set-azure-account.png)

**Checking SDK version**

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/check-sdk.png)

**Creating machine learning workspace**

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/create-ml-workspace.png)

**Loading Azure ML workspace**

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/load-ml-workspace.png)

**Registering device to the IoT Hub**

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/register-edge-device.png)

**Getting the device connection string**

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/show-conn-string.png)**Installing libraries**

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/install-libraries.png)

**Loading and reading dataset**

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/load-dataset.png)

**Loading features**

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/load-features.png)

**Training the model**

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/train-model.png)

**Evaluating the accuracy**

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/evaluate-accuracy.png)

**Serialising and testing the model**

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/serialize-model-and-test.png)

**Registering the model to the cloud**

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/register-model.png)

**Writing iot_score.py file**

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/write-iot-score-py.png)

**Creating the docker image**

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/create-docker-image.png)

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/list-images.png)

**Testing model on Azure container Instance**

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/test-model-aci.png)

**Testing web service**

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/test-web-service.png)

**Getting container details**

![An illustration showing ](/home/aysmtl/Documents/train-package-module-iot-edge/media/get-container-details.png)

**Deploying container to the Edge device**

![An illustration showing ](../media/deploy-module-to-edge-device.png)