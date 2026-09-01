::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=260634fa-417d-437b-8d6f-167a33fa950e]

::: zone-end

::: zone pivot="text"

3:47 AM. The PagerDuty alert wakes the on-call engineer: checkout completion rate dropped 15% in the last hour. Thousands of customers are abandoning carts. The service level agreement (SLA) breach timer starts ticking—45 minutes to identify root cause and restore service before escalation to senior leadership.

Adventure Works' multi-agent customer service platform has 14 agents involved in the checkout flow. Application Insights shows red metrics across multiple agents. The distributed trace viewer displays a tangled web of requests spanning six services. Customer complaints are flooding social media. This is what production debugging looks like for multi-agent systems—time pressure, distributed complexity, limited visibility into what changed, and significant business impact.

The debugging challenge in multi-agent systems is different from monolithic applications. In a single service, you follow the stack trace to the exception and check recent code changes. In a multi-agent system, the failure may have originated three agents upstream from where the error surfaced. The root cause could be a model deployment change rather than a code change. Reproducing the issue requires reconstructing the exact multi-step conversation flow with specific model versions and tool responses. Traditional debugging strategies don't translate directly.

In this module, you learn how to:

- Use agent replay techniques to reproduce production failures deterministically in controlled environments.
- Design systematic root cause analysis frameworks for multi-agent service failures.
- Configure automated detection and remediation for recurring failure patterns.
- Establish incident response processes with blameless postmortems that drive reliability improvements.

By the end of this module, you know how to debug production multi-agent incidents under time pressure and build systems that detect and remediate failures before customers notice.

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
