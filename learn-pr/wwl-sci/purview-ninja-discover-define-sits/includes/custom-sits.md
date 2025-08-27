Following the last module, all SITs not identified against the built-in SITs now need to be created. This involves analyzing any remaining sensitive data unique to your organization, such as internal project codes, proprietary formulas, or unique identifiers, that aren't covered by standard out-of-box types. By developing custom sensitive information types (SITs) tailored to these specific data points, you ensure comprehensive coverage and protection of all sensitive assets within your environment.

## Step 1: Create custom sensitive information types from remaining data points

- Identify organization-specific data not covered by out-of-box types. Examples include internal project codes, medical record numbers, proprietary formulas, and unique customer or employee IDs. This ensures that all unique and potentially sensitive information specific to your organization is properly recognized and protected.

- Define [patterns, keywords, or regular expressions](/purview/sit-create-a-custom-sensitive-information-type) that match your custom data types. Creating accurate definitions helps improve detection accuracy and reduce the risk of overlooking sensitive data.

  - [Exact data match](/purview/sit-learn-about-exact-data-match-based-sits) is the best way to decrease false positives as it uses exact or nearly exact data values, instead of one that finds matches based on generic patterns. Examples include medical record numbers, Student ID numbers, and highly sensitive machine part numbers.

  - [Document fingerprinting](/purview/sit-document-fingerprinting#how-document-fingerprinting-works) creates a SIT based on a template, such as a standard proprietary form, that is given to the system. [Trainable classifiers](/purview/trainable-classifiers-get-started-with) can be taught to recognize and categorize sensitive information through machine learning, such as cover letters and resumes.

## Step 2: Test custom sensitive information types within the Microsoft Purview portal

- **Iterate and refine definitions based on test results and stakeholder feedback.**

- Review test results for false positives or missed detections, gather stakeholder feedback (if necessary), and update SIT definitions for improved accuracy.

- Repeat testing until SITs meet organizational needs.

- Once custom SITs and OOB SITs are identified, ensure you test your SIT by following this guidance: [Test the effects of a sensitive information type](/purview/sit-test-a-sit#test-the-effects-of-a-sensitive-information-type).

- Confirm all SITs are configured and tested, address any issues, and keep documentation for compliance.

  - _This step is critical as it decreases false positives before Data Loss Prevention and autolabeling policies are created._

- Thorough SIT testing reduces unnecessary alerts and improves the effectiveness of DLP and autolabeling.
