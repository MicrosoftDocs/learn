After you deploy your model to an endpoint, you can start interacting with it to see how it works. Let's explore how you can use prompt engineering techniques to optimize your model's performance.

## Apply prompt patterns to optimize your model's output

The quality of the questions you send to the language model, directly influences the quality of the responses you get back. You can carefully construct your question, or **prompt**, to receive better and more interesting responses. The process of designing and optimizing prompts to improve the model's performance is also known as **prompt engineering**.

Prompt engineering requires users to ask relevant, specific, unambiguous, and well-structured questions, instructing the model to generate more accurate responses. To understand how to create well-defined prompts, let's explore some patterns that help you improve the output of a model:

- Instruct the model to act as a persona.
- Guide the model to suggest better questions.
- Provide a template to generate output in a specific format.
- Understand how a model reasons by asking it to reflect.
- Add context to improve the accuracy of the model's output.

> [!Note]
> The patterns listed here are based on the work by [White et al., (2023) who constructed a prompt pattern catalog](https://arxiv.org/abs/2302.11382?azure-portal=true).

As a developer, an effective approach is to add instructions to your deployed model in the form of a *system prompt*. The system prompt sets the model's behavior and allows you to guide the model without exposing the end user to the instructions. The best results are often achieved through the assignment of an explicit system prompt and guidance (or templates) that help users submit prompts that reflect the patterns described here.

### Instruct the model to act as a persona

When you want the model to take a specific point of view or perspective when answering a question, you can ask it to act as a persona.

For example, you can ask the model to respond as if it's a seasoned marketing professional if you're working in sales and need insights about a new CRM software.

|                  |No persona specified|With persona specified|
|------------------|---------|--------|
|**System prompt** |*None* |You're a seasoned marketing professional that writes advertising copy for an audience of technical customers. |
|**User prompt**|Write a one-sentence description of a CRM product.|Write a one-sentence description of a CRM product.|
|**Model response**|A CRM product is a software tool designed to manage a company's interactions with current and potential customers, encompassing sales, marketing, customer service, and technical support.|Experience seamless customer relationship management with our CRM product, designed to streamline your business operations, enhance customer interactions, and drive sales growth with its intuitive interface and robust analytics tools.|

You can create different personas for various business roles. Think of roles like a product manager, data analyst, customer service expert, or teacher. Define the persona and add more detail to what you expect that persona to know or do to get tailored, context-driven responses.

### Ask for better question suggestions

When you want the model to help refine your question, you can ask it to suggest better ways to phrase your query. You can also ask it to provide extra context.

For example, if you're seeking advice on cooking a meal, you can prompt the model to suggest clarifying questions to help you get a more targeted answer.

|                  | No suggestions given | With suggestions given |
|------------------|----------------------|------------------------|
|**System prompt** |You're an AI chef who can advise on menus. |You're an AI chef who can advise on menus. You're approachable and always want to provide the best advice you can. |
| **User prompt** | I have to host a dinner party for four people. What should I cook? | I have to host a dinner party for four people. What should I cook? What other information do you need to help me plan a great meal for my guests? |
| **Model response** | Hosting a dinner party for four is a wonderful opportunity to showcase your culinary skills. Here's a suggested three-course menu that balances flavors and provides a pleasant dining experience:<br><br>*Appetizer*<br>**Caprese Salad Skewers**<br> - *Ingredients*: Cherry tomatoes, fresh mozzarella balls, fresh basil leaves, balsamic glaze, olive oil, salt, and pepper.<br>- *Instructions*: Thread a cherry tomato, a basil leaf, and a mozzarella ball onto small skewers. Drizzle with olive oil and balsamic glaze, then season with salt and pepper. This dish is light, refreshing, and easy to prepare ahead of time.<br><br>*Main Course*<br>**Herb-Crusted Salmon with Lemon Asparagus**<br>- *Ingredients*: Salmon fillets, fresh herbs (such as parsley, dill, and thyme), breadcrumbs, lemon, asparagus, olive oil, salt, and pepper.<br>- *Instructions*: Preheat your oven to 400°F (200°C). Mix breadcrumbs with chopped fresh herbs and a bit of olive oil to form a paste. Press this mixture onto the salmon fillets and season with salt and pepper. Place salmon on a baking sheet and bake for about 15-20 minutes, or until cooked through. In the last 10 minutes of cooking, toss asparagus with olive oil, lemon zest, salt, and pepper, and roast alongside the salmon. Serve with a squeeze of fresh lemon juice over the salmon and asparagus.<br><br>*Dessert*<br>**Chocolate Mousse with Fresh Berries**<br> -*Ingredients*: Dark chocolate, eggs, sugar, heavy cream, vanilla extract, and mixed berries (such as strawberries, blueberries, and raspberries).<br>- *Instructions*: Melt the chocolate over a double boiler, then let it cool slightly. Separate egg yolks and whites. Whip the egg whites to soft peaks, then gradually add sugar to make a meringue. Whip the heavy cream until soft peaks form and mix in vanilla extract. Fold the melted chocolate into the egg yolks, then gently fold in the whipped cream and meringue until combined. Spoon the mousse into serving dishes and refrigerate for at least 2 hours. Serve topped with fresh berries for a burst of color and freshness.<br><br>**Additional Tips**<br>- *Pairings*: Consider serving a light white wine with the appetizer and main course, and perhaps a dessert wine with the chocolate mousse.<br>- *Timing*: Prepare the appetizer and dessert in advance to minimize last-minute stress. The main course will take the most time in the oven, so plan accordingly.<br><br>This menu is designed to be elegant yet approachable, ensuring your guests enjoy both the food and the experience. Enjoy your dinner party! | Hosting a dinner party is a wonderful opportunity to showcase your culinary skills and create memorable experiences for your guests. To help you plan a great meal, here are a few questions that can guide you in choosing the perfect menu:<br><br><ul><li>**Dietary Preferences/Restrictions**: Are any of your guests vegetarian, vegan, gluten-free, or have any food allergies or intolerances? Knowing this will help in selecting dishes that everyone can enjoy.</li><li>**Flavor Preferences**: Do your guests have any favorite cuisines or flavors? For example, do they enjoy Italian, Mexican, Mediterranean, or perhaps something more adventurous like Thai or Indian?</li><li>**Time and Skill Level**: How much time do you have to prepare the meal, and what is your comfort level in the kitchen? Are you looking for a simple meal or are you up for something more elaborate?</li><li>**Occasion**: Is this a casual get-together, a celebration, or something more formal? The nature of the event might influence the menu style.</li><li>**Seasonal Ingredients**: Are you interested in using seasonal ingredients? This can help in choosing fresh and flavorful produce.</li><li>**Drinks Pairing**: Would you like to include alcoholic or non-alcoholic beverages to pair with the meal?</li></ul><br>With this information, I can suggest a tailored menu. Here’s a general idea that can be adapted based on your answers:<br><br>**Starter**<ul><li>**Garden Salad with Citrus Vinaigrette**: Fresh greens, seasonal vegetables, and a light citrus dressing.</li><li>**Stuffed Mushrooms**: For a vegetarian option, filled with herbs and cheese.</li></ul><br>**Main Course**<br><ul><li>**Herb-Crusted Chicken Breast**: Served with roasted vegetables.</li><li>**Quinoa Stuffed Bell Peppers**: A flavorful vegetarian or vegan option.</li></ul><br>**Side Dishes**<br><ul><li>**Garlic Butter Roasted Potatoes**: Classic and comforting.</li><li>**Steamed Green Beans with Almonds**: A simple, healthy side.</li></ul><br>**Dessert**<br><ul><li>**Chocolate Lava Cake**: A decadent treat to end the meal.</li><li>**Fruit Tart**: A lighter, refreshing option.</li></ul><br>**Drinks**<br><ul><li>**Wine Pairing**: A versatile white wine like Sauvignon Blanc or a light red like Pinot Noir.</li><li>**Mocktail Option**: A refreshing citrus mocktail or sparkling water with herbs.</li></ul><br><br>Feel free to share more details, and I can help refine the menu further! |

When you encourage the model to suggest clarifications or extra details can help you ask the right questions and achieve better, more accurate answers in fewer interactions.

### Specify the desired format for responses 

When you want the model to generate output in a specific format, you can provide a template or structure in your prompt.

For example, if you're a sports reporting composing a historical article, you can request that the model follow a specific template, which includes headings, bullet points, and data breakdowns.

|                  | No template specified | With template specified |
|------------------|-----------------------|-------------------------|
| **System prompt**| You're a helpful AI assistant. | You're a helpful AI assistant for sports reporters. |
| **User prompt** | What happened in the 2018 Soccer World Cup final? | What happened in the 2018 Soccer World Cup final? Format the result to show the match date, location, and the two teams competing. Then the final score, and finally any notable events that occurred during the match. |
| **Model response** | The 2018 FIFA World Cup final took place on July 15, 2018, at the Luzhniki Stadium in Moscow, Russia. France faced Croatia in the match. France emerged victorious with a 4-2 win. The goals for France were scored by Mario Mandzukic (own goal), Antoine Griezmann (penalty), Paul Pogba, and Kylian Mbappé. Croatia's goals were scored by Ivan Perišić and Mandzukic. Kylian Mbappé, at just 19 years old, became the second youngest player to score in a World Cup final, after Pelé. This victory marked France's second World Cup title, their first being in 1998.| **Match Date**: July 15, 2018<br>**Location**: Luzhniki Stadium, Moscow, Russia<br>**Teams Competing**: France vs. Croatia<br>**Final Score**: France 4, Croatia 2<br><br>**Notable Events**:<br><ol><li>**First Half**: France took an early lead in the 18th minute with an own goal by Mario Mandžukić after a cross from Antoine Griezmann. Croatia equalized in the 28th minute with a header from Ivan Perišić, who had just come on as a substitute. Just before halftime, in the 44th minute, Paul Pogba scored from a free kick to put France back in the lead.</li><li>**Second Half**: The game saw a dramatic increase in intensity after the break. In the 68th minute, Kylian Mbappé scored his first World Cup goal, bringing the score to 3-1 in favor of France. Croatia managed to score again in the 69th minute when Mandžukić headed in a cross from Perišić, reducing the deficit to 3-2.</li><li>**Final Moments**: In the 81st minute, a controversial penalty was awarded to France after a handball by Croatian defender Dejan Lovren. Griezmann converted the penalty, sealing the victory for France with a 4-2 scoreline.</li><li>**Additional Context**: This match was notable for being the youngest ever World Cup final in terms of average age, featuring players like Mbappé and N’Golo Kanté. France’s victory marked their second World Cup title, having previously won in 1998. Croatia reached the final for the first time in their history, finishing as runners-up.</li></ol>|

You can apply this approach to other scenarios where a specific format is needed, such as generating emails, summaries, proposals, or even code and scripts. Define the format template clearly and provide details on how you want the output structured to get consistent and organized responses.

You can also use a **one-shot** or **few-shots** approach by providing one or more examples to help the model identify a desired pattern.

### Ask for an explanation of reasoning

When you want the model to explain the reasoning behind its answers, you can ask the model to automatically reflect on its rationale and assumptions after providing a response.

For example, if you're working on a mathematical problem, you can ask the model to explain the reasoning behind specific calculations.

|                  | No reflection specified | With reflection specified |
|------------------|-----------------------|-------------------------|
| **System prompt**| You're an AI math assistant. | You're an AI math assistant. You always explain your answers. |
| **User prompt** | A right-angled triangle has a hypotenuse side of length 3 cm and an adjacent side length of 2cm.What is the length of the remaining side? | A right-angled triangle has a hypotenuse side of length 3 cm and an adjacent side length of 2cm.What is the length of the remaining side? |
| **Model response** | Approximately 2.24 cm.| We can use the Pythagorean theorem to solve this problem. The Pythagorean theorem states that in a right-angled triangle, the square of the length of the hypotenuse (the side opposite the right angle) is equal to the sum of the squares of the lengths of the other two sides. Mathematically, this can be written as:<br>*c² = a² + b²*<br>where *c* is the length of the hypotenuse, and *a* and *b* are the lengths of the other two sides.<br>In this problem, we are given the length of the hypotenuse (c = 3 cm) and the length of one of the other sides (a = 2 cm). We need to find the length of the remaining side (b).<br>Plugging the given values into the Pythagorean theorem, we get:<br>*3² = 2² + b²*<br>*9 = 4 + b²*<br>Now, we can solve for b²:<br>*b² = 9 - 4*<br>*b² = 5*<br>Finally, we take the square root of both sides to find the length of the remaining side:<br>*b = √5 ≈ 2.24 cm*<br>So, the length of the remaining side is approximately 2.24 cm.|

You can apply this approach when you want explanations in data analysis, marketing strategy, or technical troubleshooting. When you ask the model to define its reasoning, you use a technique called **chain-of-thought** to make it think step by step.

### Add context

When you want the model to focus on specific topics, you can specify the context to consider. You can also tell the model to ignore irrelevant information.

For example, if you're planning a trip, you can provide the model with more context to help improve the relevance of its response.

|                  | No context specified | With context specified |
|------------------|-----------------------|-------------------------|
| **System prompt**| You're an AI travel assistant. | You're an AI travel assistant. |
| **User question** | When should I visit Edinburgh? | When should I visit Edinburgh? I'm particularly interested in attending Scotland's home matches in the Six Nations rugby tournament. |
| **Model response** | Edinburgh, the capital city of Scotland, is a wonderful destination with a rich history and vibrant culture. The best time to visit Edinburgh largely depends on your preferences for weather, events, and tourist crowds.<br><ol><li>Spring (April to June): The weather starts to warm up, and the days get longer. Springtime is perfect for exploring the city's historic sites, gardens, and parks, such as the Royal Botanic Garden. The Edinburgh Festival Fringe, the world's largest arts festival, takes place in August, which is the end of summer.</li><li>Summer (July to August): The weather is at its warmest, and the days are long. This is a popular time to visit, but it can also be crowded with tourists. Summer is ideal for outdoor activities, and you can enjoy the Edinburgh International Festival and the Royal Edinburgh Military Tattoo.</li><li>Autumn (September to November): The weather begins to cool down, and the leaves change color, creating a picturesque backdrop for the city's historic architecture. It's less crowded, and you can enjoy events like the Edinburgh International Book Festival.</li><li>Winter (December to February): The weather is colder, and there may be snowfall, which can create a magical atmosphere. Winter is a quieter time to visit, with fewer tourists and lower prices. You can attend events like the Edinburgh Christmas Market and the Hogmanay Street Party, which celebrates the New Year.</li></ol><br>In summary, the best time to visit Edinburgh depends on your preferences. Spring and autumn offer pleasant weather and fewer crowds, while summer is ideal for outdoor activities and festivals. Winter can be a quieter, more magical experience, with festive events to enjoy.| The Six Nations rugby tournament typically runs from late January to early March. Edinburgh, as a host city, often has matches at Murrayfield Stadium, which is Scotland's national stadium. To ensure you don't miss Scotland's home matches in the Six Nations, I recommend planning your visit for this period.<br><br>However, keep in mind that match dates and times can vary, so it's a good idea to check the official Six Nations website or the Scottish Rugby Union's website for the exact schedule of matches. Additionally, Edinburgh has a lot to offer beyond rugby, with its rich history, stunning architecture, and vibrant cultural scene, so you might consider extending your stay to explore the city before or after the tournament.<br><br>Also, remember that visiting during the tournament might mean larger crowds and busier accommodations, so book your flights, hotel, and transportation well in advance to ensure a smooth experience. Enjoy your trip to Edinburgh and the thrilling atmosphere of the Six Nations rugby matches!|

By defining what the model should focus on or disregard, you can ensure the conversation stays on track and generate more relevant, tailored responses.

You can specify the context by describing what it should or shouldn't include, and by connecting the model to data sources it should retrieve context from before generating an answer.

## Apply model optimization strategies

> [!NOTE]
> This section discusses options and considerations for model optimization that you may consider beyond prompt engineering. A full exploration of *how* to apply these optimization strategies is beyond the scope of this module.

Prompt engineering can be an effective way to optimize model responses, but in some cases it may not provide sufficient context or guidance to always meet your exact needs. As a developer, you can consider the following additional optimization strategies to improve the relevance of your generative AI application's responses:

- **Retrieval Augmented Generation (RAG)**: A technique that involves using a data source to provide *grounding* context to prompts. RAG can be a useful approach when you need the model to answer questions based on a specific knowledge domain or when you need the model to consider information related to events that occurred after the training data on which the model is based.
- **Fine-tuning**: A technique that involves extending the training of a foundation model by providing example prompts and responses that reflect the desired output format and style.

Both of these approaches involve additional cost, complexity, and maintainability challenges, so as a general rule it's best to start your optimization efforts through prompt engineering, and then consider additional strategies if necessary.

The strategy you should choose as a developer depends on your requirements:

:::image type="content" source="../media/model-optimization.png" alt-text="Diagram showing the various strategies to optimize the model's performance.":::

- **Optimize for context**: When the model lacks contextual knowledge and you want to **maximize responses accuracy**.
- **Optimize the model**: When you want to improve the response format, style, or speech by **maximizing consistency of behavior**.

To optimize for context, you can apply a **Retrieval Augmented Generation** (**RAG**) pattern. With RAG, you *ground* your data by first retrieving context from a data source before generating a response. For example, you want employees to ask questions about expense claim processes and limits based on your own corporation's expenses policy documentation.

When you want the model to respond in a specific style or format, you can instruct the model to do so by adding guidelines in the system message. When you notice the model's behavior isn't consistent, you can further enforce consistency in behavior by **fine-tuning** a model. With fine-tuning, you train a base language model on a dataset of example prompts and responses before integrating it in your application, with the result that the fine-tuned model will produce responses that are consistent with the examples in the fine-tuning training dataset.

You can use any combination of optimization strategies, for example prompt engineering, RAG *and* a fine-tuned model, to improve your language application.
