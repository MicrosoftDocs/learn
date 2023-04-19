The first generation of the Tailwind Traders e-commerce website was available exclusively in English. However, when the Marketing team sponsored a demographics study for the company's brick-and-mortar locations, it found that, on average, only 80 percent of potential customers speak English. In some neighborhoods, that number falls to 50 percent. The team sees the addition of multiple languages as a wonderful opportunity to serve non-English speakers with the same online e-commerce experience as English speakers.

## Which service should you choose?

As in the preceding unit, apply the decision criteria you learned about earlier to find the right option.

First, is Tailwind Traders building a virtual agent that interfaces with humans via natural language? No, it isn't, so Azure Bot Service isn't a good candidate for this scenario. However, should Tailwind Traders ever implement a customer service agent, it might want to consider using the Translator API to provide real-time translation to help customers who aren't English speakers.

Second, does Tailwind Traders need a service that can understand the content and meaning of images, video, audio, or translate text into a different language? Yes, it does. Translating textual content from one language into another is a general purpose task that you can simplify by using the Azure Cognitive Services Translator service. The service is easy to integrate into your applications, websites, tools, and solutions. It allows you to add multilanguage user experiences in more than 60 languages, and you can use it on any hardware platform with any operating system for text-to-text language translation.

Azure Cognitive Services is likely the best option for this scenario, but let's continue applying the decision criteria to make sure.

Third, does Tailwind Traders need to predict user behavior or provide users with personalized recommendations? No, it doesn't, so the Azure Cognitive Services Personalizer isn't a good candidate for this scenario.

Finally, will the Tailwind Traders app need to predict future outcomes based on private historical data? No. Although it's possible to create a Machine Learning model for multilanguage translation, it would be expensive and time consuming for Tailwind Traders to attempt to build translation models themselves. The team doesn't have the deep learning competency or the linguistic data that's required to train the models.

Now that you've examined all the expert criteria, you can confidently select Cognitive Services as the best product option for this scenario.
