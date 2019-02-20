Detecting threats to your data is an important part of security. As mentioned earlier, you can check an audit trail for all activity against a storage account. However, that's often only going to show you when an intrusion _has already occurred_. What we really want is a way to be notified when suspicious activity is actively occuring. Enter **Azure Storage Advanced Thread Protection**.

Azure Storage Advanced Threat Protection (preview) detects anomalies in account activity and notifies you of potentially harmful attempts to access your account. This layer of protection allows you to address threats without the need to be a security expert or manage security monitoring systems. Today, Storage Threat Detection is available for the Blob service. Security alerts are integrated with Azure Security Center and are sent by email to subscription admins.

You can turn on threat protection in the Azure portal through the configuration page of the Azure Storage account.

1. In the **Settings** page, select **Advanced Threat Protection**.
3. In the **Advanced Threat Protection** configuration blade
    - Turn **ON** Advanced Threat Protection
    - Click **Save** to save the new or updated Advanced Threat Protection policy.

![Screenshot of Advanced Threat Protection Preview](../media/6-preview.png)