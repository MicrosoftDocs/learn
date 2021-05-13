YaST is an admin tool developed by SUSE that allows you to add packages to your machine (in addition to other things). Recall, Trailwinds needs you to add Apache webserver to the machine for the LAMP stack. In this exercise, we’ll walk through how you can use the YaST admin tool to install Apache to your SUSE SLES VM. At the end of this unit, you will have installed Apache on your VM.

## Start YaST 

1. To launch the ncurses-based version of YaST, ssh into your machine and run yast2 as follows: 

    ```console
    sudo yast2
    ```  

1. Use the Tab or arrow keys to navigate between interface elements like menu items, fields, and buttons.

    All menu items and buttons in YaST can be accessed using the appropriate function keys or keyboard shortcuts. For example, you can cancel the current operation by pressing F9, while the F10 key can be used to accept the changes. Each menu item and button in YaST's ncurses-based interface has a highlighted letter in its label. This letter is part of the keyboard shortcut assigned to the interface element. For example, the letter Q is highlighted in the Quit button. This means that you can activate the button by pressing Alt–Alt+Q. 



## Install Software Packages with YaST

1. Once inside the YaST Control Center, launch the YaST Software Management module: **Software > Software Management**
1. Select the Filter menu (ALT+F] and select the line with Search
1. In the search field at the top left, enter:  

    ```console
    apache <RETURN> 
    ```

    Notice that the icon or marker (i) in front of the apache entry on the right shows an empty box. This indicates that the package is not yet installed. 

1. Switch to the right box with <TAB> and go down and select **apache2** in the list with the <SPACE> bar 

    The icon changes to a check mark (or “+”).  Any shown dependencies will also be indicated (a+). 

1. Click Accept to install the apache package 

    A new window will be shown with the additional dependent packages which need to be installed too.  click: Continue 

1. In the Installation dialog, click Finish. You will get an information window presented with the summary of your install 
1. Close the YaST interface
