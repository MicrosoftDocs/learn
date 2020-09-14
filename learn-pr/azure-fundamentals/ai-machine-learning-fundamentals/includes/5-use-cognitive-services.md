The first generation of the Tailwind Trader's ecommerce website was available exclusively in English.  However, the Marketing department sponsored a demographics study for their brick-and-mortar locations.  On average, only 80% of potential customers spoke English, and that proportion falls to 50% in some neighborhoods.  The Marketing department sees the addition of multiple languages as a wonderful opportunity to serve non-English speakers with the same online ecommerce experience as English speakers. 

## Which service should we choose?

Just like we did in the previous unit, let's apply the decision criteria we learned about in the previous unit to find the right option.

First, is Tailwind Traders building a virtual agent that interfaces with humans via natural language? No, so Azure Bot Service is not a good candidate for this scenario.  However, should Tailwind Traders ever implement a customer service agent, they may want to consider using the Translator's APIs to provide real-time translation to help customers who are not English speakers.

Second, does Tailwind Traders need a service that can understand the content and meaning of images, video, audio, or translate text into a different language? Yes! Translating textual content from one language into another is a general purpose task that is made easy using Azure Cognitive Service's Translator service. It's easy to integrate in your applications, websites, tools, and solutions. It allows you to add multi-language user experiences in more than 60 languages, and can be used on any hardware platform with any operating system for text-to-text language translation. 

Azure Cognitive Services is likely the best option for this scenario, but let's continue applying the decision criteria to make sure.

Third, does Tailwind Traders need to predict user behavior or provide users with personalized recommendations? No, the Azure Cognitive Services Personalizer is not a good candidate for this scenario.

Finally, will the Tailwind Trader app predict future outcomes based on private historical data? No. While it would be possible to create a Machine Learning model to perform multi-language translation, it would be expensive and time consuming for Tailwind Traders to attempt to do build translation models themselves. They do not have the deep learning competency, nor the linguistic data required to train the models.

Now that we've examined all of the expert criteria, we can confidently select Cognitive Services as the best product option for this scenario.