## Revert .NET Core SDK changes

The setup script installs a newer version of the .NET Core SDK, alongside the default SDK version of Cloud Shell. You can choose to keep this configuration. To revert to your prior configuration, run the following command:

```bash
cp ~/.bashrc.bak.microservices-aspnet-core ~/.bashrc
```

The preceding command restores your prior *:::no-loc text=".bashrc":::* profile startup file from a backup saved by the setup script.
