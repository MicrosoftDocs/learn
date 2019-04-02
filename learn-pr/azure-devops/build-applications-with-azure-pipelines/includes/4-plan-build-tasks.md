Talk track: Alice wants to use Azure Pipelines to build the app. We should explain why this is a good next step and what pain it relieves (one idea is that it could notify QA about builds though email.)
But first, she must understand her existing build process.

(Mention that these are specific to her process. You can perform a similar exercise to identify your build steps.)

Talk track:

* Alice can run the app locally, but she wants to better undertand how the app is built on the build server.
* She and Bob log in to the build server. Bob walks her through the process and Alice takes notes.
* Alice sees a lot of complicated scripts, and she's not sure how it all fits together or if all the scripts are necessary.
* Bob mentions some of the challenges, such as:
  * Keeping the server updated with patches and security fixes.
  * Keeping build software and related tools such as NuGet up to date and in sync with what the dev team is using.
  * Handoffs to QA can be awkward. The QA team doesn't always know when a new build is available. They try to schedule handoffs up-front, but things slip (build is late, QA forgets.)

Here are some notes Alice collected. Turn these into a narrative.

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

Talk track: Alice takes her notes and builds a shell script that performs the tasks she's identified. She runs it on her laptop.

> [!NOTE]
> You don't need to run this .... it's to illustrate ....

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

Talk track: The script gives Alice a sense of how the build process works, but she realizes it's incomplete. For example, it doesn't deal with errors (e.g. it keeps going even if there are errors and it doesn't notify you if there are errors) or missing or out of date software.

Talk track: Provide a soft CTA here for the learner to consider their build process.

## Map script commands to Azure Pipelines tasks

(Unit 2 should already cover some of the basics around what Azure Pipelines is and some of what's in the YAML file. Focus on task mapping here.)

Talk track: 
  * Microsoft provides [reference documentation](https://docs.microsoft.com/azure/devops/pipelines/tasks/?view=azure-devops&azure-portal=true) for all the Azure Pipelines tasks you can use.
  * Alice begins to map each script command with an appropriate build task.
  * For example, the [.NET Core task](https://docs.microsoft.com/azure/devops/pipelines/tasks/build/dotnet-core?view=azure-devops&azure-portal=true), `DotNetCoreCLI@2`, helps you run `dotnet` commands.

| Script command   | Azure Pipelines task |
|------------------|----------------------|
| `npm install`    | `Npm@1`              |
| `node-sass`      | `CmdLine@2`          |
| `gulp`           | `gulp@1`             |
| ``echo `date` `` | `CmdLine@2`          |
| `dotnet restore` | `DotNetCoreCLI@2`    |
| `dotnet build`   | `DotNetCoreCLI@2`    |
| `dotnet publish` | `DotNetCoreCLI@2`    |

`script` is shortcut for `CmdLine@2`, so you could use the `script` task or `CmdLine@2` to print the date to `buildinfo.txt`.

(Here, it feels like the mapping "just happened". I wonder how we can better showed how she accomplished this without belaboring it.)

Reference (remove this later)

https://docs.microsoft.com/azure/devops/pipelines/tasks/utility/command-line?view=azure-devops&tabs=yaml