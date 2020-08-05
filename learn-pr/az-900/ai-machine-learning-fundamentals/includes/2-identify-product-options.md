Artificial Intelligence (AI) is a broad classification of computing that allows a software system to perceive its environment and take action that maximizes its chance of successfully achieving its goals.  There's two basic approaches to AI.  The first is to create a system that is modelled on the neural network of the human mind, enabling it to learn and grow through trial and error.

Azure's Artificial Intelligence offerings utilize a different approach called "machine learning".  Machine learning is a data science technique that allows computers to use existing data to forecast future behaviors, outcomes, and trends. By using machine learning, computers learn without being explicitly programmed.

Forecasts or predictions from machine learning can make apps and devices smarter. For example, when you shop online, machine learning helps recommend other products you might want based on what you've bought. Or when your credit card is swiped, machine learning compares the transaction to a database of transactions and helps detect fraud. And when your robot vacuum cleaner vacuums a room, machine learning helps it decide whether the job is done.

Virtually every device or software system that collects data -- textual data, visual data, audio data -- could feed that data into a Machine Learning model that helps to make that device or software system smarter about how it functions in the future.

## Azure Product Options

At a high level, there are three primary offerings, each of these are aimed at a specific audience and use case, and provide a diverse set of tools, services, programmatic APIs, and more.

### Azure Machine Learning

Azure Machine Learning is a platform containing several complimentary tools and services that help data scientists connect to data to train and test the pre-built or custom algorithms and determine which one will most accurately predict a result. Once you've run experiments to test the model, you can then deploy the model and use it in real time via a web API endpoint.

There are tools to:

- Create custom algorithms utilizing tools and programming languages familiar to data scientists
- Create a model that defines how to obtain data, how to handle missing or bad data, how to split the data into either a training set or test set, and pushes it into the algorithms
- Create pipelines that define where and when to run the compute-intensive experiments required to score the algorithms based on the training and test data
- Deploy the winning algorithm as an API to an endpoint so it can be consumed in real-time by other applications

You would choose Azure Machine Learning when your data scientists need complete control over the design and training of an algorithm using your own data.

### Azure Cognitive Services

Azure Cognitive Services are APIs, SDKs, and services available to help developers build intelligent applications without having direct AI or data science skills or knowledge. Azure Cognitive Services enable developers to easily add cognitive features into their applications. The goal of Azure Cognitive Services is to help developers create applications that can see, hear, speak, understand, and even begin to reason. The catalog of services within Azure Cognitive Services can be categorized into five main pillars - Vision, Speech, Language, Web Search, and Decision.

Cognitive Services provides machine learning capabilities to solve general problems such as analyzing text for emotional sentiment or analyzing images to recognize objects or faces. You don't need special machine learning or data science knowledge to use these services.

Cognitive Services is a group of services, each supporting different, generalized prediction capabilities. 

**Decision** services -	Build apps that surface recommendations for informed and efficient decision-making.	

**Language** services -	Allow your apps to process natural language with pre-built scripts, evaluate sentiment and learn how to recognize what users want.	

**Search** services - Add Bing Search APIs to your apps and harness the ability to comb billions of webpages, images, videos, and news with a single API call.

**Speech** services - Convert speech into text and text into natural-sounding speech. Translate from one language to another and enable speaker verification and recognition.

**Vision** services -Recognize, identify, caption, index, and moderate your pictures, videos, and digital ink content.

Both Azure Machine Learning and Azure Cognitive Services have the end-goal of applying artificial intelligence (AI) to enhance business operations, though how each provides this in the respective offerings is different.


### Azure Bot Service

The Azure Bot Service and Bot Framework offer developing, testing, deploying, and hosting bots.  Azure Bot Service is a bit different from Azure Machine Learning and Azure Cognitive Services insomuch that it has a specific use case.  However, bots may use other Azure services, such as Azure Cognitive Services to build intelligent applications.

Bots provide an experience that feels less like using a computer and more like dealing with a person - or at least an intelligent robot. They can be used to shift simple, repetitive tasks, such as taking a dinner reservation or gathering profile information, on to automated systems that may no longer require direct human intervention. Users converse with a bot using text, interactive cards, and speech. A bot interaction can be a quick question and answer, or it can be a sophisticated conversation that intelligently provides access to services.

Bots are a lot like modern web applications, living on the internet and use APIs to send and receive messages. What's in a bot varies widely depending on what kind of bot it is. Modern bot software relies on a stack of technology and tools to deliver increasingly complex experiences on a wide variety of platforms. However, a simple bot could just receive a message and echo it back to the user with very little code involved.