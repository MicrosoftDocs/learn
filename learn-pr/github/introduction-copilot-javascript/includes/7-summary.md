You edited and previewed the portfolio in the sample codespace. You can now:

- Use inline suggestions in VS Code to complete code as you type.
- Give GitHub Copilot Chat the relevant file and a focused prompt for a JavaScript change.
- Review a suggestion and check the result in the browser: verify the profile text and GitHub link, then test the hover animation with and without reduced motion.

## Stop or delete the exercise codespace

> [!IMPORTANT]
> Before you stop or delete the codespace, verify that the copy you've saved outside it contains the work you want to keep. GitHub can [automatically delete a stopped codespace](https://docs.github.com/en/codespaces/setting-your-user-preferences/configuring-automatic-deletion-of-your-codespaces) even if it has unpushed commits. The default retention period is 30 days of inactivity after stopping, but a shorter period can apply. With zero-day retention, GitHub can delete the codespace immediately when it stops or times out.

To save the portfolio changes to your fork, commit and push only the edits you want to publish:

1. In **Source Control**, review the diffs for `src/App.jsx` and `src/styles.css`. Stage a whole file only if all its changes belong to the exercise. If it also contains unrelated edits, select just the exercise lines in the diff and choose [**Stage Selected Ranges**](https://code.visualstudio.com/docs/sourcecontrol/staging-commits#_stage-specific-lines-or-code-blocks).
1. Open the diffs under **Staged Changes**. Check that only the profile and hover edits you want to publish are staged. If anything else is staged, unstage that file and stage only the intended lines, if any. Unstaging keeps your edits; discarding them doesn't.
1. Check that you're on the intended branch, then commit the reviewed changes. If you have read-only access to the sample, Codespaces can [create or link your fork automatically](https://docs.github.com/en/codespaces/developing-in-a-codespace/using-source-control-in-your-codespace#about-automatic-forking) when you commit or push a new branch. Push the commit only after confirming that the destination is **your fork** and the intended branch. If you have multiple remotes, use [**Git: Push to...**](https://code.visualstudio.com/docs/sourcecontrol/repos-remotes#_push-commits) to select your fork's remote.
1. On GitHub, open **your fork** and select that branch. Verify that your commit is visible and that `src/App.jsx` contains the updated profile and `src/styles.css` contains the hover animation.

Pushing the exercise commit doesn't save other work that exists only in the codespace. Before you stop or delete it, back up anything else you want to keep outside the codespace. For example, download the affected files to your computer and check that the copies contain your edits.

Closing the browser tab doesn't stop the codespace immediately. It can keep using compute until its idle timeout. To stop or delete the exercise codespace:

1. Open [Your Codespaces](https://github.com/codespaces).
1. Find **this exercise's codespace** and open its **…** menu.
1. Select **Stop codespace** if you plan to resume it. If you're finished and have backed up the work you want to keep, select **Delete** instead.

[Stopping the codespace](https://docs.github.com/en/codespaces/developing-in-a-codespace/stopping-and-starting-a-codespace) ends compute usage, but the codespace still uses storage. [Deleting the codespace](https://docs.github.com/en/codespaces/developing-in-a-codespace/deleting-a-codespace) ends storage usage and discards changes saved only there. It doesn't delete your fork or refund time already used.

## References

Use these resources to learn more about Copilot, Codespaces, and VS Code:

- [About GitHub Copilot](https://docs.github.com/en/copilot/get-started/about-github-copilot)
- [How Copilot inline suggestions work](https://docs.github.com/en/copilot/responsible-use/inline-suggestions)
- [Code with GitHub Codespaces](/training/modules/code-with-github-codespaces/)
- [Visual Studio Code (YouTube)](https://www.youtube.com/@code/playlists)

## Provide feedback

Use this [issue form](https://github.com/githubpartners/microsoft-learn/issues/new/choose) to provide content feedback or suggested changes for this Microsoft Learn module. GitHub maintains this content and a team member will triage the request. Thank you for taking the time to improve our content!