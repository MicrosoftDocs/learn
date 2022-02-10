> [!IMPORTANT]
> In your Azure DevOps PartsUnlimited project, prepare two builds pipelines (used in previous demos)

 -  Build pipeline **PartsUnlimited Security Package**.
    
     -  **.NET Core** build task (Restore, build, push)
     -  Enable CI trigger
 -  Build pipeline **PartsUnlimited E2E**.
    
     -  **ASP.NET** web application type
     -  NuGet restore task

## Steps to build and push the NuGet package

1.  Edit the build pipeline **PartsUnlimited Security Package**.
    
     -  dotnet restore
     -  dotnet build
     -  dotnet push
        
         -  Use the command `nuget push` and specify path `**/*.nupkg`.
         -  Select target feed PartsUnlimited.
2.  Start a new build and select agent pool.

    The build has succeeded, but you'll see the final step **dotnet push** fails. The reason for this failure can be found in the log information.

3.  Open the log information.

    It shows the feed already contains the **PartsUnlimited.Security 1.0.0**. We go back to the Visual Studio project to see what is happening.

4.  Open the source code for the PartsUnlimited package in Visual Studio in a different solution.
    
     -  Open the **Project Properties.**
     -  Go to the package tab.

    Look at the Package version. We see that the version is still 1.0.0. Packages are immutable.

    As soon as a package is published to a feed, there can never be another package with the same version.

    We need to upgrade the version to a new one that uses the major, minor, and the changed patch version.

5.  Change the patch version: `1.0.1`. Make a small edit to the code for illustrative purposes, and check in the new code.
6.  Change the **exception type** check-in, commit, and push the new code. We go back to the Azure DevOps pipeline. Since there's a trigger on the code we just changed, the build will automatically start.
7.  Go back to build pipeline for **PartsUnlimited Security Package**.

    As you see, the build is triggered and completed successfully, including the push to the NuGet feed.

    Since there was no version conflict, we successfully pushed the new version to the feed.

8.  Open **Artifacts** and show the feed.

    Since there was a successful build for the entire web application, you can see that the PartsUnlimited feed now also includes all the downloaded upstream packages from the NuGet.org source.

9.  Scroll down and click on the **PartsUnlimited.Security 1.0.1** package. By clicking on it, we can inspect the details and the versions.
10. Edit the build pipeline **PartsUnlimited E2E**.
11. Click **NuGet restore**.

There is a second pipeline that builds the complete web application. It is an ASP.NET web application build.

The NuGet restore task is also configured to consume packages from the PartsUnlimited feed.

Because PartsUnlimited has an upstream source for NuGet.org, we don't have to **Use packaged from NuGet.org** explicitly. You can uncheck this box.
