As an IT admin for a resort and hotel company, you need to be prepared to handle issues on your web applications starting from 500 errors or page startup errors or site down issues.

Azure App Service is a web hosting service that helps you deploy your ASP.NET Core web app. In this unit, you'll learn how Kudu console can help you diagnose the different app startup errors in your ASP.NET Core web app. 

## What is Kudu console?

Kudu is a troubleshooting and analysis tool for Microsoft Azure App Service. Kudu Console provides both command line and file browser access to your sites. 

To access the Kudu console of a web app, go to the `{yourwebapp}.scm.azurewebsites.net` URL and click on **Debug Console**.

The Source Control Management (SCM) service site runs the Kudu service and other site extensions. The services offered by Kudu include deployment and troubleshooting for Azure Web Apps, with options for viewing and downloading log files.

## Kudu console functionality

Azure web sites are associated with "scm" service site. The scm site uses single sign on, so if you are already logged on to the Azure Portal, you will be able to go directly to the Kudu console without typing additional credentials. If you prefer not to use Single Sign On and instead use basic authentication, then you can go to `https://mysite.scm.azurewebsites.net/basicauth`, which will prompt you for credentials. 

You can access Kudu Console through the Azure Portal by navigating to the **Development Tools** category of your web app's overview page and clicking the **Advanced Tools** option and the **Go** button in the advanced tools page. 

Some of the things you can do with Kudu console:

1. **Run commands** - Use it to do most standard console operations: changing folder, copy/rename/delete files, and so on. You can also run git commands like git log, git status to diagnose some issues.

1. **Navigate folder UI** - You can use a GUI to select the site folder, and the console window simultaneously navigates to the same folder, so the two halves of the Kudu console work together. 

1. **Download files and folder** - For files and folders, you can download the file or a zip file containing the contents of the folder.

1. **Upload files and folder** - Use drag and drop into the Kudu Console's file explorer UI.

1. **Upload and expand zip file** - Dragging and dropping a zip file into Kudu Console will copy the content of the expanded zip file. It is an efficient way to upload a large number of small files and folders.

1. **View and edit text files** - You can edit files through Kudu Console using Ace for in-browser editing. The editor provides an interface to investigate and identify issues.You can also use it to edit the web.config file, with syntax checking and highlighting.

 