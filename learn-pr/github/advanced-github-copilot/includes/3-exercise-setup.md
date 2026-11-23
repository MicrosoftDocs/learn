:::image type="content" source="../media/03-exercise-setup.svg" alt-text="Diagram providing an overview of the important concepts in this unit.":::

In this exercise, you'll open a codespace for the provided Python web API repository. You can experiment in this environment without first creating your own repository.

## Environment setup

First, launch the Codespaces environment, which comes preconfigured with the GitHub Copilot extension. Review the machine type, payer, remaining allowance, and spending controls before creating the codespace.

> [!IMPORTANT]
> Personal GitHub Free accounts include 120 Codespaces core-hours and 15 GB-month of storage each month. On a two-core machine, 120 core-hours is 60 hours of running time, provided you haven't used any of that allowance elsewhere. Personal GitHub Pro accounts have a different allowance. Organization and enterprise plans don't include a free Codespaces quota.

The [Codespaces billing documentation](https://docs.github.com/en/billing/concepts/product-billing/github-codespaces) describes current allowances and charges. After reviewing your account's settings, create the environment:

1. Open the [codespace with the preconfigured environment](https://codespaces.new/MicrosoftDocs/mslearn-advanced-copilot?azure-portal=true) in your browser.
2. On the **Create codespace** page, review the configuration settings, then select **Create new codespace**.
3. Wait for container setup and extension installation to finish. This process can take a few minutes.

The remaining exercises take place in this development container. Use the Python environment already configured for the project rather than creating a second environment.

The launch link opens a codespace associated with the provided repository. If you have read access and permission to fork, Codespaces can create or link a fork under your account when you commit or push a new branch. Follow the fork prompt if one appears. A commit stored only in the codespace isn't a backup on GitHub.

## Enable GitHub Copilot

Sign in to VS Code with the GitHub account that has your Copilot access. If you don't have access yet, enable Copilot Free or use an eligible plan provided by your organization. Select **Chat** in the title bar, then **Open Chat**, and confirm that you can send a request before continuing.

You don't need to purchase a paid Copilot plan just to start this exercise. Copilot Free includes limited usage, including 2,000 monthly code completions and an allowance of AI credits. Check your current allowance before starting. Feature availability and usage depend on your account and organization policies. See [Copilot plans](https://docs.github.com/en/copilot/get-started/plans) for current details.

Verified students can activate [Copilot Student through GitHub Education](https://docs.github.com/en/copilot/how-tos/copilot-on-github/set-up-copilot/enable-copilot/set-up-for-students). Verified teachers and eligible maintainers of popular open-source projects may qualify for [Copilot Pro at no cost](https://docs.github.com/en/copilot/how-tos/copilot-on-github/set-up-copilot/enable-copilot/set-up-for-teachers-and-os-maintainers). Eligibility and activation requirements differ.

## Run the Python web API

The container installs the project requirements into its configured Python environment. When you attach to the codespace, the configured startup command runs Uvicorn on port 8000 with automatic reload.

1. Check the startup terminal for successful application startup. If an error appears, resolve it before continuing. A port entry alone doesn't prove the application is running.
2. Open the **Ports** view and locate port **8000**, labeled **Application**.
3. Open that port in your browser and keep its visibility **Private**. The application's root redirects to its interactive API documentation at `/docs`.

The server is normally already running. Don't start a second copy on port 8000. Saved Python changes trigger the configured reload. If you need to restart the server manually, stop its existing process with **Ctrl+C** in the terminal running it before starting another copy.

After the previous server has stopped, run this recovery command from the repository root in the Codespace:

```bash
/home/vscode/venv/bin/python -m uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```

Use the forwarded application URL in your browser, not your own computer's `localhost:8000`. For more information, see [forwarding ports in your codespace](https://docs.github.com/en/codespaces/developing-in-a-codespace/forwarding-ports-in-your-codespace).
