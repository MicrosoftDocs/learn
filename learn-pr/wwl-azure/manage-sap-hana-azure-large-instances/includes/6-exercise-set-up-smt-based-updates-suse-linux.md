Deploy an Azure VM to the Azure virtual network, which is connected to the HANA Large Instance, install and configure SMT server within the OS of the VM, and use it to register and download updates for the HANA Large Instance unit.

Prerequisites for installing an SMT server that fulfills the task for HANA Large Instances are:

 -  An Azure virtual network that is connected to the HANA Large Instance ExpressRoute circuit.
 -  A SUSE account that is associated with an organization. The organization should have a valid SUSE subscription.

## Install SMT server on an Azure virtual machine

1.  First, sign in to the SUSE Customer Center. Navigate to **Organization** &gt; **Organization Credentials**. In that section, you should find the credentials that are necessary to set up the SMT server.
2.  Then, install a SUSE Linux VM in the Azure virtual network. To deploy the virtual machine, use a SLES 12 Azure Marketplace image (select **BYOS SUSE image**).
3.  After the installation, check the connectivity to the HANA Large Instance unit. Depending on your existing setup, you might need to configure resolution of the HANA Large Instance units in etc/hosts of the Azure VM.
4.  Add a data disk to the Azure VM. You use this disk to store the updates if the OS disk does not suffice. A 128 GB disk should suffice.
5.  Sign in to the HANA Large Instance unit or units, review **/etc/hosts**, and verify that you can reach the Azure VM that that hosts the SMT server. After this verification, sign in to the Azure VM. After you signed in, run the following sequence of commands:
    
    ```bash
    cd ~
    
    echo "export NCURSES_NO_UTF8_ACS=1" >> .bashrc
    
    ```
6.  Restart your bash to activate the settings. Then start YAST.
7.  Connect your VM (SMT server) to the SUSE site:
    
    ```bash
    SUSEConnect -r [registration code] -e s [email address] --url https://scc.suse.com
    
    ```
8.  After connecting to the SUSE site, install the SMT packages. Use the following command to install the SMT packages.
    
    ```bash
    zypper in smt
    
    ```
9.  You can also use the YAST tool to install the SMT packages. In YAST, navigate to Software Maintenance, and search for **SMT**. Select **SMT**, which switches automatically to yast2-smt.
10. Accept the selection for installation on the SMT server. After the installation completes, navigate to the SMT server configuration. Enter the organizational credentials from the SUSE Customer Center you retrieved earlier. Also enter your Azure VM hostname as the SMT Server URL. Now test whether the connection to the SUSE Customer Center works.
11. After the SMT setup starts, provide a database password. Because it's a new installation, you should define that password. The next step is to create a certificate.
12. At the end of the configuration, it might take a few minutes to run the synchronization check. After the installation and configuration of the SMT server, you should find the directory repo under the mount point on the Azure VM. There are also some subdirectories under repo.
13. Restart the SMT server and its related services with these commands.
    
    ```bash
    rcsmt restart
    
    systemctl restart smt.service
    
    systemctl restart apache2
    
    ```

## Download packages onto SMT server

After all the services are restarted, select the appropriate packages in SMT Management by using YAST. The package selection depends on the operating system image of the HANA Large Instance server. The package selection doesn't depend on the SLES release or version of the Azure VM running the SMT server.

Next, start the initial copy of the selected packages to the SMT server you set up. This copy is triggered by running the command `smt-mirror`.

The packages should get copied into the directories created under the mount point. This process can take an hour or more, depending on how many packages you select. As this process finishes, move to the SMT client setup.

## Set up the SMT client on HANA Large Instance units

The client or clients in this case are the HANA Large Instance units.

1.  The SMT server setup copied the script clientSetup4SMT.sh into the Azure VM. Copy that script over to the HANA Large Instance unit you want to connect to your SMT server. Start the script with the -h option, and give the name of your SMT server as a parameter. It's possible for the import of the certificate from the server by the client to succeed but the registration fails. If the registration fails, refer to SUSE support documentation. For the server name, provide the name of the Azure VM, without the fully qualified domain name.
2.  Next, run the following command on the HANA Large Instance unit:
    
    ```bash
    SUSEConnect –cleanup
    
    ```
3.  Wait a few minutes after that step. If you run clientSetup4SMT.sh immediately, you might get an error.
4.  This completes configuration of the SMT client of the HANA Large Instance unit necessary to connect to the SMT server you installed in the Azure VM. You now can run `zypper up` or `zypper in` to install operating system updates to HANA Large Instances or install additional packages. You can only get updates that you downloaded before on the SMT server.
