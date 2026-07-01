After evaluating passwordless options, the IT team needs to finalize its rollout strategy. It must match each authentication method to the right user scenario.

This flow chart shows a simplified view of the team's decision-making process:

:::image type="content" border="true" source="../media/authentication-method.svg" alt-text="Diagram that shows how the IT team decides which passwordless method to use." lightbox="../media/authentication-method.svg":::

The following sections walk through more key factors to consider when selecting a method.

## How to choose the right method

Choosing a passwordless method depends on three key factors:

### User context

- Does the user work on a single device or multiple devices?
- Do they primarily work on-site or remotely?

### Security requirements

- Is the account a standard user or a high-risk role?
- How important is phishing resistance?

### Usability needs

- Does the method need to be fast and seamless?
- Can the user manage additional devices or hardware?

These criteria help the IT team evaluate which method fits each situation.

## Apply the methods to real scenarios

The IT team maps each passwordless approach to specific user needs in the organization:

### Office-based employees

- **Method:** Windows Hello for Business
- **Why:**
  - Device-bound authentication fits corporate laptops
  - Provides a fast, seamless sign-in experience
- **Trade-off:**
  - Less flexible across multiple devices

### Remote and hybrid workers

- **Method:** Authenticator app
- **Why:**
  - Works across multiple devices and locations
  - Enables secure approval of sign-in requests
- **Trade-off:**
  - Requires access to a mobile device

### Administrators and high-risk users

- **Method:** Security keys
- **Why:**
  - Provides the strongest protection against phishing
  - Requires physical possession of the device
- **Trade-off:**
  - Additional cost and management overhead

## Compare the options

The IT team summarizes its decision using a simple comparison:

| **Scenario** | **Best method** | **Key benefit** |
| :---: | :---: | :---: |
| **Single, managed device** | Windows Hello for Business | Seamless, device-based authentication |
| **Multi-device or remote** | Authenticator app | Flexible, portable access |
| **High-risk or privileged** | Security keys | Maximum phishing resistance |

## Combine methods for full coverage

In practice, no single method meets every need. Therefore, the IT team ensures that users have at least one primary method as well as at least one backup option.

For example:

- A user might use Windows Hello for Business daily, with an authenticator app as a fallback
- An administrator might use a security key, with the option of a secondary authenticator method for limited access and recovery

## Key takeaway

Selecting the right passwordless method requires balancing user environment, security requirements, and ease of use.

By aligning each method to specific scenarios, the IT team creates a secure, flexible authentication strategy that reduces risk without disrupting productivity.
