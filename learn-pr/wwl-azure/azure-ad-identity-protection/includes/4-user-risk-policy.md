Identity Protection can calculate what it believes is normal for a user's behavior and use that to base decisions for their risk. User risk is a calculation of probability that an identity has been compromised. Administrators can decide based on this risk score signal to enforce organizational requirements. Administrators can choose to block access, allow access, or allow access but require a password change using Azure AD self-service password reset.

:::image type="content" source="../media/az500-user-risk-policy-41559c0a.png" alt-text="A user risk policy shows different risk levels and the ability to block access.":::


The above image shows the configuration of **User Risk Policy** applied

 -  To user sign-ins
 -  Automatically respond based on a specific user’s risk level
 -  Provide the condition (risk level) and action (block or allow)
 -  Use a high threshold during policy roll out
 -  Use a low threshold for greater security

## Risky users

With the information provided by the risky users report, administrators can find:

 -  Which users are at risk, have had risk remediated, or have had risk dismissed?
 -  Details about detections
 -  History of all risky sign-ins
 -  Risk history

Administrators can then choose to act on these events. Administrators can choose to:

 -  Reset the user password
 -  Confirm user compromise
 -  Dismiss user risk
 -  Block user from signing in
 -  Investigate further using Azure ATP
