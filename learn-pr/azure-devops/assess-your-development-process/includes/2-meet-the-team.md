DevOps has many features and tools to help a team collaborate and improve its processes. Your journey through DevOps begins with an introduction to our fictitious software team members, who are discovering that they need to improve their release process.

Tailspin Toys, or Tailspin for short, is a video game company. Tailspin hosts its game servers and websites in an on-premises datacenter. The company just celebrated the release of a new racing game. They'll be releasing a space shooter game, called _Space Game_, in the coming months.

The team that you'll be working with builds websites to support new game titles. These websites provide information about the game, ways to get it, and leaderboards that show top scores. Each website must go live the same day the game is released, which requires coordination among the teams and puts some extra pressure on the web team.

The _Space Game_ website is a .NET app written in C# that's deployed to Linux. The website isn't finished yet, but here's what it looks like right now:

<!-- TODO: Host this under our team account. -->
<!-- TODO: Throw a fake DNS name in front of this to hide the fact we're hosting it on Azure - the fictitious team isn't there yet. -->

:::image type="content" source="../media/2-space-game-top.png" alt-text="Screenshot of a web browser showing the Space Game website. The page shows graphics from the game and a button to download the game.":::

And here's what the leaderboard looks like:

:::image type="content" source="../media/2-space-game-leaderboard.png" alt-text="Screenshot of a web browser showing the Space Game leaderboard. The leaderboard shows the top 10 players and their high scores.":::

You can filter the leaderboard by mode or by game map. You can also select a player's name to see their profile and game achievements:

:::image type="content" source="../media/2-player-profile.png" alt-text="Screenshot of the Space Game website showing the top player's profile information.":::

Here are your team members:

<!-- TODO: We need final graphics for the team members. -->

[!include[](../../shared/includes/meet-andy-row.md)]

[!include[](../../shared/includes/meet-amita-row.md)]

[!include[](../../shared/includes/meet-tim-row.md)]

[!include[](../../shared/includes/meet-irwin-row.md)]

[!include[](../../shared/includes/meet-mara-row.md)]

## Good morning

Irwin, the team's product manager, has called everyone into a meeting, and he's in a bad mood. The leaderboard for the racing game was updated with several new features and he showed it at a local gaming group. Players' reactions were disappointing, to say the least. He reads off a list of the top problems:

* Some features work correctly for only some game modes.
* Updating the leaderboard takes too long, even with a few players.
* Multiple scores per player show up as multiple players.
* The new ranking feature returns incorrect results.
* There's no way to group scores according to a specific date or game session.
* It took months to produce the new release (and it's broken).

He demands, "How long before these problems are fixed?"

**Andy thinks**: I bet it'll take me a month to write that code.

**Amita thinks**: It'll take me at least a week to test this code and I can't start until Andy is finished, and he always wants to sneak in new code.

**Tim thinks**: It'll take me at least a week to set up the environments and deploy this code to production. I can't start until Amita is finished, and she's never willing to call something a release candidate.

**Mara wonders**: Was taking this job a mistake?

Andy looks around at his teammates and says, "We'll get back to you."
