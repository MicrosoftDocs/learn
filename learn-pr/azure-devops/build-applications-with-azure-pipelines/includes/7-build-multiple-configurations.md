In the previous part, you implemented a pipeline that builds the _Space Game_ web site. You started with a script that performs each build action and mapped each action to its corresponding pipeline task. The output of the pipeline is a .zip file that contains the compiled web application.

You may have noticed that you built only the application's Release configuration. Say that Carol from QA also requires the Debug configuration so that she can better report crashes and other application failures.

In this part, you'll use a template to define build tasks that can build any configuration defined in the project file.

## How might you define both build configurations?

Consider the following tasks that build and publish the _Space Game_ web project's Release configuration.

```yml
- task: DotNetCoreCLI@2
  displayName: 'dotnet build Release'
  inputs:
    command: 'build'
    arguments: '--no-restore --configuration Release'
    projects: '**/*.csproj'

- task: DotNetCoreCLI@2
  displayName: 'dotnet publish Release'
  inputs:
    command: 'publish'
    projects: '**/*.csproj'
    publishWebProjects: false
    arguments: '--no-build --configuration Release --output $(Build.ArtifactStagingDirectory)/Release'
    zipAfterPublish: true
```

To build the Debug configuration, you might repeat these two tasks, but replace "Release" with "Debug".

Although that would likely give you the result you're looking for, consider what might happen as your build gains complexity and your requirements change. You would then need to manually locate and modify both variations of each build task. Once you have add additional build requirements, you would also need to create two tasks, one for the Debug configurations and one for Release, to satisfy those requirements.

Wouldn't it be better if you could write the build tasks one time and configure those tasks to build the configuration you choose?

## Define the template

Recall that a template enables you to define common build tasks one time and reuse those tasks multiple times. You call a template from its parent template as a build step and pass parameters into a template from the parent pipeline.

Here you'll create a template that can build any configuration defined in the project file.

1. From Visual Studio Code's integrated console, create the **templates** directory.

    ```bash
    mkdir templates
    ```

    You can place a template file in any location you choose. You don't need to place them in the **templates** directory.

1. From the integrated terminal, create a file named **build-config.yml** in the **templates** directory.

    **PowerShell**

    ```powershell
    TBD
    ```

    **Bash**

    ```bash
    touch templates/build-config.yml
    ```

    <!-- TODO: Add PowerShell equivalent -->

1. From Visual Studio Code, add this to **build-config.yml**.

    ```yml
    parameters:
      buildConfiguration: 'Release'

    steps:
    - task: DotNetCoreCLI@2
      displayName: 'dotnet build ${{ parameters.buildConfiguration }}'
      inputs:
        command: 'build'
        arguments: '--no-restore --configuration ${{ parameters.buildConfiguration }}'
        projects: '**/*.csproj'

    - task: DotNetCoreCLI@2
      displayName: 'dotnet publish ${{ parameters.buildConfiguration }}'
      inputs:
        command: 'publish'
        projects: '**/*.csproj'
        publishWebProjects: false
        arguments: '--no-build --configuration ${{ parameters.buildConfiguration }} --output $(Build.ArtifactStagingDirectory)/${{ parameters.BuildConfiguration }}'
        zipAfterPublish: true
    ```

    These tasks resemble the ones you defined earlier to build and publish the application. However, in a template, you work with input parameters differently than you do normal variables. Here are two differences:

    1. In a template file, you use the `parameters` section instead of `variables` to define inputs.
    1. In a template file, you use the `${{ }}` syntax instead of `$()` to read a parameter's value.
        When you read a parameter's value, you include the `parameters` section in its name, for example, `${{ parameters.buildConfiguration }}`.

## Call the template from the pipeline

Here you'll call the template you just built from the pipeline. You'll do so one time for the Debug configuration adn then repeat the process for the Release configuration.

1. From Visual Studio Code, modify **azure-pipelines.yml** like this.

    ```yml
    pool:
      vmImage: 'Ubuntu-16.04'
      demands:
        - npm

    variables:
      wwwrootDir: 'Tailspin.SpaceGame.Web/wwwroot'

    steps:
    - task: Npm@1
      displayName: 'npm install'
      inputs:
        verbose: false

    - script: './node_modules/.bin/node-sass $(wwwrootDir) --output $(wwwrootDir)'
      displayName: 'node-sass $(wwwrootDir)'

    - task: gulp@1
      displayName: 'gulp'

    - script: 'echo "$(Build.DefinitionName), $(Build.BuildId), $(Build.BuildNumber)" > buildinfo.txt'
      workingDirectory: $(wwwrootDir)
      displayName: 'output build info'

    - task: DotNetCoreCLI@2
      inputs:
        command: 'restore'
        projects: '**/*.csproj'

    - template: templates/build-config.yml
      parameters:
        buildConfiguration: 'Debug'

    - template: templates/build-config.yml
      parameters:
        buildConfiguration: 'Release'

    - task: PublishBuildArtifacts@1
      condition: succeeded()
      displayName: 'Publish Artifact: drop'
    ```

    This file resembles the original, except that it calls the template to perform the build and publish tasks.

    ```yml
    - template: templates/build-config.yml
      parameters:
        buildConfiguration: 'Debug'

    - template: templates/build-config.yml
      parameters:
        buildConfiguration: 'Release'
    ```

    You see that the template is called one time for each configuration. Each `template` task uses the `parameters` argument to pass the configuration name to the template.

## Run the pipeline

Here you'll push your changes to GitHub and see the pipeline run.

1. From the integrated terminal, add **azure-pipelines.yml** and **templates/build-config.yml** to the index, commit the changes, and push the changes up to GitHub.

    ```bash
    git add azure-pipelines.yml templates/build-config.yml
    git commit -m "Support build configurations"
    git push origin build-pipeline
    ```

1. From Azure DevOps, trace the build through each of the steps.
    **TODO**: Say something more here. Perhaps show a screenshot.

<!-- TODO: I realized that we never merged `build-pipeline` into master. That requires a pull request, possible review, and a merge. The merge triggers the pipeline one final time. Do we show it for completeness, or call out that we don't and that you'll learn more in the next module? -->