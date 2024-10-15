GitHub Copilot isn't just a tool for writing code in your favorite IDE; it’s also a powerful assistant that can help streamline your command-line workflows. By integrating with the GitHub CLI, Copilot can provide explanations for unfamiliar commands, suggest commands based on your needs, and even execute them on your behalf. Whether you're new to the command line or a seasoned user, Copilot can enhance your productivity by offering intelligent suggestions and simplifying complex tasks.

This unit covers:

- Guiding you through the common GitHub Copilot CLI commands,
- Exploring configuration options enabling you to make the most of GitHub Copilot directly from your terminal. 


## Common commands
Once you have Copilot set up in the CLI, here are some frequently used commands for interacting with it:

- **Getting command explanations**:
   - If you're unsure about what a specific command does, you can ask Copilot to explain it. For instance:

     ```shell
     gh copilot explain "sudo apt-get"
     ```

     :::image type="content" source="../media/copilot-explain-in-cli.png" alt-text="Screenshot of copilot explain in cli.":::

     This command provides you with a detailed explanation of the provided command.

- **Getting command suggestions**:
   - Need help with constructing a command? You can ask Copilot to suggest a command based on what you want to accomplish:
     ```shell
     gh copilot suggest "Undo the last commit"
     ```

     :::image type="content" source="../media/copilot-suggest-in-cli.png" alt-text="Screenshot of copilot suggest in cli.":::

     Copilot starts an interactive session to clarify your request and suggest the best command.

- **Executing suggested commands**:
After receiving a suggestion, you can choose the `Execute command` option. This copies the command to your clipboard. You can also allow Copilot to execute commands on your behalf only if you configure the `ghcs` alias, you. 

   Using the alias:

   ```
   ghcs suggest "What command to see running docker containers"
   ```

   :::image type="content" source="../media/executing-suggested-command-copilot-suggest-in-cli.png" lightbox="../media/executing-suggested-command-copilot-suggest-in-cli.png" alt-text="Screenshot of executing suggested command copilot suggest in cli.":::

- **Revise suggested command**:
   To give GitHub Copilot CLI to rework or revise a command to make it better or more suited to your expectations, use the "Revise command" option along with your feedback.

   :::image type="content" source="../media/revising-suggested-command-copilot-suggest-in-cli.png" alt-text="Screenshot of revising suggested command copilot suggest in cli.":::


## Configuration options

To make the most out of Copilot in the CLI, you may want to configure certain settings:

- **Alias Configuration**:
   If you want Copilot to execute commands on your behalf directly, you need to set up the `ghcs` alias. Using an alias allows you to bypass copying and pasting commands manually, and instead Copilot does it for you.

   To configure the `ghcs` alias, run the following commands:

   For bash:

   ```
   echo 'eval "$(gh copilot alias -- bash)"' >> ~/.bashrc
   ```

   For PowerShell:

   ```
   $GH_COPILOT_PROFILE = Join-Path -Path $(Split-Path -Path $PROFILE -Parent) -ChildPath "gh-copilot.ps1"
   gh copilot alias -- pwsh | Out-File ( New-Item -Path $GH_COPILOT_PROFILE -Force )
    echo ". `"$GH_COPILOT_PROFILE`"" >> $PROFILE
   ```

   For Mac terminal or Zsh:

   ```
   echo 'eval "$(gh copilot alias -- zsh)"' >> ~/.zshrc
   ```

- **Feedback mechanism**:
   Copilot encourages user feedback to improve its suggestions. You can rate the quality of a suggestion by selecting the `Rate response` option after Copilot provides you with a command.

   :::image type="content" source="../media/rating-suggested-command-copilot-suggest-in-cli.png" alt-text="Screenshot of rating suggested command copilot suggest in cli.":::

- **Organizational settings**:
   If you're using Copilot within an organization your access to certain features may be governed by your organization's policies. Administrators can enable or disable Copilot's capabilities within the CLI.

   For further customization and detailed configuration so you can optimize Copilot's functionality for your specific needs, refer to the [GitHub documentation](https://docs.github.com/en/copilot).

- **Data handling**:
   GitHub Copilot CLI doesn't retain your prompts, but it keeps your usage analytics. You can configure whether you want GitHub Copilot to keep and use your usage data to improve the product. Enter the command ` gh copilot config` , select "Optional Usage Analytics", then select "No" if you want to opt out.

   :::image type="content" source="../media/configure-usage-data-setting-in-cli.png" alt-text="Screenshot of configure usage data setting in cli.":::
