
 To deploy Defender for IoT for OT monitoring in your car manufacturer across global locations requires planning. You'll want to consider what traffic to monitor across various systems and sites in your organization. Sites could include offices responsible for design and plants with pneumatic  and packaging systems. Also, you'll want to know the teams and roles to involve in the different phases of deployment. This unit describes the process to deploy Defender for IoT.

## Defender for IoT for OT deployment path

The image depicts an OT monitoring deployment path, with the team responsible for each phase:
:::image type="content" source="../media/2-ot-deploy.png" alt-text="Diagram of an OT deployment path." border="false":::

The phases include:

- Plan and prepare, done by your architecture teams
- Onboard your planned sensors, done by your deployment teams
- Site networking setup, done by your connectivity teams
- Deploy sensors, done by your deployment teams
- Calibrate and fine-tune, done by your deployment teams

At the end of your deployment, baseline learning ends with a set of learned network traffic, and operation mode begins.

## Plan and prepare

:::image type="content" source="../media/2-plan-prepare.png" alt-text="Diagram of the planning and preparing path." border="false":::

### OT site deployment planning

You and your architecture team (such as the network architect and OT engineers) should prepare to deploy Defender for IoT across your organization. Recall that you're planning to deploy sensors across many distinct types of locations globally, including offices and distinct manufacturing systems. Planning includes thinking about:

- **Sites and zones**: How can you segment the networks you want to monitor across your auto manufacturing organization's global locations into different geographical and logical areas?

- **Sensor management**: The example in this learn module assumes a cloud-connected sensor system. What sensor connection methods do you need (such as a direct connection or via a proxy)?

- **Users and roles**: Given the distinct locations and sensor connections, what types of users and user roles are needed on each sensor?

### OT site deployment preparation

While planning for your organization, identify and make notes about the following items:

- **A network diagram**, including:
    - Your overall monitoring goals for your manufacturing organization.
    - What areas of your network to connect.
    - What devices there are and how they communicate.
    - Your security and operational risks, and the most interesting traffic for those risks.

    Create a full list of monitored devices, subnets, switches, vendors, and protocols for verification.

- **A list of sensors**, including:
    - The sensors your organization needs.
    - How you might segment your network into different geographical and logical areas.

    Based on the list of traffic, monitored devices, and subnets, make a list of the OT sensors needed and where to place them in your network.

- **Traffic mirroring methods**, including:
    - What and where your organization's switch port types are.
    - How to manage your unmanaged switches.
    - Whether you use broadcast or multicast messaging.
    - The traffic mirroring method that best fits your switch port types.

    Choose a traffic mirroring method for each OT sensor, such as a SPAN port or TAP.

- **Appliances**, including:
    - Given the OT sensors needed, the profiles needed for your appliances.
    - The preconfigured appliances and ancillary hardware needed.
    - The deployment workstation and any hardware or virtual machines for your deployment.

    Order any preconfigured appliances and hardware that you intend to use.

## Onboard your planned sensors

:::image type="content" source="../media/2-onboard-sensors.png" alt-text="Diagram of an onboard sensors path." border="false":::

With your deployment teams, onboard your OT sensors with Defender for IoT on the Azure portal.

In the onboarding phase, make sure to:

- Assign sites and zones for different geographic and logical areas based on your sensor plans.
- Download and save each OT sensor's activation file.

Your onboarding team, which can include IoT and OT engineers, needs appropriate Azure roles, such as Admin or Security Admin, to complete onboarding and management tasks.

## Site networking setup

:::image type="content" source="../media/2-site-networking-setup.png" alt-text="Diagram of a site networking setup path." border="false":::

In the site networking setup phase, you and your connectivity teams will:

- Configure traffic mirroring in your network based on your plan.
- Provision for cloud management by ensuring that firewall rules permit connection to the Azure portal.

## Deploy sensors

:::image type="content" source="../media/2-deploy-sensors.png" alt-text="Diagram of a sensor deployment path." border="false":::

In the sensor deployment phase, you and your deployment teams:

- Download and install Defender for IoT on your OT sensors, if you're installing the software yourself. If you're ordering preconfigured appliances, you can skip this step.
- Activate your OT sensors, perform the initial setup with the setup wizard, and install SSH/TLS certificates.
- Configure a proxy connection, if relevant.

## Calibrate and fine-tune

:::image type="content" source="../media/2-calibrate-fine-tune.png" alt-text="Diagram of a calibration and fine-tuning path." border="false":::

You and your deployment teams do the following in the calibration and fine-tuning phase:

- Control OT monitoring on your sensor by ensuring networks are monitored and identified as desired. Configure the subnets, customize port and VLAN names, and configure DHCP address ranges as needed.
- Verify and update your detected device inventory.
- Learn OT alerts as authorized traffic to create a network baseline. Review all the alerts in your system to create your initial baseline.

## Baseline learning ends

:::image type="content" source="../media/2-baseline-learning-ends.png" alt-text="Diagram of the baseline learning ends path." border="false":::

Once your sensor is no longer regularly detecting new traffic and you no longer have unhandled alerts, your learning phase ends and the operational mode for ongoing monitoring begins.

In the next units you'll identify the types of sites and zones appropriate for your auto manufacturer, determine the best connection to the cloud for your needs, and identify the types of user roles your team members will need.  

## Knowledge check
