The installation of SAP HANA is your responsibility. You can start installing a new SAP HANA on Azure (Large Instances) server after you establish the connectivity between your Azure virtual networks and the HANA Large Instance unit(s) and have completed the validation tasks.

> [!NOTE]
> Per SAP policy, the installation of SAP HANA must be performed by a person who's passed the Certified SAP Technology Associate exam, SAP HANA Installation certification exam, or who is an SAP-certified system integrator (SI).

When you're planning to install HANA 2.0, see [SAP Note \#2235581](https://launchpad.support.sap.com/#/notes/2235581) to make sure that the OS is supported with the SAP HANA release that you're installing. The supported OS for HANA 2.0 is more restrictive than the supported OS for HANA 1.0. For Type II units, currently, only the SLES 12 SP2 OS version is supported.

To install HANA on SAP HANA on Azure (Large Instances), you must first do the following:

1.  You provide Microsoft with all the data to deploy for you on an SAP HANA Large Instance.
2.  You receive the SAP HANA Large Instance from Microsoft.
3.  You create an Azure virtual network that is connected to your on-premises network.
4.  You connect the ExpressRoute circuit for HANA Large Instances to the same Azure virtual network.
5.  You install an Azure virtual machine that you use as a jump box for HANA Large Instances.
6.  You ensure that you can connect from the jump box to your HANA Large Instance unit, and vice versa.
7.  You check whether all the necessary packages and patches are installed.
8.  You read the SAP notes and documentation about HANA installation on the operating system you're using. Make sure that the HANA release of choice is supported on the operating system release.

## Download the SAP HANA installation bits

The HANA Large Instance units aren't directly connected to the internet. You can't directly download the installation packages from SAP to the HANA Large Instance virtual machine. Instead, you download the packages to the jump box virtual machine.

You need an SAP S-user or other user, which allows you to access the SAP Marketplace.

1.  Sign in, and go to SAP Service Marketplace. Select **Download Software** &gt; **Installations and Upgrade** &gt; **By Alphabetical Index**. Then select Under H – **SAP HANA Platform Edition** &gt; **SAP HANA Platform Edition 2.0** &gt; **Installatio**n.
2.  From the Azure jumpbox VM, download SAP HANA 2.0 installation packages and expand the self-extracting archives into a local directory.
3.  As the archives are extracted, copy the directory created by the extraction to **/hana/shared** volume of HANA Large Instance unit.

> [!IMPORTANT]
> Don't copy the installation packages into the root or boot LUN, because space is limited and needs to be used by other processes as well.<br>

## Install SAP HANA on the HANA Large Instance unit

1.  In order to install SAP HANA, sign in as user root. Only root has enough permissions to install SAP HANA.
2.  Set permissions on the directory you copied over into **/hana/shared**.
    
    ```bash
    chmod –R 744 [Installation bits folder]
    
    ```
3.  If you want to install SAP HANA by using the graphical user interface setup, the gtk2 package needs to be installed on HANA Large Instances. To check whether it is installed, run the following command:
    
    ```bash
    rpm –qa | grep gtk2
    
    ```
4.  Switch into the installation directory, and navigate into the sub directory HDB\_LCM\_LINUX\_X86\_64.
5.  Out of that directory, start:
    
    ```bash
    ./hdblcmgui
    
    ```
6.  At this point, you progress through a sequence of screens in which you provide the data for the installation. In this walkthrough, we are installing the SAP HANA database server and the SAP HANA client components. Therefore, our selection is SAP HANA Database. Next, select Install New System along with SAP HANA Client and the SAP HANA Studio. You can also choose between a single-host and multiple-host system installation.<br>
    
    > [!IMPORTANT]
    > As HANA System ID (SID), you must provide the same SID as you provided Microsoft when you ordered the HANA Large Instance deployment. Choosing a different SID causes the installation to fail, due to access permission problems on the different volumes.
7.  For the installation path, use the **/hana/shared** directory. In the next step, you provide the locations for the HANA data files and the HANA log files.
    
    > [!NOTE]
    > The SID you specified when you defined system properties should match the SID of the mount points. If there is a mismatch, adjust the SID to the value you have on the mount points. In addition, verify and correct if needed the name of the host.
8.  In the next step, you need to specify data you provided to Microsoft when you ordered the HANA Large Instance deployment.<br>
    
    > [!IMPORTANT]
    > Specify the same System Administrator User ID and ID of User Group as you provided to Microsoft, as you order the unit deployment. Otherwise, the installation of SAP HANA on the HANA Large Instance unit fails.
9.  In the subsequent steps, you set the password for the SYSTEM user of the SAP HANA database, and the password for the sapadm user. The latter is used for the SAP Host Agent that gets installed as part of the SAP HANA database instance. After setting the password, you are presented with a confirmation screen. where you can check all the data listed, and initiate the installation.
10. Once the installation completes, the SAP HANA instance should now be up and running, and ready for usage. You should be able to connect to it from SAP HANA Studio.
