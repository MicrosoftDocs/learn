Mara now has a copy of the _Space Game_ code on her local machine. She's going to build it using Azure Pipelines instead of the existing Ubuntu 16.04 build server. Before she can do that, she needs to think about the existing build scripts. Follow along as she maps the existing scripts to Azure Pipelines tasks. Think about how you can do the same with your own build process. 

Here are some notes Mara collected when she talked to Andy, the dev lead. 

* The build machine is running Ubuntu 16.04.
* It has build tools such as npm (the package manager for Node.js), NuGet (the package manager for .NET), and the .NET runtime installed.
* Here's the overall build process:
  * Run `npm install` to install the Node.js packages defined in `package.json`. (This isn't a Node.js app, but it uses Node.js to run other build tools.)
  * Run `node-sass` to convert .scss files to .css files.
      (The project uses Sass to make it easier to author cascading style sheets (CSS) files. node-sass is a Node.js package that converts .scss files to standard .css files.
  * Run `gulp` to minimize JavaScript and CSS files.
      (Explain minimized assets)
      `gulp` is a Node.js package that helps you run build tasks.
      It runs the tasks defined in `gulpfile.js`. 
  * Print build info to the `wwwroot` directory to help the QA team identify the build number and date.
  * Run `dotnet restore` to install the project's dependencies.
  * Run `dotnet build` to build the app under both Debug and Release configurations.
  * Run `dotnet publish` to package the application as a .zip file and copy the results to a network share for the QA team to pick up.

Mara builds a shell script that performs the tasks she's identified. She runs it on her laptop.

> [!NOTE]
> You don't need to run this script. It's here to illustrate what a typical build script might do.

```bash
#!/bin/bash
# Install Node.js modules as defined in package.json.
npm install --quiet
# Compile Sass (.scss) files to standard CSS (.css).
node-sass Tailspin.SpaceGame.Web/wwwroot
# Minimize JavaScript and CSS files.
gulp
# Print the date to wwwroot/buildinfo.txt.
echo `date` > Tailspin.SpaceGame.Web/wwwroot/buildinfo.txt
# Install the latest .NET packages the app depends on.
dotnet restore
# Build the app under the Debug configuration.
dotnet build --configuration Debug
# Publish the build to the /tmp directory.
dotnet publish --no-build --configuration Debug --output /tmp/Debug
# Build the app under the Release configuration.
dotnet build --configuration Release
# Publish the build to the /tmp directory.
dotnet publish --no-build --configuration Release --output /tmp/Release
```

The `/tmp` directory mimics the team's network share.

After she runs the script, Mara realizes that it's incomplete. For example, it doesn't deal with errors. It doesn't notify anyone if there are build errors and, even when there are errors, it keeps running. It also doesn't give the date when the build occurred. 

## Map script commands to Azure Pipelines tasks

Next, Mara is going to map the existing script commands to Azure Pipelines tasks. To define a build, she uses Visual Studio Code to create a YAML file. In it, she enters all the Azure Pipeline tasks she she'll use to replace the existing script commands. For example, the [.NET Core task](https://docs.microsoft.com/azure/devops/pipelines/tasks/build/dotnet-core?view=azure-devops&azure-portal=true), `DotNetCoreCLI@2`, helps you run `dotnet` commands.

This table associates the script commands with the new Azure Pipelines tasks. 

| Script command   | Azure Pipelines task |
|------------------|----------------------|
| `npm install`    | `Npm@1`              |
| `node-sass`      | `CmdLine@2`          |
| `gulp`           | `gulp@1`             |
| ``echo `date` `` | `CmdLine@2`          |
| `dotnet restore` | `DotNetCoreCLI@2`    |
| `dotnet build`   | `DotNetCoreCLI@2`    |
| `dotnet publish` | `DotNetCoreCLI@2`    |

She remembers that the build date is missing. The `CmdLine@2` task fixes that problem. It prints the date to `buildinfo.txt`.  

`script` is shortcut for `CmdLine@2`, so you could use the `script` task or `CmdLine@2` to print the date to `buildinfo.txt`.

<!-- I don't understand what 'script' refers to-->

<!-- Can we show the YAML file?-->

* Microsoft provides [reference documentation](https://docs.microsoft.com/azure/devops/pipelines/tasks/?view=azure-devops&azure-portal=true) for all the Azure Pipelines tasks you can use.

You're going to create a YAML file of your own in Unit 6.

Reference (remove this later)

https://docs.microsoft.com/azure/devops/pipelines/tasks/utility/command-line?view=azure-devops&tabs=yaml