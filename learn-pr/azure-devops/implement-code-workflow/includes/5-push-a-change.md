Here we have the learner practice the flow of moving changes into the pipeline, starting from their local development environment.

1. Propose a change to the app (a basic one, such as modifying the text on the homepage or similar.)
1. Build & run it locally through the Cloud Shell.
1. Commit the change, push it up.
1. Submit a PR, ask for reviewers.
    (Is it too much to configure the process such that approval is _required_? Might make things tricky given you'd need a second account to make the approval...)
1. After the change is approved, watch the build happen.
1. See the artifact come out the other end.

-----

Notes from spike:

## #1

- Propose feature
- Check out a branch
- Give user code for feature
- Build / run it locally
- `git add`; `git commit`; `git push`
- Create PR
  - See (default) trigger cause build to run.
    - From GitHub
    - From Azure Pipelines
  - This doesn't merge the change; it merely confirms that the build would succeed.

## #2

(TODO: We need a more appropriate scenario. One factor of a CI build, having it build on every push lets you know if there is a problem before you get all the way to opening a PR. We don't want to give the impression folks should be over-limiting things.

We have settings that if a new push comes in, it will stop the in progress build and start a new one (that one is for PR triggers). Or it can batch all changes and not start a new build until the current one finishes (that one is CI triggers)
)

- By default, the pipeline builds when _any_ PR is submitted. Let's say we want to limit automatic building only to PRs submitted against the `master` branch.
  - (Why limit it? Reduce congestion?)
- `git checkout`
- Add this to the top of azure-pipelines.yml:
    ```yml
    pr:
      branches:
        include:
        - master
      paths:
        exclude:
        - README.md
    ```
    Explain it - we want to include `master` and exclude changes to the README from triggering a build.
- `git add`; `git commit`; `git push`
- Set PR against `master`. See the build happen.
- Merge the change. See the second build happen. (This is important because it helps ensure that any changes merged to master since the PR was opened produces a clean build)

(Question: should we have the learner PR against some other branch to show that the build _doesn't_ happen?)

## #3

You don't want to be able to merge during the build, and you want at least one reviewer to approve changes before you merge.

- From GitHub, navigate to **Settings**, **Branches**.
- Enable **Require pull request reviews before merging** and set **Required approving reviews** to 1.
- Enable **Require status checks to pass before merging** and leave the rest blank for now.
- Under **Apply rule to**, specify `master`.
- Click **Create**.

(Explain what **Require signed commits** _would_ mean?)

(Explain that we don't check **Include administrators** for learning purposes so you can approve your own changes?)

Then...

- `git checkout master`
- `git pull origin master`
- (Make a trivial change to the code)
- `git add`; `git commit`; `git push`
- Create a PR.
- You see that code review is required. But you can still merge because you're an admin.

Merge when build completes? (Or drop it?)

## #4

You may have noticed that you can still merge even though the build hasn't finished.
