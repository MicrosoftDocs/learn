When creating custom content, you can store and manage it in your own Microsoft Sentinel workspaces, or an external source control repository, including GitHub and Azure DevOps repositories. Managing your content in an external repository allows you to make updates to that content outside of Microsoft Sentinel, and have it automatically deployed to your workspaces.


## Prerequisites and scope
Before connecting your Microsoft Sentinel workspace to an external source control repository, make sure that you have:

- Access to a GitHub or Azure DevOps repository, with any custom content files you want to deploy to your workspaces, in relevant Azure Resource Manager (ARM) templates.

    Microsoft Sentinel currently supports connections only with GitHub and Azure DevOps repositories.

- An Owner role in the resource group that contains your Microsoft Sentinel workspace. This role is required to create the connection between Microsoft Sentinel and your source control repository. If you're unable to use the Owner role in your environment, you can instead use the combination of User Access Administrator and Sentinel Contributor roles to create the connection.

## Maximum connections and deployments
Each Microsoft Sentinel workspace is currently limited to five connections.

Each Azure resource group is limited to 800 deployments in its deployment history. If you have a high volume of ARM template deployments in your resource group(s), you may see a Deployment QuotaExceeded error. 

## Validate your content
Deploying content to Microsoft Sentinel via a repository connection doesn't validate that content other than verifying that the data is in the correct ARM template format.

We recommend that you validate your content templates using your regular validation process. You can use the Microsoft Sentinel GitHub validation process and tools to set up your own validation process.

## Connect a repository

This procedure describes how to connect a GitHub or Azure DevOps repository to your Microsoft Sentinel workspace, where you can save and manage your custom content, instead of in Microsoft Sentinel.

Each connection can support multiple types of custom content, including analytics rules, automation rules, hunting queries, parsers, playbooks, and workbooks. For more information, see About Microsoft Sentinel content and solutions.

To create your connection:

- Make sure that you're signed into your source control app with the credentials you want to use for your connection. If you're currently signed in using different credentials, sign out first.

- In Microsoft Sentinel, on the left under Content management, select Repositories.

- Select Add new, and then, on the Create a new connection page, enter a meaningful name and description for your connection.

- From the Source Control dropdown, select the type of repository you want to connect to, and then select Authorize.

- Select one of the following tabs, depending on your connection type:

### GitHub

- Enter your GitHub credentials when prompted.

    The first time you add a connection, you'll see a new browser window or tab, prompting you to authorize the connection to Microsoft Sentinel. If you're already logged into your GitHub account on the same browser, your GitHub credentials will be auto-populated.

- A Repository area now shows on the Create a new connection page, where you can select an existing repository to connect to. Select your repository from the list, and then select Add repository.

    The first time you connect to a specific repository, you'll see a new browser window or tab, prompting you to install the Azure-Sentinel app on your repository. If you have multiple repositories, select the ones where you want to install the Azure-Sentinel app, and install it.

    You'll be directed to GitHub to continue the app installation.

- After the Azure-Sentinel app is installed in your repository, the Branch dropdown in the Create a new connection page is populated with your branches. Select the branch you want to connect to your Microsoft Sentinel workspace.

- From the Content Types dropdown, select the type of content you'll be deploying.

    - Both parsers and hunting queries use the Saved Searches API to deploy content to Microsoft Sentinel. If you select one of these content types, and also have content of the other type in your branch, both content types are deployed.

    - For all other content types, selecting a content type in the Create a new connection pane deploys only that content to Microsoft Sentinel. Content of other types isn't deployed.

- Select Create to create your connection. 


After the connection is created, a new workflow or pipeline is generated in your repository, and the content stored in your repository is deployed to your Microsoft Sentinel workspace.

The deployment time may vary depending on the volume of content that you're deploying.

### Azure DevOps

- You're automatically authorized to Azure DevOps using your current Azure credentials. To ensure valid connectivity, verify that you've authorized to the same Azure DevOps organization that you're connecting to from Microsoft Sentinel, or use an InPrivate browser window to create your connection.

- In Microsoft Sentinel, from the dropdown lists that appear, select your Organization, Project, Repository, Branch, and Content Types.

    - Both parsers and hunting queries use the Saved Searches API to deploy content to Microsoft Sentinel. If you select one of these content types, and also have content of the other type in your branch, both content types are deployed.

    - For all other content types, selecting a content type in the Create a new connection pane deploys only that content to Microsoft Sentinel. Content of other types isn't deployed.

- Select Create to create your connection. For example:




After the connection is created, a new workflow or pipeline is generated in your repository, and the content stored in your repository is deployed to your Microsoft Sentinel workspace.

The deployment time may vary depending on the volume of content that you're deploying.