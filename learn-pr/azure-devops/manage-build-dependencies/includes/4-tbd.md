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