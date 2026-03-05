Balancing alert volume is an important part of maintaining an efficient insider risk program. If your policies generate too few alerts, you might miss meaningful signals. If they generate too many, investigators might become overwhelmed, making it harder to focus on high-risk activity. Microsoft Purview Insider Risk Management includes several tools and settings to help you fine-tune alert volume and ensure your environment supports consistent, focused investigations.

## When you're receiving too few alerts

Receiving fewer alerts than expected might indicate that your policies are too narrow or that thresholds are set too high. To increase alert volume:

- **Enable more risk indicators** in the **Policy indicators** settings. This expands the types of activities that policies detect.
- **Include more users** in policy scope by editing the **Users and groups** section of the policy.
- **Lower trigger thresholds** to start evaluating users earlier based on specific events, such as resignation or access to sensitive content.
- **Lower indicator thresholds** to generate alerts based on less frequent or less severe activity.
- **Adjust the alert volume slider** under **Settings > Intelligent detections**. Moving the slider toward "More alerts" increases overall alert generation, including medium- and low-severity alerts.

> [!TIP]
> Policies based on certain templates, like _Data leaks_ and _Risky browser usage_, allow custom thresholds that can be lowered to help generate more alerts.

## When you're receiving too many alerts

High alert volume can overwhelm analysts and reduce the effectiveness of your investigation process. To reduce alert volume:

- **Enable analytics** in **Settings > Analytics** to identify high-risk areas and adjust your approach accordingly.
- **Use real-time insights** to update thresholds and indicator selections based on recommended values.
- **Refine policy scope and content** by narrowing the list of in-scope users or prioritizing only the most sensitive files and communication channels.
- **Enable inline alert customization** to allow analysts to adjust thresholds during triage.
- **Dismiss multiple low-priority alerts in bulk** to reduce noise in the alert queue.

## Configuration options for alert management

Beyond basic tuning, Microsoft Purview provides several configuration options to help manage alert volume more effectively:

- **Use appropriate policy templates** to target specific risk scenarios.
- **Configure global exclusions** to prevent benign activity from triggering alerts.
- **Define detection groups** to apply different policies to different user populations.
- **Create indicator variants** to refine detection logic.
- **Adjust policy timeframes** to control how far back activity is evaluated.
- **Assign appropriate roles** to ensure only qualified users can make sensitive configuration changes.

Effective alert volume management requires both upfront planning and ongoing tuning. Use built-in analytics and threshold recommendations to maintain a manageable signal-to-noise ratio. When alert volume is tuned effectively, your investigation process becomes more focused, efficient, and aligned with organizational risk priorities.
