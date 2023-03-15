
With the Configuration Manager client deployed on a device, instead of using Group Policy, you can leverage the inbuilt functionality of Configuration Manager to manage application deployment. This will provide you with more flexibility and control for managing the application estate. Both approaches follow the same workflow, and, like Group Policy, Configuration Manager does not manage preparation; however, Configuration Manager can manage the other elements of the lifecycle.

### Application deployment in Configuration Manager

Although *application* or *app* is a widely used term in computing, in Configuration Manager, it means something different and specific. Think of an application like a box. This box contains one or more sets of installation files for a software package (known as a *deployment type*), plus instructions on how to deploy the software. When you deploy the application to devices, **requirements** decide which deployment type Configuration Manager installs on the device.

You can do many more things with an application to cater to multiple scenarios. Below are some of the key elements that make up the application model.

:::row:::
  :::column:::
    **Element** 
  :::column-end:::
  :::column:::
    **Description** 
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Deployment type
  :::column-end:::
  :::column:::
    The *deployment type* is the set of contents in the box. An application needs at least one deployment type, as it determines how to install the app. Use more than one deployment type to configure different content and installation program for the same application.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Requirements
  :::column-end:::
  :::column:::
    *Requirements* ensure the target endpoint is installed with the most appropriate application, such as the OS being Windows x64.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Global conditions
  :::column-end:::
  :::column:::
    *Global conditions* can be used alongside requirements to pre-define or specify custom requirements. For example, an environments key identifier for a test or production domain.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Simulated deployment
  :::column-end:::
  :::column:::
    A *simulated deployment* evaluates the requirements, detection method, and dependencies for an application and reports out what the expected result would be without installing the application.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Deployment applications
  :::column-end:::
  :::column:::
    A *deployment action* specifies whether you want to install or uninstall the application. Not all deployment types support the uninstall action.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Purpose
  :::column-end:::
  :::column:::
    The *deployment purpose* specifies whether the deployment app is **Required** or **Available.** If the deployment is required, the client will install based on the schedule. If the deployment is available, it will be made available in Software Center.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Revisions
  :::column-end:::
  :::column:::
    When you make changes to an application, a *revision* is created to enable the application change configuration to be tracked.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Detection method
  :::column-end:::
  :::column:::
    Use *detection methods* to discover whether a device has already installed an application. If the detection method indicates the application is installed, Configuration Manager will not attempt to install it again.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Dependency
  :::column-end:::
  :::column:::
    *Dependencies* define one or more deployment types from another application that the client must install before it installs this deployment type. This is often helpful in more complex application installations.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Supersedence
  :::column-end:::
  :::column:::
    You can use Configuration Manager to upgrade or replace existing applications by using a *supersedence* relationship. When you supersede an application, you specify a new deployment type to replace the deployment type of the superseded application.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Application groups
  :::column-end:::
  :::column:::
    Starting in version 1906, you can use *application groups* to deploy a group of applications to a user or device collection. Previously, you would have used a task sequence to perform such an action in a complex dependency setup. Application groups streamline this process.
  :::column-end:::
:::row-end:::


### Create an application in Configuration Manager

While there are many different options that exist for creating an application in Configuration Manager, the following procedure walks through an example that you can later expand on.

To create an application:

1.  In the Configuration Manager console, choose **Software Library** &gt; **Application Management** &gt; **Applications**. Select Users and groups, and then select All users.
2.  On the **Home** tab, in the **Create** group, choose **Create Application**.
3.  On the **General** page of the **Create Application Wizard**, choose **Automatically detect information about this application from installation files**. This pre-populates some of the information in the wizard with information that is extracted from the installation .msi file. Then, specify the following information:
    
    1.  **Type**: Choose **Windows Installer (\*.msi file)**.
    2.  **Location**: Type the location (or choose **Browse** to select the location) of the installation file **Contoso.msi**. Note that you must specify the location in the form *\\\\Server\\Share\\File* for Configuration Manager to locate the installation files.
        
        The example below shows the location of an MSI file.
        
        :::image type="content" source="../media/configuration-manager-msiexec-file-location-deaa5ab8.png" alt-text="Screenshot of dialog prompting for the type and path to the application install files.":::
        
4.  On the **General Information** page, you can supply further information about the application to help you sort and locate it in the Configuration Manager console.
5.  Additionally, in the **Installation program** field, you can specify the full command line that will be used to install the application on PCs. You can edit the command line to add your own properties (for example, **/q** for an unattended installation).
    
    Below is the example MSI application.
    
    :::image type="content" source="../media/configuration-manager-example-msiexec-application-4954adc8.png" alt-text="Screenshot of dialog prompting for information about the application, such as name, publisher, version, and comments.":::
    
6.  Choose **Next**. On the **Summary** page, confirm your application settings and then complete the wizard.
7.  You have now created the app. To find it, in the **Software Library** workspace, expand **Application Management**, and then choose **Applications**. For this example, you will see:
    
    :::image type="content" source="../media/configuration-manager-software-library-example-6247005d.png" alt-text="Screenshot of Application Management folder, with the sample Contoso application listed in the Applications group.":::
    

> [!TIP]
> For an MSI file, you can place parameters directly on the installation program line rather than inside of a script file.

For a complex application deployment that has multiple applications, a specific sequence, or restarts as part of the eventual completion, the application model may not suit this specific scenario. In this instance, you can use the task sequence engine to initiate the installation.

### Choose an Endpoint Manager solution for deploying an application

Endpoint Manager offers application deployment from both Configuration Manager and Intune to deliver your line of business applications to Windows clients. Below are the supported applications types that each can offer.

:::row:::
  :::column:::
    **Application Type**
  :::column-end:::
  :::column:::
    **Configuration Manager**
  :::column-end:::
  :::column:::
    **Microsoft Intune**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    .MSI
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes\*
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    .IntuneWin
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Office C2R
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    APPX/MSIX
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Store Apps
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M365 Apps for Enterprise
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    App-V
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::


> [!NOTE]
> While Intune can deliver MSI applications, these cannot include advanced parameters as part of the installation. For instances such as these, you need to convert the application to a \*.IntuneWin format and deliver it from a script file.

You can deliver many of the application formats using both Configuration Manager and Intune. However, for more advanced configuration delivered natively, Configuration Manager is still a more robust option for application deployment.
