As an IT admin for a resort and hotel company, you need to be prepared to handle issues on your web applications starting from 500 errors or page startup errors or site down issues.

Azure App Service is a web hosting service that helps you deploy your ASP.NET Core web app. In this unit, you'll learn how Kudu console can help you diagnose the different app startup errors in your ASP.NET Core web app. 

## What is Kudu console?

Kudu is a troubleshooting and analysis tool for capturing memory dump using logs and configuration parameters on Microsoft Azure Web Apps. Kudu Console provides both command line and file browser access to your sites. To access the Kudu console of the web page, go to the `{yoursite}.scm.azurewebsites.net` URL and click on **Debug Console**.

The Source Control Management (SCM) service site runs the Kudu service and other site extensions. The services offered by Kudu manages deployment and troubleshooting for Azure Web Apps, including options for viewing and downloading log files.

## Kudu console functionality

Some of the things you can do with Kudu console:

1. **Run commands** - Use it to do most standard console operations: changing folder, copy/rename/delete files, and so on. You can also run git commands like git log, git status to diagnose some issues.

1. **Navigate folder UI** - You can use a GUI to select the site folder, and the console window simultaneously navigates to the same folder, so the two halves of the Kudu console work together. 

1. **Download files and folder** - For files and folders, you can download the file or a zip file containing the contents of the folder.

1. **Upload files and folder** - Use drag and drop into the Kudu Console's file explorer UI.

1. **Upload and expand zip file** - Dragging and dropping a zip file into Kudu Console, will copy the content of the expanded zip file. It is an efficient way to upload a large number of small files and folders.

1. **View and edit text files** - You can edit files through Kudu Console using Ace for in-browser editing. Editor provides an interface to investigate and identify issues.You can also use it to edit the web.config file, with syntax checking and highlighting.

 