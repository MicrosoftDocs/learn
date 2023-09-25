The threat-modeling framework looks at each element in the data-flow diagram, including each one's interactions. It helps you find potential threats and ways to reduce or eliminate risk.

## Threat categories

Microsoft engineers find security design issues using the six major threat categories in the STRIDE framework:

|Category|Description|
|--------|-----------|
|Spoofing|Pretending to be someone or something else|
|Tampering|Changing data without authorization|
|Repudiation|Not claiming responsibility for an action taken|
|Information disclosure|Seeing data without permission|
|Denial of service|Overwhelming the system|
|Elevation of privilege|Having permissions I shouldn't have|

## Security control categories

Each threat category is associated with a security control to help you reduce or eliminate risk:

|Category|Security Control|Description|
|--------|----------------|-----------|
|Spoofing|Authentication|They are who they say they are|
|Tampering|Integrity|Prevents data from being maliciously modified|
|Repudiation|Non-repudiation|Actions are tied to users|
|Information disclosure|Confidentiality|Data is protected against unintended disclosure|
|Denial of service|Availability|System handles all requests appropriately|
|Elevation of privilege|Authorization|User has appropriate permissions to carry out a request|

In the next few units, we look at each threat category.
