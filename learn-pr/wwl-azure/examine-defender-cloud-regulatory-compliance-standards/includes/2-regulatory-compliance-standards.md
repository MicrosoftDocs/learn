Microsoft Defender for Cloud streamlines the regulatory compliance process by helping you to identify issues that are preventing you from meeting a particular compliance standard, or achieving compliance certification.

Industry standards, regulatory standards, and benchmarks are represented in Defender for Cloud as [security standards](/azure/defender-for-cloud/security-policy-concept), and appear in the Regulatory compliance dashboard.

## Compliance controls

Each security standard consists of multiple compliance controls, which are logical groups of related security recommendations.

Defender for Cloud continually assesses the environment-in-scope against any compliance controls that can be automatically assessed. Based on assessments, it shows resources as being compliant or non-compliant with controls.

> [!NOTE]
> It's important to note that if standards have compliance controls that can't be automatically assessed, Defender for Cloud isn't able to decide whether a resource complies with the control. In this case, the control will show as greyed out.

## Viewing compliance standards

The Regulatory compliance dashboard provides an interactive overview of compliance state.

:::image type="content" source="../media/regulatory-compliance-dashboard-overview-05d39e24-cc7cb7de.png" alt-text="Screenshot showing an example of the regulatory compliance dashboard in Microsoft Defender for Cloud.":::


In the dashboard you can:

 -  Get a summary of standards controls that have been passed.
 -  Get of summary of standards that have the lowest pass rate for resources.
 -  Review standards that are applied within the selected scope.
 -  Review assessments for compliance controls within each applied standard.
 -  Get a summary report for a specific standard.
 -  Manage compliance policies to see the standards assigned to a specific scope.
 -  Run a query to create a custom compliance report.
 -  [Create a "compliance over time workbook"](/azure/defender-for-cloud/custom-dashboards-azure-workbooks) to track compliance status over time.
 -  Download audit reports.
 -  Review compliance offerings for Microsoft and third-party audits.

## Compliance standard details

For each compliance standard you can view:

 -  Scope for the standard.
 -  Each standard broken down into groups of controls and subcontrols.
 -  When you apply a standard to a scope, you can see a summary of compliance assessment for resources within the scope, for each standard control.
 -  The status of the assessments reflects compliance with the standard. There are three states:
    
    
     -  A green circle indicates that resources in scope are compliant with the control.
     -  A red circle indicates that resources are not compliant with the control.
     -  Unavailable controls are those that can't be automatically assessed and thus Defender for Cloud is unable to access whether resources are compliant.

You can drill down into controls to get information about resources that have passed/failed assessments, and for remediation steps.

## Default compliance standards

By default, when you enable Defender for Cloud, the following standards are enabled:

 -  For Azure: [Microsoft Cloud Security Benchmark (MCSB)](/azure/defender-for-cloud/concept-regulatory-compliance).
 -  For AWS: [Microsoft Cloud Security Benchmark (MCSB)](/azure/defender-for-cloud/concept-regulatory-compliance) and [AWS Foundational Security Best Practices standard](https://docs.aws.amazon.com/securityhub/latest/userguide/fsbp-standard.html).
 -  For GCP: [Microsoft Cloud Security Benchmark (MCSB)](/azure/defender-for-cloud/concept-regulatory-compliance) and GCP Default.

## Available compliance standards

The following standards are available in Defender for Cloud:

| **Standards for Azure subscriptions** | **Standards for AWS accounts**                        | **Standards for GCP projects**                        |
| ------------------------------------- | ----------------------------------------------------- | ----------------------------------------------------- |
| Australian Government ISM Protected   | AWS Foundational Security Best Practices              | Brazilian General Personal Data Protection Law (LGPD) |
| Canada Federal PBMM                   | AWS Well-Architected Framework                        | California Consumer Privacy Act (CCPA)                |
| CIS Azure Foundations                 | Brazilian General Personal Data Protection Law (LGPD) | CIS Controls                                          |
| CMMC                                  | California Consumer Privacy Act (CCPA)                | CIS GCP Foundations                                   |
| FedRAMP ‘H’ & ‘M’         | CIS AWS Foundations                                   | CIS Google Cloud Platform Foundation Benchmark        |
| HIPAA/HITRUST                         | CRI Profile                                           | CIS Google Kubernetes Engine (GKE) Benchmark          |
| ISO/IEC 27001                         | CSA Cloud Controls Matrix (CCM)                       | CRI Profile                                           |
| New Zealand ISM Restricted            |                                                       | CSA Cloud Controls Matrix (CCM)                       |
| NIST SP 800-171                       | ISO/IEC 27001                                         | Cybersecurity Maturity Model Certification (CMMC)     |
| NIST SP 800-53                        | ISO/IEC 27002                                         | FFIEC Cybersecurity Assessment Tool (CAT)             |
| PCI DSS                               | NIST Cybersecurity Framework (CSF)                    |                                                       |
| RMIT Malaysia                         | NIST SP 800-172                                       | ISO/IEC 27001                                         |
| SOC 2                                 | PCI DSS                                               | ISO/IEC 27002                                         |
| SWIFT CSP CSCF                        |                                                       | ISO/IEC 27017                                         |
| UK OFFICIAL and UK NHS                |                                                       | NIST Cybersecurity Framework (CSF)                    |
|                                       |                                                       | NIST SP 800-53                                        |
|                                       |                                                       | NIST SP 800-171                                       |
|                                       |                                                       | NIST SP 800-172                                       |
|                                       |                                                       | PCI DSS                                               |
|                                       |                                                       | Sarbanes Oxley Act (SOX)                              |
|                                       |                                                       | SOC 2                                                 |
