> [!IMPORTANT]
> To complete this exercise, you need an active GitHub account and a Visual Studio Code environment. If you don't have a GitHub account, you can [sign up](https://github.com/) for a free individual account and use a GitHub Copilot Free plan to complete the exercise. For help with enabling GitHub Copilot in Visual Studio Code, see [Enable GitHub Copilot in Visual Studio Code](https://go.microsoft.com/fwlink/?linkid=2320158&azure-portal=true).

In this exercise, you use GitHub Copilot to analyze and resolve issues in an e-commerce app. Tasks include:

- **TBD**

When you select the launch exercise button, the browser navigates to a public GitHub page that provides instructions for this exercise.

When you finish the exercise, return here for:

- A quick knowledge check.
- A summary of what you learned during this module.
- A badge for completing this module.





**TODO**: Add link to the exercise instructions page.




[![Button to launch exercise.](../media/launch-exercise.png)](https://go.microsoft.com/fwlink/?linkid=2342115&azure-portal=true)




---

## Task 1: Review Security Alerts on GitHub

Goal: Identify what secrets have been detected in the repository before writing any code. Understanding the alerts will focus our remediation efforts.

Use the following steps to complete this task:

1. Open GitHub in your browser and sign in.

1. Navigate to the repository (e.g., ECommerceApp) that contains the legacy code.

1. Go to the Security tab.

    On the repo’s GitHub page, click the “Security” tab (alongside Code, Issues, Pull Requests, etc.). This is where GitHub surfaces security alerts.

1. Find Secret Scanning alerts.

    In the Security overview, look for a section or link for “Secret scanning”. (It might show a count of alerts.) Click on “Secret scanning alerts.”

1. View the list of alerts.

    You should see one or more alerts listed, each labeled by the type of secret. For example, you might see “Stripe API Key” and “Azure SQL Connection String” or similar, each with a red icon indicating it’s open/critical.

1. Click an alert to see details.

    This opens a pane showing the file name, a snippet of code with the secret highlighted, and which commit introduced it. You’ll also see options like “Resolve” or “Dismiss” (we’ll use those later after fixing). Take note of the file and line number – for instance, an alert might point to ECommerceApp/Program.cs line 20 for the DB password, and another to PaymentProcessor for the API key.

## Task 2: Open the Project in Visual Studio Code

Goal: Set up your environment to edit the code and use Copilot. We need to reproduce the issue locally and get ready to apply fixes.

Use the following steps to complete this task:

1. Clone the repository to your local machine.

    If you haven’t already, use a Git client or command line:

    ```bash
    git clone https://github.com/<your-account>/ECommerceApp.git
    ```

    Replace <your-account> and repo name accordingly. This downloads the code to your computer.

1. Open the project in VS Code.

    Launch Visual Studio Code, and choose File > Open Folder, then select the ECommerceApp project folder you just cloned. The code should load, and you should see files like Program.cs in the Explorer sidebar.

1. Ensure GitHub Copilot is enabled.

    You should have the GitHub Copilot Chat extension installed (the lab assumes this is set up). You might see a Copilot panel or an icon. If not, install the extension and sign in with GitHub.

    Sign into Copilot if prompted. In VS Code, the Copilot Chat panel might ask you to Authenticate. Complete that step so Copilot can function.

Now you’re ready to start investigating and fixing within VS Code.

## Task 3: Use Copilot Ask Mode to Analyze the Issue

Goal: Get Copilot’s explanation of why the code is insecure. This helps reinforce your understanding and confirms the alert’s significance.

Use the following steps to complete this task:

1. Open the problematic file associated with the secret scanning alerts.

    For example, open Program.cs and also PaymentProcessor.cs (if it’s separate; in our code above, PaymentProcessor is in the same file). This is just to have the context visible.

1. Highlight the secret in code.

    In Program.cs, find the line with the DB connection string. Select the part that includes User ID=appuser;Password=P@ssw0rd123;. (You could do the Stripe key line first; you’ll eventually ask about both.)

1. Open Copilot Chat (Ask Mode).

    In VS Code, open the Copilot Chat view (often a panel on the right). Ensure it’s in Ask mode (not Agent).

1. Ask Copilot about the code.

    In the chat input box, type a question. For example: “Why is it a security risk to have this connection string in code?” or “What’s problematic about the code on lines 20-25?” Be specific so Copilot knows what you’re referring to (it takes into account the open files and your selection).

1. Wait for Copilot’s response.

    Copilot will analyze the code context and likely respond with something along these lines: “The code contains a hard-coded database password (P@ssw0rd123). Hard-coding credentials is a security risk because ... Additionally, if this repository is public, anyone can see these credentials. It should be stored securely, e.g., in environment variables or a secret manager.” The answer might mention how Secret Scanning flags this pattern.

1. Scroll and read the full explanation.

    Ensure you get the complete answer. Copilot might even suggest best practices (like rotating the credential, using config files, etc.).

1. Ask follow-up questions if needed.

    For instance, “How should I store connection strings securely?” Copilot can elaborate on using environment variables or Azure Key Vault, etc. For the Stripe key, you might ask, “What’s the risk of exposing a Stripe API key?” and it will explain that an attacker could abuse it to make charges or API calls on your behalf.

Your analysis with Copilot should confirm why the alert exists and outline the general solution (remove the hard-coded secret). Now you have not only the what (from GitHub’s alert) but the why and some hints on how to fix.

## Task 4: Use Copilot Agent Mode to Fix the Code

Goal: Engage Copilot to assist in actually refactoring the code to eliminate the hard-coded secrets. 
We’ll fix some issues now and others after testing Push Protection.

Use the following steps to complete this task:

1. Switch to Agent Mode.

    In the Copilot Chat view, change the mode to Agent. This mode lets Copilot propose code edits.

1. Prompt Copilot to fix the Stripe API key issue.

    For example, in the chat input you could write:

    ```plaintext
    Remove the hard-coded Stripe API key. Instead, read it from an environment variable called STRIPE_KEY.
    ```

    This instruction is clear about what we want.

1. Review the changes proposed.

    Copilot might respond with something like:

    ```plaintext
    I have modified the PaymentProcessor class to remove the hard-coded Stripe API key. It now retrieves the key from an environment variable named STRIPE_KEY. Here are the changes I made:"
    ```

    it will show a diff:

    ```csharp
    - private const string StripeApiKey = "sk_test_4eC39HqLyjWDarjtT1zdp7dc";
    + private static readonly string StripeApiKey = Environment.GetEnvironmentVariable("STRIPE_KEY");
    ```

    and perhaps add an `if (StripeApiKey == null)` check to handle missing environment variable. It may also show a message or comment about what it did.

1. Apply the changes.

    If the diff looks correct, you can click **Keep** or apply the edit. Copilot will then modify your PaymentProcessor code accordingly. Now the secret is gone from the code and it's fetched from an environment variable (a safer practice).

1. Next, fix the database password.

    Similarly, prompt Copilot:

    ```plaintext
    Remove the hard-coded database password in the connection string. Use an environment variable for the password.
    ```

    This one is trickier, because the connection string is one big string. Copilot might split it or reconstruct it. Review its suggestions: ideally it might do something like:

    ```csharp
    var dbPassword = Environment.GetEnvironmentVariable("DB_PASSWORD");
    var connectionString = $"Server=tcp:myserver.database.windows.net,1433;Initial Catalog=mydb;User ID=appuser;Password={dbPassword};";
    ```

1. Ensure it doesn’t inadvertently expose the password elsewhere.

1. Accept the change if it looks good.

1. Leave one issue unfixed (on purpose).

    We want to demonstrate Push Protection. Let’s say we’ve fixed the Stripe key but choose to leave the DB password as-is for now, or vice versa. (Alternatively, fix both in code but we’ll reintroduce a fake secret for testing push protection.) For this flow, assume we fixed only the Stripe key via Copilot, and decided to address the DB connection string later. In that case, maybe you did not apply the environment variable fix for the DB string, or you left some part of it with a dummy secret.

1. Save your files.

    Ensure all changes are saved in VS Code (Ctrl+S or Cmd+S for each file). The source control panel should show the modifications (e.g., Program.cs modified).

At this point, you harnessed Copilot to implement a secure pattern (removing a plaintext secret). Even though we haven’t fixed everything, you’ve seen how Agent Mode can eliminate a security flaw in seconds, which might have taken several minutes to code manually (plus the cognitive load of recalling the exact syntax).

## Task 5: Commit and Push the Changes, Verify Alerts

Goal: Push your partial fixes to GitHub and see how the Security alerts update. We expect one alert to resolve and one to remain.

1. Stage and commit the changes locally.

    In VS Code, open the Source Control view. You should see the modified file(s) ready to be staged. Stage them, then write a commit message. For example, enter "Remove hard-coded Stripe API key (use env var instead)" and then commit the changes.

1. Push to GitHub.

    Use Source Control: Push (VS Code might prompt after committing) or go to the terminal and run:

    ```bash
    git push origin main
    ```

    (Assuming you’re on the main branch and have permission to push.)

1. Observe the push output.

    If Push Protection was not yet enabled, the push will succeed (since we still have one secret, but push protection is off by default for private repos and we haven’t enabled it yet for this repo).

    If by chance Push Protection was on, you might have gotten blocked – we handle that in the next task, so assuming it went through now.

1. Open your GitHub page in the browser, and then refresh the Security tab.

    After the push, give it a few seconds, then refresh the Security > Secret scanning alerts page.

1. Verify one alert is gone or marked resolved.

    The alert for the Stripe API Key should no longer appear under "Open" alerts because that key is no longer in the code (GitHub might auto-close it or mark it resolved once the commit is scanned). The database password alert will still be present (since we haven’t removed it yet).

1. Manually mark resolved if needed. If the Stripe alert is still showing as open (maybe GitHub hasn’t auto-closed it yet), you can click it, and then choose “Close as Fixed” (with a comment like “Key removed from code”). Generally, the absence of the string in the latest code should eventually indicate it’s fixed, but it may require you to close it.

1. Confirm remaining alert(s). You should see that at least one alert (the DB password) is still open – this is expected. It means we still have work to do, which we intentionally left to demonstrate more features.

You’ve now seen the feedback loop: fix code -> push -> alerts update. This is how you’d normally close the loop on security issues. The Stripe API key secret is out of the repo’s current content (it might still exist in commit history, but being a test key, we won’t worry, though in real life you’d purge history or rotate it).

## Task 6: Enable and Test Push Protection

Goal: Turn on push protection for the repository and ensure it’s working. We’ll attempt to push a known secret to see GitHub block it.

1. Enable push protection in repo settings.

    On GitHub, go to the repository’s Settings tab. Under “Code security and analysis”, find “Secret scanning” settings. There should be an option for “Push Protection”. Click to enable it for this repository (if it isn’t already on). Save or confirm any prompts. (If it was already enabled by default for whatever reason, that’s fine.)

1. Prepare a fake secret in code.

    Back in VS Code, we’ll simulate a developer inadvertently adding a secret. Open Program.cs (or anywhere) and add a dummy secret. For example, add:

    ```csharp
    // Dummy secret for testing push protection
    string TestSecret = "ghp_1234567890abcdef1234567890abcdef12345678";
    ```

    Here I used a pattern resembling a GitHub Personal Access Token (ghp_...) as an example of a detectable secret. You can also use something like `PRIVATE_KEY=-----BEGIN RSA KEY-----` or any known signature.

1. Attempt to commit and push the dummy secret.

    Stage the change and commit with message “Add dummy secret” (you can do this quickly since it’s just a test). Now try to push.

1. Observe the push protection block.

    GitHub should reject the push. In VS Code’s output or terminal, you’ll see an error from git push with a message that secret(s) were detected. It might enumerate the secrets and give instructions. Typically it says you can retry with --no-verify (for client hooks) or that you can add a special string in the commit to bypass (something like #[secret-scanning skip] or similar). The key point: the push did not go through.

1. Read the error message.

    It should clearly indicate “Push rejected due to secrets” or something along those lines, listing the dummy secret. This confirms that Push Protection is active and doing its job.

1. Remove the dummy secret.

    Open the code and delete the TestSecret line (we don’t actually want that in our repo!). Save the file.

1. Commit the removal.

    If it wasn’t committed, just revert the change. Ensure your local branch is clean (no dummy secret).

Push Protection has prevented a potential leak. This is exactly how it catches real mistakes – for instance, had you tried to commit a real Stripe key, it would have blocked it similarly.
