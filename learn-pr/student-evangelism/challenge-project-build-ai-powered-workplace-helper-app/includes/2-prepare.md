Since you're creating a Power App and a chatbot that has Generative AI capabilities, you'll need some services in place to get started. Here, we discuss the project scenario and specification and the things you'll need to get started.

## Project specifications

Let's discuss a more detailed project description for the use case in consideration: Build an AI Powered Workplace Helper App.

Your customer is Contoso, a fictitious company with several employees and offices worldwide. Due to the company's size, employees often don't know where to find the information they need to answer their questions. The local Contoso office contracted you to help make it easier for their employees to get answers to administrative questions, policy and procedure information, and emergency procedures. The app should use existing policy documents, websites, and resources that already contain the necessary information but give employees a quick and easy way to ask specific questions to get answers. Safety is important to Contoso, so they also want to help ensure that the bot provides specified local information quickly when asked for emergency contact information.

You decide the best solution is to create a Power App for the organization with a chatbot in Copilot Studio by using Generative AI capabilities. The app will use the existing documents as a data source and allow you to specify responses with local emergency contact details via topic-based answers.

## Requirements

- Users can ask the app free-form questions about Contoso policies and receive answers and links.
- Users receive specified local emergency contact information if they use the words "fire", "police", "ambulance", or "emergency."
- Generative answers are provided after the specified local emergency contact information for questions by using the emergency words.
- On the main screen, the app has the name of the city for which the app was created.
- Be creative with additional features to make the app or chatbot more useful.

## Set up your tools

To complete this exercise, you need the following:

- Power Apps Developer account. If you don't have an account, you can [create one for free](https://powerapps.microsoft.com).
- Copilot Studio account. [Start a free trial](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-studio).
- Access to AI Builder to use Generative Answers in Copilot Studio. [Create a 30-day free trial](https://powerapps.microsoft.com/ai-builder/).
- Power Platform environment with access to AI text generation technology. If you are outside the US, **create a new environment** in the Power Platform Admin Center and **set the region to United States**.
  - For more information on the release of different AI technologies, see [AI Builder regional availability](/ai-builder/availability-region).
