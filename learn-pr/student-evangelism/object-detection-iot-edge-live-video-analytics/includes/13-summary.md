The employee safety scenario showed how an organization might use edge video analytics to detect a person near a machine and reduce safety risk. The original module implemented that scenario with Live Video Analytics on IoT Edge, the archived Vision on Edge sample, Azure Media Services, and Custom Vision.

> [!IMPORTANT]
> That implementation is no longer a supported current learning path. Live Video Analytics client packages are no longer maintained, Azure Video Analyzer Edge is retired, Azure Media Services retired on June 30, 2024, and the Vision on Edge sample repository is archived. Custom Vision is planned to retire on September 25, 2028. Microsoft supports existing customers until that date; after that, API calls will fail. Use this module as historical architecture context only.

You should now understand the original pattern:

- Register an IoT Edge device with IoT Hub
- Deploy containerized edge modules
- Send a simulated camera stream to the edge
- Run an object detection model near the video source
- Surface detections in an application or send results upstream

For a current solution, start with supported services and current documentation. Options include Azure AI Video Indexer enabled by Arc for edge video insights with real-time analysis, subject to preview requirements, gated subscription approval, hardware requirements, and feature limitations, or another maintained edge video pipeline. For custom model training or retraining, plan for Azure Machine Learning AutoML for image classification and object detection rather than new Custom Vision dependencies. For broader generative or custom-solution scenarios, evaluate Azure AI Foundry separately.

## Clean up

When you're working in your subscription, identify whether you still need the resources you created. Resources left running can cost you money. You can delete resources individually or delete the resource group to delete the entire set of lab resources.

Also clean up temporary security exposure and credentials:

- Delete any temporary inbound NSG rule for port 8181.
- Remove public access paths that were used only for the lab.
- Delete lab-created Azure Bastion resources, such as the Bastion host, Bastion public IP address, and Bastion subnet or VNet if they aren't used by anything else.
- Delete lab-only service principals, repository-scoped tokens, and scope maps, and remove role assignments created only for the lab.
- Rotate or delete IoT Edge device keys, service principal secrets, API keys, and registry credentials used for testing.
- Disable the Azure Container Registry admin account if you enabled it for a short test.
- Remove local copies of secrets and sample files that you no longer need.
