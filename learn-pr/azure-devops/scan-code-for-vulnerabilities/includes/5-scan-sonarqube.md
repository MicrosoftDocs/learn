Sample flow/ideas:

1. Move the card from Backlog to Doing.
1. Note the secure data in the sources. Perhaps it's an SSH key, certificate, or other plaintext file.
1. Run credscan (or similar tool) locally to see what other files it finds.
  1. It finds the file you discovered manually.
1. Add credscan (or similar tool) to the build process. Run it and watch it fail.
1. Remove the offending file from the sources.
1. Generate a fresh secret (can't recycle the existing one because it's part of the Git history.)
1. Use Azure Key Vault to store the secret. Configure the pipeline to retrieve it during the build.
1. Watch the build turn green. Watch credscan pass in the build output. (you now have a process in place to catch further errors.)
1. Perhaps also add a widget to the dashboard.
1. Move the card from Doing to Done.

[Inspriation](https://blogs.msdn.microsoft.com/visualstudio/2017/11/17/managing-secrets-securely-in-the-cloud/)

-----

```yml
condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/master'))
```

-----

At the end --

"Wow, we weren't as clean as we thought!"
"..."

If you're interested in building .NET applications, as an optional exercise you can practice fixing one or more of these errors.
You also get to practice the entire process end to and as well as your Git skills - create branch, do work, verify locally, commit, push, see the result

-----

## TBD

(INSTEAD OF -- fetch your project key)

1. **+** > **Analyze new project**
1. GO THROUGH THE WIZARD
1. Copy Project key and token to a safe place
    IMPORTANT - copy it to a safe place. If you lose it, regenerate
1. Ignore 2 **Run analysis on your project**. You'll do that through the pipeline shortly.


SCRATCH:

1. Go to your organization “Administration > Projects Management” page
1. Click on “Create Project” and set the project name and key (com.github.yeutech-lab.accept-dot-path in your case)

https://community.sonarsource.com/t/project-was-never-analyzed-when-analysing-on-sonarcloud-with-travis/511


## Create service connection

1. Azure DevOps > **Project settings** in the lower corner.
1. Under **Pipelines**, select **Service connections**.
1. Click **New service connection**, then select **SonarQube**.
1. In the dialog that appears, enter these fields:
    * **Connection name**: SonarQube
    * **Server Url**: https://sonarcloud.io
    * **Token**: 

----

Notes from spike:

- Sign up at https://sonarcloud.io. Use your GitHub account.
- From https://sonarcloud.io/account/security/, generate a token. Name it "DevConnect". 
  - Copy it to your clipboard 7d76be0c4c54ddc2a8f8dcbc65a284e5175ab339-1

(OK, just check the `sonar` branch for the code. When revisting this, add in code coverage as well. [Reference](https://medium.com/@stef.heyenrath/azurepipelines-with-sonarcloud-1091f9756dac))

- Run it.
- Go back to the SQ dashboard an analyze the results.

Maybe also show how to use a tool from this page: https://geekflare.com/github-credentials-scanner/

Notes:
- Got this from the designer, walk the learner through how to do this? It's kind of a hack.

```yml
steps:
- task: SonarSource.sonarqube.15B84CA1-B62F-4A2A-A403-89B77A063157.SonarQubePrepare@4
  displayName: 'Prepare analysis on SonarQube'
  inputs:
    SonarQube: test
    projectKey: 7d76be0c4c54ddc2a8f8dcbc65a284e5175ab338
    projectName: DevConnectWeb0207

- task: SonarSource.sonarqube.6D01813A-9589-4B15-8491-8164AEB38055.SonarQubeAnalyze@4
  displayName: 'Run Code Analysis'

steps:
- task: SonarSource.sonarqube.291ed61f-1ee4-45d3-b1b0-bf822d9095ef.SonarQubePublish@4
  displayName: 'Publish Quality Gate Result'
```