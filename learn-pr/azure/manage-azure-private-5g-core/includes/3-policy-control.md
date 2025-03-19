Enterprises use their private mobile networks to attach various user equipment (UE) devices. Each UE uses a SIM or eSIM to identify and authenticate itself to the network.

To effectively manage the network traffic between the UEs and the data networks (DNs), Azure Private 5G Core allows you to define SIM policies that are applied to the SIMs. SIM policies ensure that the network requirements of each UE are satisfied and the packet flows from each UE are appropriately controlled.

Azure Private 5G Core also allows you to define services, which are sets of rules for network traffic handling. With separately defined services and SIM policies, you have the flexibility to reuse a service in one or more SIM policies.

This unit introduces you to the policy control tasks, like SIM policy configuration or service configuration.

> [!NOTE]
> To design and configure services and SIM policies, you need to be familiar with network traffic at the packet level.

## Video: SIM Policy Configuration

The following video provides an overview of how to configure SIM policies in Azure Private 5G Core:

> [!VIDEO ad0ba484-74ac-44b6-9e90-a4d45830b93f]

## Network traffic control

In a private mobile network, packet core instances are responsible for handling the network traffic between UEs and DNs. Azure Private 5G Core allows you to use services and SIM policies to control the network traffic at the packet level.

### How a packet core instance controls network traffic

To use services and SIM policies effectively, you need to understand how a packet core instance controls network traffic in a private mobile network first.

In 5G networks, the packet core instance is a key component in establishing protocol data unit (PDU) sessions, which are used to transport user plane traffic between a UE and a DN. Within each PDU session, there are one or more service data flows (SDFs). Each SDF is a single IP flow or a set of aggregated IP flows of UE traffic for a specific service.

Each SDF might require a different set of quality of service (QoS) characteristics, including prioritization and bandwidth limits. For example, an SDF carrying traffic used for industrial automation needs to be handled differently to an SDF used for internet browsing.

To ensure the correct QoS characteristics are applied, each SDF is bound to a QoS flow. Each QoS flow has a unique QoS profile, which identifies the QoS characteristics that should be applied to any SDFs bound to the QoS flow. Multiple SDFs with the same QoS requirements can be bound to the same QoS flow.

The following diagram shows an example PDU session:

:::image type="content" source="../media/pdu-qos-example.png" alt-text="An diagram that shows an example PDU session." border="true":::

In the preceding example, **IP flow 1** and **IP flow 2** are assigned to **SDF 1** and **SDF 2** respectively, because they're for different services. However, **SDF 1** and **SDF 2** require the same QoS characteristics, so we bind them to the same QoS flow, **QoS flow 1**. **QoS profile 1** defines the QoS characteristics of **QoS flow 1**.

In 4G networks, the packet core instance helps to establish packet data network (PDN) connections to transport user plane traffic. PDN connections also contain one or more SDFs. The SDFs are bound to Evolved Packet System (EPS) bearers. EPS bearers are also assigned a QoS profile. Each EPS bearer is assigned an EPS bearer ID (EBI), which is used by network elements to map SDFs to EPS bearers.

For more information about these concepts, see relevant 4G or 5G documentation.

### Using services and SIM policies for network traffic control

Azure Private 5G Core allows you to define the QoS flows that the packet core instance creates and binds to the SDFs, when establishing PDU sessions or PDN connections. You can configure two primary resource types - services and SIM policies.

A service is a representation of a set of QoS characteristics you apply to SDFs that match specific properties, such as their destination or the protocol used. You can also use services to limit or block SDFs based on these properties.

Each service includes:

- One or more data flow policy rules identifying the SDFs to which the service should be applied.
- An optional set of QoS characteristics that should be applied on SDFs matching the service. The packet core instance uses these characteristics to create a QoS flow or EPS bearer to bind to matching SDFs.

A SIM policy defines a set of interoperability settings that can be assigned to one or more SIMs.

Each SIM policy includes:

- Top-level settings that are applied to every SIM using the SIM policy.
- A network scope that defines the network slice and DN to which the SIM policy applies.

  You can use the network scope to determine the services offered to SIMs on the DN and the set of QoS characteristics. These characteristics are used to form the default QoS flow for PDU sessions, or EPS bearer for PDN connections in 4G networks.

In each SIM policy, you can specify how the network traffic from relevant UEs should be controlled on a per slice and DN basis. The following diagram shows how the network traffic is controlled with different slices and DNs.

:::image type="content" source="../media/policy-slice-dn.png" alt-text="A diagram that shows two UEs connecting to two DNs using two different slices." border="true":::

As shown in the diagram, UE 1 uses slice 1 and DN 2, while UE 2 uses slice 2 and DN 1. The SIM policies used by UE 1 and UE 2 respectively specify the slices and DNs to be used.

For more information about controlling the network traffic in a private mobile network, see [Policy control](/azure/private-5g-core/policy-control).

## Manage services and SIM policies

Before using UEs in your private mobile network, you need to define SIM policies and assign them to UEs appropriately. You can also use the [default service](/azure/private-5g-core/default-service-sim-policy) and SIM policy that you create when you first create a private mobile network.

### Design policy control configuration

When you first design the policy control configuration for a private mobile network, we recommend that you take the following approach:

1. Provision the SIMs.
1. Identify the SDFs that the private mobile network needs to handle.
1. Learn about each of the available options for a service. then, compare these options with the requirements of the SDFs to decide on the services you need.
1. Collect the appropriate policy configuration values you need for each service.
1. Configure each service.
1. Categorize the SIMs according to the services they require. For each category, configure a SIM policy and assign it to the correct SIMs.

For details, see [Policy control](/azure/private-5g-core/policy-control).

### Configure a service through the Azure portal

A service is a representation of a particular set of QoS information that you want to offer to the UE. For example, you might want to configure a service that provides higher bandwidth limits for particular traffic.

To create a new service, take these steps:

1. Collect all the [configuration values](/azure/private-5g-core/collect-required-information-for-service) for the service.
1. Open the **Mobile Network** resource representing the private mobile network for which you want to create the service.
1. Select **Services** from the resource menu, and then select the **Create** button.

   The **Create a service** screen is displayed, as shown in the following screenshot:

   :::image type="content" source="../media/sim-create-a-service.png" alt-text="A screenshot showing an example service creation screen." border="true":::

1. Specify appropriate values for each field.

   To configure the data flow policy rules you want to use for this service, select the **Add a policy rule** button. You can add multiple policy rules for a service.

To modify or delete an existing service, take these steps:

1. Open the **Mobile Network** resource representing the private mobile network for which you want to modify or delete the service.
1. Select **Services** from the resource menu.
1. Proceed with one of the following operations:

   - To modify a service, select it, and then select **Modify service**.
   - To delete a service, select it, and then select **Delete**.

For detailed instructions on configuring a service, see [Configure a service for Azure Private 5G Core](/azure/private-5g-core/configure-service-azure-portal).

### Configure a SIM policy through the Azure portal

A SIM policy defines a set of interoperability settings that can be assigned to one or more SIMs. It also defines the default QoS settings for any services that the policy uses. You need to assign a SIM policy to a SIM before the UE using that SIM can access the private mobile network.

To create a new SIM policy, take these steps:

1. Collect all the [configuration values](/azure/private-5g-core/collect-required-information-for-sim-policy) for the policy.
1. Open the **Mobile Network** resource representing the private mobile network for which you want to create the SIM policy.
1. Select **SIM policies** from the resource menu, and then select the **Create** button.

   The **Create a SIM policy** screen is displayed, as shown in the following screenshot:

   :::image type="content" source="../media/sim-create-a-sim-policy.png" alt-text="A screenshot showing an example SIM policy creation screen." border="true":::

1. Specify appropriate values for each field.

   To configure the network scope you want to use for this policy, select the **Add a network scope** button. SIM policies also define the default QoS settings for any services that they use. You can override the default QoS settings on a per-service basis.

> [!TIP]
> At the end of the SIM policy creation process, you can optionally assign the SIM policy to one or more provisioned SIMs.

To modify or delete an existing SIM policy, take these steps:

1. Open the **Mobile Network** resource representing the private mobile network for which you want to modify or delete the SIM policy.
1. Select **SIM policies** from the resource menu.
1. Proceed with one of the following operations:

   - To modify a SIM policy, select it, and then select **Modify the selected SIM policy**.
   - To delete a SIM policy, select it, and then select **Delete**.

For detailed instructions on configuring a SIM policy through the Azure portal, see [Configure a SIM policy - Azure portal](/azure/private-5g-core/configure-sim-policy-azure-portal).

### Configure a service and a SIM policy through an ARM template

If you're familiar with ARM templates, you can create an ARM template that specifies the services and SIM policies you want to create, and then use the template to create all the resources in one go.

From the [Azure Private 5G Core REST API](/rest/api/mobilenetwork/) document, you can get a list of fields that you need to specify for a service or a SIM policy. Because the Resource Manager converts a template into REST API operations when you deploy the template, the parameters in the API requests are the same as the fields in the ARM template. For example, for a service, you can find information about the `servicePrecedence` field in the Azure REST API article [Services - Create or update](/rest/api/mobilenetwork/services/create-or-update).

For details about the fields for a service, see [Services](/rest/api/mobilenetwork/services). For details about the fields for a SIM policy, see [SIM policies](/rest/api/mobilenetwork/sim-policies).

The article [Configure a service and SIM policy using an ARM template](/azure/private-5g-core/configure-service-sim-policy-arm-template) provides an ARM template example, with which you can deploy a service and a SIM policy.
