Microsoft has updated how eDiscovery works in Microsoft Purview. If you're familiar with the older experience in the Microsoft Purview compliance portal, you'll notice several changes in the new one. Some workflows have been updated or consolidated, while others have been removed entirely.

## Why there are two eDiscovery experiences

During the transition from the Microsoft Purview compliance portal to the new portal, Microsoft introduced an updated experience for managing eDiscovery cases, searches, and review sets. For a limited time, you can still use the classic experience, but the new experience is the supported path going forward.

Many of the same concepts still apply, but the layout, terminology, and feature availability are different.

## What's different in the new experience?

Here are some of the most important differences between the classic and new eDiscovery experiences:

- **Advanced indexing runs automatically**: In the classic experience, advanced indexing had to be triggered manually to reprocess partially indexed content before you could search it. In the new experience, advanced indexing happens automatically when you run a search, add items to a review set, or export results. There's no need to initiate it separately.

- **Search statistics have replaced collections**: The classic experience used collections to estimate the size and scope of potentially relevant content. In the new experience, search statistics provide similar insights. You can still analyze the scope of results and preview items, but you're no longer limited to fixed, immutable collections. Searches can be updated or rerun at any time.

- **Content search is built into eDiscovery**: Previously, Content search was a separate feature from eDiscovery. In the new experience, content search is available by default in a system-generated eDiscovery case. Members of the eDiscovery Manager or Administrator role groups can access it directly. You can also manage holds and review sets within this case, depending on your subscription.

- **Cases are now the central organizing unit**: In the classic experience, custodians played a more prominent role in organizing cases. The new experience centers everything around the case itself. You still assign custodians and add data sources, but those actions all happen within the context of the case.

- **Exporting content is faster and more consistent**: The export process has been streamlined. It now provides faster performance, clearer reports, and consistent options for both standard and premium features. Exporting from either a review set or a search now follows the same unified process.

- **Jobs are now called processes**: In the classic experience, tasks and activities were grouped as jobs. The new experience uses the term processes instead. These provide more visibility and reporting for long-running tasks like indexing, exporting, or adding content to a review set.

## Feature availability based on licensing

In the new eDiscovery experience, standard and premium capabilities are part of the same unified interface. Your organization's license determines which features are available, but there's no longer a need to switch between separate tools. What you can do within a case depends on your permissions and subscription level.

Use the table to understand which capabilities are available based on your license:

| Capability  | Standard | Premium |
|-----|-----|-----|
| Search for content  | ✓ | ✓|
| Keyword queries and search conditions | ✓ | ✓ |
| Search statistics | ✓ | ✓ |
| Export search results | ✓ | ✓ |
| Role-based permissions | ✓ | ✓ |
| Case management | ✓ | ✓ |
| Place content locations on hold | ✓ | ✓ |
| Advanced indexing | | ✓ |
| Review sets | | ✓ |
| Cloud attachments and SharePoint versions | | ✓ |
| Optical character recognition (OCR) | | ✓ |
| Conversation threading | | ✓ |
| Review set filtering | | ✓ |
| Tagging | | ✓ |
| Analytics (email threading, near-duplicate) | | ✓ |
| Computed document metadata | | ✓ |
| Reporting for long-running processes | | ✓ |

## Temporary access to the classic experience

You can still use the classic eDiscovery experience in the Microsoft Purview portal if your organization relies on specific features that haven't yet migrated. These include:

- Sending and tracking legal hold notifications
- Associating custodians with reusable data sources
- Importing non-Microsoft 365 data into a review set
- Remediating multiple processing errors in bulk

These features will be available only for a limited time and are scheduled to retire after August 2025.

The new eDiscovery experience in Microsoft Purview simplifies how organizations manage searches, holds, and review sets across Microsoft 365. While many core features are still available, the updated interface improves performance and reduces the number of manual steps required. By understanding how the two experiences differ and what features your license includes, you can take full advantage of the latest tools and prepare for the retirement of the older interface.
