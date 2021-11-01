> [!NOTE]
> Nonblocking warnings are expected in the deployment process. An unexpected exception might occur, or the script might enter a `Retrying in 5s...` loop with no sign of exiting. In the event of an exception, or if the loop has been running for about five minutes, reset any changes that the script has made. 
>
> Select <kbd>Ctrl+C</kbd> (<kbd>⌘+C</kbd> on macOS) to stop the script. Then run the following command:
>
> ```azurecli
> cd ~ && \
>   rm -rf ~/clouddrive/aspnet-learn && \
>   az group delete --name eshop-learn-rg --yes
> ```
>
> You can then re-run the setup script.
