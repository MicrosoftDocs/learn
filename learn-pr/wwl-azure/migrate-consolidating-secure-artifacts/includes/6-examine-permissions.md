The feeds in Azure Artifacts require permission to the various features it offers. The list of permissions consists of increasing privileged operations.

The list of privileges is as follows:

:::image type="content" source="../media/2-2-permissions-roles-matrix-a7c8db4f.png" alt-text="Screenshot of Permissions Roles matrix.":::


You can assign users, teams, and groups to a specific role for each permission, giving the permissions corresponding to that role.

You need to have the Owner role to do so. Once an account has access to the feed from the permission to list and restore packages, it's considered a `Feed user`.

:::image type="content" source="../media/2-2-feed-permissions-d556816e.png" alt-text="Screenshot of Feed Permissions.":::


Like permissions and roles for the feed itself, there are extra permissions for access to the individual views.

Any feed user has access to all the views, whether the default views of @Local, @Release, @Prerelease or newly created ones.

When creating a feed, you can choose whether the feed is visible to people in your Azure DevOps organization or only specific people.

:::image type="content" source="../media/2-2-feed-visibility-653a1c98.png" alt-text="Screenshot of Feed visibility.":::


See also: [Secure and share packages using feed permissions](/azure/devops/artifacts/feeds/feed-permissions).
