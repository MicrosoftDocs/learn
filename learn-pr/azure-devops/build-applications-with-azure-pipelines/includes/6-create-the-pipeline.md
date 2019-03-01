Create a pipeline, connect it to your GitHub project, and watch it build.

[Reference](https://docs.microsoft.com/azure/devops/pipelines/get-started-yaml?view=azdevops#get-your-first-build)

-----

TODO: Let's not go down the msbuild route. Let's keep it more basic.

Notes from spike:

## Create the pipeline

TODO: Change this to exclude docs/ from builds, not filter branches.

- Explain how now you need a way to build it. The team currently uses...
  - Now let's build it using a pipeline
- From Azure DevOps, navigate to your project.
- Choose Pipelines
- Where is your code?
  - GitHub
- Select a repository
  - **Authorize with OAuth**
  - Select repo
- Configure your pipeline
  - Select **ASP.NET Core**
- Make the .yml file look like this (note change to the build command to match the one you did manually.)
    ```yml
    # ASP.NET Core
    # Build and test ASP.NET Core projects targeting .NET Core.
    # Add steps that run tests, create a NuGet package, deploy, and more:
    # https://docs.microsoft.com/azure/devops/pipelines/languages/dotnet-core

    trigger:
    - master

    pool:
      vmImage: 'Ubuntu-16.04'

    variables:
      buildConfiguration: 'Release'

    steps:
    - script: dotnet build src --configuration $(buildConfiguration)
      displayName: 'dotnet build src $(buildConfiguration)'
    ```
- Click **Save and run**
- Click **Save and run** (again)
- Walk the user through the build process that follows.
  - Discuss what the learner is seeing as the job runs.
    - Prepare job, Initialize Agent, etc.
  - Call out that the build process is specific to ASP.NET Core. Your build process would perform what you need for your app.
- You see that azure-pipelines.yml is added to your repo.
  - `git pull origin master`
  - View on GitHub

> !TIP Check your inbox! You'll receive a build notification. You can configure this ...

> TODO: Show the agent pool from Project settings -> Agent pools (https://dev.azure.com/{your_organization}/_admin/_AgentPool). Click on agent to see what's installed in the image.

## Publish the build artifact

- What you saw so far was a basic process.
- The team builds on Visual Studio.
- Need to install build deps, run msbuild, then publish the build artifact.
- Go into more detail on the dependencies and build process here...

## Knowledge needed

- What are build artifacts?
  - Artifacts are the files that you want your build to produce. Artifacts can be anything that your team needs to test or deploy your app. (Docs)
- More about built-in tasks?
  - What's the @ thing all about?

## Examine existing build process

(TODO: On second thought, maybe we change this to something Linux-based instead of flip-flopping between Linux and Windows.)

Requirements:

- npm
- node.js
- msbuild
- visualstudio
- nuget packages

Walk through existing commands the team uses. Then map to each of these build tasks:

- NuGetToolInstaller
- NuGetCommand
- Npm
- Grunt
- powershell
- VSBuild
- PublishBuildArtifacts

## Task

- From the pipeline (web interface), modify azure-pipeline.yml like this.

    ```yml
    pool:
      vmImage: vs2017-win2016
      demands:
      - npm
      - node.js
      - msbuild
      - visualstudio

    variables:
      BuildPlatform: 'any cpu'
      BuildConfiguration: 'release'

    steps:
    - task: NuGetToolInstaller@0
      displayName: 'Use NuGet 4.4.1'
      inputs:
        versionSpec: 4.4.1

    - task: NuGetCommand@2
      displayName: 'NuGet restore'
      inputs:
        restoreSolution: src/Xamarin.Web.DevConnect.sln

    - task: Npm@1
      displayName: 'npm install'
      inputs:
        verbose: false

    - task: Grunt@0
      displayName: 'grunt '
      inputs:
        arguments: 'less:prod'

    - powershell: '"$(Build.DefinitionName), $(Build.BuildId), $(Build.BuildNumber)" | Out-File buildinfo.txt'
      workingDirectory: src/Xamarin.Web.DevConnect/wwwroot
      displayName: 'output build info'

    - task: VSBuild@1
      displayName: 'Build solution src/Xamarin.Web.DevConnect.sln'
      inputs:
        solution: src/Xamarin.Web.DevConnect.sln
        msbuildArgs: '/p:DeployOnBuild=true /p:WebPublishMethod=Package /p:PackageAsSingleFile=true /p:SkipInvalidConfigurations=true /p:PackageLocation="$(build.artifactstagingdirectory)\\"'
        platform: '$(BuildPlatform)'
        configuration: '$(BuildConfiguration)'

    - task: PublishBuildArtifacts@1
      condition: succeeded()
      displayName: 'Publish Artifact: drop'
    ```

    TODO: Perhaps introduce this (publish only from the `master` branch instead of only _building_ the `master` branch...)

    ```yml
    - task: PublishBuildArtifacts@1
      condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/master'))
    ```

    Explain it.

- Click **Save and run**.
- Trace the build through each of the steps.
- When the build completes, you see the **Artifacts** button appear.
  - Click it, then click **drop**. The **Artifacts explorer** appears.
- From the **Artifacts explorer**, expand the **drop** folder.
  - You see an number of files, including documentation, command (.cmd), and configuration files. (Explain these.)
  - You also see a .zip file, which contains your package and its dependencies.

## Build Debug and Release configurations

- Add this to templates/vsbuild.yml

    ```yml
    parameters:
      BuildConfiguration: 'Release'
    
    steps:
    - task: VSBuild@1
      displayName: 'Build solution src/Xamarin.Web.DevConnect.sln - ${{ parameters.BuildConfiguration }}'
      inputs:
        solution: src/Xamarin.Web.DevConnect.sln
        msbuildArgs: '/p:DeployOnBuild=true /p:WebPublishMethod=Package /p:PackageAsSingleFile=true /p:SkipInvalidConfigurations=true /p:PackageLocation="$(build.artifactstagingdirectory)\${{ parameters.BuildConfiguration }}\\"'
        platform: '$(BuildPlatform)'
        configuration: '${{ parameters.BuildConfiguration }}'
    ```

- Modify azure-pipeline.yml like this.

```yml
# trigger:
# - master

# pr:
#   branches:
#     include:
#     - master
#   paths:
#     exclude:
#     - README.md

pool:
  vmImage: vs2017-win2016
  demands:
  - npm
  - node.js
  - msbuild
  - visualstudio

variables:
  BuildPlatform: 'any cpu'

steps:
- task: NuGetToolInstaller@0
  displayName: 'Use NuGet 4.4.1'
  inputs:
    versionSpec: 4.4.1

- task: NuGetCommand@2
  displayName: 'NuGet restore'
  inputs:
    restoreSolution: src/Xamarin.Web.DevConnect.sln

- task: Npm@1
  displayName: 'npm install'
  inputs:
    verbose: false

- task: Grunt@0
  displayName: 'grunt '
  inputs:
    arguments: 'less:prod'

- powershell: '"$(Build.DefinitionName), $(Build.BuildId), $(Build.BuildNumber)" | Out-File buildinfo.txt'
  workingDirectory: src/Xamarin.Web.DevConnect/wwwroot
  displayName: 'output build info'

- template: vsbuild.yml  # Template reference
  parameters:
    BuildConfiguration: 'Debug'

- template: vsbuild.yml  # Template reference
  parameters:
    BuildConfiguration: 'Release'

- task: PublishBuildArtifacts@1
  displayName: 'Publish Artifact: drop'
```

- Add, commit, push

```bash
git checkout ...
git add .
git commit -m ""
git push origin 
```

- Watch it build. Trace each step. See both artifacts come out the end.