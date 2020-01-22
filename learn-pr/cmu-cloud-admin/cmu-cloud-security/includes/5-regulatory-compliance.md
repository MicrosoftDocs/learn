it'sin an organization's best interest to safeguard access to the data it handles, in part to protect its assets and earn the trust of its customers. But increasingly, organizations aren't left to their own devices to determine what to protect and how to protect it. Governments are getting involved, too.

If you work in IT at a hospital or a healthcare provider, the term "HIPAA" is probably just as much a part of your lexicon as "database backup." The Health Insurance Portability and Accountability Act (HIPAA) specifies requirements for handling and storing healthcare information electronically in the United States, and it's just one of many regulations IT departments may be subject to. More recently, the European Union's General Data Protection Regulation (GDPR) added a whole new set of security and privacy requirements to companies that do business in EU, including U.S. companies whose Web sites are available in Europe. In its own words, GDPR "will fundamentally reshape the way in which data is handled across every sector, from healthcare to banking and beyond<sup>[1][^1]</sup>." That's good for customers, but an added responsibility for businesses.

Major cloud platforms such as AWS and Azure advertise compliance with dozens of laws and regulations, including HIPAA and GDPR. Cloud service providers don't (and can't) ensure the applications you deploy to their platforms comply with applicable local, federal, and industry-specific regulations, but they do guarantee their own platforms are compliant. That's important, because if Azure wasn't HIPAA-compliant, healthcare organizations that use the public cloud would have to look to one of Azure's competitors for cloud services.

The sections that follow introduce some of the most important standards and regulations enforced by their respective governments, and the nature of the controls to which they apply. The list is by no means exhaustive, but it's a great place to start if regulatory compliance falls within your purview. The first three apply to organizations in the United States; the final one (GDPR) applies to organizations that do business in Europe.

## Sarbanes-Oxley (SOX)

The Sarbanes-Oxley Act of 2002 (SOX) is the result of an effort by the U.S. Senate to combat corporate accounting fraud. Although it wasn't exactly a cybersecurity law, the extent to which it mandates the accuracy of an organization's financial reporting structure requires the use of security controls to ensure transparency and eliminate the opportunities for fraud and abuse. In 2016, an extension of SOX was introduced in the U.S. Congress that would make it mandatory for a publicly traded organization to report its cybersecurity risk assessments. That extension has yet to pass.

Section 802 of SOX governs the management of electronic records, which is applicable to how those records are stored in the public cloud.<sup>[2][^2]</sup> This section specifies three rules:

- Penalties and prison time of up to 20 years may be imposed upon an organization's members and employees for the willful destruction and alteration of records that may be pertinent to a legal investigation.

- Certain categories of documented business records must be retained by an organization for periods of time ranging from three years to perpetuity, with penalties that may apply for failure to comply.

- Certain categories of electronic business records and communications must be retained and stored by an organization for varying periods of time.

Some log-management platforms, including SolarWinds Security Event Manager, include tools for producing evidence to federal agencies that SOX mandates are being met.

## HIPAA / HITECH

The Health Insurance Portability and Accountability Act of 1996 (HIPAA) specifies how patients' medical records and personal information must be protected and managed by healthcare organizations, insurance providers, and all institutions that may handle such records, including cloud service providers.<sup>[3][^3]</sup> The HIPAA Privacy Rule passed in 2000 and was modified in 2002. The HIPAA Security Rule in 2005 made more clarifications. Then in 2013, the Health Information Technology for Economic and Clinical Health Act (HITECH) strengthened the law's requirements, while mandating a more pro-active role for the U.S. Dept. of Health and Human Services (HHS) to give guidance and support.

- HIPAA's initial Privacy Rule laid forth rules for how the transfers of sensitive electronically protected health information (ePHI) were to take place between *covered entities* (organizations, providers, and IT firms as defined by the terms of the law). Its key objective was to ensure a smooth flow of information, enabling automated tools coupled with human oversight to ensure and protect handoffs, storage, and copying procedures.

- The Security Rule, first enforced in 2005, established national standards for the storage and protection of ePHI, including sensitive records and other information about individual patients. HHS established an Office for Civil Rights and charged it with enforcing the Security Rule, and encouraged organizations to undertake voluntary compliance activities to help ensure their participation and compliance.

- The Omnibus Rule implements provisions of the HITECH Act mandating the form and format of a Business Associate Agreement (BAA) between the healthcare provider and anyone handling its records. A CSP falls under that category. For a healthcare provider to enter into a BAA with a cloud firm (such as an IaaS provider or a data-storage provider) as its customer, that firm must first conduct a thorough risk analysis and make the results of that analysis available to the customer.

For any data to qualify as PHI or ePHI, it must contain data that identifies at least one individual and data that may pertain to the past, present, or future health of that individual.

## FISMA

The Federal Information Security Management Act of 2002 (FISMA) required federal agencies to provide security for their information systems. Up until that time, U.S. law had yet to define what information systems were, for the purposes of protecting data and services. FISMA was brought up to date with the passage of the Federal Information Security Modernization Act of 2014, which strengthens and re-specifies security principles for the era of cloud services.

## GDPR

General Data Protection Regulation (GDPR) was adopted by EU countries in April 2016 and became enforceable in May 2018. It's an expansive set of rules designed to protect the privacy of residents of the European Union and the European Economic Area (EEA). Its aim is to make sure individuals, and not organizations, have control over information about them, even if they "volunteered" that information by joining, for example, a social-media platform. Penalties for not complying with GDPR can be severe. From the GDPR Web site<sup>[4][^4]</sup>:

*Organizations in breach of GDPR can be fined up to 4% of annual global turnover or €20 Million (whichever is greater). This is the maximum fine that can be imposed for the most serious infringements - for example, not having sufficient customer consent to process data or violating the core of Privacy by Design concepts. There is a tiered approach to fines e.g. a company can be fined 2% for not having their records in order, not notifying the supervising authority and data subject about a breach or not conducting impact assessment. It is important to note that these rules apply to both controllers and processors - meaning 'clouds' are not exempt from GDPR enforcement.*

While major cloud platforms are all GDPR-compliant, it's up to you to make sure any applications and services you deploy to a public cloud are compliant, too. For an organization that hosts a Web site in Azure in a U.S. data center but serves users all over the world (including Europe), being compliant could mean, but isn't limited to:

- Making sure names, e-mail addresses, and other personal data the application stores about its users is fully encrypted and safeguarded against breaches

- Making sure the site uses HTTPS rather than HTTP so information traveling over the wire is encrypted

- Making sure opt-in boxes in Web forms aren't checked by default (for example, "Subscribe to our monthly newsletter" check boxes)

- Being careful about sharing personal data with third parties and making it abundantly clear to users what you share, who you share it, and under what circumstances you share it

- Making terms and conditions highly visible and avoiding blanket consents asking users to check a box saying they agree to all terms and conditions and opting them into various services if they do

- Avoiding the use of HTTP cookies to persist data across sessions, or making users aware cookies are being used and providing them with the opportunity to decline

- Eliminating intrusive security questions such as "What was your mother's maiden name?"

- Honoring a user's right to be "forgotten" if they so choose

To sum up, a great way to address compliance (not just GDPR, but all applicable laws and regulations) is to think about compliance the same way you think about security. Cloud providers are responsible for compliance *of* the cloud, but cloud users are responsible for compliance *in* the cloud.

### References

1. _GDPR.eu. <https://gdpr.eu/>._

2. _U.S. SEC (2003). *SEC Adopts Rules on Retention of Records Relevant to Audits and Reviews*. <https://www.sec.gov/news/press/2003-11.htm>._

3. _HHS.gov (2020). *HIPAA for Professionals*. <https://www.hhs.gov/hipaa/for-professionals/index.html>._

4. _GDPR.eu. *General Data Protection Regulation (GDPR)*. <https://gdpr.eu/tag/gdpr/>._

[^1]:  <https://gdpr.eu/>  "GDPR.eu."

[^2]:  <https://www.sec.gov/news/press/2003-11.htm>  "U.S. SEC (2003). *SEC Adopts Rules on Retention of Records Relevant to Audits and Reviews*."

[^3]:  <https://www.hhs.gov/hipaa/for-professionals/index.html>  "HHS.gov (2020). *HIPAA for Professionals*."

[^4]:  <https://gdpr.eu/tag/gdpr/>  "GDPR.eu. *General Data Protection Regulation (GDPR)*."
