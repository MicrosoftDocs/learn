Computer systems that interact directly with users are considered endpoint systems. Systems on devices, such as laptops, smartphones, tablets, and computers, all need to be secured to help prevent them from acting as gateways for security attacks on an organization’s networked systems.

Earlier, we discussed the shared responsibilities of helping secure services in Azure. IaaS involves more customer responsibility than PaaS and SaaS did, and Microsoft Defender for Cloud provides the tools you need to harden your network, help secure your services, and stay on top of your security posture.

## First step: Help protect against malware

Install antimalware to help identify and remove viruses, spyware, and other malicious software. You can install Microsoft Antimalware or an endpoint protection solution from a Microsoft Partner.

## Second Step: Monitor the status of the antimalware

Next, integrate your antimalware solution with Microsoft Defender for Cloud to monitor the status of the antimalware protection. Security Center reports this on the **Endpoint protection issues** blade. Security Center highlights issues, such as detected threats and insufficient protection, which might make your VMs and computers vulnerable to malware threats. By using the information on Endpoint protection issues, you can make a plan to address any identified issues.

Focusing just on the endpoint recommendation, what does Microsoft Defender for Cloud report as issues?

By using the information under **Endpoint protection issues**, you can identify a plan to address any issues identified.

Security Center reports the following endpoint protection issues:

 -  **Endpoint protection not installed on Azure VMs** \- A supported antimalware solution isn’t installed on these Azure VMs.
 -  **Endpoint protection not installed on non-Azure computers** \- A supported antimalware solution isn’t installed on these non-Azure computers.
 -  Endpoint protection health issues:
     -  **Signature out of date**. An antimalware solution is installed on these VMs and computers, but the solution doesn’t have the latest antimalware signatures.
     -  **No real time protection**. An antimalware solution is installed on these VMs and computers, but it isn’t configured for real-time protection. The service might be disabled, or Security Center might be unable to obtain the status because the solution isn’t supported.
     -  **Not reporting**. An antimalware solution is installed but not reporting data.
     -  **Unknown**. An antimalware solution is installed, but either its status is unknown or it’s reporting an unknown error.
