> [!VIDEO https://learn-video.azurefd.net/vod/player?id=872dc789-d141-472d-80dc-cb12f99a5e07]

You operate 200 Windows virtual machines (VMs) for a retailer. Of those, 190 serve the public returns portal in load-balanced pools and 10 serve a separate staff application. Each public backend reads its support link from a local file. Your first update reports failure, yet a direct request to that VM returns the new link. Most customers still see the old one. You run the change; the **portal workload owner**, who is accountable for the returns service, decides whether to release the next wave. What evidence would you present before exposing another pool?

:::image type="content" source="../media/returns-portal-request-path.svg" alt-text="Diagram that shows the new link on one canary and the old link on the other 189 public backends, with 10 staff VMs outside the portal.":::

Before you review the portal change, separate two decisions. **Which tool changes the setting?** That depends on where the setting lives and how long it should stay in effect. **How will you change a fleet that's already serving users?** That takes an agreed list of VMs, a way to detect failure on the first one, and a way to recover without putting the others at risk.

:::image type="content" source="../media/fleet-tool-rollout-decisions.svg" alt-text="Diagram that shows why choosing a guest command doesn't authorize a 19-VM pilot or more than one concurrent write per pool.":::
