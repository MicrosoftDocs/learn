Before you can use GitHub Spec Kit to practice spec-driven development, you need to set up your environment. This unit covers the prerequisites, installation process, and configuration steps to get GitHub Spec Kit running in your development environment.

## Prerequisites and system requirements

Before installing GitHub Spec Kit, ensure your development environment meets the requirements for operating system, software dependencies, and AI coding assistant support.

### Operating system

Your development environment must use one of the following operating systems:

- **Linux or macOS:** Fully supported.
- **Windows:** Fully supported with PowerShell scripts.

### Required software

Your development environment must include the following software:

- **Python 3.11 or later:** GitHub Spec Kit's CLI is a Python tool.
- **Git:** Required for version control integration and pulling the toolkit.
- **uv tool:** GitHub Spec Kit uses the `uv` tool for package management. The `uv` tool is a modern package manager that can install tools directly from GitHub.

### AI coding assistant

Your development environment must have at least one supported AI coding assistant configured and working. GitHub Spec Kit supports:

| Agent | Environment | Slash Command Support |
|-------|-------------|----------------------|
| GitHub Copilot | Visual Studio Code | Yes |
| Claude Code | CLI / IDE | Yes |
| Cursor | Cursor IDE | Yes |
| Windsurf | Windsurf IDE | Yes |
| Amazon Q Developer CLI | CLI / IDE | check |
| Gemini CLI | CLI | Yes |
| And others | Various | Varies |

The lab exercise in this module uses Visual Studio Code with GitHub Copilot.

## Install the uv tool

You can install the `uv` tool using one of the following methods:

- **On macOS and Linux:**

    ```bash
    curl -LsSf https://astral.sh/uv/install.sh | sh
    ```

- **On Windows (in PowerShell):**

    ```powershell
    powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
    ```

After installation, restart your terminal to ensure `uv` is available in your PATH.

## Install Specify CLI

GitHub Spec Kit uses the `specify` CLI tool to manage specifications and interact with AI coding assistants. There are two main ways to install the `specify` CLI tool.

### Method 1: Global installation (recommended)

The recommended approach is to install `specify-cli` globally using `uv`. A global installation makes the `specify` command available in any project.

```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

Global installation provides these benefits:

- Available in any project directory.
- Easy to update using `uv tool upgrade specify-cli`.
- No need to rerun installation commands each time.

### Method 2: One-time usage

If you prefer not to install globally, you can run GitHub Spec Kit directly using `uvx`:

```bash
uvx --from git+https://github.com/github/spec-kit.git specify init
```

One-time usage downloads and runs GitHub Spec Kit for that single invocation. It's useful for:

- Trying out GitHub Spec Kit before committing to installation
- Running on systems where you can't install globally (like some CI servers)

The drawback is that you need to prefix commands with the full `uvx --from ...` each time, which is less convenient for regular use.

## Verifying your installation

After installing, verify that GitHub Spec Kit is working correctly:

```bash
specify check
```

This command checks for required tools and confirms that installation succeeded. It reports:

- Whether or not Git is found and configured.
- Whether or not your AI coding assistant is detected.
- Any missing dependencies or configuration issues.

If `specify check` reports issues, address them before proceeding.

## Setting up Visual Studio Code with GitHub Copilot

You can use the following steps to set up Visual Studio Code with GitHub Copilot (for use with GitHub Spec Kit):

1. Install Visual Studio Code.

    Download and install Visual Studio Code from [code.visualstudio.com](https://code.visualstudio.com) if you haven't already.

1. Install GitHub Copilot extension.

    1. Open Visual Studio Code.
    1. Go to the Extensions view (Ctrl+Shift+X or Cmd+Shift+X).
    1. Search for "GitHub Copilot."
    1. Install the GitHub Copilot extension.
    1. Sign in with your GitHub account that has an active GitHub Copilot subscription.

1. Verify GitHub Copilot is working.

    Open the GitHub Copilot Chat panel and verify chat functionality is working.

1. Open the integrated terminal.

    You can run `specify` commands in Visual Studio Code's integrated terminal:

    1. Open a new Terminal.
    1. Navigate to your project directory.
    1. To verify everything is configured, run `specify check`.

## Installing for other environments

If you're not using Visual Studio Code, the process is similar:

### Claude Code

1. Install `specify-cli` globally as described previously
1. Open Claude's interface in your project folder
1. Type slash commands (`/speckit.specify`, etc.) directly in the chat

### Cursor

1. Install `specify-cli` globally.
1. Open your project in Cursor.
1. Ensure the AI agent is running.
1. Use slash commands in Cursor's AI chat interface.

### Other AI tools

Most supported AI coding assistants follow the same pattern:

1. Install the `specify-cli` globally.
1. Open your project in your preferred environment.
1. Use the slash commands in that tool's AI chat interface.

Check the "Supported AI Agents" table in GitHub Spec Kit README file for any tool-specific considerations.

## Troubleshooting common issues

You might encounter some common issues during installation or setup. The following sections provide solutions for common problems.

### uv command not found

If `uv` isn't recognized after installation:

- Close and reopen your terminal.
- Ensure the installation directory is in your PATH.
- On Windows, you might need to restart your computer.

### Specify command not found

If `specify` isn't found after installation:

- Close and reopen your terminal.
- Check that `~/.local/bin` (or the `uv` tool bin directory) is in your PATH.
- Try running `uv tool list` to see if specify-cli appears.

### AI tool not detected

If `specify check` reports your AI tool isn't found:

- Ensure the AI tool is installed and running.
- For Visual Studio Code with GitHub Copilot, ensure the extension is installed and you're signed in.
- Check that you're running the check from a terminal where the AI tool is accessible.

### Windows-specific issues

If you're on Windows and experiencing issues:

- Ensure PowerShell is available (typically preinstalled).
- Run PowerShell commands in a PowerShell terminal (not Command Prompt).
- Install prerequisites (Python, uv, Git) for Windows.

For issues beyond these common problems, consult the GitHub Spec Kit README and community resources on the GitHub repository.

## Summary

GitHub Spec Kit supports various development environments and AI coding assistants. Core requirements include Python 3.11+, Git, and the `uv` tool. You can install the `specify` CLI globally or use it one-time via `uvx`. Visual Studio Code with GitHub Copilot is a common setup, but other AI tools are supported as well. Verifying your installation with `specify check` helps ensure everything is configured correctly.
