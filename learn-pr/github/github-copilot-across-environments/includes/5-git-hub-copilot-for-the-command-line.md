GitHub Copilot isn’t just for IDEs—it’s now a powerful assistant in your terminal. **GitHub Copilot CLI** brings Copilot directly into the command line, where it can explain commands, suggest shell commands from natural language, and help you work safely and interactively with your files and projects.

Copilot CLI uses GitHub authentication and runs independently from GitHub CLI, though it leverages your existing credentials. Whether you’re new to the command line or an experienced developer, Copilot CLI reduces guesswork and speeds up everyday workflows.

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

You’ll see a welcome banner and a prompt:

:::image type="content" source="../media/copilot-cli-banner.png" alt-text="Screenshot of copilot interactive mode banner.":::

You can now either:

* Type natural language directly:

  ```
  > Explain what `git reset --hard HEAD` does
  > Find all .log files in my home folder and suggest a deletion command
  ```

  :::image type="content" source="../media/copilot-cli-banner.png" alt-text="Screenshot of copilot interactive mode banner.":::

  
You can also use **slash commands** for actions like `/context`, and `/feedback`.

  :::image type="content" source="../media/copilot-cli-banner.png" alt-text="Screenshot of copilot interactive mode banner.":::

For **one-shot prompts** without entering full interactive mode:

```bash
copilot -i "explain brew install git"
copilot -i "suggest find large files and delete them"
```

## Slash Commands

Inside interactive mode, Copilot CLI supports several slash commands:

| Slash Command        | Description                                           |
| -------------------- | ----------------------------------------------------- |
| `/help`              | Show available commands and options                   |
| `/explain <command>` | Ask Copilot to explain any shell command              |
| `/suggest <task>`    | Ask Copilot to suggest a shell command for a task     |
| `/revise`            | Revise the last suggestion based on your instructions |
| `/feedback`          | Submit feedback on a response or suggestion           |
| `/exit`              | Exit interactive mode                                 |

> 💡 **Tip:** You don’t always need a slash command—just typing your request in natural language works perfectly.

## Example Workflows

### 1. Explain a command

```text
> /explain git reset --hard HEAD
```

or simply type:

```text
> Explain what `git reset --hard HEAD` does
```

Copilot will provide a detailed explanation.

### 2. Suggest a command

```text
> /suggest find and delete all .log files in the home directory
```

or just type:

```text
> Find and delete all .log files in my home folder
```

Copilot will generate a safe command suggestion.

### 3. Revise a suggestion

After receiving a suggestion:

```text
> /revise Include only files modified in the last 7 days
```

### 4. Provide feedback

After a response or suggestion:

```text
> /feedback
```

Copilot will prompt you to rate the quality or provide comments.

### 5. Exit interactive mode

```text
> /exit
```

## Configuration Options

View or update Copilot CLI settings:

```bash
copilot configure
```

Options include:

* **Feedback mechanism**: Use `/feedback` to rate responses.
* **Data handling**: Opt out of optional usage analytics.
* **Organizational settings**: Admins can manage CLI capabilities for enterprise users.

Refer to the [official GitHub Copilot CLI documentation](https://github.com/github/copilot-cli) for full configuration options.

### Tips for Effective Use

* Use **interactive mode (`copilot`)** for exploratory tasks.
* Use **one-shot mode (`copilot -i`)** for quick answers.
* **Natural language input works**—you don’t always need slash commands.
* Always review commands before execution.
* Combine Copilot CLI with GitHub CLI (`gh`) for repository and issue management.
* Use **slash commands** when you want structured actions or feedback.
