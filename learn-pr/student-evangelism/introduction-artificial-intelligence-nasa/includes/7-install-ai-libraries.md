It might seem like you had to download an excessive number of libraries for this project. Luckily, Anaconda helps you quickly download all the libraries you need. Microsoft has a [video about downloading and configuring an environment](https://www.youtube.com/watch?v=5E3WMb8_T3s&list=PLlrxD0HtieHjDop2DtiCmwTTcrlwKAVHE&index=8?azure-portal=true) that's similar to the one we need, but continue reading to download the libraries you need for this project.

## Download Anaconda

Begin by going to the [Anaconda download page](https://www.anaconda.com/products/individual?azure-portal=true) to begin installing Anaconda. Select the download button. In the list of download links that are shown, select the link that corresponds to your computer operating system. Wait for the download to finish, and then select the executable file in the lower-left corner to start installation.

> [!NOTE]
> The following image depicts a computer running Windows 10 with the Microsoft Edge browser, but you should select the download that represents your computer.

:::image type="content" source="../media/anaconda.png" alt-text="Screenshot of the Anaconda download webpage and an installation in progress on the computer.":::

Next, complete the steps to install Anaconda on your computer. You'll be asked to read and agree to some license agreements and then wait for Anaconda to finish installing. When installation is finished, you should find an application on your computer named *anaconda prompt*. On Mac, you find this application on your computer because Anaconda is installed in your terminal.

## Create an environment by using AI libraries

Start the Anaconda prompt application (or terminal on Mac). Start the prompt by searching for *anaconda* on your computer. At the Anaconda prompt, enter the following code:

`conda create -n myenv python=3.7 pandas jupyter seaborn scikit-learn keras pytorch pillow`

This code installs all the libraries we need through Anaconda. You'll download a few other libraries that are good data science libraries you might find useful in the future.

You'll be prompted to install the packages. Enter Y, and then press Enter.

You'll need to activate your new environment. To activate the environment, enter the following code: 

`conda activate myenv`

The new environment should be created and ready to use. Then, we need to add one more library to the environment.

## Install torchvision

To install torchvision, at the Anaconda prompt, enter the following code: 

`conda install -c pytorch torchvision`

You'll be prompted to install the packages. Enter Y, and then press Enter.

## Create a new folder and a Jupyter Notebook file

You now have an environment that can take you through the rest of the learning path. The final thing you need to do is create a folder and the files that we'll be coding in. Choose an easily accessible location on your computer and make a folder. For example, you might name the folder *ClassifyingSpaceRocks*.

Next, open Visual Studio Code. Open the new folder that you created. Create a new Jupyter Notebook file and name it something like *ClassifySpaceRockProgram*. Last, at the upper-right and lower-left corners of the file, change the environment to the new Anaconda environment you created.

:::image type="content" source="../media/set-environment.png" alt-text="Screenshot of Visual Studio Code and setting the Anaconda environment.":::

> [!Note]
> In some Python configurations, the Python 3 and Python 3.x N-bit ('myenv': conda) environments are essentially the same.
> If you change the environment by selecting ('myenv': conda), Visual Studio Code might report the new environment as Python 3 rather than ('myenv': conda).
> 

Congratulations, you installed all the libraries you need to make an AI program, and configured Visual Studio Code to find them.
