It may seem like there are a lot of libraries that we must download for this project. Luckily, there is a software called Anaconda that lets us download all of the libraries very quickly. Microsoft has a [video about downloading and configuring a similar environment](https://www.youtube.com/watch?v=5E3WMb8_T3s&list=PLlrxD0HtieHjDop2DtiCmwTTcrlwKAVHE&index=8) to the one we need, but continue reading to download the right libraries for this project.

## Download Anaconda

Start by going to the [Anaconda Download page](https://www.anaconda.com/products/individual) to begin installing Anaconda. Click on the download button and you will be brought to the bottom of the page with all of the download links. Click on the link that corresponds to your computer type, wait for the download to finish, and click on the executable file at the bottom left of the screen to initiate installation.

>[!Note]
>The picture below depicts a user using Windows 10 with the Microsoft Edge browser, but you should choose the box that represents your system.

:::image type="content" source="..\Media\anaconda.jpg" alt-text="How to download VSCode":::

Next, walk through the steps to install Anaconda on your computer. You will be asked to read and agree to some license agreements and then wait for Anaconda to finish installing. After it is complete, you should have an application on your computer called "anaconda prompt". On Mac, you will not have this application because Anaconda is installed in your terminal.

## Create an environment with AI libraries

Now that we have Anaconda installed, bring up the anaconda prompt application (or terminal on Mac). You can do this by searing for "anaconda" on your computer. Once you have the anaconda prompt open type the following:
`conda create -n myenv python=3.7 pandas jupyter seaborn scikit-learn keras pytorch pillow`

This code will begin installing all of the libraries we need through Anaconda. Note, we are having you download a few other libraries, but these are good data science libraries that may be useful in the future.
You will be prompted to install the packages, type 'y' and then enter.

Finally, you will have to activate your new environment. To do this type:
`conda activate myenv`

This new environment should be created and ready to use. There is one more library that we need to add to the environment that cannot be downloaded in this way.

## Install torchvision to environment

To install torchvision, in the anaconda prompt type:
`conda install -c pytorch torchvision`

You will once again be asked to type 'y' and then enter.

## Create new folder and Jupyter Notebooks file

You now have an environment built that will be able to take you through the rest of the program. The last thing you need to do it create a folder and the files that we are going to be coding in. To do this, choose a easily accessible location on your computer and make a folder. This can be named something like `ClassifyingSpaceRocks`.

Next, open Visual Studio code and open the new folder that you just created. Create a new Jupyter Notebook file and name it something like `ClassifySpaceRockProgram`. Lastly, at the top right and bottom left of the file, change the environment to be the new environment you just created.

:::image type="content" source="..\Media\set-environment.jpg" alt-text="How to download VSCode":::

Congratulations, you just installed all of the libraries you need to make an Artificial Intelligence program and told Visual Studio code where to find them.
