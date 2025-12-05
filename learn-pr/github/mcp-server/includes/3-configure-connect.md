In this unit, you'll learn how to set up and use GitHub MCP Server in Visual Studio Code so you can bring AI-powered workflows directly into your development environment. You'll learn:

- How to set up using OAuth or a Personal Access Token (PAT)

- Optional local setup using Docker for more control

- How to use GitHub MCP Server with Copilot Chat for AI-powered productivity

- Common troubleshooting steps 

## Set up GitHub MCP Server in VS Code

### Use OAuth

Now that you know what GitHub MCP Server can do, let's walk through how to set it up in Visual Studio Code so you can start using it immediately. This will let you integrate your preferred AI-powered workflows directly into your coding environment without complex setup. 

1. In Visual Studio Code, open the Command Palette by pressing Ctrl+Shift+P (Windows/Linux) or Cmd+Shift+P (Mac).
1. Type MCP: add server and press Enter.
1. From the list, select **HTTP (HTTP or Server-Sent Events)**.
1. In the **Server URL** field, enter https://api.githubcopilot.com/mcp/, then press Enter.
1. When prompted to enter a **Server ID**, you can press Enter to use the default or type a custom ID if you prefer.
1. Choose where you would like to save your MCP Server configuration. You can add it to your user settings to use across all projects or to your workspace settings for the current project.
1. A prompt will appear asking you to authorize with GitHub using OAuth. Select **Allow** and sign in to your GitHub account if prompted.

After setup, GitHub MCP Server will be ready to use with your projects in VS Code. You can now start using AI-powered tools and workflows to automate tasks, manage issues, and analyze your code directly within your editor, helping you stay focused on your work while GitHub MCP Server handles the heavy lifting in the background.

### Use Personal Access Token

In order to use Personal Access Token (PAT) for advanced control, you can follow these steps:

1. Create a PAT with repo and read: packages scope in your GitHub account.
1. You'll follow the same steps above, but cancel OAuth when prompted.
1. In your configuration file, add:

    ```json
    "headers": {
      "Authorization": "Bearer ${input:github_token}"
    }
    ```

1. Next, add an input prompt to securely enter your token:

    ```json
    "inputs": [
      {
        "id": "github_token",
        "type": "promptString",
        "description": "GitHub Personal Access Token",
        "password": true
      }
    ]
    ```

1. Finally, restart the MCP server in VS Code and enter your PAT when prompted.
1. The MCP server will now be configured to use the PAT for authorization.

## Local MCP Server setup with Docker (Optional)

If your enterprise uses GitHub Enterprise Server with PAT restrictions, you can only access the API scopes allowed by your organization's policy. If all endpoints are restricted, the MCP Server won't be available, check with your admin if you're unsure.

For local use, the MCP Server requires Docker and authentication with a Personal Access Token (PAT). OAuth isn't supported in this setup.

1. First you need to confirm that Docker is installed and running on your system.
1. Next, generate a PAT with the necessary scopes.
1. Use the following configuration to run the server locally:   

    ```json
    {
      "inputs": [
        {
          "type": "promptString",
          "id": "github_token",
          "description": "GitHub Personal Access Token",
          "password": true
        }
      ],
      "servers": {
        "github": {
          "command": "docker",
          "args": [
            "run",
            "-i",
            "--rm",
            "-e",
            "GITHUB_PERSONAL_ACCESS_TOKEN",
            "ghcr.io/github/github-mcp-server"
          ],
          "env": {
            "GITHUB_PERSONAL_ACCESS_TOKEN": "${input:github_token}"
          }
        }
      }
    }
    ```

1. Restart the MCP server and enter your PAT when prompted to complete the setup.

## Troubleshooting

If you encounter issues while using GitHub MCP Server, here are some practical checks:

- Confirm that you're signed into your GitHub account within VS Code.
- If using a PAT, ensure it has the correct scopes and is entered correctly.
- Double-check your configuration for any typos or missing fields.
- If using Docker, ensure it's installed and actively running.
- Try restarting VS Code or the MCP Server to resolve temporary connection issues.
