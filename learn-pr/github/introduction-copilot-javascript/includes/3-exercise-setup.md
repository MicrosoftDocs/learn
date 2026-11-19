Open the existing React portfolio in a browser codespace. Before you edit it, check that Copilot can suggest JavaScript and that you can see the portfolio home page.

## Check your account access

Check that your GitHub account gives you access to both services:

- **Codespaces:** [Sign in to GitHub](https://github.com/login) with an account that can create a codespace on the MicrosoftDocs sample repository. If you have read-only access, you need permission to fork it, but you don't need to make a fork first. An [Enterprise Managed User account](https://docs.github.com/en/enterprise-cloud@latest/admin/managing-iam/understanding-iam-for-enterprises/abilities-and-restrictions-of-managed-user-accounts#github-codespaces) can't create a codespace on this repository if MicrosoftDocs is outside your organization. A Copilot seat doesn't change that restriction.
- **Copilot:** The same GitHub account needs access to both inline completions and [Copilot Chat in VS Code](https://docs.github.com/en/copilot/how-tos/copilot-in-your-ide/chat-with-copilot/chat-in-ide?tool=vscode#prerequisites). If your organization or enterprise provides your seat, it must allow Chat in the IDE. If you're eligible and don't have an individual plan or an assigned seat, you can [activate Copilot Free](https://docs.github.com/en/copilot/how-tos/manage-your-account/get-started-with-a-copilot-plan#accessing-copilot-free) without starting a Pro trial or entering a payment card.

[Copilot Free](https://docs.github.com/en/copilot/get-started/plans) includes up to 2,000 inline completions per month. Inline completions don't use GitHub AI Credits. On Free, Copilot Chat selects the model automatically and uses a monthly [AI credit allowance](https://docs.github.com/en/copilot/concepts/billing-and-usage/individuals/billing), not a fixed number of messages. Copilot Pro includes unlimited inline completions. On usage-based Pro plans, Chat uses GitHub AI Credits.

Verified students can activate [Copilot Student](https://docs.github.com/en/copilot/how-tos/copilot-on-github/set-up-copilot/enable-copilot/set-up-for-students) through GitHub Education. Verified teachers and qualifying maintainers of popular open-source projects may be eligible for [Copilot Pro at no cost](https://docs.github.com/en/copilot/how-tos/copilot-on-github/set-up-copilot/enable-copilot/set-up-for-teachers-and-os-maintainers).

## Open the sample in a codespace

The [sample configuration](https://github.com/MicrosoftDocs/mslearn-copilot-codespaces-javascript/blob/4ee124077555bba7f613ca56b86f0a308402a8b8/.devcontainer/devcontainer.json#L5-L49) requests at least four cores. One hour on a running four-core machine uses four core-hours. With all 120 monthly core-hours available on a personal GitHub Free account, you get up to 30 running hours at four cores. Other Codespaces billed to your account share that allowance, and larger machines use it faster. This [Codespaces allowance](https://docs.github.com/en/billing/concepts/product-billing/github-codespaces#free-quota) is separate from Copilot Free. Organization and enterprise plans don't include a free Codespaces quota.

To stay within your personal account's included usage, [check both compute and storage](https://docs.github.com/en/codespaces/troubleshooting/troubleshooting-included-usage). They're metered separately. If either allowance runs out and paid usage isn't enabled, you can't create or reopen a codespace billed to you until the allowance resets. If paid usage is enabled, additional use can incur charges.

If you can't reopen a codespace with edits you want to keep, [export the changes without launching it](https://docs.github.com/en/codespaces/troubleshooting/exporting-changes-to-a-branch) while it still exists. Only the currently checked-out branch is exported. With read-only access to the sample, the export creates a branch in your fork. Verify your edited files on that branch on GitHub before relying on the copy.

If you already have a codespace for this sample, find it on [Your Codespaces](https://github.com/codespaces). Its name opens your default editor. To [open it in your browser](https://docs.github.com/en/codespaces/developing-in-a-codespace/opening-an-existing-codespace?tool=webui), select **…** > **Open in** and choose the browser option. Continue to [Check a JavaScript inline suggestion](#check-a-javascript-inline-suggestion).

If you don't have a codespace for this exercise yet, create one:

1. Select **Open in GitHub Codespaces**.

    [![Illustration of the Open in GitHub Codespaces button for the JavaScript portfolio.](https://github.com/codespaces/badge.svg)](https://codespaces.new/MicrosoftDocs/mslearn-copilot-codespaces-javascript)

1. Confirm the repository is `MicrosoftDocs/mslearn-copilot-codespaces-javascript`, review the machine type, and create the codespace. This opens a working copy of the sample; it doesn't create a new repository.
1. Wait for the codespace to open. Startup can take a few minutes. If it opens outside the browser, use **Open in** on **Your codespaces** to switch to the browser. Use this same codespace for the rest of the module.

## Check a JavaScript inline suggestion

The desktop version of VS Code includes the [built-in GitHub Copilot Chat extension](https://code.visualstudio.com/updates/v1_116#_github-copilot-is-now-built-in) for both Chat and inline suggestions. You don't need to install VS Code or an extension on your computer for this exercise. Test inline suggestions in the preconfigured browser editor:

1. Select **File** > **New Text File**. With the untitled file active, select the language mode in the status bar (usually **Plain Text**) and choose **JavaScript**.
1. Open the Copilot menu in the status bar. Sign in with the GitHub account that has your Copilot access if prompted. Make sure inline suggestions are enabled for JavaScript.
1. Type `const gitHub = "microsoft";` on the first line and `// Build the GitHub profile URL from the gitHub username.` on the next. Press **Enter** and pause. Look for dimmed code that uses `gitHub` to build `https://github.com/microsoft`. The exact suggestion can vary.
1. If nothing appears, open **View** > **Command Palette** and run **Trigger Inline Suggestion**. If it still doesn't appear, confirm that you're signed in with the intended GitHub account. Open the [Copilot status dashboard](https://code.visualstudio.com/docs/agents/agent-troubleshooting/faq#_how-can-i-monitor-my-copilot-usage) from the status bar. Check that suggestions are enabled for JavaScript and look at the inline usage shown for your plan before trying again.
1. Press **Esc** to dismiss the suggestion, then close the untitled file without saving.

This checks inline suggestions, not Chat. You'll try your first Chat prompt when you edit the portfolio profile.

> [!NOTE]
> If Chat reports a policy or usage limit, read the message. On a credit-based plan, check AI credit usage in the Copilot status dashboard, not the inline count. With a managed seat, ask your administrator about the IDE Chat policy and [organization usage limits](https://docs.github.com/en/copilot/concepts/billing-and-usage/organizations-and-enterprises/billing#how-do-ai-credits-work); you might not have a personal credit balance. Creating a new codespace doesn't change your Copilot access.

## Check the portfolio preview

If the portfolio home page already loads, leave Parcel running and go straight to **Ports** below. The preview inside the editor is enough for this first check. If the page doesn't load, check the startup messages:

1. Let setup finish installing the dependencies. For a container or installation failure, [check the creation log](https://docs.github.com/en/codespaces/troubleshooting/github-codespaces-logs#creation-logs): select **View logs** during creation if offered, or run **Codespaces: View Creation Log** from the Command Palette once connected. If the container works but installation failed, resolve the reported error, then retry `npm install` from the repository root.
1. After VS Code connects, look in **Terminal** for the session that runs `npm start`. If it's visible, check for Parcel's listening address or a startup error. If you only see an empty terminal, check the preview from **Ports** before starting another server. The first server might still be running.
1. If Parcel is listening but reports an application build error, leave it running and fix the reported error. If setup succeeded but no Parcel server is running, resolve any startup error, then run `npm start` once from the repository root.

In **Ports** next to the terminal, find the port Parcel reports. The sample labels port **1234** as **Application**. If Parcel reports a different number, use that port even if it has no label. If the port isn't listed, select **Add port** and enter the reported number. Keep the [forwarded port](https://docs.github.com/en/codespaces/developing-in-a-codespace/forwarding-ports-in-your-codespace) **Private**.

Right-click that port and select **Open in Browser**. Confirm that the portfolio home page loads. Use this tab instead of the [embedded preview](https://docs.github.com/en/codespaces/troubleshooting/troubleshooting-github-codespaces-clients?tool=webui#troubleshooting-the-simple-browser) for the link and motion checks in the portfolio exercise.
