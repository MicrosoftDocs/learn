This unit describes areas of security optimization to consider as you move through the [Plan methodology](/azure/cloud-adoption-framework/plan/) phase of your journey.

A cloud adoption plan often has many technical challenges. You must carefully plan each step of your cloud adoption process, specifically when you update legacy workloads for cloud infrastructure. Prioritize security over performance and cost efficiency when you start your designs. This approach ensures that you don't introduce risks that could require you to redesign workloads later.

## Plan for landing zone adoption

To build your cloud estate foundation, use the landing zone approach, especially for enterprise and large organizations. Smaller organizations might not need a landing zone initially but should understand the design areas for their cloud adoption plan.

Landing zones are preconfigured, highly secure, scalable cloud environments that include network topology, identity management, security, and governance components. They help you standardize your cloud environment, ensure consistency and compliance with security policies, and facilitate easier management and scalability.

## Security posture modernization

When you develop a security modernization plan, focus on adopting new technologies and operational practices while aligning security measures with business objectives.

### Plan for Zero Trust adoption

Incorporate Zero Trust principles to structure phases and steps for teams. The Microsoft Zero Trust approach covers seven technology pillars:

- **[Identity](/security/zero-trust/deploy/identity):** Guidance for verifying identities with strong authentication and controlling access under the principle of least privilege.

- **[Endpoints](/security/zero-trust/deploy/endpoints):** Guidance for securing all endpoints, including devices and apps, that interact with your data. This guidance applies regardless of where the endpoints connect from and how they connect.

- **[Data](/security/zero-trust/deploy/data):** Guidance for securing all data by using a defense-in-depth approach.

- **[Apps](/security/zero-trust/deploy/applications):** Guidance for securing the cloud apps and services that you consume.

- **[Infrastructure](/security/zero-trust/deploy/infrastructure):** Guidance for securing cloud infrastructure through strict policies and enforcement strategies.

- **[Network](/security/zero-trust/deploy/networks):** Guidance for securing your cloud network through segmentation, traffic inspection, and end-to-end encryption.

- **[Visibility, automation, and orchestration](/security/zero-trust/deploy/visibility-automation-orchestration):** Guidance for operational policies and practices that help enforce Zero Trust principles.

### Consider business alignment

Ensure alignment between technology and business stakeholders. Approach plan development collaboratively. Negotiate with stakeholders to fine the best way to adapt processes and policies. Business stakeholders must understand how the modernization plan affects business functions. Technology stakeholders should know where to make concessions to maintain security.

## Plan for preparedness and incident response

- Evaluate vulnerability management solutions, threat detection systems, and infrastructure monitoring.
- Harden infrastructure to reduce attack surfaces.
- Build a robust incident response plan.
- Identify roles and key phases (investigation, mitigation, communications) in the Plan phase.
- Add details as you develop your cloud estate.

## Plan for availability


