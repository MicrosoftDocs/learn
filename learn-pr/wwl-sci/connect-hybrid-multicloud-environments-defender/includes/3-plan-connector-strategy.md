With a clear picture of how Defender for Cloud covers multicloud environments, you're ready to plan a connector strategy. Before you create any connectors, make three key decisions for each cloud environment: the scope of each connector, the scan interval, and the permission model. These decisions affect operational overhead, coverage completeness, API call volume, and audit trail quality.

:::image type="content" source="../media/connector-scope-decision.png" alt-text="Decision tree for selecting organization-level or account-level connector scope.":::

## Plan your AWS connector

For AWS, **one connector corresponds to one AWS account**. You have two scope options depending on your organizational structure.

### Select AWS connector scope

An **organization-level connector** connects your AWS management account. Defender for Cloud uses AWS StackSets to automatically create connectors for all child accounts under that management account—including new accounts added later. This is the right choice for central security teams that need consistent coverage across accounts they can’t directly manage, without creating and maintaining dozens of individual connectors.

An **account-level connector** covers a single AWS account and gives granular control over scan intervals, plan selection, and permission configuration for that account. The account-level approach is appropriate when:

- Security requirements differ meaningfully across accounts (production vs. dev/test)
- You can't yet onboard the full organization due to ownership or approval constraints
- You need to start with a limited pilot before rolling out organization-wide

### Define AWS scan interval

Defender for Cloud offers four scan intervals for AWS connectors: **4, 6, 12, or 24 hours**. The interval controls how frequently Defender for Cloud polls AWS APIs for resource configuration changes.

A shorter interval catches configuration drift faster—important for environments where resources are frequently created, modified, or deleted. However, scan interval only controls the *configurable* data collectors. Several AWS data collectors run on **fixed intervals** regardless of your setting:

| Fixed scan interval | AWS data collected |
|---------------------|--------------------|
| Every 1 hour | EC2 instances, ECR images, ECR repositories, S3 buckets, EKS clusters, Auto Scaling groups |
| Every 12 hours | IAM policy versions, IAM entities for policies, S3 bucket policies, S3 access control lists, S3 replication configuration |

EC2 instances—the workloads most commonly protected by Defender for Servers—refresh every hour regardless of the interval you set. IAM configuration data, which feeds Cloud Security Posture Management (CSPM) recommendations on over-permissive roles, refreshes every 12 hours. For most production environments, a **4-hour scan interval** is the right starting point.

### Explore AWS permission requirements

The IAM permissions Defender for Cloud needs in your AWS environment depends on which Defender plans you enable.

**CSPM** (always required) uses read-only API calls to assess posture. It needs read-only permissions across services like EC2, IAM, S3, RDS, and CloudTrail—no write access, no changes to your environment.

**Cloud Workload Protection Platform (CWPP) plans** require extra permissions:

- **Defender for Servers** needs permissions to interact with AWS Systems Manager (SSM) to validate and trigger Arc agent installation on EC2 instances
- **Defender for Containers** needs permissions to create and manage CloudWatch log groups, SQS queues, Kinesis Data Fire Hose delivery streams, and S3 buckets in each monitored region

During connector creation, you choose between **default access** (current and anticipated future permissions) and **least privilege access** (only what your selected plans need today). For production environments, start with least privilege. If you add plans later, regenerate and redeploy the CloudFormation template with updated plan selections.

### Configure AWS Arc automatic deployment

For AWS EC2 instances, the native cloud connector can **auto-provision Azure Arc** as part of Defender for Servers activation. Defender for Cloud uses AWS Systems Manager (SSM) to install the Azure Connected Machine agent on discovered EC2 instances—no manual deployment needed at scale. For Contoso, with hundreds of EC2 instances across multiple AWS regions, autoprovisioning eliminates manual agent deployment while ensuring CWPP coverage extends to every new instance as it launches.

---

## Plan your GCP connector

For GCP, **one connector can cover a single project or an entire GCP organization**. The model is a more flexible model than AWS.

### Choose GCP connector scope

An **organization-level connector** covers all current and future projects within the GCP organization—individual projects don't require separate connectors. New projects added to the organization are covered automatically.

A **project-level connector** covers a single GCP project and gives granular control over scan intervals, plan selection, and permission configuration for that project. Use when:

- Security requirements differ meaningfully across projects (production vs. dev/test)
- You can't yet onboard the full organization due to ownership or approval constraints
- You need to start with a scoped pilot

### Configure GCP scan interval

Defender for Cloud offers the same four scan intervals for GCP connectors: **4, 6, 12, or 24 hours**. GCP Compute Engine VMs and Container clusters refresh hourly regardless of the configured interval—the same fixed-interval pattern as EC2 on AWS. For most production environments, use a **4-hour** starting interval.

### Explore GCP permission requirements

**CSPM** (always required) uses read-only access to Compute, Storage, IAM, and BigQuery APIs—no write access, no changes to your GCP environment.

**CWPP plans** require extra permissions:

- **Defender for Servers** needs permissions to interact with Compute Engine metadata and Google Cloud OS Config to validate and trigger Arc agent installation on Compute Engine VMs

During connector creation, choose between **default access** and **least privilege access**. The GCloud script generated by the portal is customized to the plans you select and the permission type you choose. For production environments, use least privilege. If you add plans later, rerun the updated GCloud script to add the new permissions.

> [!NOTE]
> If this GCP connector already uses **Least privilege access** and you want to enable AI Security Posture Management (AI SPM) for AI workload visibility—including Google Vertex AI—the existing service account bindings don't include the required permissions. Rerun the updated GCloud script to add them.

### Configure GCP Arc autoprovisioning

For GCP Compute Engine VMs, the native cloud connector can also **auto-provision Azure Arc** as part of Defender for Servers activation. Defender for Cloud uses Google Cloud OS Config to install the Azure Connected Machine agent on discovered Compute Engine VMs—the same operational advantage as AWS, without manual deployment at scale.

---

## Plan connector decisions and prioritization

With the AWS and GCP connector models in mind, a few decisions apply across both environments.

**On-premises machines require a different path.** Unlike EC2 and Compute Engine VMs, on-premises servers have no autoprovisioning capability. You must manually deploy the Azure Connected Machine agent on each server—either one at a time using the portal-generated onboarding script. Or you can deploy at scale using a service principal with your organization's management tooling such as Group Policy, Ansible, or Microsoft Configuration Manager. This manual deployment step applies regardless of how many machines you have, so factor the deployment effort into your planning timeline before onboarding large on-premises estates.

:::image type="content" source="../media/arc-provisioning-paths.png" alt-text="Diagram comparing Azure Arc provisioning paths: EC2 and Compute Engine VMs use autoprovisioning; on-premises servers require manual agent deployment.":::

**Prioritize by attack surface risk.** Before creating connectors, identify which environments carry the greatest unmonitored risk. Internet-facing EC2 instances, production databases on RDS, GKE clusters running multitenant applications, and storage buckets holding sensitive data are common high-risk starting points. Start with connectors for those environments to get recommendations and secure score contribution as quickly as possible.

**Contoso's recommended path.** For Contoso's environment—defined production and sandbox AWS accounts and multiple GCP projects under a single GCP organization—use organization-level connectors for each provider when organizational buy-in exists. For an initial pilot, start with account-level connectors for the highest-risk production environments.
