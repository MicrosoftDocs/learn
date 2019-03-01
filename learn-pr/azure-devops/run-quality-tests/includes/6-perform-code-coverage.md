Details TBD, but use a tool such as [coverlet](https://github.com/tonerdo/coverlet) to perform code coverage testing.

Perhaps run it locally and then connect it to the build.

See it run and observe what's tested and what's not.

Add a code coverage badge to the GitHub repo.

Finally, consider adding a widget to the dashboard to visualize code coverage over time.

-----

Notes from spike:

(Mention coverlet?)

- Get latest
    ```bash
    git checkout master
    ```

    ```bash
    git pull origin master
    ```

- Create a branch

    ```bash
    git checkout -b code-coverage
    ```

- Run locally

- Modify azure-pipelines.yml

    ```yml
    # Run tests
    - script: dotnet test src/Xamarin.Web.DevConnect.Tests --logger trx --collect "Code coverage"
    - task: PublishTestResults@2
      condition: succeeded()
      inputs:
        testRunner: VSTest
        testResultsFiles: '**/*.trx'
    ```

- Add the change, commit, push.

    ```bash
    git add azure-pipelines.yml
    ```

    ```bash
    git commit -m "Add code coverage"
    ```

    ```bash
    git push origin code-coverage
    ```

- Submit PR. Watch it build. Trace the steps.

- Navigate to **Test Plans**, **Runs**.
- Select the most recent run.
- You see the tests continue to pass.
- In the **Attachments** section, you see two files
  - The .trx file is ... (maybe explain this in the previous unit?)
  - The .coverage file holds the results of the code coverage run.

You can download this file and view in from Visual Studio. (I think Ultimate only?)

You can also use a free dashboard widget provided by the community.

### Add dashboard widget

Knowledge needed: What is the Marketplace? 
- Mention that many add-ons are free, but some still require an evaluation or license key.

Describe how you might discover it.
- Navigate to [marketplace.visualstudio.com](https://marketplace.visualstudio.com)
- Search for it.

OK, here are the steps:

- From a new browser tag, navigate to [Code Coverage Protector](https://marketplace.visualstudio.com/items?itemName=davesmits.codecoverageprotector&referrer=https%3A%2F%2Fapp.vssps.visualstudio.com%2F_signedin%3Frealm).
- Click **Get it free**.
- Select your Azure DevOps organization from the drop-down.
- Click **Install**.
- From your Azure DevOps tab:
  - Navigate to **Overview**, **Dashboards**
  - Click **Edit**
  - Click **Add a widget**
  - Search for **Code Coverage**. (This is the one you just installed)
  - Drag **Code Coverage** to the (canvas).
  - Click the gear icon to configure the widget.
    - Keep all the settings at their default, except for:
      - Build definition => (Select your pipeline)
      - Measurement method => (TODO: Choose one that gives useful feedback)
  - Click **Save**.
  - Click **Done Editing**.

Describe what the widget does and what you can do with it.

Existing code coverage is low, but you have a baseline that you can improve over time.