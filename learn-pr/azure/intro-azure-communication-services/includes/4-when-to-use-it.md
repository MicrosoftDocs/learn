Here, we'll discuss how you can decide whether Azure Communication Services is the right choice for your company and problems.

## Criteria

We'll list some criteria that will help you make the right decision.

* **Existing Business/Application/Idea**: Do you have an existing Business/Application/Idea you'd like to integrate Azure Communication Services with?
* **Features**: Do you need the features of Azure Communication Services?
* **Environment**: Would Azure Communication Services work in your environment?
* **Geographic Region**: What location/market are you targeting?
* **Suitability**: Azure Communication Services has many features; how can you be sure which one is right for a scenario?

### Existing business/application/idea

Azure Communication Services can't create an application or business all by itself. It works best when there's an existing application into which to integrate Azure Communication Services, or at least you have an idea for which it would make sense to create an application. If you don't have an existing application or idea, then a different product that fulfills your needs and requirements might be better.

A good example here is that you'll need an existing form of Identity solution (log in, log out, and so on) to tie your user's identities to Azure Communication Services' identity platform. Creating calls without identities is possible, but users won't have a consistently defined identity to recognize each other with.

### Features

Azure Communication Services has a wide array of features, but you need to decide if these features are of use to you within your solution. Review the list of features available and decide if they're applicable.

It's possible to mix and match Azure Communication Services features, as well as combine them with other Azure offerings. You don't have to use all of Azure Communication Services' features; you can pick and choose the areas that are of most interest to you. For example, you might need voice and video calling features, but you might not need telephony features. Your calls and contact points could be designed to occur only digitally. Don't feel obligated to use every available feature.

### Environment

Azure Communication Services requires a suitable environment in which to work. An environment is the combination of the target device or browser and the programming language used.

Azure Communication Services supports the following environments:

* Most modern browsers (Chrome, Edge, Safari)
* Android phones and devices
* iOS phones and devices

It also supports the following programming languages:

* JavaScript
* .NET
* Java Server Edition (SE)
* Python
* iOS (Swift)
* Android

If your business/application/idea intends to use languages or devices/browsers that Azure Communication Services doesn't support, then Azure Communication Services may not be right for you.

### Geographic region

Some features of Azure Communication Services are only available in certain countries/regions or locations. Additionally, certain countries/regions or locations may have restrictions on features. These restrictions (or gaps) in Azure Communication Services' support across the world can be caused by legal or regulatory matters, or by Azure Communication Services simply not supporting a region yet. When considering if Azure Communication Services is right for you, ensure that you factor this into your current business, as well as any potential expansion of your business.

Of particular mention in this area are telephony and SMS features. As telephone networks in different countries/regions vary in terms of structure and regulatory/legal matters, it's very important to ensure that Azure Communication Services supports your target location. Additionally, your billing location also affects this. For example, to make calls or send SMS messages to a UK number, you'll need a billing address in the UK.

SMS and Telephony are available in number of locations. You can find all the supported regions, number types and available capabilities in the [Azure Communication Services documentation](https://aka.ms/CountryAvailability)

### Suitability

When deciding to use Azure Communication Services, it's also important to think about which of its many features you should use for a particular scenario. There may be a temptation to go overboard and use everything, but that's often not ideal. As we explained before, you can mix and match features or choose to not use any at all. To aid in a decision, here's some guidance that may help.

First, remember that not all customers are willing to jump on a video or audio call with a real person. It's important to offer them various types of communication to suit their needs and motivations. Always start with something more passive and asynchronous, like chat or email. Once there's an established business relationship with a customer, r're more likely to be willing to hop on a call, especially if they need things like support or maintenance.

Additionally, some users may be unwilling to supply their phone number or other personal details, which might rule out some of Azure Communication Services' telephony features. Make sure you have other flows in place, such as email.

If in doubt, starting with chat (and in particular, a chat experience that doesn't require a user to provide sign-in information) might be a good idea to communicate to your users.

## Apply the criteria

Ultimately, Azure Communication Services works best when you've already got existing ideas, applications, and businesses that need communication features and a compatible platform on which to launch. Keep in mind that there are cases where it might be difficult to decide or edge cases where, even with these criteria in mind, you may still use Azure Communication Services. The decision is up to you, and you may need to make a judgment call based on your individual circumstances.

### Applying criteria to the example scenario

If we think back to our example scenario from earlier in the module with Contoso Appliances (our appliance company), we can apply our decision criteria to their goals and requirements:

* Their business is established and has existing websites, applications, and so on.
* They're in need of calling and chat related features, which Azure Communication Services can provide.
* They're operating in a geographic region that Azure Communication Services supports.
* They use application environments and platforms for which Azure Communication Services has SDKs.

Based on our criteria we've discussed and the company's requirements, this scenario would be a good fit for Azure Communication Services.
