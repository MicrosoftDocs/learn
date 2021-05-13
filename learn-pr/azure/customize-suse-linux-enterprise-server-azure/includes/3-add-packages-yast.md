Once you’ve launched a pay-as-you-go SLES VM image on Azure, you will need to add packages for the Apache, MySQL, and PHP portion of the LAMP stack to build your website. In this unit we’ll talk about what packages are and how you can use YaST admin tool to add Apache. edit 1

## Packages add functionality to your machine

Your Linux engine is a blank slate that you need to fill to create the functionality and feature set you desire. This requires adding additional software. Many times, these software packages are developed by individual contributors from the opensource community, which means that they don’t always work well together.  

Distributors like SUSE provide bugfixing, maintenance and support of such packages and provide them as a “Linux Distribution” to give you ready-to-run options. The main SUSE distribution targeted to enterprise customers is the SUSE Linux Enterprise Server (SLES). There is also an opensource version called openSUSE. 

SUSE uses the RPM package format to deliver such software to the system. 

By choosing to run SLES, you automatically get access to over 3,500 RPM packages that have been pre-configured by SUSE engineers to work great together.  

## YaST is a specialized tool that helps you to administrate your system  

YaST is a SUSE Linux Enterprise Server tool that provides a graphical interface for all essential installation and system configuration tasks. Whether you need to update packages, configure a printer, modify firewall settings, set up an FTP server, or partition a hard disk—you can do it using YaST. For the purpose of this module, we’ll be using YaST to add packages to your VM. Following similar steps you can use YaST to update and delete packages as well.  

Since all VMs in Azure are remote, you will not have a graphical environment to start and will only be able to log into the system over ssh. You will need load YaST using the sudo command, which allows you to perform administer-level functions from your unique log-in without using the administrator log-in ID. This distinction is important because it allows for better activity tracking and auditing. 

YaST has two graphical interfaces: one for use with graphical desktop environments like KDE and GNOME and one that is an ncurses-based, pseudo-graphical interface for use on systems without an X server.  

TODO images

The ncurses-based, pseudo-graphical YaST interface is designed primarily to help system administrators to manage systems without an X server. The interface offers several advantages compared to the conventional GUI:  

- You can navigate the ncurses interface using the keyboard, and there are keyboard shortcuts for practically all interface elements.  
- The ncurses interface is light on resources, and runs fast even on modest hardware.  
- You can run the ncurses-based version of YaST via an SSH connection, so you can administer remote systems.  

Keep in mind that the minimum supported size of the terminal emulator in which to run YaST is 80x25 characters.  

Please note, when you first start YaST, not all of the functionality may automatically install. If you appear to be missing something, you can try searching for available packages with “yast” in the name.

## Packages are cumulative and most frequently used as collections  

By nature, packages are cumulative and have defined dependencies which lead to specific outcomes. For example, if you want to run a relational database like MariaDB, you need to install the collection of packages, called a module, that enable MariaDB.  

SUSE makes it easier to find the right packages for the tasks you want to complete by offering several different groupings of related packages in YaST.  

- **Modules** group packages in like bundles i.e. Programming languages, Public Cloud adoption  
- **Patterns** group packages by popular scenarios i.e. Run Oracle workloads, Enable a graphical interface 
- The **repository** is like a directory that show packages across the entire server  

You can view these different options through the TUI or GUI interface for YaST.
