Now that we've packaged our DeepStream Graph Composer application into a container, we're ready to publish this artifact into an instance of [Azure Container Registry](https://azure.microsoft.com/services/container-registry/#overview) for secure distribution to other supported devices.

This preparation will also set the stage for potential deployment by using [Azure IoT Edge](/azure/iot-edge/about-iot-edge), which we'll cover in more detail in the next module.

1. To begin, follow instructions from Microsoft Docs to "create a container registry." This document demonstrates how to instantiate the necessary Azure Container Registry resources in Microsoft Azure and how to sign in and push images to this service. After you've completed the steps in this section, we'll proceed to publish our DeepStream Graph Composer container artifact into this registry.

    Follow the steps in the [Quickstart: Create an Azure container registry by using the Azure portal](/azure/container-registry/container-registry-get-started-portal). You only need to follow the steps to "create a container registry." The extra steps mentioned in the documentation are optional. After this task has been completed, continue with the next steps.

1. Go to your newly deployed instance of Container Registry in the Azure portal:

    :::image type="content" source="../media/overview.png" alt-text="Screenshot that shows the Azure Container Registry overview.":::

    You'll notice your container registry has a property of **Login server** that refers to the url for accessing your service remotely. This property ends in **azurecr.io**. Take note of this value because we'll refer to it shortly.

1. Next, select the **Access keys** section on the left side under **Settings**, and enable the option for **Admin user**. This operation will grant you the ability to authenticate against your container registry to allow access from the Docker instance running on your host machine. Again, take note of the values for **Login server**, **Username**, and **Password** because they'll be used in the next step.

    :::image type="content" source="../media/access-keys.png" alt-text="Screenshot that shows the Container Registry Access keys.":::

1. Now you're ready to authenticate against your container registry and grant access to the host's Docker instance. To do this step, run the following commands in a terminal session on the host machine:

    ```Bash
    sudo docker login <Login server>
    ```

    1. When prompted for **Username**, enter the value provided in the **Access keys** section of your  container registry in the Azure portal.

    1. When prompted for **Password**, enter the value provided in the **Access keys** section of your container registry in the Azure portal.

    1. You should see a message that indicates "Login Succeeded" upon successful entry.

1. Before you can push your recently created Docker image into your container registry, you must tag your image to reference your container registry. Run the following command in a terminal on the host machine:

    ```Bash
    sudo docker tag deepstream_test1_dgpu <Login Server>/deepstream_test1_dgpu:v1
    ```

1. Push your DeepStream Graph Composer container image into this repository by running this command:

    ```Bash
    sudo docker push <Login Server>/deepstream_test1_dgpu:v1
    ```

1. Wait for the push to complete, then navigate back to your Azure Container Registry in the Azure portal and verify that the image has been uploaded by selecting `Repositories` under the `Services` section on the left-hand side of the overview page.  You should see your freshly pushed `deepstream_test1_dgpu:v1` image in the repository list as shown below:

    :::image type="content" source="../media/repo.png" alt-text="Screenshot that shows the Azure Container Registry Repo list.":::

1. Finally, if you wish to execute and run this image using the image contained in the Azure Container Registry you can execute the following commands in a terminal on a compatible host:

    ```Bash
    sudo docker run -it --rm --gpus all -v /tmp/.X11-unix/:/tmp/.X11-unix/ -e DISPLAY=:0 
    <Login server>/deepstream_test1_dgpu:v1
    ```

    >[!NOTE]
    > If you intend to run this workload on a machine that isn't the current host that we've been working with, you'll need to enable access to X11 with `sudo xhost +` and also authenticate your Docker instance for access to your Azure Container Registry.

Congratulations!  You've successfully built and published your first DeepStream Graph Composer application into a secure Azure Container Registry to enable distribution of your workload to various compatible hosts!

### Try this

Imagine that you have been tasked to develop an IVA application to count people entering into a restaurant establishment. Your development team works in close connection to a testing team that validates the accuracy of the IVA solution before deploying into production.  How could you distribute new builds of the IVA application to the test team in a way that does not require manual reconfiguration of test hardware?
