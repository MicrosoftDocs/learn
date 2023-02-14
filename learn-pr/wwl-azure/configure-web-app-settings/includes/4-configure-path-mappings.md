
In the  **Configuration > Path mappings** section you can configure handler mappings, and virtual application and directory mappings. The **Path mappings** page will display different options based on the OS type.

## Windows apps (uncontainerized)

For Windows apps, you can customize the IIS handler mappings and virtual applications and directories.

Handler mappings let you add custom script processors to handle requests for specific file extensions. To add a custom handler, select **New handler**. Configure the handler as follows:

* **Extension**: The file extension you want to handle, such as **.php* or *handler.fcgi*.
* **Script processor**: The absolute path of the script processor. Requests to files that match the file extension are processed by the script processor. Use the path `D:\home\site\wwwroot` to refer to your app's root directory.
* **Arguments**: Optional command-line arguments for the script processor.

Each app has the default root path (`/`) mapped to `D:\home\site\wwwroot`, where your code is deployed by default. If your app root is in a different folder, or if your repository has more than one application, you can edit or add virtual applications and directories. 

You can configure virtual applications and directories by specifying each virtual directory and its corresponding physical path relative to the website root (`D:\home`). To mark a virtual directory as a web application, clear the **Directory** check box.

## Linux and containerized apps

You can add custom storage for your containerized app. Containerized apps include all Linux apps and also the Windows and Linux custom containers running on App Service. Click **New Azure Storage Mount** and configure your custom storage as follows:

* **Name**: The display name.
* **Configuration options**: Basic or Advanced.
* **Storage accounts**: The storage account with the container you want.
* **Storage type**: **Azure Blobs** or **Azure Files**. Windows container apps only support Azure Files.
* **Storage container**: For basic configuration, the container you want.
* **Share name**: For advanced configuration, the file share name.
* **Access key**: For advanced configuration, the access key.
* **Mount path**: The absolute path in your container to mount the custom storage.

