To start, install the Bicep CLI or the [Visual Studio Code Extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). Having both installed will give you a great authoring experience.

## Installing the VS Code extension

The extension provides language support, IntelliSense, and linting support.

:::image type="content" source="../media/bicep-extension-f990a375.png" alt-text="Screenshot of Bicep extension from VS Code marketplace.":::


To verify you've it installed, create a file with the `.bicep` extension and watch the language mode change in the lower right corner of VS Code.

## Installing Bicep CLI

You need to have Azure CLI version **2.20.0** or later installed to be able to install the Bicep CLI. When you're ready, run the install command:

```azurecli
az bicep install
```

You can upgrade the Bicep CLI by running the `az bicep upgrade,` and for validating the installation, use the `az bicep version`.

We deliberately avoided breaking down the installation for Windows, macOS, and Linux since Azure CLI is cross-platform, and the steps would be the same.

## Manual installation

You can manually install it if you don't have Azure CLI installed but still want to use Bicep CLI.

### Windows

You can use Chocolatey or Winget to install the Bicep CLI:

```azurecli
choco install bicep
winget install -e --id Microsoft.Bicep
bicep --help
```

:::image type="content" source="../media/bicep-cli-windows-aafe9494.png" alt-text="Screenshot of the Bicep C L I for Windows with the version output.":::


### Linux

To install the Bicep CLI on Linux manually, use the below script:

```Bash
curl -Lo bicep https://github.com/Azure/bicep/releases/latest/download/bicep-linux-x64
chmod +x ./bicep
sudo mv ./bicep /usr/local/bin/bicep
bicep --help
```

### macOS

And for macOS, use homebrew or the previous script for Linux:

```Bash
brew tap azure/bicep
brew install bicep
bicep --version
```

## Troubleshooting the installation

If any errors or issues were faced during the installation, make sure you visit the [troubleshooting guide](/azure/azure-resource-manager/bicep/installation-troubleshoot/) on Azure Bicep documentation.

## Next steps

In the next unit, you'll create your first Bicep template and deploy it to Azure.
