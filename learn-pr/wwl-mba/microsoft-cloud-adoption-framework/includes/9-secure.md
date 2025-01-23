You can use the Secure methodology to help secure your Azure cloud estate. This guidance is relevant to all methodologies within the Cloud Adoption Framework because you should implement security as an integral part of each phase. All recommendations in the Secure methodology adhere to the Zero Trust principles of assume compromise (or assume breach), least privilege, and explicit verification of trust.

This Cloud Adoption Framework Secure guidance is one component of a larger holistic set of Microsoft security guidance designed to help various teams understand and perform their security responsibilities. The complete set includes the following guidance:

- The Cloud Adoption Framework Secure methodology provides security guidance for teams that manage the technology infrastructure that supports all the workload development and operations hosted on Azure.

- [Azure Well-Architected Framework security guidance](/azure/well-architected/security/) provides guidance for individual workload owners about how to apply security best practices to application development and DevOps and DevSecOps processes. Microsoft provides guidance that complements this documentation about how to apply security practices and DevSecOps controls in a security development lifecycle.

- [Microsoft Cloud Security Benchmark](/security/benchmark/azure/) provides best practice guidance for stakeholders to ensure robust cloud security. This guidance includes security baselines that describe the available security features and recommended optimal configurations for Azure services.

- [Zero Trust guidance](/security/zero-trust/) provides guidance for security teams to implement technical capabilities to support a Zero Trust modernization initiative.

Throughout your cloud adoption journey, look for opportunities to enhance your overall security posture through modernization. Incident preparation and response are also cornerstone elements of your overall security posture. Your ability to prepare for and respond to incidents can significantly affect your success in the cloud. Well-designed preparation mechanisms and operational practices enable quick threat detection and help minimize the blast radius of incidents.

The CIA Triad is a fundamental model in information security that represents three core principles: confidentiality, integrity, and availability.

- **Confidentiality** ensures that only authorized individuals can access sensitive information. This policy includes measures like encryption and access controls to protect data from unauthorized access.

- **Integrity** maintains the accuracy and completeness of data. This principle means protecting data from alterations or tampering by unauthorized users, which ensures that the information remains reliable.

- **Availability** ensures that information and resources are accessible to authorized users when needed. This task includes maintaining systems and networks to prevent downtime and ensure continuous access to data.

Some ways that the triad principles can help ensure security and reliability include:

- **Data protection:** Protect sensitive data from breaches by taking advantage of the CIA Triad, which ensures privacy and compliance with regulations.

- **Business continuity:** Ensure data integrity and availability to maintain business operations and avoid downtime.

- **Customer trust:** Implement the CIA Triad to build trust with customers and stakeholders by demonstrating a commitment to data security.

Assign appropriate security roles to help ensure that your team can carry out security functions during every stage of the cloud lifecycle, from development to continuous improvement. 

- Map out your existing roles and what functions they cover.
- Check for gaps.
- Assess whether your organization can and should invest to address those gaps. 

You must ensure that everyone understands their role in security and how to work with other teams. To accomplish this goal, document cross-team security processes and a shared responsibility model for your technical teams. A shared responsibility model is similar to a Responsible, Accountable, Consulted, Informed (RACI) model. A shared responsibility model helps illustrate a collaborative approach, including who makes decisions and what teams must do to work together for particular items and outcomes.

You must continuously improve security to maintain a robust security posture in the cloud because cyber threats continuously evolve and become more sophisticated. Restrospectives and monitoring can help you identify areas that might benefit from improvement. Also ensure that you provide proper training to remain up to date with evolving threats and technologies.