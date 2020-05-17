The threat modeling framework looks at each element in the data-flow diagram, including their interactions, to help you find potential threats and ways to reduce or eliminate risk.

## Threat Categories

Microsoft engineers find security design issues using the six major threat categories in the STRIDE framework:

|Category|Description|
|--------|-----------|
|Spoofing|Pretending to be someone or something else|
|Tampering|Changing data without authorization|
|Repudiation|Not claiming responsibility for an action taken|
|Information Disclosure|Seeing data without permission|
|Denial of Service|Overwhelming the system|
|Elevation of Privilege|Having permissions I should not have|

## Security Control Categories

Each threat category is associated with a security control to help you reduce or eliminate risk

|Category|Security Control|Description|
|--------|----------------|-----------|
|Spoofing|Authentication|They are who they say they are|
|Tampering|Integrity|Prevents data from being maliciously modified|
|Repudiation|Non-repudiation|Actions are tied to users|
|Information Disclosure|Confidentiality|Data is protected against unintended disclosure|
|Denial of Service|Availability|System handles all requests appropriately|
|Elevation of Privilege|Authorization|User has appropriate permissions to carry out a request|

Let's look at each threat category in the next few units.