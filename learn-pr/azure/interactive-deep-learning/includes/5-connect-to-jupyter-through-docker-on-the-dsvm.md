Now that you have your Data Science Virtual Machine up and running, you decide to train your first deep learning model. You want to run your experiments in isolation from everything else on your server. To do that, you run them within a Docker container.

## Connect to the VM with ssh

Make sure you're still connected to your VM through ssh. If not, just run this command again to remote back into the virtual machine.

1. Execute the following command in Azure Cloud Shell to sign into the VM.

    ```azurecli 
    ssh <USERNAME>@<IP>
    ``` 
    
    Replace  `<USERNAME>` with the admin account name you defined when creating the VM. Replace `<IP>` with the IP address of the VM you saved in the preceding exercise.  

1. When prompted, enter your password for the admin account to complete the sign-in process.

## Run a Jupyter Notebook server in a Docker container in the VM

> [!NOTE]
> Since we only have an admin, or root, account on our VM, we have to run all Docker commands as root using `sudo`

1. To see what Docker containers exist on the VM, run the following command at the command prompt.

    ```azurecli 
    sudo docker ps
    ```

1. Run the following command at the command prompt to create a new container for our experiments.

    ```azurecli 
    sudo docker run --rm -it --entrypoint '/bin/sh' -p 8888:8888 pytorch/pytorch -c \
    'conda install jupyter matplotlib -y &&\
    curl https://pytorch.org/tutorials/_downloads/cifar10_tutorial.ipynb > first_pytorch_classifier.ipynb &&\
    jupyter notebook --ip=0.0.0.0 --no-browser --allow-root'
    ``` 

    This command will run for quite a while. So, while we have some time, let's discuss what the command does. 
    - `docker run` runs a command in a new container. The Docker image being used is pytorch/pytorch. It first creates a writeable container layer over the specified image, and then starts it using the specified command.
    - `--rm` will remove the container once it exits. If you want to keep the container around, drop this argument. 
    - `--entrypoint 'bin/sh'` overwrites the default entry point of the image to be the Bash shell
    - `-c` defines what command to run when the container starts. In this case, it's running three commands:
        - Installs Jupyter and matplotlib
        - Copies a notebook (cifar10_tutorial.ipynb) from pytorch.org to a file in the container called `first_pytorch_classifier.ipynb`
        - Starts the notebook server in the container in the same way as the preceding exercise.  No browser is started, allow the notebook to be accessed by root and listen on all ports. 
    
    The notebook server listens on all ports for that container. But, how will traffic come from outside the container? The `-p 8888:8888` argument binds port `8888` of the container to TCP port 8888 on the host machine. So, traffic coming to the VM over port 8888 will be picked up by the container. 

## Connect to the Jupyter Notebook server from a remote browser 

Once the Jupyter notebook is running in the container, you'll  see a message similar to the following message. 

> *Copy/paste this URL into your browser when you connect for the first time, to login with a token: http://(5b8783e7911d or 127.0.0.1):8888/?token={sometoken}*

1. Replace the **http://(5b8783e7911d or 127.0.0.1)** part of the URL with the Fully Qualified Domain Name (FQDN) or the IP address of the VM and navigate to the address in a new tab of your browser.

    ![Screenshot showing Jupyter Notebooks dashboard. ](../media/notebook-in-docker.png)

    > [!TIP]
    > You can get the FQDN and IP address of your VM with the following command:
    > 
    > `az vm show -d --name <HOSTNAME> --resource-group <rgn>[sandbox resource group name]</rgn> --output table`
    >
    > Remember to replace `<HOSTNAME>` with the name you gave your VM. 
    
    This time we only see a single notebook. That's because we're in a container and only copied down this notebook. In the next exercise, we'll experiment with this notebook. 
    
    > [!TIP]
    > Don't shut down the notebook server just yet. We'll look at the `first_pytorch_classifier.ipynb` notebook in the next exercise.