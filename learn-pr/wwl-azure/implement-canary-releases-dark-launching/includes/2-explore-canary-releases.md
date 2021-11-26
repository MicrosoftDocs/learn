The term canary release comes from the days that miners took a canary with them into the coal mines.

The purpose of the canary was to identify the existence of toxic gasses.

The canary would die much sooner than the miner, giving them enough time to escape the potentially lethal environment.

A canary release is a way to identify potential problems without exposing all your end users to the issue at once.

The idea is that you tell a new feature only to a minimal subset of users.

By closely monitoring what happens when you enable the feature, you can get relevant information from this set of users and either continue or rollback (disable the feature).

If the canary release shows potential performance or scalability problems, you can build a fix for that and apply that in the canary environment.

After the canary release has proven to be stable, you can move the canary release to the actual production environment.

:::image type="content" source="../media/canary-release-47d754eb.png" alt-text="Screenshot of Canary Release.":::


Canary releases can be implemented using a combination of feature toggles, traffic routing, and deployment slots.

 -  You can route a percentage of traffic to a deployment slot with the new feature enabled.
 -  You can target a specific user segment by using feature toggles.
