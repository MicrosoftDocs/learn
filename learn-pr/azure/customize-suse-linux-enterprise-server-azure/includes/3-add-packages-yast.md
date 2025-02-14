YaST is an admin tool developed by SUSE that allows you to add packages to your machine (in addition to other things).

Once you launch a pay-as-you-go SLES virtual machine image on Azure, you need to add packages for the Apache, MySQL, and PHP portion of the LAMP stack to build your website.

In this unit, we talk about what packages are, and how you can use YaST to manage them on your SLES virtual machine.

## Packages add functionality to your machine

Your Linux engine is a blank slate that you need to fill to create the functionality and feature set you desire, which requires installing software. Many times, software packages developed by individual contributors from the open-source community don’t always work well together.  

Distributors like SUSE provide bug fixes, maintenance, and support of such packages and provide them as a "Linux Distribution" to give you ready-to-run options. The main SUSE distribution targeted to enterprise customers is the SUSE Linux Enterprise Server (SLES). There's also an open-source version called openSUSE. 

SUSE uses the RPM package format to deliver such software to the system. 

By choosing to run SLES, you automatically get access to over 3,500 RPM packages preconfigured by SUSE engineers to work great together.  

## YaST is a specialized tool that helps you to administrate your system  

YaST is a SUSE Linux Enterprise Server tool that provides a graphical interface for all essential installation and system configuration tasks. Whether you need to update packages, configure a printer, modify firewall settings, set up an FTP server, or partition a hard disk—you can do it using YaST. In this module, we use YaST to add packages to your VM. Following similar steps you can use YaST to update and delete packages as well.  

Since all VMs in Azure are remote, you won't have a graphical environment to start and will only be able to log into the system over ssh. You need to load YaST using the sudo command, which allows you to perform administer-level functions from your unique sign in without using the administrator sign-in ID. This distinction is important because it allows for better activity tracking and auditing.

YaST has two graphical interfaces: one for use with graphical desktop environments like KDE and GNOME and one that is an ncurses-based, pseudo-graphical interface for use on systems without an X server.  

:::image type="content" source="../media/yast-control-center-graphical-interface-inline.png" alt-text="Screenshot of the YaST control center graphical interface." lightbox="../media/yast-control-center-graphical-interface-expanded.png":::

:::image type="content" source="../media/yast-control-center-text-interface-inline.png" alt-text="Screenshot of the YAST control center text interface." lightbox="../media/yast-control-center-text-interface-expanded.png":::

The ncurses-based, pseudo-graphical YaST interface is designed primarily to help system administrators to manage systems without an X server. The interface offers several advantages compared to the conventional GUI:  

- You can navigate the ncurses interface using the keyboard, and there are keyboard shortcuts for practically all interface elements.  
- The ncurses interface is light on resources, and runs fast even on modest hardware.  
- You can run the ncurses-based version of YaST via an SSH connection, so you can administer remote systems.  

Keep in mind that the minimum supported size of the terminal emulator in which to run YaST is 80x25 characters.  

When you first start YaST, not all of the functionality may automatically install. If you appear to be missing something, you can try searching for available packages with "YaST" in the name.

## Packages are cumulative and most frequently used as collections  

By nature, packages are cumulative and have defined dependencies that lead to specific outcomes. For example, if you want to run a relational database like MariaDB, you need to install the collection of packages, called a module, that enables MariaDB.  

SUSE makes it easier to find the right packages for the tasks you want to complete by offering several different groupings of related packages in YaST.  

- **Modules** group packages in like bundles like Programming languages, Public Cloud adoption, etc.  
- **Patterns** group packages by popular scenarios like Run Oracle workloads, Enable a graphical interface, etc.
- The **repository** is like a directory that show packages across the entire server  

You can view these different options through the TUI or GUI interface for YaST.
