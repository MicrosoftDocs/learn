You have an Azure SQL Database that contains sample data. Before you deploy the _Space Game_ website to App Service through Azure Pipelines, let's first verify that you can bring up the application locally. This helps ensure that everything works before you run the pipeline.

## Fetch the branch from GitHub

Here, you fetch the `database` branch from GitHub and checkout, or switch to, that branch.

This branch contains the _Space Game_ project you worked with in the previous modules and an Azure Pipelines configuration to start with.

1. In Visual Studio Code, open the integrated terminal.
1. Run the following `git` commands to fetch a branch named `database` from Microsoft's repository and switch to that branch.

    ```bash
    git fetch upstream database
    git checkout -b database upstream/database
    ```

    The format of these commands enables you to get starter code from Microsoft's GitHub repository, known as `upstream`. Shortly, you'll push this branch up to your GitHub repository, known as `origin`.

1. Optionally, in Visual Studio Code, open the *azure-pipelines.yml* file, and familiarize yourself with the initial configuration.

    The configuration resembles the ones that you created in the previous modules in this learning path. It builds only the application's **Release** configuration. For brevity, it also omits the triggers, manual approvals, and tests you set up in previous modules.

    [!include[](../../shared/includes/pipeline-branches-note.md)]

## Optional - Explore the database project

If you're interested specifically in SQL Server, you can check out the database project, *Tailspin.SpaceGame.Database.sqlproj*, under the *Tailspin.SpaceGame.Database* directory. This is the SQL Server Data Tools project we discussed earlier. The *Tables* directory contains *.sql* files that define the four SQL tables you worked with in the previous section.

> [NOTE]
> Although you won't need to build the database project locally, keep in mind that this projects builds only under Windows.

To see how the _Space Game_ webapp runs SQL queries against the database, open the *RemoteDBRepository.cs* file under the *Tailspin.SpaceGame.Web* directory.

Here's an example that gets the achievements for a specific profile. These achievements appear when you select a player profile from the leaderboard.

```cs
sql = string.Format("SELECT a.description from dbo.Achievements a JOIN dbo.ProfileAchievements pa on a.id = pa.achievementid WHERE pa.profileid = {0}", profileId);
command = new SqlCommand(sql, conn);
using (SqlDataReader reader = command.ExecuteReader())
{
    //get the array of achievements
    user.Achievements = new string[recordCount];
    int i = 0;
    while (reader.Read())
    {
        user.Achievements[i] = reader.GetString(0);
        i++;
    }
}
conn.Close();
```

## Specify your database's connection string

Here, you fetch the connection string to your database and store it in a file named *secrets.json*. Doing so enables your web application, running locally, to connect to the database. The project is already set up to read from this file; you just need to create this file and specify the connection string.

> [!NOTE]
> Because your *secrets.json* file contains the connection string, which is a form of sensitive information, this file does not get placed under source control. Later, you'll use a different approach to specify the connection string for App Service to use.

### Fetch the connection string from the Azure portal

1. From the Azure portal, on the left, select **SQL databases**.
1. Choose the **tailspindatabase**.
1. Under the **Settings** section, select **Connection strings**. Copy the connection string that appears on the **ADO.NET** tab.

   ![Azure portal selecting connection strings page](../media/5-get-connection-string.png)

    Notice that the connection string doesn't show your password. You'll specify your password shortly.

### Specify the connection string locally

1. From Visual Studio Code, open **Tailspin.SpaceGame.Web.csproj** under the *Tailspin.SpaceGame.Web* directory. Notice the entry for `UserSecretsId`. This is how the web project locates your *secrets.json* file. You create a *secrets.json* file in a directory with that GUID in the file's name.

    ```xml
    <UserSecretsId>d7faad9d-d27a-4122-89ff-b9376c13b153</UserSecretsId>
    ```
1. From Visual Studio Code, open the terminal.
1. Move to the *Tailspin.SpaceGame.Web* directory.

    ```bash
    cd Tailspin.SpaceGame.Web
    ```
1. From a temporary file, paste in your connection string. Then replace `{your_password}` with your SQL password. Then copy the entire connection string back to the clipboard.
1. From the integrated terminal, create a Bash variable that specifies your connection string. Replace `{your_connection_string}` with your connection string.

    ```bash
    DB_CONNECTION_STRING="{your_connection_string}"
    ```

    Here's a complete example:

    ```bash
    DB_CONNECTION_STRING="Server=tcp:tailspin-space-game-sql-333.database.windows.net,1433;Initial Catalog=tailspindatabase;Persist Security Info=False;User ID=azuresql;Password=MyPassword1234;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
    ```

1. Run the following `dotnet user-secrets set` command to write your connection string to *secrets.json*.

    ```bash
    dotnet user-secrets set "ConnectionStrings:DefaultConnection" "$DB_CONNECTION_STRING"
    ```

    On Windows, the file is written to *%APPDATA%\Microsoft\UserSecrets\d7faad9d-d27a-4122-89ff-b9376c13b153\secrets.json*.

    On macOS, the file is written to *~/.microsoft/usersecrets/d7faad9d-d27a-4122-89ff-b9376c13b153/secrets.json*.

    As an optional step, you can print this file to verify its contents. 

1. Run `dotnet user-secrets list` to print the contents of *secrets.json*.

    ```bash
    dotnet user-secrets list
    ```

    You see your connection string. Here's an example:

    ```output
    ConnectionStrings:DefaultConnection = Server=tcp:tailspin-space-game-sql-333.database.windows.net,1433;Initial Catalog=tailspindatabase;Persist Security Info=False;User ID=azuresql;Password=MyPassword1234;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;
    ```

## Run the web application locally

Here, you build and run the web application locally to verify that the application can successfully connect to the database.

1. In Visual Studio Code, navigate to the terminal window and run this `dotnet build` command to build the application:

    ```bash
    dotnet build --configuration Release
    ```

1. Set the `ASPNETCORE_ENVIRONMENT` Bash variable to "Development" and export the variable.

    ```bash
    export ASPNETCORE_ENVIRONMENT=Development
    ```

    This setting tells ASP.NET Core that you're in development mode, and not in production mode, so it's safe to read from the *secrets.json* file.

1. Run this `dotnet run` command to run the application:

    ```bash
    dotnet run --configuration Release --no-build
    ```

1. From a new browser tab, navigate to [http://localhost:5000](http://localhost:5000?azure-portal=true) to see the running application.

    You see this:

    ![The Space Game web site](../media/5-space-game-top.png)

    > [!TIP]
    > If you see an error in your browser that's related to a certificate error, select Ctrl+C from your terminal to stop the running application.
    > Then run `dotnet dev-certs https --trust` and select **Yes** when prompted. Or [see this blog post](https://www.hanselman.com/blog/DevelopingLocallyWithASPNETCoreUnderHTTPSSSLAndSelfSignedCerts.aspx?azure-portal=true) for more information.
    >
    > After your computer trusts your local SSL certificate, run the `dotnet run` command a second time and go to [http://localhost:5000](http://localhost:5000?azure-portal=true) from a new browser tab to see the running application.

    You can interact with the page, including the leaderboard. When you select a player's name, you see details about that player.

    ![The Space Game leaderboard](../media/5-space-game-leaderboard-profile.png)

    Unlike in previous modules, the leaderboard data is read from your Azure SQL Database.

    When you're finished, return to the terminal window and select Ctrl+C to stop the running application.