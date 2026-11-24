The Adventure Works Cycles app is in production, and a regional manager reports that they can open the app but see no inventory data. The cause is rarely the app. Access has layers, and this unit teaches you to trace which layer failed.

## Share the app through item permissions

To give someone access to a Fabric app without adding them to its workspace, grant access directly to the app item. In the Fabric portal, select **Share** to open the **Grant recipients access** dialog. Enter the recipients by name or email address, and review these permissions:

| Permission | What it allows |
| :----------- | :--------------- |
| **View and Execute** (granted by default) | Open and use the deployed app, including calling its backend APIs. |
| **Share** (optional) | Share the app with other people. Leave this checkbox cleared unless recipients need to share it further. |

Choose whether to notify recipients by email, optionally add a message, and select **Grant** when you're ready to share. You need authority to share the app; granting access to related items also requires authority to share those items.

:::image type="content" source="../media/grant-recipient-access.png" alt-text="Screenshot of the Grant recipients access dialog showing default View and Execute permissions, the optional Share checkbox, and notification options." lightbox="../media/grant-recipient-access.png":::

Depending on the app's connections and authentication modes, the sharing experience can also present related items, such as semantic models, lakehouses, warehouses, and SQL databases in Fabric. Review any permissions offered for those items and any items you can't share. An app with no delegated connections might not show related items. Other access paths include:

- **Access requests.** A person who opens the app without access can send a request to the app owner. Approval uses the sharing experience, so the owner reviews related items instead of granting everything.
- **Org apps.** You can include a Fabric app in an org app. Users still need the permissions that the app's authentication modes and data operations require.
- **Links.** A link doesn't grant access by itself.

## Separate access to the app from access to the data

Three layers decide what a user sees:

| Layer | Question | Controlled by |
|:------|:---------|:--------------|
| The app | Can the user open the app and call its backend? | Item permissions on the app |
| Related items | Can the user reach sources the app reads under their own identity? | Permissions on each source item |
| Data policies | Which rows and fields can the user see? | Entity permission decorators |

Application authentication leaves source access with the app identity, which is currently the owner of the app item. The sharing experience doesn't present application-authenticated source items for per-user grants, and every user who can open the app sees the same source view. Application authentication doesn't make the source public, because the app's data policies still control what each user gets. Delegated authentication runs queries as each signed-in user, so each person needs permission on each related item. Sharing the app doesn't grant access to unshared related items. An app can use different modes for different connectors, so review the deployed connector configuration instead of assuming one mode.

## Diagnose a user with no data

When one manager sees no data, check these layers:

- **App access.** Can the manager open the app? If not, check item permissions.
- **Related items.** If the connector uses delegated access, does the manager have access to the warehouse or semantic model?
- **Data policies.** Do entity rules hide the rows from this user, such as an owner-only policy with no rows owned by them?

For the Adventure Works manager who opens the app but sees no inventory, the app layer works. The next question is whether the inventory connector uses delegated access, which makes related-item access the likely cause. If the inventory source is a lakehouse that the connector reads through its SQL analytics endpoint, check one more detail. App sharing grants permissions on the endpoint but doesn't grant **Read** on the parent lakehouse, so someone with sharing authority on the lakehouse must grant it separately.

A failed operation doesn't by itself prove an access problem. Reproduce the failure with the same signed-in user, and read the actual error before you change any permission.

## Review before you share

In this guided task, you review what a share involves without sending a grant.

1. Open your deployed app item in the Fabric portal, and select **Share**.
1. Confirm that the dialog grants **View and Execute** permissions by default. Leave the optional **Share** checkbox cleared.
1. If you have a test recipient in your organization, select them by name or email address. Review any related items and the permissions offered for each. Don't select **Grant**.
1. Close the dialog without sending the share.

Your starter app might not show any related items. When an app has delegated connections, users need access to those sources; application-authenticated sources aren't presented for per-user grants. Grant only the permissions a recipient needs, and leave **Share** cleared unless they need to share the app further.

A Fabric administrator can also block an app. A blocked app can't be loaded by anyone except its owner, but blocking doesn't restrict the app's backend APIs.

## Next step

In the next unit, you learn how to monitor a released app and diagnose failures by layer.
