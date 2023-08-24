Now we have an understanding of the components of a prompt and how to use the components to construct a prompt to generate high-quality completions. 

Let's update the hiking recommendation application we started in the previous exercise to incorporate some of those techniques.

## Update the system prompt

When classifying a product review, we only want the model to tell us if the review is positive, neutral, or negative. Let's update the prompt the model receives so it has the best chance of providing a high-quality response.

The current system prompt is OK, but we can get the model to recommend more appropriate and exciting hikes by following best practices in prompt construction. Let's make the instructions on how the model should act a bit more clear

### Add instructions

1. Open up the **HikingConversationsAI** project you created earlier.
1. In the **Program.cs** file, locate the `systemPrompt` variable that is used to tell the model its personality traits and any rules it needs to follow.
1. Remove all existing text from the variable and add the following that that outlines how the model should act and the rules it should follow:

    ```csharp
    var systemPrompt = 
    """
    You are a hiking enthusiast who helps people discover fun hikes in their area. You are upbeat and friendly. You introduce yourself when first saying hello. When helping people out, you always ask them for this information to inform the hiking recommendation you provide:
    
    1. Where they are located
    2. What hiking intensity they are looking for
    """;
    ```

### Add primary content

The primary content refers to the text that is being transformed by the model and what to do with it. In this case the hiking recommendations themselves.

1. Update the `systemPrompt` variable to instruct the model what to do with the content.

    ```csharp
    var systemPrompt = 
    """
    You are a hiking enthusiast who helps people discover fun hikes in their area. You are upbeat and friendly. You introduce yourself when first saying hello. When helping people out, you always ask them for this information to inform the hiking recommendation you provide:
    
    1. Where they are located
    2. What hiking intensity they are looking for
    
    You will then provide three suggestions for nearby hikes that vary in length after you get that information. You will also share an interesting fact about the local nature on the hikes when making a recommendation.
    """;
    ```

## Improve hiking recommendation requests

Now that the model has better information on how it should act and the rules it should follow, let's make the requests it receives better so the hikes it recommends can be more appropriate.

### Be specific

The previous request only said the hike should be strenous with a great view. Let's tell the model exactly what we're looking for.

1. Find the `hikeRequest` variable and update it to have the following specific request information.

    ```csharp
    var hikeRequest = 
    """
    I live near Seattle and would like a strenous hike around the I-90 corridor that ends with
    a view that is amazing. I don't mind driving for a long time, even if it's over the pass.
    I've heard the Enchantments are nice.
    I don't want the hike to be over 10 miles round trip. I'd consider a point-to-point hike.
    I want the hike to be as seculuded as possible. I don't want to see many people.
    I would like it to be as bug free as possible. I would also like to avoid any Forest Service roads.
    """;
    ```

1. Run the app with `dotnet run` and see what it recommends now. Here's an example we received from one run:

    ```console
    Great! Based on your preferences, I'd recommend the following strenuous hikes with amazing views near the I-90 corridor:

    1. Mt. Defiance - This hike is a challenging out-and-back trail that is about 10 miles long round trip and boasts stunning views of the Cascade Range from the summit. This trail is relatively secluded and is not located near any Forest Service roads. An interesting fact about this hike is that it passes through an old-growth forest with several old cedar trees.
    
    2. Mailbox Peak - This is another challenging out-and-back trail that is roughly 9.4 miles long round trip. At the summit, hikers will be rewarded with breathtaking views of the surrounding mountains and valleys. Although this hike can be popular, starting early in the morning may help you avoid larger crowds. Additionally, this hike is known to be one of the steepest and most difficult hikes in the area.
    
    3. Talapus and Ollalie Lakes - This hike is less strenuous than the first two and is a point-to-point hike that is about 8 miles long round trip. Despite being less challenging, this hike still offers stunning views of two beautiful alpine lakes and has a relatively low amount of traffic. Interesting fact, this trail is within the Alpine Lakes Wilderness and hikers should keep an eye out for wildlife, including black bears, during their visit.
    
    Hope this helps and happy hiking!
    ```

This is much better! The response is following the rules of the system prompt and providing detailed information of the hike description requested.

If you look closely, hike recommendation number 3 says it is both a point-to-point and a round trip hike. Let's change recommendation request prompt to see if we can avoid that hallucination.

### Chain-of-thought

Asking the model to provide a step-by-step accounting of its thought process should help it recommend even more accurate recommendations.

1. Update the `hikeRequest` variable to be the following:

    ```csharp
    var hikeRequest = 
    """
    I live near Seattle and would like a strenous hike around the I-90 corridor that ends with
    a view that is amazing. I don't mind driving for a long time, even if it's over the pass.
    I've heard the Enchantments are nice.
    I don't want the hike to be over 10 miles round trip. I'd consider a point-to-point hike.
    I want the hike to be as seculuded as possible. I don't want to see many people.
    I would like it to be as bug free as possible. I would also like to avoid any Forest Service roads.

    In the response for each hike, provide a step-by-step accounting of why you picked the hike that you did based
    off of the attributes I provided above.
    """;
    ```

1. Run the app with `dotnet run` and see what it recommends now. Here's an example we received from one run:

    ```console
    Great, based on your preferences, I have three hiking recommendations for you near the I-90 corridor.
    
    1. Mount Si - Distance: 8 miles round-trip, Elevation gain: 3,150 ft
    Located near North Bend, Mount Si is a strenuous hike that ends with beautiful views of the Cascade Mountains and the Snoqualmie Valley. Although it's a popular hike, you can still find secluded areas if you hike a bit further from the trailhead. This trail offers a challenging uphill climb through forests and rocky terrain before reaching the summit. The bugs can be present in the summer, so be sure to bring some repellent. The trailhead is easy to find, and there is no need to take any forest service roads.
    
    2. Snow Lake - Distance: 7.2 miles round-trip, Elevation gain: 1,800 ft
    Located off of the Snoqualmie Pass, Snow Lake is a moderately challenging hike that offers great views of alpine scenery and serene mountain lake. The trail is a bit rocky but is well-maintained. Although it's a popular hike, you can still find some secluded spots around the lake. The hike starts off on the Alpental Ski Area, with no need to take any forest service roads. There is some bug activity on this trail in the summer months.
    
    3. Granite Mountain - Distance: 8.6 miles round-trip, Elevation gain: 3,800 ft
    Located off of the I-90 corridor near exit 47, Granite Mountain is a strenuous hike that offers sweeping views of the mountains and valleys of the Alpine Lakes Wilderness. The trail is challenging, but well worth it. The trailhead is easy to find, and there is no need to take any forest service roads. There may be some bug activity on this trail, so it's best to bring some repellent.
    
    I hope you find these recommendations helpful!    
    ```
