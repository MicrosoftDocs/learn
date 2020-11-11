> [!NOTE]
> Non-blocking warnings are expected in the deployment process. If an unexpected exception occurs, you can reset any changes made by the script by running the following command:
>
> ```azurecli
> cd ~ && \
>   rm -rf ~/clouddrive/aspnet-learn && \
>   az group delete --name eshop-learn-rg --yes
> ```
