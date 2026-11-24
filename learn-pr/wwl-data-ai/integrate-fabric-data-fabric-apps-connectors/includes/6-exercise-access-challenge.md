In this unit, you learn what sharing a Fabric app does and doesn't grant. Then you apply that knowledge in a challenge that has no step-by-step instructions. A one-user test can't prove another user's access, so you predict, justify, and verify what you can.

## Understand what sharing grants

App access and data access aren't the same. A user can open the app and still fail to run an operation that needs a related item. The sharing experience reviews the app's lineage to find the underlying Fabric items, and the identity mode of each connector decides what it shows.

| Identity mode | What sharing presents | Who needs source access |
|:--------------|:----------------------|:------------------------|
| Application | Items accessed with application authentication aren't presented for per-user grants. | The app identity needs source permissions. Users don't need their own grants to those items. |
| Delegated | Related items accessed on behalf of the signed-in user are presented for review. | Each user needs access and the permissions that the operation requires. |

Keep these points in mind:

- **Application access doesn't make the source public.** The app still controls what it exposes, and users still need app access and entity permissions.

- **Completing the share doesn't prove that every feature works.** Recipients who lack access to an unshared related item can open the app and still fail on the features that depend on it.

- **An app can mix modes.** Review the deployed connector configuration instead of assuming that every connection uses the same mode.

- **Direct access isn't scoped to one app.** Removing a user's direct grant on a related item can remove access that another report or app also relies on.

- **Lakehouse access has an extra step.** For delegated access through a lakehouse SQL analytics endpoint, sharing the app grants permissions on the endpoint but not Read permission on the parent lakehouse.

## The challenge

Adventure Works shares the app with a new regional manager. The manager can run the app and has no access to the warehouse or the semantic model.

1. For each connector, write a prediction in one sentence:
   - What does the new manager see in the inventory view, which uses application access?
   - What does the new manager see in the sales view, which uses delegated access?
1. Justify each prediction by using the configuration: the connector's `auth.type`, the identity that runs the query, and the sharing rules.
1. Verify what you can without a second user. Run `npx rayfin connector list`, check each `auth.type` and `operations` list in `rayfin/rayfin.yml`, and confirm that the inventory connector allows only `read`. Don't claim that your own successful test proves another user's access.
1. Decide which change fixes the sales view for this manager. Then explain why that change is a governance decision and not a configuration shortcut.

If you need a hint, remember that the application identity is the app item owner, and a delegated call runs as the signed-in user.

## Compare with the expected reasoning

- The inventory view returns the same rows for the new manager, because the query runs as the app identity. The manager needs only app access and the `read` entity role. Application authentication doesn't present the warehouse for a per-user grant.
- The sales view shows an error for the new manager, because the delegated call runs under the manager's identity, and the manager lacks access to the model. Sharing the app doesn't grant access to related items that you leave unshared.
- Granting the manager Read and Build on the semantic model, or sharing the model in the sharing experience, fixes the sales view and keeps per-user governance. Switching the sales connector to `application` isn't possible, because semantic models support delegated access only.

## Clean up

Remove the app and sample resources created for this module. Deleting the app doesn't delete the warehouse or semantic model that its connectors access.

1. Stop any running local development session.
1. In your development Fabric workspace, delete the `adventure-connectors` app item and any remaining child items created for the app.
1. Delete the `AdventureWorksSales` semantic model and the `AdventureWorksConnectors` warehouse created during the source setup. If you used existing organizational sources instead, don't delete those shared items.
1. Delete the local `adventure-connectors` project folder after closing any terminals or editor windows that use it.
