Take remote safeguarding one step further by integrating with [Conditional access app control](/defender-cloud-apps/proxy-intro-aad). This integration enables organizations to apply real-time access and session controls for cloud applications, ensuring only compliant devices and authenticated users can interact with sensitive data. With Conditional Access App Control, administrators can dynamically restrict downloads, uploads, or other risky actions in cloud apps. These restrictions are based on user risk levels, device compliance, and session context.

What are ways to integrate Defender for Cloud Apps for real-time session monitoring and configure session controls in web apps?

- Onboard your cloud applications (for example, OneDrive and Google Drive) into Defender for Cloud Apps using the app connectors.

- Enable real-time session controls by configuring policies that monitor user activities during live sessions.

- Set policy conditions based on user risk levels, device compliance, or location.

- Create session policies that detect attempts to download or upload files marked as sensitive (for example, containing Social Security Numbers or labeled as highly confidential).

- Trigger real-time controls to block risky actions such as downloading or uploading sensitive files.

- This approach is effective for remote workers accessing company resources from unmanaged devices or networks, helping to contain risky behavior before data loss occurs.

Configuration of session controls involves specifying what actions should be blocked or monitored and under which circumstances.

- Administrators can use adaptive protection to dynamically restrict downloads and uploads based on detected insider risk levels or specific file labels.

- For instance, if a user with an elevated risk level tries to download a sensitive document from OneDrive, the policy can immediately block the download and notify the user or security team.

- Similarly, uploads to cloud storage can be restricted for risky users, ensuring sensitive files aren't transferred outside approved environments.

- These controls work seamlessly with endpoint DLP and Conditional Access. Together, they provide a comprehensive, layered approach to data protection for remote employees, regardless of where or how they access corporate data.

Use [Microsoft Entra Conditional Access](/entra/identity/conditional-access/overview) to require compliant, domain-joined devices or enforce MFA for access to critical resources.
