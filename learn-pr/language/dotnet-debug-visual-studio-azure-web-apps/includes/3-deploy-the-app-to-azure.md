In order to work through a remote debugging exercise with App Service, you'll first need to create an application and deploy it to Azure. The Razor Pages sample app you'll create allows users to search for GitHub repositories by organization. However, the app also contains a subtle bug that you'll troubleshoot using Visual Studio after it's deployed.

## Create the sample app

You can create the sample app for this module using Visual Studio. The sample app allows you to search for GitHub organizations by name and display their repositories in a simple table.

1. Inside Visual Studio, select **File > New Project**.

2. In the **Create a new project** dialog, search for **ASP.NET** and select the **ASP.NET Core Web App** option. Make sure to choose the **Razor Pages** project template instead of the **Model-View-Controller** option, then select **Next**.

    :::image type="content" source="../media/visual-studio-create-project.png" alt-text="A screenshot of the new project dialog in Visual Studio.":::

3. On the **Configure your new project** dialog, name the project **GitHubBrowser**, leave the rest of the settings at their defaults, and then choose **Next**.

   > [!IMPORTANT]
   > Make sure to name your project **GitHubBrowser** for the code snippets below to work with matching namespaces. If you name your project something else, you'll need to update the namespace in the code snippets.

4. On the **Additional information** step, choose **.NET 6.0 (Long Term Support)**, then select **Create**. This exercise can also work with earlier versions of .NET, such as .NET 5.0 or .NET Core 3.1.

5. After Visual Studio creates the project, expand the `Pages` folder in the solution explorer and open the `Index.cshtml` file. Replace the contents of `Index.cshtml` with the following code:

    ```razor
    @page
    @model IndexModel
    
    <h1 class="display-6">Welcome to the GitHub searcher!</h1>
    <p class="mb-3">Enter the name of a GitHub organization such as "Microsoft" or "Azure" to browse its repositories.</p>
    
    <form method="post" class="form mb-5">
        <div class="form-group mb-3">
            <input type="text" class="form-control" asp-for="@Model.SearchTerm" />
        </div>
        <input class="btn btn-success" type="submit" value="Search" />
    </form>
    
    <table class="table table-striped table-bordered">
        <thead>
            <tr>
                <td>Name</td>
                <td>Description</td>
                <td>Link</td>
            </tr>
        </thead>
        @foreach (var item in Model.Repos)
        {
            <tr>
                <td>@item.Name</td>
                <td>@Html.Raw(item.Description)</td>
                <td><a class="btn btn-secondary" href="@item.HtmlUrl">Browse</a></td>
            </tr>
        }
    </table>
    ```

    This Razor code provides a basic search form to browse for GitHub organizations and displays the results in a table.

6. In the solution explorer, expand the arrow next to `Index.cshtml` to reveal the `Index.cshtml.cs` file. Double click the `Index.cshtml.cs` file to open it, then replace its contents with the following code:

    ```csharp
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.RazorPages;
    using Microsoft.Net.Http.Headers;
    using System.Text.Json;
    using System.Text.Json.Serialization;
    
    namespace GitHubBrowser.Pages
    {
        public class IndexModel : PageModel
        {
            private readonly IConfiguration _env;
    
            [BindProperty]
            public string SearchTerm { get; set; }
    
            public IEnumerable<GitRepo> Repos { get; set; } = new List<GitRepo>();
    
            public IndexModel(IConfiguration env)
            {
                _env = env;
            }
    
            public IActionResult OnGet()
            {
                return Page();
            }
    
            public async Task<IActionResult> OnPost()
            {
                var client = new HttpClient();

                var githubUrl = _env["GitHubUrl"];
                var searchUrl = $"{githubUrl}/orgs/{SearchTerm}/repos";
                var httpRequestMessage = new HttpRequestMessage(HttpMethod.Get, searchUrl)
                {
                    Headers =
                    {
                        { HeaderNames.UserAgent, "dotnet" }
                    }
                };

                var httpResponseMessage = await client.SendAsync(httpRequestMessage);
                var content = await httpResponseMessage.Content.ReadAsStringAsync();
                Repos = JsonSerializer.Deserialize<IEnumerable<GitRepo>>(content);
    
                return Page();
            }
        }

        public class GitRepo
        {
            [JsonPropertyName("name")]
            public string Name { get; set; }
            
            [JsonPropertyName("description")]
            public string Description { get; set; }
    
            [JsonPropertyName("html_url")]
            public string HtmlUrl { get; set; }
        }
    }
    ```

    The preceding code contains two important methods:
    * The **OnGet** method handles initially loading the search page.
    * The **OnPost** method handles the form submission. The method pulls the GitHub API URL from the `appsettings.Development.json` file using the configuration service and makes an HTTP request with the submitted search term as a parameter. The items returned from the API are then assigned to a property and rendered using a table in the `Index.cshtml` file.

7. In the Visual Studio Solution Explorer, expand the arrow next to the `appsettings.json` file. Open the `appsettings.Development.json` file and replace its contents with the following code:

    ```json
    {
      "GitHubURL": "https://api.github.com",
      "DetailedErrors": true,
      "Logging": {
        "LogLevel": {
          "Default": "Information",
          "Microsoft.AspNetCore": "Warning"
        }
      }
    }
    ```

    This file provides some essential configuration values for the app, including GitHub API's URL that's used to retrieve an organization's repositories.

8. Test the app locally by selecting the **Run** button at the top of Visual Studio. The app should load in the browser and present a form to use for search queries. For example, search *dotnet* to browse repos for that GitHub organization to get an idea of what the results should look like.

    :::image type="content" source="../media/visual-studio-remote-debug-app.png" alt-text="A screenshot of the sample app.":::

## Deploy the app to Azure

Next, you need to deploy the app to Azure so others can use it to browse repositories. You can deploy the app using Visual Studio and the following steps.

1. If you're using the Learn sandbox, you might need to log out and log in again inside of Visual Studio for your subscription information to refresh. You can manage your account by clicking on the **Name** icon in the upper right of Visual Studio, choose **Account settings**, then choose **Sign out**, then **Sign in**. Make sure you're logged into the same account you used to create the sandbox.

   :::image type="content" source="../media/visual-studio-remote-account.png" alt-text="A screenshot of the account settings icon.":::

2. Right-click the project node in the solution explorer, then select **Publish**.

    :::image type="content" source="../media/visual-studio-remote-debug-publish.png" alt-text="A screenshot of the publishing option in Visual Studio.":::

3. In the publishing dialog, select **Azure** as the Target, then select **Next**.

4. On the **Specific Target** step, select **Azure App Service (Windows)**, then choose **Next**.

5. For the **App Service** step, make sure you're signed into the correct Azure Account in the upper right of the dialog.

   Remember, for the Learn sandbox, you might need to sign out of Visual Studio and sign in to make the sandbox subscription available, as described previously.

6. Select the subscription to which you'd like to deploy.

   For the Learn sandbox environment, check whether the `Concierge Subscription` has loaded by clicking the **Refresh** button. If it's available, select it. If it's not available, continue with the next step.

7. Create a new app service instance by selecting the **+ Create new** button.

   > [!NOTE]
   > For the sandbox environment, you might need to wait while Visual Studio loads the subscription information. This may take some time.

    :::image type="content" source="../media/visual-studio-remote-debug-loading-subscriptions.png" alt-text="A screenshot of loading subscription info in the create app service workflow.":::

8. In the new app service dialog, enter or verify the following values:

    | Setting | Value  |
    | --- | --- |
    | **Name** |  Enter `GitHubBrowser123`, where `123` are three random numbers of your choosing to ensure your App Service name and domain is unique across Azure. |
    | **Subscription name** | If you're using the Learn sandbox environment, select the `Concierge Subscription`; otherwise, select your own. |
    | **Resource group** | Choose the default <rgn>[sandbox resource group name]</rgn> resource group if you're using the sandbox, or select **New...** to create your own new group with a name such as `mslearn-github-browser`. |
    | **Hosting plan** | If you;re using the Learn sandbox, leave the default value. If you're using your own subscription, select **New...** and enter a name of `mslearn-github-browser-plan` and choose your instance size. |

    > [!TIP]
    > If you're using the Learn sandbox and the default hosting plan doesn't appear, switch the resource group to a new group, then switch back to the default group.)

    :::image type="content" source="../media/visual-studio-remote-debug-create-app-service.png" alt-text="A screenshot of the create app service workflow.":::

9. Select **Create** to close the dialog, and Visual Studio will take a moment to create the App Service instance for you.

   Once the App Service is created, select the new instance, then choose **Finish**. If you see a blank screen instead, try proceeding to the next step.

10. Visual Studio will display a summary view of the publishing profile. Select **Publish** in the upper right corner to deploy your app to Azure. This process might take a little time to complete.

    :::image type="content" source="../media/visual-studio-remote-debug-publish-profile.png" alt-text="A screenshot of the publishing profile.":::

When the deployment finishes, Visual Studio will launch a web browser to the home page of your app. At first, it appears that everything is working correctly.

Next, enter *dotnet* again in the GitHubBrowser app's search box, and at this point you'll receive an error page instead of the table of results. This error didn't happen locally, and you can use Visual Studio to figure out why.

:::image type="content" source="../media/visual-studio-remote-debug-error.png" alt-text="A screenshot of the application error.":::

## Enable remote debugging

Before you can debug this issue with Visual Studio, you need to enable the App Service's remote debugging feature. This setting allows the Visual Studio debugger to connect to the main App Service web hosting process.

1. If you're using the Learn sandbox, open the [Learn sandbox Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true). Make sure to sign in with the same account that you opened the sandbox. If you're not using the sandbox, sign into your own [Azure portal](https://portal.azure.com/).

   Locate your deployed application in the Azure portal. You can find your app by browsing to the **App Services** page and then selecting the **GitHubBrowser123** app.  You can also search for the App Service instance directly by name in the search bar at the top.

    :::image type="content" source="../media/visual-studio-remote-debug-azure-search.png"  alt-text="A screenshot of Azure search." :::

2. On the App Service settings page, select **Configuration** under **Settings** in the left navigation menu, then select the **General Settings** tab.

3. Towards the bottom of the page, make sure to set the **Remote Debugging** feature to **On** and select **2022** as the **Remote Visual Studio version**.

    :::image type="content" source="../media/visual-studio-remote-debug-azure-settings-small.png"  alt-text="A screenshot of the Azure remote debugging settings." lightbox="../media/visual-studio-remote-debug-azure-settings.png":::

4. Select **Save**, then select **Continue** at the top of the page to persist your changes.

Your app service instance now supports remote debugging through Visual Studio.
