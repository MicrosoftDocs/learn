## How many licenses must you have?

Your directory needs at least as many Azure AD Premium P2 licenses as the number of employees who will be performing the following tasks:

- Member users who are assigned as reviewers

- Member users who perform a self-review

- Member users as group owners who perform an access review

- Member users as application owners who perform an access review

For guest users, licensing needs will depend on the licensing model you’re using. However, the below guest users’ activities are considered Azure AD Premium P2 usage:

- Guest users who are assigned as reviewers

- Guest users who perform a self-review

- Guest users as group owners who perform an access review

- Guest users as application owners who perform an access review

Azure AD Premium P2 licenses are not required for users with the Global Administrator or User Administrator roles who set up access reviews, configure settings, or apply the decisions from the reviews.

## Example license scenarios

| Scenario| Calculation| Number of licenses|
| :--- | :--- | :--- |
| An administrator creates an access review of Group A with 75 users and 1 group owner, and assigns the group owner as the reviewer.| 1 license for the group owner as reviewer.| 1|
| An administrator creates an access review of Group B with 500 users and 3 group owners, and assigns the 3 group owners as reviewers.| 3 licenses for each group owner as reviewers.| 3|
| An administrator creates an access review of Group B with 500 users. Makes it a self-review.| 500 licenses for each user as self-reviewers.| 500|
| An administrator creates an access review of Group C with 50 member users and 25 guest users. Makes it a self-review.| 50 licenses for each user as self-reviewers.*| 50|
| An administrator creates an access review of Group D with 6 member users and 108 guest users. Makes it a self-review.| 6 licenses for each user as self-reviewers. Guest users are billed on a monthly active user (MAU) basis. No additional licenses are required. *| 6|

