The Data Science Virtual Machine is an Azure-based machine running Windows or Linux preloaded with applications and tools for data science and machine learning.

If you work with data, you know: Wrangling data is time-consuming. Wrangling data requires different tools for different tasks. Wrangling data can require large amounts of storage and RAM, challenge the CPU/GPU, and be difficult to replicate. Sharing data and tools can be difficult and involve fragile data transmissions or "sneakernet" sharing of drives.

You want to work:

* In the operating system you prefer
* With the tools you know
* On a powerful machine
* Easily share your work with your colleagues

You may, of course, buy or build your own machine and configure it just as you choose. This may be the right choice for you if you are willing to bear the upfront costs and know that you will heavily utilize the machine. Even so, safe remote access to the machine either for yourself or your colleagues may be a challenge and will, at the least, be an ongoing administrative task. 

With a Data Science Virtual Machine you only pay for when the machine is running. If you're worried about forgetting to shut down the machine, you can schedule a daily shutdown at the time of your choosing. The DSVM has dozens of applications and programming tools and libraries preinstalled and preconfigured. These tools are configured to take advantage of the GPU(s) if you choose to run the DSVM on hardware with GPU compute resources. For Python, R, Julia, Node, and .NET developers, not only are the base languages installed, but popular packages, development environments, and Jupyter kernels.

## Learning objectives

In this module, you will:

* Match operating systems and hardware resources available for the DSVM
* Create a Data Science Virtual Machine running Ubuntu 18.04
* Connect to the command-line of the DSVM via ssh 
* Add a non-administrative user to the DSVM
* Connect to the graphical Desktop of the DSVM via X2Go Client 
* Create a Jupyter Notebook powered by the DSVM and use tk to do some rudimentary data manipulation
* As a different user, access the Jupyter Notebook and data

