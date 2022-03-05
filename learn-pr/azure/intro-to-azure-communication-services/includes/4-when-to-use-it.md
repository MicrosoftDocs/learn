Here, we'll discuss how you can decide whether Azure Communication Services (ACS) is the right choice for your company and problems.

## Criteria

We'll list some criteria that will help you make the right decision.

* Existing Business/Application/Idea - Do you have an existing Business/Application/Idea you'd like to integrate Azure Communication Services with?
* Features - Do you need the features of ACS?
* Environment - Would ACS work in your environment?
* Geographic Region - What Location/Market are you targeting?
* Suitability - ACS has many features, how can you be sure which one is right for a scenario?

### Existing Business/Application/Idea

ACS can't create an application or business all by itself. It works best when there's an existing application with which to integrate ACS into. Or at least if an idea exists that it would make sense to create an application for. If you don't have an existing application or idea, then a different product that fulfills your needs and requirements might be better.

A good example here's that you'll need an existing form of Identity solution(Log In, Log Out etc.) to tie your user's identities to our identity platform. Creating calls without this is possible but users won't have a consistently defined identity.

### Features

ACS has a wide array of features but you need to decide if these features are of use to you within your solution. Ensure that you're reviewing the list of features available and deciding if they're applicable.

It's possible to mix and match ACS features and combine them with other Azure offerings. It's not required to use all of our features. You can pick and choose the areas that are of most interest to you. For example, you might need voice and video calling features but you might not need our telephony features. Your calls and contact points, could be designed to occur only digitally. Don't feel obligated to use every feature we have to offer.

### Environment

ACS requires a suitable environment to work within. By environment we mean both the target device/browser and the programming language of the application written for that device/browser.

When it comes to these, we support:

* Most Modern Browsers (Chrome, Edge, Safari)
* Android Phones and Devices
* iOS Phones and Devices

As for programming languages we support:

* JavaScript
* .NET
* Java Server Edition(SE)
* Python
* iOS (Swift)
* Android

If your business/application/idea intends to use languages or devices/browsers that ACS doesn't support. Then ACS may not be correct for you.

### Geographic Region

Some features of ACS are only available in certain countries or locations, additionally certain countries, or locations may have restrictions placed upon them. These restrictions or gaps in ACS' support across the world, can be caused by legal or regulatory matters or by ACS simply not supporting a region yet. When considering if ACS is right for you, ensure that you factor this into your current business as well as any potential expansion of your business. You can read about regional differences in offerings of ACS features on a variety of pages:

* [Telephony regions eligibility](/azure/communication-services/concepts/numbers/sub-eligibility-number-capability)
* [Additional SMS message information](/azure/communication-services/concepts/sms/sms-faq)

### Suitability

When deciding to use ACS, it is also important to think about which of its many features you should use for a particular scenario. There may be a temptation to go overboard and use everything but that is often not ideal. As we explained before you can mix and match features or choose to not use any at all. To aid in a decision here's some guidance that may help.

Firstly, remember that not all customers are willing to jump on a video or audio call with a real person. Its important to offer them various types of communication to suit their needs and motivations. Always start with something more passive and asynchronous like chat or email. Once there's an established business relationship with a customer they're more likely to be willing to hop on a call, especially if they need things like support or maintenance.

Additionally, some users may be unwilling to supply their phone number of other personal details that might rule out some of ACS' telephony features. Make sure you have other flows such as Email in place.

If in doubt, starting with chat and in particular a chat experience that does not require a user to provide sign-in information may be a good idea to communicate to your users.

## Apply the criteria

Ultimately, ACS works best when you've already got existing ideas, applications, and businesses that need communication features and a compatible platform to launch on. As with many things there are cases where it might be difficult to decide or edge cases where, even with these criteria in mind you may still use ACS. The decision is up to you and you may need to make a judgment call based on your individual circumstances.

### Applying criteria to the Example Scenario

If we think back to our example scenario from earlier in the module with Contoso Appliances(our appliance), we can apply our decision criteria to their goals and requirements:

* Their business is established and has existing websites, applications etc.
* They're in need of calling and chat related features which ACS has.
* They're operating in a geographic region which ACS supports.
* They use application environments and platforms which ACS has SDKs for.

Based on our criteria we've discussed and the requirements here this scenario would be a good fit for Azure Communication Services.
