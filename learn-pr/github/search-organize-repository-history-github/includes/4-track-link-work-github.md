## Track and link your work on GitHub

GitHub offers several tools to help link issues, pull requests, and project planning. Understanding these features helps your team maintain visibility and traceability throughout the software development lifecycle.

### Link a pull request to an issue

To automatically close an issue when a pull request is merged, use a **keyword reference** in the pull request description:

```markdown
Fixes #42
```

This will close issue #42 when the pull request is merged.

Keywords like `Fixes`, `Closes`, and `Resolves` work with issue references in this format: `Fixes #issue_number`. The reference can also link across repositories using `owner/repo#issue_number`.

### Issue templates vs. issue forms

**Issue templates** are markdown files stored in `.github/ISSUE_TEMPLATE/` and provide pre-filled issue content. They're static and helpful for maintaining consistency.

**Issue forms** are built using YAML and let you create structured fields—like dropdowns, required inputs, and checkboxes—providing a more interactive experience.

Use templates when:

* You want to guide the user with prewritten instructions.

Use forms when:

* You want validation, structured inputs, or to reduce noise.

More on [issue forms](https://docs.github.com/issues/tracking-your-work-with-issues/creating-issue-forms-for-your-repository).

### Using keywords in issues and PRs

You can automate issue closure with keywords. Common ones include:

| Keyword         | Effect                              |
| --------------- | ----------------------------------- |
| `Fixes #123`    | Closes the linked issue when merged |
| `Closes #123`   | Same as above                       |
| `Resolves #123` | Same as above                       |

Include them in the pull request description or a commit message (not the title).

### Issue hierarchy and custom fields

GitHub Issues now supports advanced planning features:

* **Issue types** – Classify issues (e.g., Task, Bug, Feature).
* **Sub-issues** – Break down complex work into smaller, trackable parts.
* **Custom fields** – Add metadata like priority or team.
* **Filters** – Use issue type and custom field filters to find relevant issues quickly.

These features are often used within **Projects** to build Kanban boards or roadmaps. They provide a better way to plan and track work across teams.

To learn more, explore [Custom fields and issue types](https://docs.github.com/issues/planning-and-tracking-with-projects/customizing-issues/custom-fields).

These linking and planning tools help connect the dots between ideas, work in progress, and completed code.
