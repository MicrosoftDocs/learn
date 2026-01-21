<!--
## Content Sources

This unit was built from the following source content:

**Primary Sources:**
- includes/3-examine-github-spec-kit.md
  - "Key components of GitHub Spec Kit" → "Specify CLI tool" section (installation commands)
  - "GitHub Spec Kit's AI agent support" → "Multi-agent compatibility" section (supported agents list)

**Supporting Sources:**
- Module Outline (Unit 7)
  - Prerequisites and system requirements
  - Installation methods (global and one-time)
  - Visual Studio Code setup specifics
  - Troubleshooting guidance

**External References:**
- GitHub Spec Kit README (installation instructions, uv tool usage)
- blog.ovilgroup.com (installation walkthrough, prerequisites)
-->

Before you can use GitHub Spec Kit to practice spec-driven development, you need to set up your environment. This unit covers the prerequisites, installation process, and configuration steps to get GitHub Spec Kit running in your development environment.

## Prerequisites and system requirements

Before installing GitHub Spec Kit, ensure you have the following:

### Operating system

- **Linux or macOS:** These are the recommended operating systems
- **Windows:** Use Windows Subsystem for Linux 2 (WSL2) since GitHub Spec Kit expects a Unix-like environment

### Required software

- **Python 3.11 or later:** GitHub Spec Kit's CLI is a Python tool
- **Git:** Required for version control integration and pulling the toolkit
- **uv tool:** GitHub Spec Kit uses the `uv` (universal virtual environment) tool for installation. If you haven't used `uv` before, it's a modern package manager CLI that can install tools directly from GitHub

### AI coding assistant

You need at least one supported AI coding assistant set up and working. GitHub Spec Kit supports:

| Agent | Environment | Slash Command Support |
|-------|-------------|----------------------|
| GitHub Copilot | Visual Studio Code | Yes |
| Claude Code | CLI / IDE | Yes |
| Cursor | Cursor IDE | Yes |
| Windsurf | Windsurf IDE | Yes |
| Amazon Q Developer | CLI / IDE | Yes |
| Gemini CLI | CLI | Yes |
| And others | Various | Varies |

For this module and the lab exercise, we use **Visual Studio Code with GitHub Copilot**. Ensure the GitHub Copilot extension is installed, enabled, and you're signed in with an active subscription.

## Installing the uv tool

If you don't already have `uv` installed, you can install it using one of these methods:

**On macOS and Linux:**

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

**On Windows (in PowerShell):**

```powershell
powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
```

After installation, restart your terminal to ensure `uv` is available in your PATH.

## Installation methods

There are two main ways to install GitHub Spec Kit's `specify` CLI tool:

### Method 1: Global installation (recommended)

The recommended approach is to install `specify-cli` globally using `uv`. This makes the `specify` command available in any project.

```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

**Benefits of global installation:**
- Available in any project directory
- Easy to update using `uv tool upgrade specify-cli`
- No need to re-run installation commands each time

### Method 2: One-time usage (no install)

If you prefer not to install globally, you can run GitHub Spec Kit directly using `uvx`:

```bash
uvx --from git+https://github.com/github/spec-kit.git specify init
```

This downloads and runs GitHub Spec Kit for that single invocation. It's useful for:
- Trying out GitHub Spec Kit before committing to installation
- Running on systems where you can't install globally (like some CI servers)

The drawback is that you need to prefix commands with the full `uvx --from ...` each time, which is less convenient for regular use.

## Verifying your installation

After installing, verify that GitHub Spec Kit is working correctly:

```bash
specify check
```

This command checks for required tools and confirms installation succeeded. It will report:
- Whether Git is found and configured
- Whether your AI coding assistant is detected
- Any missing dependencies or configuration issues

If `specify check` reports issues, address them before proceeding.

## Setting up Visual Studio Code with GitHub Copilot

For the lab exercise in this module, you'll use Visual Studio Code with GitHub Copilot. Follow these setup steps:

### Step 1: Install Visual Studio Code

Download and install Visual Studio Code from [code.visualstudio.com](https://code.visualstudio.com) if you haven't already.

### Step 2: Install GitHub Copilot extension

1. Open Visual Studio Code
2. Go to the Extensions view (Ctrl+Shift+X or Cmd+Shift+X)
3. Search for "GitHub Copilot"
4. Install the GitHub Copilot extension
5. Sign in with your GitHub account that has an active GitHub Copilot subscription

### Step 3: Verify GitHub Copilot is working

Open a new file and start typing some code. GitHub Copilot should provide inline suggestions. You can also open the GitHub Copilot Chat panel to verify chat functionality is working.

### Step 4: Open the integrated terminal

You'll run `specify` commands in Visual Studio Code's integrated terminal:
1. Open Terminal (Ctrl+` or View → Terminal)
2. Navigate to your project directory
3. Run `specify check` to verify everything is configured

## Installing for other environments

If you're not using Visual Studio Code, the process is similar:

### Claude Code

1. Install `specify-cli` globally as described above
2. Open Claude's interface in your project folder
3. Type slash commands (`/speckit.specify`, etc.) directly in the chat

### Cursor

1. Install `specify-cli` globally
2. Open your project in Cursor
3. Ensure the AI agent is running
4. Use slash commands in Cursor's AI chat interface

### Other AI tools

Most supported AI coding assistants follow the same pattern:
1. Install the `specify-cli` globally
2. Open your project in your preferred environment
3. Use the slash commands in that tool's AI chat interface

Check the GitHub Spec Kit README's "Supported AI Agents" table for any tool-specific considerations.

## Troubleshooting common issues

### uv command not found

If `uv` isn't recognized after installation:
- Close and reopen your terminal
- Ensure the installation directory is in your PATH
- On Windows, you may need to restart your computer

### specify command not found

If `specify` isn't found after installation:
- Close and reopen your terminal
- Check that `~/.local/bin` (or the uv tool bin directory) is in your PATH
- Try running `uv tool list` to see if specify-cli appears

### AI tool not detected

If `specify check` reports your AI tool isn't found:
- Ensure the AI tool is installed and running
- For Visual Studio Code with GitHub Copilot, ensure the extension is installed and you're signed in
- Check that you're running the check from a terminal where the AI tool is accessible

### Windows-specific issues

If you're on Windows and experiencing issues:
- Ensure you're using WSL2 (Windows Subsystem for Linux 2)
- Run commands from within WSL, not from PowerShell or Command Prompt
- Install prerequisites (Python, uv, Git) within WSL

For issues beyond these common problems, consult the GitHub Spec Kit README and community resources on the GitHub repository.

## Summary

To install GitHub Spec Kit:

1. **Install prerequisites:** Python 3.11+, Git, and the uv tool
2. **Run the install command:** `uv tool install specify-cli --from git+https://github.com/github/spec-kit.git`
3. **Verify installation:** Run `specify check` to confirm everything is working
4. **Set up your AI tool:** Ensure Visual Studio Code with GitHub Copilot (or your preferred AI assistant) is ready

With these steps complete, you're ready to use GitHub Spec Kit. In the next unit, you'll learn about the specific commands and see what outputs they produce.
