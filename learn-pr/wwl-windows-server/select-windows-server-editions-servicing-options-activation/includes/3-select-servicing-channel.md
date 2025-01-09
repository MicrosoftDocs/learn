Azure Arc's Pay-as-you-go subscription licensing option is an alternative to the conventional perpetual licensing for Windows Server 2025. With Pay-as-you-go, you can deploy a Windows Server device, license it, and only pay for as much as you use. This feature is facilitated through Azure Arc and billed via your Azure subscription. You have the flexibility to disable Pay-as-you-go whenever necessary. Additionally, you can use Pay-as-you-go for free for the first seven days after enabling it as a trial.

## Pricing model

Windows Server Pay-as-you-go shares the same pricing and model as Windows Server licensing on Microsoft Azure, but is designed for devices that are deployed outside of Microsoft Azure. Windows Server Pay-as-you-go with Azure Arc isn't supported on Microsoft Azure, as there are other ways to license Windows Server with Pay-as-you-go with that service.

Pay-as-you-go regulations differ from traditional perpetual licensing. For instance, in Pay-as-you-go, the cost is the same for both Standard and Datacenter editions, and there are no client access licenses (CALs) required for standard functionality. However, Remote Desktop Services (RDS) CALs are still required.

The Pay-as-you-go license only applies to the exact device where the feature is enabled on Microsoft Azure. Unlike traditional perpetual licenses, it doesn't provide additional rights for virtual machines (VM) running on the same server. Thus, the Automatic Virtual Machine Activation (AVMA) feature isn't available. Each VM requires its own separate license, regardless of the host server. The host and VMs can run different versions of the operating system (OS) and mix different license types.

## Pay-as-you-go prerequisites

You choose the Pay-as-you-go licensing option during deployment or later when you would normally enter a product key. Once you choose Pay-as-you-go, you will not need to provide a product key. Windows Server Pay-as-you-go is only available if installed from a retail copy of Windows Server 2025. Pay-as-you-go isn't available in Preview, Evaluation, or volume license versions of Windows Server 2025. Pay-as-you-go has the following prerequisites: 

- Your device must be running Windows Server 2025 Standard or Datacenter edition.
- Your device must be Azure Arc-enabled and be running Microsoft Azure connected machine agent version 1.47 or later.
- Your device isn't currently licensed (activated) with another license type, such as OEM, Retail, or Volume License (VL).
- An active internet connection is required.
