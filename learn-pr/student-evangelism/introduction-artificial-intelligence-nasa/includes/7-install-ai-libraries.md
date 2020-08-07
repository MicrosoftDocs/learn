It might seem like you had to download an excessive number of libraries for this project. Luckily, Anaconda helps you quickly download all the libraries you need. Microsoft has a [video about downloading and configuring a similar environment](https://www.youtube.com/watch?v=5E3WMb8_T3s&list=PLlrxD0HtieHjDop2DtiCmwTTcrlwKAVHE&index=8?azure-portal=true) to the one we need, but continue reading to download the right libraries for this project.

## Download Anaconda

Start by going to the [Anaconda Download page](https://www.anaconda.com/products/individual?azure-portal=true) to begin installing Anaconda. Click on the download button and you will be brought to the bottom of the page with all the download links. Click on the link that corresponds to your computer type, wait for the download to finish, and click on the executable file at the bottom left of the screen to initiate installation.

> [!NOTE]
> The following image depicts a user using Windows 10 with the Microsoft Edge browser, but you should choose the box that represents your system.

:::image type="content" source="../media/anaconda.png" alt-text="How to download VSCode":::

Next, walk through the steps to install Anaconda on your computer. You will be asked to read and agree to some license agreements and then wait for Anaconda to finish installing. After it is complete, you should have an application on your computer called "anaconda prompt". On Mac, you will not have this application because Anaconda is installed in your terminal.

## Create an environment by using AI libraries

Start the anaconda prompt application (or terminal on Mac). You can do this by searing for "anaconda" on your computer. At the Anaconda prompt, enter the following:

`conda create -n myenv python=3.7 pandas jupyter seaborn scikit-learn keras pytorch pillow`

This code installs all the libraries we need through Anaconda. Note, we're having you download a few other libraries, but these are good data science libraries that may be useful in the future.

You'll be prompted to install the packages. Enter Y, and then press Enter.

Finally, you will have to activate your new environment. Enter the following code: `conda activate myenv`

This new environment should be created and ready to use. We need to add one more library to the environment.

## Install torchvision

To install torchvision, in the Anaconda prompt, enter: `conda install -c pytorch torchvision`

You'll be prompted to install the packages. Enter Y, and then press Enter.

## Create a new folder and a Jupyter Notebooks file

You now have an environment built that can take you through the rest of the program. The last thing you need to do it create a folder and the files that we're going to be coding in. To do this, choose an easily accessible location on your computer and make a folder. For example, you might name it `ClassifyingSpaceRocks`.

Next, open Visual Studio code and open the new folder that you just created. Create a new Jupyter Notebook file and name it something like `ClassifySpaceRockProgram`. Lastly, at the top right and bottom left of the file, change the environment to be the new environment you just created.

:::image type="content" source="../media/set-environment.png" alt-text="How to download VSCode":::

Congratulations, you just installed all of the libraries you need to make an AI program and told Visual Studio code where to find them.
