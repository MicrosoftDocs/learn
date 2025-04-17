To search for content in Microsoft Purview eDiscovery, you must first create a case. A case provides the workspace where searches, holds, and exports are managed. Creating a search also creates a case, which ensures that access to investigation data is controlled and auditable. This ensures that access to investigation data is controlled and auditable.

## Why cases are required

Every search must be associated with a case. The case model provides:

- Controlled access to investigation data
- An auditable trail of search and export actions
- A consistent structure for managing investigation tasks

The person who creates the case is automatically added as a member. Other users must be added manually. Even with the correct eDiscovery roles, users can’t access a case unless they’re listed as a member.

## Create a search

You can either create a case and search in a single step or create a search through a case.

### Create a search directly

1. In the [Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true), go to **Solutions** > **eDiscovery** > **Cases**.
1. Select the arrow next to **+ Create case**, then select **Create search**.

   :::image type="content" source="../media/create-search-split-button.png" alt-text="Screenshot showing split button and where to create a search in eDiscovery." lightbox=" ../media/create-search-split-button.png":::

1. Enter a **case name** and a **search name**.
1. Optionally, provide descriptions for the case and search.
1. Select **Create** to create the case and search.

   :::image type="content" source="../media/create-search-fields.png" alt-text="Screenshot showing the fields to create an eDiscovery search." lightbox=" ../media/create-search-fields.png":::

This creates a case and a search at the same time, so you can move directly into configuring your search criteria without setting up the case separately.

### Create a search through a case

If you prefer to create the case first and then add a search from within it:

1. Go to **Solutions** > **eDiscovery** > **Cases**.
1. Select **+ Create case**.
1. Enter a **name** and optional **description**.
1. Select **Create** to create a case.

   :::image type="content" source="../media/create-case-fields.png" alt-text="Screenshot showing the fields to create an eDiscovery case." lightbox=" ../media/create-case-fields.png":::

1. On the **Searches** tab of your case, select **Create search**.
1. Enter a **name** and optional **description**.
1. Select **Create** to create the search.

Once the search is created, you can begin configuring the search criteria to locate the content relevant to your investigation.