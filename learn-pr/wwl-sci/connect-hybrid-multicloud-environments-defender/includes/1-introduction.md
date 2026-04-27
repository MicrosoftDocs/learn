Contoso's security team can see everything happening inside Azure. Virtual machines generate alerts. Misconfigurations surface as recommendations. The regulatory compliance dashboard tracks Azure resources against the Microsoft Cloud Security Benchmark. But outside the Azure boundary—in the Amazon Web Services (AWS) EC2 instances running production workloads, the Google Cloud Platform (GCP) Compute Engine virtual machines hosting development environments, and the on-premises Windows and Linux servers powering the data centers—Defender for Cloud sees nothing. No recommendations surface. No secure score reflects those environments. No Cloud Workload Protection Platform (CWPP) plan covers those machines. The Chief Information Security Officer (CISO) mandated unified visibility and protection before the next compliance audit.

This module shows you how to close that gap. You connect Contoso's on-premises servers, AWS accounts, and GCP projects to Microsoft Defender for Cloud using native connectors and Azure Arc–enabled servers. Then you extend Cloud Security Posture Management (CSPM) and CWPP protection across a unified hybrid and multicloud estate.

In this module, you:

- Explain the multicloud connectivity model in Defender for Cloud, including how federated authentication works for AWS and GCP connectors
- Plan a connector strategy for hybrid and multicloud environments, including scope, scan interval, and required permissions per environment type
- Connect on-premises machines to Defender for Cloud using Azure Arc–enabled servers
- Connect AWS accounts to Defender for Cloud using the native cloud connector and CloudFormation template
- Connect GCP projects to Defender for Cloud using the native cloud connector and GCloud deployment script
- Verify multicloud connectivity health and confirm CSPM and CWPP coverage surfaces across connected environments
