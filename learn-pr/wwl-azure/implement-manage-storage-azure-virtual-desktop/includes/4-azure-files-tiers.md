Azure Files offers two different tiers of storage: premium and standard. These tiers let you tailor the performance and cost of your file shares to meet your scenario's requirements.

 -  Premium file shares are backed by solid-state drives (SSDs) and are deployed in the FileStorage storage account type. Premium file shares provide consistent high performance and low latency for input and output (IO) intensive workloads. Premium file shares use a provisioned billing model, where you pay for the amount of storage you would like your file share to have, regardless of how much you use.
 -  Standard file shares are backed by hard disk drives (HDDs) and are deployed in the general purpose version 2 (GPv2) storage account type. Standard file shares provide reliable performance for IO workloads that are less sensitive to performance variability, such as general-purpose file shares and dev/test environments. Standard file shares use a pay-as-you-go billing model, where you pay based on storage usage, including data stored and transactions.

The table lists our recommendations for which performance tier to use based on your workload. These recommendations will help you select the performance tier that meets your performance targets, budget, and regional considerations. We've based these recommendations on the example scenarios from [Remote Desktop workload types](/windows-server/remote/remote-desktop-services/remote-desktop-workloads).

| **Workload type**            | **Recommended file tier**                                 |
| ---------------------------- | --------------------------------------------------------- |
| Light (fewer than 200 users) | Standard file shares                                      |
| Light (more than 200 users)  | Premium file shares or standard with multiple file shares |
| Medium                       | Premium file shares                                       |
| Heavy                        | Premium file shares                                       |
| Power                        | Premium file shares                                       |
