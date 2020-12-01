You've learned how to create a pull request when there's guidance - either in a pull request template, or in a `CONTRIBUTING` file. But what if a project doesn't (yet) offer that guidance and documentation on conventions?

## Describe your changes

A best practice writing a commit message, and subsequently your pull request, is the following:

Your Git commit message subject line should complete the following sentence:
If applied, this commit `<will your subject line here>`.
It contains a succinct description of the change using the imperative, present tense: "add" not "added" nor "adds". Limit your subject line to 50 characters, start with a capital letter, and don't end with a period (.). You can use emoji in your subject line, and `@`-mention other GitHub users, although not everyone is a fan of such frivolity.  

For the body of your message and pull request, continue to use present tense, and make sure to include the motivation for the change. Contrast this with the previous behavior. Use the real estate at your disposal to explain the *what* and *why* vs. the *how*.

Your commit message is only as to the point as the content that you're about to submit. Commit / submit for review small, isolated sets of changes. This also increases the likelihood of your changes getting merged into the project.

## Adding granularity

Before you submit your pull request, check the sidebar for ways to complete your PR. Select *Reviewers* and/or *Assignees* if you're familiar with the project's team structure. Add *Labels* when there's guidance on using those in for instance the CONTRIBUTING.md file. You can use labels as a visual clue as to what you're trying to accomplish. A maintainer may also add a label (or: multiple labels). Some of the labels we use in the repository for this Learn module for instance are:

- (red colored label) bug: something isn't working
- (blue) documentation: improvements or additions to documentation
- (grey) duplicate: this issue or pull request already exists
- (teal) enhancement: new feature or request

Optionally you can *link issues* in the sidebar as well, where successfully merging a pull request may close the corresponding issue. And you can customize your subscription to *notifications* on the thread - some PRs receive a lot of comments, reviews, and CI/CD related notifications. You can choose between:

- Not subscribed, and only receive notifications when you have participated or have been `@mentioned`.
- Subscribed, and receive all notifications for this pull request.
- Custom, and only be notified for the events you select

## Exercise

Using the [First Contributions](https://github.com/firstcontributions/first-contributions?azure-portal=true) project practice forking, cloning, and ultimately submitting a pull request. The First Contributions project aims to "guide the way beginners make their first contribution", and has guides for both using the command line, as well as several GUIs (Graphical User Interfaces). The project also has support for several languages, make sure to check their `Translations` folder.

With the lessons from the previous module and the above in mind, now go back to a pull request you opened recently (or: navigate to the pull requests tab of a project you're watching), and find out how a good subject line can make all the difference. Consider updating a pull request accordingly. Put roughly as much time in writing your PR as you did making the change to the project, so to help the maintainer(s) to triage (categorize and prioritize) community contributions.

**Bonus:** check Microsoft's Accessibility Guidelines and Requirements, and in particular the bit about ["describing interactions with UI"](https://docs.microsoft.com/style-guide/procedures-instructions/describing-interactions-with-ui), to avoid ableist language in your Docs contributions. Customers interact with products using different input methods: keyboard, mouse, touch, voice, and more. You will want to use generic verbs that work with any input method, for instance "select" instead of the input-specific "click" or "swipe".
