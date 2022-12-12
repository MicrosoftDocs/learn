Azure Automanage machine best practices eliminates the need to discover and know how to onboard and configure certain Azure services to benefit your virtual machines. These Azure services help enchance reliability, security, and management for virtual machines.

Azure Automanage machine best practices provide the following benefits:

- Intelligently onboards virtual machines to select best practices Azure services
- Automatically configures each service per Azure best practices
- Supports customization of best practice services
- Monitors for drift and corrects for it when detected
- Provides a simple experience (point, click, set, forget)

Both Windows Server and Linux virtual machines can use Azure Automanage. Azure Automanage can even be used on Arc-enabled servers to extend these best practices services to machines hosted outside of Azure.

## Participating services

After onboarding your machines to Azure Automanage, each best practice service is configured to its recommended settings. The diagram below shows the types of services that can be configured for your virtual machines using Azure Automanage best practices.

:::image type="content" source="../media/intelligently-onboard-services-1.png" alt-text="Diagram of intelligently onboard services.":::

Your VMs will be automatically onboarded to these participating services when you use the best practices configuration profiles. Participating services include the following:





NOTE!


## Configuration profiles

Configuration profiles are the foundation of Azure Automanage best practices. They define which services are onboarded for your machines and, to some extend, what the configuration of those services will be.

If you want to customize the best practice services and settings, you can use the custom profile option. Custom profiles allow you to customize the services and settings that you want to apply to your machines. This is a great option if your IT requirements differ from the best practices. For instance, if you do not want to use the Microsoft Antimalware solution because your IT organization requires you to use a different antimalware solution, then you can simply toggle off Microsoft Antimalware when creating a custom profile.

## Automanage machine statuses

You can view the overall status of all your Azure Automanage machines from the **Automanage machine best practices** page in the Azure portal:

:::image type="content" source="../media/configured-status.png" alt-text="Screenshot of a list of automanaged enabled virtual machines." lightbox="../media/configured-status.png":::

The page lists the following details for each machine listed: Name, Configuration profile, Status, Resource type, Resource group, Subscription

