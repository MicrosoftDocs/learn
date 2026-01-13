GitHub Copilot isn’t just for Integrated Development Environments(IDEs)—it’s now a powerful assistant in your terminal. **GitHub Copilot CLI** brings Copilot directly into the command line, where it can explain commands, suggest shell commands from natural language, and help you work safely and interactively with your files and projects.

Copilot CLI uses GitHub authentication and runs independently from GitHub CLI, though it uses your existing credentials. Whether you’re new to the command line or an experienced developer, Copilot CLI reduces guesswork and speeds up everyday workflows.

This unit covers:

* Installing and running GitHub Copilot CLI
* Interactive sessions in the terminal
* Slash commands and natural language input
* Configuration and options

## Installing and Launching Copilot CLI

Install via **Homebrew** on macOS and Linux:

```bash
brew install copilot-cli
```

Or use the **official install script**:

```bash
curl -fsSL https://gh.io/copilot-install | bash
```

Launch Copilot CLI in **interactive mode**:

```bash
copilot
```

It displays see a welcome banner and a prompt:

:::image type="content" source="../media/copilot-cli-banner.png" alt-text="Screenshot of Copilot interactive mode banner.":::

On first launch, Copilot asks whether you trust the files in the current folder. Copilot may read, modify, or execute files in this directory during the session, so only proceed in locations you trust. 

:::image type="content" source="../media/copilot-cli-trust-files.png" alt-text="Screenshot of Copilot interactive specify directory.":::

You can use the `@` to select a specific file you want to work with as context.

:::image type="content" source="../media/copilot-cli-select-file.png" alt-text="Screenshot of selecting a file in copilot interactive mode.":::

Inside an interactive session, you can:

* Use **slash commands** (`/command`) to control the session and configure Copilot CLI.
* Type **natural language prompts** to explain, suggest, or revise commands.

For **one-shot prompts** without entering full interactive mode:

```bash
copilot -i "explain brew install git"
copilot -i "suggest find large files and delete them"
```

## Common Slash Commands

Slash commands are explicit session-control commands. Here are the most common ones:

| Slash Command          | Description                                           |         |                       |
| ---------------------- | ----------------------------------------------------- | ------- | --------------------- |
| `/help`                | Show available commands and options                   |         |                       |
| `/explain <command>`   | Ask Copilot to explain any shell command              |         |                       |
| `/suggest <task>`      | Ask Copilot to suggest a shell command for a task     |         |                       |
| `/revise`              | Revise the last suggestion based on your instructions |         |                       |
| `/feedback`            | Submit feedback on a response or suggestion           |         |                       |
| `/exit`                | Exit interactive mode                                 |         |                       |
| `/model <model>`       | Select which AI model to use                          |         |                       |
| `/theme [auto          | dark                                                  | light]` | Change terminal theme |
| `/skills`              | Manage skills for enhanced capabilities               |         |                       |
| `/mcp`                 | Manage Model Contect Protocol server configuration                       |         |                       |
| `/list-dirs`           | Show allowed directories for file operations          |         |                       |
| `/reset-allowed-tools` | Reset allowed tools list                              |         |                       |

> Slash commands cannot be replaced with natural language prompts. They are the only way to control session settings and configuration.

## Example Workflows

### 1. Explain a command

```text
> Explain what `git reset --hard HEAD` does
```

Copilot will provide a detailed explanation.

:::image type="content" source="../media/copilot-explain-command.png" alt-text="Screenshot of Copilot CLI explaining a command in interactive mode.":::


### 2. Suggest a command

```text
> Find and delete all .log files in my home folder
```

Copilot generates a command suggestion, and prompt you to execute it if you're satisfued with its suggestions.

:::image type="content" source="../media/copilot-cli-suggest-command.png" alt-text="Screenshot of Copilot CLI suggesting a command in interactive mode.":::

### 3. Revise a suggestion

After receiving a suggestion, you can type a follow-up prompt to revise the suggested command:

```text
> Include only files modified in the last 7 days
```
:::image type="content" source="../media/copilot-cli-revise-suggestion.png" alt-text="Screenshot of Copilot CLI improving a suggestion based on the follow-up prompt.":::

### 4. Provide feedback

After a response or suggestion:

```text
> /feedback
```
:::image type="content" source="../media/copilot-cli-provide-feedback.png" alt-text="Screenshot of using the /feedack slash command in Copilot CLI interactive mode.":::

Copilot prompts you to choose the kind of feedback you want to send, then navigate you to the appropriate form to complete your feedback.

### 5. Exit interactive mode

```text
> /exit
```

## Configuration Options

In Copilot CLI, configuration is handled via:

1. **Slash commands** inside interactive mode

   * `/model` choose AI model
   * `/theme` change terminal theme
   * `/skills` manage enhanced capabilities
   * `/reset-allowed-tools` reset tools
   * `/list-dirs` view allowed directories
   * `/mcp` MCP server settings

2. **`copilot configure` command** (non-interactive mode)

   ```bash
   copilot configure
   ```

   * Lets you set global preferences like default model, theme, or optional usage analytics.
   * Feedback settings and organizational access can be managed here.

Refer to the [official GitHub Copilot CLI documentation](https://github.com/github/copilot-cli) for full configuration options.

### Tips for Effective Use

* Use **interactive mode (`copilot`)** for exploratory tasks.
* Use **one-shot mode (`copilot -i`)** for quick answers.
* **Natural language input works**—you don’t always need slash commands.
* Always review commands before execution.
* Combine Copilot CLI with GitHub CLI (`gh`) for repository and issue management.
* Use **slash commands** when you want structured actions or feedback.
