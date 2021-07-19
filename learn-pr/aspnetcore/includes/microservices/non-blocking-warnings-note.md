> [!NOTE]
> Nonblocking warnings are expected in the deployment process. An unexpected exception might occur, or the script might enter a `Retrying in 5s...` loop with no sign of exiting. In the event of an exception, or if the loop has been running for about 5 minutes, reset any changes made by the script. 
>
> Select <kbd>Ctrl+C</kbd> (<kbd>⌘+C</kbd> on macOS) to stop the script. Then run the following command:
>
> ```azurecli
> cd ~ && \
>   rm -rf ~/clouddrive/aspnet-learn && \
>   az group delete --name eshop-learn-rg --yes
> ```
>
> You cn then re-run the setup script.
