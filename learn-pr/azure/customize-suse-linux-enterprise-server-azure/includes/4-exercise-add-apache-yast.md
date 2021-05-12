In this unit, we’ll walk through how to use the YaST admin tool to install and remove Apache to your SUSE SLES VM. 

Task 1: Start YaST 

To launch the ncurses-based version of YaST, ssh into your machine and run yast2 as follows: 

sudo yast2  

Use the Tab or arrow keys to navigate between interface elements like menu items, fields, and buttons.  

 

All menu items and buttons in YaST can be accessed using the appropriate function keys or keyboard shortcuts. For example, you can cancel the current operation by pressing F9, while the F10 key can be used to accept the changes. Each menu item and button in YaST's ncurses-based interface has a highlighted letter in its label. This letter is part of the keyboard shortcut assigned to the interface element. For example, the letter Q is highlighted in the Quit button. This means that you can activate the button by pressing Alt–Alt+Q. 

For more details have a look at the SUSE documentation at https://documentation.suse.com/sles/15-SP2/single-html/SLES-admin/#cha-yast-gui  

 

Task 2: Install Software Packages with YaST 

Once inside the YaST Control Center, launch the YaST Software Management module: Software > Software Management 

 

Select the Filter menu (ALT+F] and select the line with Search 

 

 

  

In the search field at the top left, enter:  
apache <RETURN> 

Notice that the icon or marker (i) in front of the apache entry on the right shows an empty box. This indicates that the package is not yet installed. 

Switch to the right box with <TAB> and go down and select apache2 in the list with the <SPACE> bar 

The icon changes to a check mark (or “+”).  Any shown dependencies will also be indicated (a+). 

 

Click Accept to install the apache package 

A new window will be shown with the additional dependent packages which need to be installed too.  click: Continue 

 

In the Installation dialog, click Finish. You will get an information window presented with the summary of your install 

 

Close the YaST interface 