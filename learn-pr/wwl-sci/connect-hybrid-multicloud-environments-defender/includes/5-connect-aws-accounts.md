With on-premises servers Arc-enabled and reporting to Defender for Cloud, you turn to Contoso's AWS environment. The native AWS connector uses API-based integration—you don't need to deploy agents on AWS infrastructure to activate CSPM coverage. The CloudFormation template that Defender for Cloud generates handles all authentication resource creation automatically, giving you a secure, federated connection within minutes.

## Plan the AWS connector

Confirm these prerequisites before starting:

- You have **Contributor or Owner** permissions on the Azure subscription where the connector is created.
- **Microsoft Defender for Cloud** is enabled on that subscription.
- You have **administrator access** to the AWS account being connected.
- If you plan to enable Cloud Infrastructure Entitlement Management (CIEM) as part of Defender CSPM, you need the **Application Administrator** or **Cloud Application Administrator** role in Microsoft Entra ID.

> [!IMPORTANT]
> The AWS connector isn't available on the national government clouds: Azure Government and Microsoft Azure operated by 21Vianet. If you operate in those cloud environments, the AWS native connector isn't supported.

If your AWS account is already connected to **Microsoft Sentinel**, review the Microsoft documentation on connecting Sentinel-connected AWS accounts to Defender for Cloud before proceeding. Simultaneous connections can cause deployment or ingestion conflicts that require configuration changes to resolve.

## Create the AWS connector

:::image type="content" source="../media/add-aws-account-environment-settings.png" alt-text="Screenshot of the Environment Settings page in Microsoft Defender for Cloud showing the Add environment button with Amazon Web Services as an option.":::

1. In the Azure portal, open **Microsoft Defender for Cloud** and select **Environment settings** from the left menu.
2. Select **Add environment** > **Amazon Web Services**.
3. On the **Account details** tab, enter:
   - **Connector name**: a descriptive name, for example, `contoso-aws-prod`
   - **Subscription**: the Azure subscription that owns this connector resource
   - **Resource group**: an existing or new resource group for the connector
   - **Location**: the Azure region where connector metadata is stored
   - **AWS account ID**: your 12-digit AWS account number
4. Select **AWS regions** to monitor using the dropdown. Defender for Cloud makes API calls only to the regions you select. Resources in deselected regions receive no coverage—misconfigurations and vulnerable resources in those regions remain invisible. Select all regions where Contoso runs production workloads.
5. Set the **Scan interval**: choose 4, 6, 12, or 24 hours. For initial deployment, 4 hours provide the fastest first scan results.
6. Select **Next: Select plans**.

### Select Defender plans

On the **Select plans** tab, choose the Defender plans to enable for the AWS account.

**Defender CSPM** is always on and can't be disabled. It provides agentless posture assessment across all selected AWS regions.

Optional CWPP plans to consider for Contoso's AWS environment:

| Plan | What it protects | Azure Arc required |
|------|-----------------|--------------|
| Defender for Servers | EC2 instances | Yes (autoprovisioned) |
| Defender for Containers | EKS clusters | No |
| Defender for SQL on EC2 | SQL Server on EC2 and RDS Custom | Yes |
| Defender for Databases (RDS) | RDS with open-source engines | No |

Enable Defender for Servers to extend CWPP coverage to Contoso's EC2 workloads. The CloudFormation template that the portal generates includes the SSM-related permissions needed for Arc agent autoprovisioning on EC2 instances.

> [!NOTE]
> The plans you select determine what IAM permissions the CloudFormation template includes. Adding or removing plans after template generation requires downloading a new template and updating the CloudFormation stack.

> [!NOTE]
> If this AWS account is already connected with **Least privilege access** and you want to add AI Security Posture Management (AI SPM) for AI workload visibility, the existing connector doesn't automatically receive the required permissions. Download an updated CloudFormation template with AI SPM permissions included and redeploy it as a stack update.

### Configure access

On the **Configure access** tab:

1. Select **Default access** or **Least privilege access**. For production environments, select **Least privilege access** to follow the principle of least privilege.
2. Select the deployment method: **AWS CloudFormation** or **Terraform**. For most environments, CloudFormation is the standard path.
3. Select **Download** to get the CloudFormation template. The template file is customized to the plans you selected.

:::image type="content" source="../media/add-aws-account-configure-access.png" alt-text="Screenshot of the Configure access tab in the AWS connector wizard showing the CloudFormation template download option.":::

## Deploy the CloudFormation template

The CloudFormation template creates the authentication resources required for Defender for Cloud to access your AWS account using federated credentials.

1. Open the **AWS Management Console** and navigate to **CloudFormation**.
2. Select **Create stack** > **With new resources (standard)**.
3. Upload the template file you downloaded, or provide its S3 URL if you staged it in a bucket.
4. Review the IAM resources the template creates:
   - An **OpenID Connect identity provider** for the Microsoft-managed Microsoft Entra application
   - IAM roles that Defender for Cloud assumes through web identity federation
   - SSM-related resources for Arc autoprovisioning (included when Defender for Servers is selected)
5. Accept the IAM resource creation acknowledgment.
6. Deploy the stack. Deployment takes two to five minutes.

> [!IMPORTANT]
> If you stage the template in your own S3 bucket before deployment, apply a bucket policy that requires SSL requests only. Staged templates prevent an AWS CSPM recommendation about S3 SSL enforcement from flagging your own onboarding infrastructure.

Once the stack shows **CREATE_COMPLETE**, return to the Azure portal and complete the connector:

1. Return to the **Configure access** tab in the Defender for Cloud connector wizard.
2. Select **Next: Review and generate**.
3. Review your connector configuration—account details, plans, and access settings.
4. Select **Create**.

Defender for Cloud begins its first scan of the connected AWS account. The connector resource appears in Environment Settings immediately. CSPM recommendations surface within four to six hours after the first scan completes.

## Validate AWS connector health

After creating the connector, verify that it's operating correctly before waiting for the first scan results.

1. In Defender for Cloud, select **Environment settings**.
2. Locate the AWS connector in the environment list.
3. Review the **Connectivity status** column:
   - **Healthy**: authentication succeeds and scans run normally
   - **Has issues**: a configuration or permission problem is preventing correct operation
   - **Connecting**: initial handshake in progress—normal for the first few minutes
4. Select the status value to open the **Environment details** page.

:::image type="content" source="../media/environment-details-connector-health.png" alt-text="Screenshot of the Environment details page for a connected AWS account showing connector health status.":::

The Environment details page lists specific issues affecting connector health and provides remediation guidance. Common issues at this stage include:

- **Missing IAM permissions**: the CloudFormation template didn't deploy completely, or a plan was added after template generation. Fix by generating a new template with updated plan selection and redeploying as a stack update.
- **IAM role trust policy mismatch**: manual edits to the CloudFormation-created roles broke the trust policy. Fix by rerunning the CloudFormation template to restore original trust conditions.

> [!NOTE]
> Once the connector shows healthy status and the first scan completes, AWS resources appear in **Inventory** tagged with the AWS origin icon, CSPM recommendations surface in the **Recommendations** screen, and the **AWS Foundational Security Best Practices** compliance standard is autoassigned in the **Regulatory Compliance** dashboard.

> [!TIP]
> If Defender for Servers is enabled and EC2 instances aren't completing Arc provisioning, verify that the SSM Agent is installed and that each EC2 instance profile includes the `AmazonSSMManagedInstanceCore` IAM policy.
