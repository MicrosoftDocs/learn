In this section, we'll install the libraries that you'll need to build your AI model as we continue in the learning path. We'll use Anaconda to complete the downloads. Anaconda is a distribution of the Python and R programming languages. It includes libraries for development in scientific computing like data science, machine learning, predictive analysis, and more. 

> [!Tip]
> You can watch this Microsoft [video about downloading and configuring an environment][VideoDownload].
> The video shows an environment that's similar to the one we'll configure, but it's slighty different.
> Be sure to read the entire topic for the complete download instructions for this project.


## Download Anaconda

Follow these steps to download and install Anaconda.

1. Go to the [Anaconda download page][AnacondaDownload] to install Anaconda.

1. Select **Download**.

1. In the list of download links, select the link that corresponds to your computer operating system.

   Wait for the download to finish.

1. To start the installation, select the executable file in the lower-left corner.

   > [!NOTE]
   > The following example shows a computer running Windows 10 with the Microsoft Edge browser.
   > You should select the download that corresponds to your computer operating system.

   :::image type="content" source="../media/anaconda.png" alt-text="A screenshot of the Anaconda download web page that shows the installation in progress.":::

1. Complete the steps to install Anaconda on your computer.

After installation is done, the application is available on your computer from the **anaconda prompt**. If you're using Windows, you run the application in the Command prompt. On a Mac, you run the application in the computer Terminal.


## Create an environment with AI libraries

Follow these steps to create the environment.

1. Start the Anaconda environment from the Command prompt (Windows) or Terminal (Mac):

   ```console
   conda create -n myenv python=3.7 pandas jupyter seaborn scikit-learn keras pytorch pillow
   ```

   This command uses Anaconda to install all the libraries that we need for our model. In this command, we're also downloading a few other libraries that are good for data science. You might find these libraries useful for future development.

1. When you're prompted to install the packages, enter Y, and then press Enter.

1. To activate your new environment, enter the following command: 

   ```console
   conda activate myenv
   ```

The new environment is ready to use. We need to add one more library through a separate install command.


## Install torchvision

Follow these steps to install the torchvision package.

1. At the Anaconda prompt, enter the following command: 

   ```console
   conda install -c pytorch torchvision
   ```

1. When you're prompted to install the package, enter Y, and then press Enter.


## Create a new folder and Jupyter Notebook file

Now you have an environment you can use for the rest of the learning path. The last step is to create a project folder for your source code files.

1. Choose an easily accessible location on your computer, and create a folder named **ClassifySpaceRocks**.

1. Open Visual Studio Code, and then open the folder you created.

1. Create a Jupyter Notebook file named **ClassifySpaceRockProgram**.

1. At the upper-right and lower-left corners of the file, change the environment to the new Anaconda environment you created.

   :::image type="content" source="../media/set-environment.png" alt-text="Screenshot of Visual Studio Code that shows how to set up the Anaconda environment.":::

   > [!Note]
   > In some Python configurations, the Python 3 and Python 3.x N-bit ('myenv': conda) environments are essentially the same.
   > If you change the environment by selecting ('myenv': conda), Visual Studio Code might report the new environment as Python 3 rather than ('myenv': conda).
   > 

Congratulations! You've installed all the libraries you need to make an AI program, and configured Visual Studio Code to find them.


<!-- Links -->

[AnacondaDownload]: https://www.anaconda.com/products/individual?azure-portal=true
[VideoDownload]: https://www.youtube.com/watch?v=5E3WMb8_T3s&list=PLlrxD0HtieHjDop2DtiCmwTTcrlwKAVHE&index=8?azure-portal=true
