To help secure your systems and environment, Microsoft Defender for Cloud generates security recommendations. These recommendations are based on industry best practices, which are incorporated into the generic, default security policy supplied to all customers. They can also come from Defender for Cloud's knowledge of industry and regulatory standards.

With this feature, you can add your own custom initiatives. Although custom initiatives aren't included in the secure score, you'll receive recommendations if your environment doesn't follow the policies you create. Any custom initiatives you create are shown in the list of all recommendations and you can filter by initiative to see the recommendations for your initiative. They're also shown with the built-in initiatives in the regulatory compliance dashboard, as described in the tutorial Improve your regulatory compliance.

As discussed in the Azure Policy documentation, when you specify a location for your custom initiative, it must be a management group or a subscription.

## To add a custom initiative to your subscription

1. From Defender for Cloud's menu, open **Environment settings**.

2. Select the relevant subscription or management group to which you would like to add a custom initiative.

*For your custom initiatives to be evaluated and displayed in Defender for Cloud, you must add them at the subscription level (or higher). We recommend that you select the widest scope available.*

3. Open the **Security policy** page, and in the **Your custom initiatives** area, select **Add a custom initiative**.

    :::image type="content" source="../media/access-security-policy-page-7e1d5026.png" alt-text="Screenshot showing the security policy page in Defender for Cloud.":::


4. Review the list of custom policies already created in your organization, and select **Add** to assign a policy to your subscription.

If there isn't an initiative in the list that meets your needs, you can create one.

## To create a new custom initiative:

1. Select **Create new**.<br>

2. Enter the definition's location and custom name.<br>

*Custom initiatives shouldn't have the same name as other initiatives (custom or built-in). If you create a custom initiative with the same name, it will cause a conflict in the information displayed in the dashboard.*

3. Select the policies to include and select **Add**.

4. Enter any desired parameters.<br>

5. Select **Save**.<br>

6. In the **Add** custom initiatives page, select refresh. Your new initiative will be available.

    :::image type="content" source="../media/create-add-custom-policy-c374edf8.png" alt-text="Screenshot showing the add custom initiatives page.":::


*Creating new initiatives requires subscription owner credentials.*

Your new initiative takes effect and you can see the results in the following two ways:

 -  From the Defender for Cloud menu, select **Regulatory compliance**. The compliance dashboard opens to show your new custom initiative alongside the built-in initiatives.<br>
 -  You'll begin to receive recommendations if your environment doesn't follow the policies you've define<br>

7. To see the resulting recommendations for your policy, select **Recommendations** from the sidebar to open the recommendations page. The recommendations will appear with a "Custom" label and be available within approximately one hour.

    :::image type="content" source="../media/custom-policy-recommendations-3c20e520.png" alt-text="Screenshot showing the recommendations page in Defender for Cloud.":::
