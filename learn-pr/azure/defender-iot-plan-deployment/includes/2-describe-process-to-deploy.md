
 To implement Defender for IoT for OT monitoring in your car manufacturer, across global locations, requires planning. You'll want to consider what traffic to monitor across various systems and sites in your organization. Sites could include offices responsible for design and plants with pneumatic and packaging. Also, you'll want to know the teams and roles to involve in the different phases of deployment.

## Defender for IoT for OT deployment path

The image depicts an OT monitoring deployment path, with the team responsible for each phase that your organization could plan:
:::image type="content" source="../media/2-ot-deploy.png" alt-text="Diagram of an OT deployment path.":::

The phases include:

- Plan and prepare (architecture teams)
- Onboard your planned sensors (deployment teams)
- Site networking setup (connectivity teams)
- Deploy sensors (deployment teams)
- Calibrate and fine-tune (deployment teams)
- Baseline learning ends

## Plan and prepare

:::image type="content" source="../media/2-plan-prepare.png" alt-text="Diagram of the planning and preparing path.":::

### OT site deployment planning

You and your architecture team (such as the network architect, OT engineers) should prepare to deploy Defender for IoT for OT monitoring across your organization. Recall that you're planning to deploy sensors across many distinct types of locations globally including offices and distinct manufacturing systems. Planning includes thinking about:

- **Sites and zones**: How can you segment the networks you want to monitor using sites and zones representing locations in your auto manufacturing organization's global locations?
- **Sensor management**: Do cloud-connected, air-gapped locally managed, or a hybrid OT sensor system make the most sense to monitor your systems? This case assumes a cloud-connected sensor system. In a cloud-connected system, what connection methods do you need (such as a direct connection or via a proxy)?
- **Users and roles**: Given the distinct locations and sensor connections, What types of users and user roles are needed on each sensor?

<!--should a sample network image be included from here https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/best-practices/sample-connectivity-models Does the deployment planning need to be reiterated if in the intro? -->

### OT site deployment preparation

While planning for your organization, prepare the following items:

- **A network diagram**: What are your overall monitoring goals for your manufacturing organization? Where should you connect? What devices are there and how do they communicate? What are the security and operational risks and the most interesting traffic for those risks? Create a full list of monitored devices, subnets, switches, vendors, and protocols for verification.
- **A list of sensors**: What sensors will your organization need? What sites and zones would be appropriate to assign? Based on the list of traffic, monitored devices, and subnets, make a list of the OT sensors needed and where to place them in your network.
- **Traffic mirroring methods**: What and where are all the switch port types used in your organization and what connector media do you need? How should you deal with unmanaged switches? Is there rack space for a collector? Do you use broadcast or multicast messaging? Which traffic mirroring method best fits your switch port types? Choose a traffic mirroring method for each OT sensor, such as a SPAN port or TAP.
- **Appliances**: Given the OT sensors needed, what appliances profiles are needed? What preconfigured appliances and what ancillary hardware do you need? Prepare a deployment workstation and any hardware or virtual machines needed. Order any preconfigured appliances and hardware that you intend to use.

## Onboard your planned sensors

:::image type="content" source="../media/2-onboard-sensors.png" alt-text="Diagram of an onboard sensors path.":::

 With your deployment teams, onboard your OT sensors with Defender for IoT on the Azure portal based on your plans for sensors and assigned zones. Download and save each OT sensor's activation file. Your onboarding team, which can include IoT and OT engineers, would need appropriate Azure account permissions, such as Admin or Security Admin to complete onboarding and management tasks.

## Site networking setup

:::image type="content" source="../media/2-site-networking-setup.png" alt-text="Diagram of a site networking setup path.":::

In the site networking setup phase, you and your connectivity teams will:

- Configure traffic mirroring in your network based on your plan.
- Provision for cloud management by ensuring that firewall rules permit connection to the Azure portal.

## Deploy sensors

:::image type="content" source="../media/2-deploy-sensors.png" alt-text="Diagram of a sensor deployment path.":::

In the sensor deployment phase, you and your deployment teams:

- Download and install Defender for IoT on your OT sensors as well as validate and calibrate the installation.
- Activate your OT sensors, perform the initial setup with the setup wizard, and install SSH/TLS certificates.
- Configure a proxy connection, if relevant.

## Calibrate and fine-tune

:::image type="content" source="../media/2-calibrate-fine-tune.png" alt-text="Diagram of a calibration and fine-tuning path.":::

You and your deployment teams do the following in the calibration and fine-tuning phase:

- Control OT monitoring on your sensor by ensuring networks are monitored and identified as desired. Configure the subnets, customize port and VLAN names, and configure DHCP address ranges as needed.
- Verify and update your detected device inventory
- Learn OT alerts as authorized traffic to create a network baseline. Review all the alerts in your system to create an initial baseline.

## Baseline learning ends

:::image type="content" source="../media/2-baseline-learning-ends.png" alt-text="Diagram of the baseline learning ends path.":::

Once you no longer detect new traffic or have unhandled alerts your learning phase ends, the operational mode for ongoing monitoring begins.

In the next units you'll identify the sites and zones appropriate for your auto manufacturer, determine the best connection to the cloud for your needs, and identify the user roles your team members will need.  

## Knowledge check
