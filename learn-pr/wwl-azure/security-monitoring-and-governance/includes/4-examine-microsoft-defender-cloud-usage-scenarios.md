Microsoft Defender for Cloud provides versatile security capabilities applicable to diverse organizational scenarios including incident response, compliance monitoring, DevSecOps integration, vulnerability management, and workload protection. Understanding practical usage scenarios helps organizations maximize Defender for Cloud's value by applying its capabilities to specific security challenges and operational workflows.

This unit examines real-world scenarios demonstrating how organizations leverage Defender for Cloud for incident response, regulatory compliance, security posture improvement, vulnerability remediation, container security, database protection, and DevOps pipeline integration.

## Incident response and threat detection

Organizations require structured incident response processes to detect, assess, diagnose, and remediate security incidents efficiently. Defender for Cloud provides integrated capabilities supporting each incident response phase.

**Incident response lifecycle:**

Modern incident response follows a structured lifecycle: **preparation** → **detection** → **analysis** → **containment** → **eradication** → **recovery** → **post-incident review**. Defender for Cloud integrates throughout this lifecycle.

**Detection phase:**

**Defender for Cloud security alerts** provide initial detection of suspicious activities across Azure resources.

**Example detection scenario:**

Defender for Cloud detects unusual administrative activity on a production SQL database:

- **Alert:** "Potential SQL injection attack detected on SQL Database."
- **Severity:** High.
- **Affected resource:** `contoso-prod-sqldb` (Azure SQL Database).
- **MITRE ATT&CK tactic:** Initial Access (T1190).
- **Details:** Suspicious SQL query containing `'; DROP TABLE` pattern detected from IP address `203.0.113.45`.

**Assessment phase:**

Security team investigates alert details to determine attack validity and scope.

**Investigation steps:**

1. **Navigate to Security alerts** in Defender for Cloud.
2. **Click alert** to open investigation pane.
3. **Review alert details:**
   - Attack source IP: `203.0.113.45` (identified as malicious by threat intelligence).
   - Attack time: `2025-10-22 14:32:18 UTC`.
   - Affected database: `contoso-prod-sqldb`.
   - Queries executed: Review query logs for suspicious patterns.
4. **Check related alerts:** Identify correlated activities (unusual login attempts, privilege escalation).
5. **Review entity timeline:** Examine database activity leading up to alert.
6. **Assess impact:**
   - Data exfiltration: Check for unusual data export operations.
   - Data modification: Review database transaction logs for unauthorized changes.
   - Account compromise: Verify if credentials were stolen or misused.

**Diagnosis phase:**

Technical investigation identifies root cause, attack vectors, and required remediation actions.

**Defender for Cloud investigation tools:**

- **Alert timeline:** Chronological sequence of events leading to security incident.
- **Related entities:** Resources, identities, and IP addresses involved in attack.
- **MITRE ATT&CK mapping:** Attack techniques used by adversary.
- **Threat intelligence:** Known malicious indicators (IPs, domains, file hashes) detected.
- **Recommended actions:** Step-by-step remediation guidance provided by Defender for Cloud.

**Containment and remediation:**

Immediate actions to stop attack progression and prevent further damage.

**Containment actions:**

```azurecli
# Block malicious IP address at network level
az network nsg rule create \
  --resource-group production-rg \
  --nsg-name sql-nsg \
  --name BlockMaliciousIP \
  --priority 100 \
  --direction Inbound \
  --access Deny \
  --source-address-prefixes 203.0.113.45 \
  --destination-port-ranges 1433 \
  --protocol Tcp

# Disable compromised SQL login
az sql server ad-admin delete \
  --resource-group production-rg \
  --server-name contoso-sql-server

# Enable SQL Database Advanced Threat Protection if not already enabled
az sql db threat-policy update \
  --resource-group production-rg \
  --server contoso-sql-server \
  --database contoso-prod-sqldb \
  --state Enabled \
  --email-account-admins Enabled
```

**Post-incident review:**

After containment, analyze incident to improve security controls and prevent recurrence.

**Lessons learned:**

- **Root cause:** Publicly exposed SQL Database without IP firewall restrictions.
- **Detection effectiveness:** Defender for Cloud detected attack within minutes of first suspicious query.
- **Response time:** Security team contained attack within 15 minutes of alert.
- **Improvements needed:**
  - Implement SQL Database firewall rules restricting access to known IP ranges.
  - Enable Azure Private Link for SQL Database to eliminate public exposure.
  - Implement web application firewall (WAF) to filter malicious SQL injection attempts.
  - Configure Defender for Cloud workflow automation to automatically block malicious IPs.

## Regulatory compliance monitoring

Organizations in regulated industries must demonstrate continuous compliance with security standards including PCI DSS, HIPAA, ISO 27001, and SOC 2. Defender for Cloud automates compliance assessment and reporting.

**Compliance scenario:**

Financial services organization requires PCI DSS compliance for payment processing systems hosted in Azure.

**Configure PCI DSS compliance monitoring:**

1. **Navigate to Regulatory compliance** in Defender for Cloud.
2. **Click "Manage compliance policies"**.
3. **Select subscription** containing payment processing resources.
4. **Enable PCI DSS v3.2.1 compliance standard**.
5. **Review compliance score:** Initial score shows `68%` compliance.
6. **Examine failed controls:**
   - **Control 2.2.4:** "Remove unnecessary services and protocols" (8 non-compliant VMs).
   - **Control 8.2.3:** "Multifactor authentication for all non-console administrative access" (MFA not enforced for 5 admin accounts).
   - **Control 10.2.1:** "Audit trails for all access to cardholder data" (diagnostic logging disabled on 12 storage accounts).

**Remediate compliance gaps:**

**Control 2.2.4 - Remove unnecessary services:**

```yaml
# Azure Policy - Audit VMs with unnecessary services running
{
  "mode": "All",
  "policyRule":
    {
      "if":
        {
          "allOf":
            [
              {
                "field": "type",
                "equals": "Microsoft.Compute/virtualMachines",
              },
              { "field": "tags['PCI-DSS-Scope']", "equals": "In-Scope" },
            ],
        },
      "then":
        {
          "effect": "auditIfNotExists",
          "details":
            {
              "type": "Microsoft.Compute/virtualMachines/extensions",
              "name": "HardeningExtension",
            },
        },
    },
}
```

**Control 8.2.3 - Enforce MFA:**

```powershell
# PowerShell - Enable MFA requirement via Conditional Access
Connect-AzureAD

$conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserConditionSet
$conditions.Users.IncludeGroups = "PaymentSystemAdministrators"

$controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
$controls._Operator = "OR"
$controls.BuiltInControls = "mfa"

New-AzureADMSConditionalAccessPolicy `
  -DisplayName "PCI DSS - Require MFA for Payment System Admins" `
  -State "Enabled" `
  -Conditions $conditions `
  -GrantControls $controls
```

**Control 10.2.1 - Enable audit logging:**

```azurecli
# Enable diagnostic logging for storage accounts
for storage_account in $(az storage account list --query "[?tags.'PCI-DSS-Scope'=='In-Scope'].name" -o tsv); do
  az monitor diagnostic-settings create \
    --name PCI-DSS-Audit-Logging \
    --resource "/subscriptions/{subscription-id}/resourceGroups/{rg}/providers/Microsoft.Storage/storageAccounts/${storage_account}" \
    --workspace /subscriptions/{subscription-id}/resourceGroups/security-rg/providers/Microsoft.OperationalInsights/workspaces/pci-audit-logs \
    --logs '[{"category":"StorageRead","enabled":true},{"category":"StorageWrite","enabled":true},{"category":"StorageDelete","enabled":true}]'
done
```

**Export compliance report:**

1. **Navigate to Regulatory compliance** in Defender for Cloud.
2. **Select PCI DSS v3.2.1 standard**.
3. **Click "Download report"**.
4. **Select format:** PDF or CSV.
5. **Provide to auditors:** Comprehensive report showing compliance status for all PCI DSS controls.

**Compliance achievement:**

After remediation, compliance score improves from `68%` to `94%`, with remaining 6% representing accepted risk exceptions documented and approved by security team.

## Secure Score improvement campaigns

Organizations run **Secure Score improvement campaigns** to systematically enhance security posture across Azure environments.

**Campaign scenario:**

Enterprise organization with Secure Score of `62/100` launches 90-day improvement campaign targeting `80/100`.

**Campaign approach:**

**Phase 1: Prioritization (Week 1-2):**

1. **Navigate to Secure Score** in Defender for Cloud.
2. **Review recommendations** sorted by potential score increase.
3. **Identify high-impact, low-effort recommendations:**
   - **Enable MFA for privileged accounts:** `+8 points`, effort: Low.
   - **Enable encryption for storage accounts:** `+6 points`, effort: Low.
   - **Apply system updates to VMs:** `+5 points`, effort: Medium.
   - **Enable Azure Backup for critical VMs:** `+4 points`, effort: Low.
4. **Create remediation project:** Assign recommendations to teams with deadlines.

**Phase 2: Bulk remediation (Week 3-8):**

**Enable MFA using Azure Policy:**

```json
{
  "displayName": "Require MFA for all administrators",
  "description": "Enforce MFA requirement for all users with administrative roles",
  "policyRule": {
    "if": {
      "allOf": [
        {
          "field": "type",
          "equals": "Microsoft.Authorization/roleAssignments"
        },
        {
          "field": "Microsoft.Authorization/roleAssignments/roleDefinitionId",
          "in": [
            "/subscriptions/{subscription-id}/providers/Microsoft.Authorization/roleDefinitions/8e3af657-a8ff-443c-a75c-2fe8c4bcb635",
            "/subscriptions/{subscription-id}/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"
          ]
        }
      ]
    },
    "then": {
      "effect": "audit"
    }
  }
}
```

**Enable storage encryption using Quick Fix:**

1. **Click recommendation:** "Storage accounts should use customer-managed key for encryption."
2. **Select all affected storage accounts** (45 accounts).
3. **Click "Quick fix"**.
4. **Configure encryption:**
   - Key Vault: `contoso-encryption-kv`.
   - Key: `storage-encryption-key`.
5. **Apply remediation:** Defender for Cloud automatically enables encryption for all selected accounts.

**Automate VM patching:**

```yaml
# Azure Pipelines - Automated VM patching workflow
trigger:
  schedules:
    - cron: "0 2 * * 0" # Every Sunday at 2 AM
      branches:
        include:
          - main

pool:
  vmImage: "ubuntu-latest"

steps:
  - task: AzureCLI@2
    inputs:
      azureSubscription: "Production-Service-Connection"
      scriptType: "bash"
      scriptLocation: "inlineScript"
      inlineScript: |
        # Get all VMs with missing patches
        vm_list=$(az vm list --query "[?tags.'Auto-Patch'=='Enabled'].{name:name, rg:resourceGroup}" -o json)

        echo "$vm_list" | jq -c '.[]' | while read vm; do
          vm_name=$(echo $vm | jq -r '.name')
          rg=$(echo $vm | jq -r '.rg')
          
          echo "Applying patches to $vm_name..."
          az vm run-command invoke \
            --resource-group $rg \
            --name $vm_name \
            --command-id RunShellScript \
            --scripts "sudo apt-get update && sudo apt-get upgrade -y"
        done
```

**Phase 3: Validation (Week 9-12):**

1. **Monitor Secure Score** weekly to track improvement progress.
2. **Review newly created resources:** Ensure new deployments maintain security standards.
3. **Conduct security review:** Validate all remediations are properly implemented.
4. **Document exceptions:** Formally document and approve any accepted risks.

**Campaign results:**

- **Initial Secure Score:** `62/100`.
- **Final Secure Score:** `83/100` (exceeding `80/100` target).
- **Recommendations remediated:** 156 of 203.
- **High-severity recommendations:** Reduced from 24 to 3.
- **Critical security gaps:** Eliminated completely.

## Container security

Organizations deploying containerized applications require comprehensive container security covering image scanning, runtime protection, and Kubernetes cluster security.

**Container security scenario:**

Company deploys microservices on Azure Kubernetes Service (AKS) and Azure Container Registry (ACR).

**Enable Defender for Containers:**

1. **Navigate to Microsoft Defender for Cloud**.
2. **Click "Environment settings"**.
3. **Select subscription**.
4. **Enable "Defender for Containers"** plan.
5. **Configure features:**
   - **Image scanning:** Scan container images in ACR for vulnerabilities.
   - **Runtime threat detection:** Detect suspicious activities in running containers.
   - **Kubernetes admission control:** Enforce security policies at deployment time.

**Container image scanning:**

Defender for Containers automatically scans images pushed to ACR:

**Vulnerability findings:**

- **Image:** `contosoapp:v1.2.3`.
- **Vulnerabilities found:** 12 (3 High, 6 Medium, 3 Low).
- **High-severity vulnerabilities:**
  - **CVE-2024-12345:** OpenSSL buffer overflow (CVSS 8.9).
  - **CVE-2024-67890:** Node.js remote code execution (CVSS 9.1).
  - **CVE-2024-11111:** Apache Tomcat path traversal (CVSS 7.5).

**Remediation:**

```dockerfile
# Dockerfile - Update base image to patched version
FROM node:18-alpine3.18  # Updated from node:16-alpine3.15

WORKDIR /app

# Update system packages
RUN apk update && apk upgrade

# Copy application files
COPY package*.json ./
RUN npm ci --only=production

COPY . .

USER node
EXPOSE 3000
CMD ["node", "server.js"]
```

**Kubernetes runtime protection:**

Defender for Containers detects suspicious activities in running pods:

**Alert example:**

- **Alert:** "Cryptocurrency mining activity detected in container."
- **Severity:** High.
- **Affected resource:** Pod `payment-service-7d8f9c-abcd` in namespace `production`.
- **Details:** Process `xmrig` (cryptocurrency miner) executed in container with elevated CPU usage.

**Investigation and response:**

```bash
# Investigate suspicious pod
kubectl describe pod payment-service-7d8f9c-abcd -n production

# Check container processes
kubectl exec payment-service-7d8f9c-abcd -n production -- ps aux

# Review container logs
kubectl logs payment-service-7d8f9c-abcd -n production

# Terminate compromised pod
kubectl delete pod payment-service-7d8f9c-abcd -n production

# Scan container image for malware
az acr repository show-tags \
  --name contosoregistry \
  --repository payment-service \
  --detail
```

**Kubernetes admission control:**

Enforce security policies preventing deployment of vulnerable or non-compliant containers:

```yaml
# Azure Policy - Deny deployment of container images with high-severity vulnerabilities
apiVersion: constraints.gatekeeper.sh/v1beta1
kind: K8sAzureContainerAllowedImages
metadata:
  name: deny-vulnerable-images
spec:
  enforcementAction: deny
  match:
    kinds:
      - apiGroups: [""]
        kinds: ["Pod"]
    namespaces:
      - production
  parameters:
    allowedRegistries:
      - contosoregistry.azurecr.io
    maxSeverity: "Medium" # Block images with High or Critical vulnerabilities
```

## DevSecOps pipeline integration

Integrating Defender for Cloud with Azure DevOps pipelines enables **shift-left security** by detecting and blocking security issues before deployment.

**DevSecOps scenario:**

Development team deploys infrastructure using ARM templates in Azure Pipelines.

**Infrastructure-as-Code (IaC) scanning:**

**Azure Pipeline with Defender for Cloud IaC scanning:**

```yaml
trigger:
  - main

pool:
  vmImage: "ubuntu-latest"

steps:
  - task: AzureCLI@2
    displayName: "Install Microsoft Security DevOps"
    inputs:
      azureSubscription: "DevSecOps-Service-Connection"
      scriptType: "bash"
      scriptLocation: "inlineScript"
      inlineScript: |
        # Install Microsoft Security DevOps CLI
        dotnet tool install -g microsoft.security.devops.cli

  - task: MicrosoftSecurityDevOps@1
    displayName: "Run Security DevOps Analysis"
    inputs:
      categories: "IaC,secrets,dependencies"

  - task: PublishSecurityAnalysisLogs@3
    displayName: "Publish security scan results"
    inputs:
      ArtifactName: "CodeAnalysisLogs"

  - task: PostAnalysis@2
    displayName: "Post-analysis"
    inputs:
      GdnBreakAllTools: false
      GdnBreakGdnToolMicrosoftSecurityDevOps: true # Break build on security issues

  - task: AzureResourceManagerTemplateDeployment@3
    condition: succeeded() # Only deploy if security scan passes
    inputs:
      azureResourceManagerConnection: "Production-Service-Connection"
      subscriptionId: "$(AzureSubscriptionId)"
      resourceGroupName: "production-rg"
      location: "East US"
      templateLocation: "Linked artifact"
      csmFile: "$(Build.SourcesDirectory)/infrastructure/main.bicep"
      deploymentMode: "Incremental"
```

**Security findings in pipeline:**

Pipeline detects security issues in ARM template before deployment:

- **Finding 1:** Storage account configured without HTTPS enforcement (High severity).
- **Finding 2:** SQL Database firewall allows access from all Azure IPs (Medium severity).
- **Finding 3:** Key Vault soft delete not enabled (Medium severity).

**Pipeline result:** Build **fails** due to high-severity security finding, preventing deployment of insecure infrastructure.

**Remediation in template:**

```json
{
  "type": "Microsoft.Storage/storageAccounts",
  "apiVersion": "2023-01-01",
  "name": "[parameters('storageAccountName')]",
  "location": "[parameters('location')]",
  "sku": {
    "name": "Standard_GRS"
  },
  "kind": "StorageV2",
  "properties": {
    "supportsHttpsTrafficOnly": true, // Fixed: Enforce HTTPS
    "minimumTlsVersion": "TLS1_2",
    "allowBlobPublicAccess": false,
    "networkAcls": {
      "defaultAction": "Deny",
      "bypass": "AzureServices"
    }
  }
}
```

After fixing security issues, pipeline succeeds and deploys secure infrastructure.

## Vulnerability management

Defender for Cloud provides integrated vulnerability assessment for VMs, container images, and SQL databases without requiring third-party vulnerability scanners.

**Vulnerability assessment scenario:**

Organization has 200 VMs requiring continuous vulnerability scanning.

**Enable vulnerability assessment:**

Defender for Cloud automatically deploys **Microsoft Defender Vulnerability Management** agent to VMs when Defender for Servers is enabled.

**Vulnerability findings:**

Defender for Cloud identifies vulnerabilities across VM estate:

- **Critical vulnerabilities:** 5 VMs with remotely exploitable vulnerabilities.
- **High vulnerabilities:** 23 VMs with privilege escalation vulnerabilities.
- **Medium vulnerabilities:** 87 VMs with information disclosure vulnerabilities.
- **Low vulnerabilities:** 143 VMs with minor security weaknesses.

**Vulnerability details:**

- **CVE-2024-98765:** Windows Remote Desktop Services Remote Code Execution (RCE) vulnerability (CVSS 9.8).
- **Affected VMs:** 5 Windows Server 2019 VMs.
- **Remediation:** Install security update KB5044553.

**Automated remediation:**

```yaml
# Azure Automation - Automated vulnerability patching
workflow AutomatedVulnerabilityPatching {
  param(
    [string]$ResourceGroupName,
    [string]$VMName,
    [string]$UpdateKB
  )

  # Connect to Azure
  $connection = Get-AutomationConnection -Name AzureRunAsConnection
  Connect-AzAccount -ServicePrincipal `
    -Tenant $connection.TenantID `
    -ApplicationId $connection.ApplicationID `
    -CertificateThumbprint $connection.CertificateThumbprint

  # Get VM
  $vm = Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VMName

  # Install Windows Update
  Invoke-AzVMRunCommand `
    -ResourceGroupName $ResourceGroupName `
    -VMName $VMName `
    -CommandId 'RunPowerShellScript' `
    -ScriptString "Install-WindowsUpdate -KBArticleID $UpdateKB -AcceptAll -AutoReboot"

  Write-Output "Successfully installed update $UpdateKB on VM $VMName"
}
```

Microsoft Defender for Cloud provides versatile security capabilities applicable to incident response, compliance monitoring, security posture improvement, container security, DevSecOps integration, and vulnerability management. By applying Defender for Cloud to these practical scenarios, organizations achieve comprehensive security visibility, automated threat detection, and continuous compliance across Azure environments. The next unit explores Azure Policy for governance enforcement and compliance automation.
