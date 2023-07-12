

The Configuration Manager client installation on a Windows computer allows not only the site to manage the device, but ultimately allows both the IT administrator and the end user to benefit from what it can provide.

#### Benefits of the Configuration Manager client

On the admin side, the client installation enables you to track software present on the device, provide inventory information in relation to hardware, and manage and deploy the OS and LoB applications. With innovations in cloud management, many of these features are no longer restricted to use within the network perimeter.

For an end user, some of the potential benefits include a feature rich self-service catalog of software that empowers the user to choose software to install and the ability to configure his/her working hours to ensure interruptions are minimized.

#### Client Deployment Options

To successfully manage a Windows computer using Configuration Manager, you can deploy the client several ways. Below are some of the most used methods:

 -  **Client push. This** method enables you to deploy the client directly from the Configuration Manager console. Devices can be discovered through various methods, however the most common is by using Active Directory LDAP integration to locate devices in a particular OU. Once discovered, these objects can have client push initialized, which copies the files to the source computer and initiates the install automatically. One consideration with using client push for larger scale deployments is an increase in network traffic from the initial copy process.
 -  **Manual deployment**: This method usually involves the manual deployment of client installation source files accompanied by a script file containing the install parameters. The installation of the agent is typically executed from the ccmsetup.exe file, however it's also possible to install the client from the MSI that is part of the client files. When installed using either option, there are various client installation parameters that dictate how the client will be installed. These parameters make up part of the scripted install. While the manual scripted install achieves the desired results, when not used through an automation tool, this process can be somewhat time consuming as a delivery mechanism. Below shows an example of a CCM Setup command line.
    
    ```cmd
    Ccmsetup.exe  SMSSITECODE=AUTO /noservice /skipprereq:Silverlight.exe CCMLOGMAXSIZE=10000 CCMLOGMAXHISTORY=2
    ```

 -  **OS deployment**. This method is one of the most common ways to deliver the client. When installing and setting up Windows using a task sequence, you can slip-stream the Configuration Manager client into the Windows setup and provide it with the necessary installation parameters. To use this method, the client must be installed when a device is built for the first time (or rebuilt), therefore it isn't appropriate for existing devices.
 -  **Microsoft Intune**. One of the more modern methods to facilitate co-management, Intune drives Configuration Manager client installation and registers the device with the Cloud Management Gateway. After it's installed, you can manage each respective workload from either Intune or Configuration Manager.
