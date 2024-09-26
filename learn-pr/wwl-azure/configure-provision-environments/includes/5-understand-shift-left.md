The goal for shifting left is to move quality upstream by performing tests early in the pipeline. It represents the phrase "fail fast, fail often" combining test and process improvements reduces the time it takes for tests to be run and the impact of failures later on.

The idea is to ensure that most of the testing is complete before merging a change into the main branch.

:::image type="content" source="../media/shift-left-cba6e08e.png" alt-text="Screenshot of the shift-left representation image showing Unit Tests and Functional Tests during the pipeline lifecycle.":::


Many teams find their test takes too long to run during the development lifecycle.

As projects scale, the number and nature of tests will grow substantially, taking hours or days to run the complete test.

They get pushed further until they're run at the last possible moment, and the benefits intended to be gained from building those tests aren't realized until long after the code has been committed.

There are several essential principles that DevOps teams should adhere to in implementing any quality vision.

:::image type="content" source="../media/shift-left-quality-vision-fe308ed2.png" alt-text="Screenshot of the quality vision principles current and future test portfolio.":::


Other important characteristics to take into consideration:

 -  **Unit tests:** These tests need to be fast and reliable.
     -  One team at Microsoft runs over 60,000 unit tests in parallel in less than 6 minutes, intending to get down to less than a minute.
 -  **Functional tests:** Must be independent.
 -  **Defining a test taxonomy** is an essential aspect of DevOps. The developers should understand the suitable types of tests in different scenarios.
     -  **L0** tests are a broad class of fast in-memory unit tests. It's a test that depends on code in the assembly under test and nothing else.
     -  **L1** tests might require assembly plus SQL or the file system.
     -  **L2** tests are functional tests run against testable service deployments. It's a functional test category requiring a service deployment but may have critical service dependencies stubbed out.
     -  **L3** tests are a restricted class of integration tests that run against production. They require a complete product deployment.

Check the case study in shifting left at Microsoft: [Shift left to make testing fast and reliable](/devops/develop/shift-left-make-testing-fast-reliable).

For more information, see:

 -  [Shift right to test in production](/devops/deliver/shift-right-test-production).
