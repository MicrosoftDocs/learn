When using a remote Windows session, your network's available bandwidth greatly impacts the quality of your experience. Different applications and display resolutions require different network configurations, so it's important to make sure your network is configured to meet your needs.

The following recommendations apply to networks with less than 0.1% loss. These recommendations apply regardless of how many sessions you're hosting on your virtual machines (VMs).

## Applications

The following table lists the minimum recommended bandwidths for a smooth user experience.

:::row:::
  :::column:::
    **Workload type**
  :::column-end:::
  :::column:::
    **Recommended bandwidth**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Light
  :::column-end:::
  :::column:::
    1.5 Mbps
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    3 Mbps
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Heavy
  :::column-end:::
  :::column:::
    5 Mbps
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Power
  :::column-end:::
  :::column:::
    15 Mbps
  :::column-end:::
:::row-end:::


Keep in mind that the stress put on your network depends on both your app workload's output frame rate and your display resolution. If either the frame rate or display resolution increases, the bandwidth requirement will also rise. For example, a light workload with a high-resolution display requires more available bandwidth than a light workload with regular or low resolution.

Other scenarios can have their bandwidth requirements change depending on how you use them, such as:

 -  Voice or video conferencing
 -  Real-time communication
 -  Streaming 4K video

Make sure to load test these scenarios in your deployment using simulation tools like Login VSI. Vary the load size, run stress tests, and test common user scenarios in remote sessions to better understand your network's requirements.

## Display resolutions

Different display resolutions require different available bandwidths. The following table lists the bandwidths we recommend for a smooth user experience at typical display resolutions with a frame rate of 30 frames per second (fps). These recommendations apply to single and multiple user scenarios. Keep in mind that scenarios involving a frame rate under 30 fps, such as reading static text, require less available bandwidth.

:::row:::
  :::column:::
    **Typical display resolutions at 30 fps**
  :::column-end:::
  :::column:::
    **Recommended bandwidth**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    About 1024 × 768 px
  :::column-end:::
  :::column:::
    1.5 Mbps
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    About 1280 × 720 px
  :::column-end:::
  :::column:::
    3 Mbps
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    About 1920 × 1080 px
  :::column-end:::
  :::column:::
    5 Mbps
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    About 3840 × 2160 px (4K)
  :::column-end:::
  :::column:::
    15 Mbps
  :::column-end:::
:::row-end:::
