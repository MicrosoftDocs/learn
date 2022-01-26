Here, we'll discuss how you can decide whether Azure Communication Services (ACS) is the right choice for your company and problems. 

## Criteria

We'll list some criteria that will help you make the right decision.

* Existing Business/Application/Idea - Do you have an existing Business/Application/Idea you'd like to integrate Azure Communication Services with?
* Features - Do you need the features of ACS?
* Environment - Would ACS work in your environment?
* Geographic Region - What Location/Market are you targeting?

### Existing Business/Application/Idea

ACS cannot create an application or business all by itself. It works best when there is an existing application with which to integrate Azure Communication Services into or at least if there is an idea to which it would make sense to create an application. If you do not have an existing application or idea that requires communication features and enhancements then you may wish to look for a different solution or product that fulfills your needs and requirements.

A good example here is that you'll need an existing form of Identity solution(Log In, Log Out etc) to tie your user's identities to our identity platform. Creating calls without this is possible but users will not have a consistent defined identity.

### Features

ACS has a wide array of features but you need to decide if these features are of use to you within your solution. Ensure that you're reviewing the list of features available and deciding if they are applicable. 

It is possible to mix and match features from ACS and combine them with other Azure offerings or systems so it is not required to use all of our features. You can pick and choose the areas that are of most interest to you. For example, you might need Voice and Video calling features within an application but you might not need our Telephone(PTSN and SMS) features as your calls are designed to occur only digitally within an application. Do not feel obligated to use every feature we have to offer.

### Environment

ACS requires a suitable environment to work within. By environment we mean both the target surface area/platform and the programming language of the application written for that surface area/platform. 

When it comes to surface areas we support:

* Most Modern Browsers (Chrome, Edge, Safari)
* Android Phones and Devices
* iOS Phones and Devices

As for programming languages we support:

* JavaScript
* .NET
* Java SE
* Python
* iOS(Swift)
* Android

If your business/application/idea intends to use languages or surface areas/platforms that ACS does not support. Then ACS may not be correct for you.

### Geographic Region

Some features of ACS are only available in certain countries or locations, additionally certain countries or locations may have restrictions placed upon them. These restrictions or gaps in ACS' support can be caused by legal or regulatory matters but they can also be caused by ACS simply not supporting a region yet. When considering if ACS is right for you ensure that you factor this into your current business as well as any potential expansion of your business. You can read about regional differences in offerings of ACS features on a variety of pages:

* [Telephony/SMS regions eligibility](https://docs.microsoft.com/azure/communication-services/concepts/numbers/sub-eligibility-number-capability)
* [Additional SMS Information](https://docs.microsoft.com/azure/communication-services/concepts/sms/sms-faq)

## Apply the criteria

Ultimately, ACS works best when you've already got existing Ideas, Applications or Businesses that need Communication Features added and a compatible platform/environment to launch those ideas on. As with many things there are cases where it might be difficult to decide or edge cases where even with these criteria in mind you might want to use ACS. Ultimately the decision is up to you and you may need to make a judgement call based on your individual circumstances.

### Applying criteria to the Example Scenario

If we think back to our example scenario from earlier in the module with our fictional home appliance company we can apply our decision criteria to their business goals and requirements. Their business is established and has existing websites, applications etc. They're also in need of calling and chat related features which ACS has, are operating in a geographic region which ACS supports and they use application environments/platforms which ACS has SDKs for.

Based on our criteria we've discussed and the requirements here this scenario would be a good fit for Azure Communication Services.
