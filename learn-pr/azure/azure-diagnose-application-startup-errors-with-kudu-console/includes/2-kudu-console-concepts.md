As an IT admin for a hotel and resort company, you need to prepare to resolve startup and site-down issues for web applications you deploy and support.

Azure App Service is a web hosting service that helps you deploy your ASP.NET Core web app. In this unit, you'll learn how the Kudu console can help you diagnose the different app startup errors in your ASP.NET Core web app.

## What is the Kudu console?

Kudu is a troubleshooting and analysis tool for Azure App Service. The Kudu console provides both command line and file browser access to the web app sites you create by using Azure App Service.

You can access the Kudu console through your web app overview in the Azure portal. Go to the **Development Tools** category of your web app overview, and then select **Advanced Tools**. Select **Go** to open the Kudu console in a new window.

:::image type="content" source="../media/advanced-tools-kudu-console.png" alt-text="Screenshot that shows going to the Kudu console through Advanced Tools for a web app in the Azure portal.":::

You also can access the Kudu console through your deployed web app. Go to the `<mysite>.scm.azurewebsites.net` URL and select **Debug console**.

The Source Control Management (SCM) service site runs the Kudu service and other site extensions. The services that Kudu offers include deployment and troubleshooting for web apps in Azure, with options for viewing and downloading log files.

Azure websites are associated with the "scm" service site. The scm site uses single sign-on. If you're already signed in to the Azure portal, you can go directly to the Kudu console without entering more credentials. If you prefer to not use single sign-on and instead use basic authentication, you can go to `https://<mysite>.scm.azurewebsites.net/basicauth` when you're prompted for credentials.

Here are some of the things you can do in the Kudu console:

- **Run commands**. Use the Kudu console to do most standard console operations: change directory, copy/rename/delete files, and so on. You also can run git commands like `git log` and `git status` to diagnose some issues.

- **Move around the folder UI**. Use a GUI to select the site folder, and the console window simultaneously goes to the same folder. The two views of the Kudu console are synced.

- **Download files and folders**. For files and folders, you can download the file or a zip file that contains the contents of the folder.

- **Upload files and folders**. Drag and drop files in the Kudu console file explorer UI.

- **Upload and expand zip files**. If you drag and drop a zip file into the Kudu console, the contents of the expanded zip file are copied to the Kudu console file explorer UI. It's an efficient way to upload a large number of folders and small files.

- **View and edit text files**. You can edit files in the Kudu console by using the Ace editor for in-browser editing. The editor provides an interface you can use to investigate and identify issues. You also can use Ace to edit the *web.config* file. Ace offers syntax checking and highlighting.

## Kudu architecture

Kudu has a single-tenant architecture. Each Azure website that uses git deployment has its own instance of the Kudu service. The instance of the Kudu service on the Azure website is distinct for different Azure websites. The Kudu service gives access to the files of the real site, so the console can publish it.

### Security model

The Kudu service runs in the same sandbox as the Azure website. This setup implies that the Kudu service can't do anything that the site can't do itself. Any code that runs on the Kudu service can only harm its buddy Azure website.

The Kudu service uses the same resources the Azure site uses. Resource sharing affects the Azure site's resource quota. If the Kudu service consumes more resources during a build process, the build process is blocked and the website's quotas aren't substantially affected.

### Authentication model

By default, the real site isn't authenticated. However, the Kudu service site is authenticated by HTTP basic authentication. HTTP basic authentication happens before the request reaches the Kudu service.

### Process model

The file system between the Kudu service and the Azure buddy site is synced. The file system isn't affected by the process or by the machine the Kudu service runs on.

The next unit helps you understand application startup errors and Azure application service diagnostics.
