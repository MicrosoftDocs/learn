* From Cloud Shell, `git clone` the app sources (including tests!).
  * One for the main app.
  * One for the dependent package.
* We do the work for you (too much to do manually), but highlight the pieces that changed.
* Perhaps at least have the learner set up the dependency and connect things up. (perhaps the initial version of the package is 0.1.0)
* Build and run the app locally. Verify it's running (e.g. `curl localhost`.)
* Push up the dependent package. Set up the build pipeline (including tests!) Watch it build. See the build artifact.
* Push up changes to the main app. Connect its build pipeline to the dependent app (including tests!) Watch it build. See the build artifact.

Either here or create another unit (or cut if it all ends up being too much):

* Make a change to the dependent package. Bump the version.
* Connect it up locally. Build it, run tests, verify it locally.
* Push up the package changes. Watch it build.
* Push up the app changes. Watch it build.

Possibly also connect things to the dashboard so you can track changes over time.

-----

Notes from spike:

(If it's a PIA to publish to NuGet.org, perhaps we give the learner a file share through sandbox?)
(Or give them a VM to run NuGet.Server?)
(Or have them enable their 30 Azure Artifacts trial?)

1. Create [nuget.org](https://www.nuget.org) account.
1. Create API key from user settings
    1. Key Name => TBD
    1. Glob Pattern => TBD
    1. Click Create, then Copy to copy API key. Save it somewhere safe.

1. Disable DevConnect pipeline through web UI

### Build package

1. Add a new pipeline through the web UI
    1. Select a source => GitHub
        1. tpetchel/DevConnectWeb0207
        1. master
    1. Choose YAML
        1. Name: DevConnectWeb0207-Core
        1. Agent pool: Hosted Ubuntu 1604
        1. YAML file path: azure-pipelines-core.yml
    1. Click Save (not Save & queue)
1. Get the code
    1. `git fetch upstream packages`
    1. `git push origin packages`
1. Manually build `packages` branch
1. Create a service connection to point to your NuGet feed
    1. Project settings => Service connections, and then create a New service connection. Select the NuGet option for the service connection. To connect to the feed, fill in the feed URL and the API key or token.
        1. Connection name => TBD / NuGet
        1. Feed URL => https://api.nuget.org/v3/index.json
        1. ApiKey => your key 
1. Push it, build it.

### Build app

1. Repo has the code? Just trigger build?
    1. Enable pipeline
    1. Manually trigger against `packages` branch.
         * Remember, this one uses azure-pipelines.yml

### TBD

TODO: Add a unit where you add a feature to the Core library, bump the version, then push through the pipeline.
Then, consume the newer version and validate things work (or the feature lights up!) in the main app locally, then push through the pipeline.