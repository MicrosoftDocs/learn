In this exercise, you reproduce the silent truncation in the issue list, fix it with cursor pagination, and add a status summary that the server computes.

## Generate more than 100 issues

1. Add a temporary seed function to your app that creates 105 issues. Create them in batches of 15 so the requests finish quickly.

    ```typescript
    async function seedMany() {
      const client = await getRayfinClient();
      const me = client.auth.getSession().user?.id;
      if (!me) throw new Error('Sign in first.');
      const statuses = ['open', 'in-review', 'closed'] as const;
      const severities = ['low', 'medium', 'high'] as const;
      for (let batch = 0; batch < 7; batch++) {
        await Promise.all(
          Array.from({ length: 15 }, (_, i) => {
            const n = batch * 15 + i + 1;
            return client.data.Issue.create({
              title: `Seed issue ${n}`,
              status: statuses[n % 3],
              severity: severities[n % 3],
              unitsAffected: 1 + (n % 4),
              reportedOn: new Date(Date.now() - n * 60_000),
              user_id: me,
            });
          }),
        );
      }
    }
    ```

1. Add a **Seed 105 issues** button that calls `seedMany()`, select it once, and wait for it to finish. Together with the three issues from the previous exercise, the app now has 108 issues.

## Reproduce the truncation

1. Change your list query to remove the `status` filter, so that it matches all issues, and keep `execute()`.
1. Count the list items. Confirm that the list stops at 100 even though 108 issues exist. No error appears.

    Predict what happens if the list had 99 or 100 matching issues, and then check the explanation at the end of this exercise.

## Fix it with pagination

1. Replace the `loadOpenIssues` function and the `Row` type immediately below it with the following code. The existing `.execute()` call is inside this function. The replacement returns a page and accepts an optional cursor. Keep the imports, `seedIssues`, and `seedMany` unchanged.

    ```tsx
    async function loadOpenIssues(cursor?: string) {
      const client = await getRayfinClient();
      const query = client.data.Issue
        .select(['id', 'title', 'status', 'reportedOn', 'store.name'])
        .orderBy({ reportedOn: 'desc' })
        .orderBy({ id: 'asc' })
        .first(25);

      return (cursor ? query.after(cursor) : query).executePaginated();
    }

    type Row = Awaited<ReturnType<typeof loadOpenIssues>>['items'][number];
    ```

1. Inside `IssueList`, replace the existing state, `useEffect`, and both seed handlers with the following code, stopping before the `return` block. The first page loads when the component appears. Each seed handler refreshes the first page and resets the cursor, while `loadMore` appends the next page. Keep the existing `return` block for now.

    ```tsx
    const [rows, setRows] = useState<Row[]>([]);
    const [cursor, setCursor] = useState<string | undefined>();
    const [more, setMore] = useState(true);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
      refreshIssues();
    }, []);

    async function refreshIssues(seed?: () => Promise<void>) {
      setLoading(true);
      setError(null);
      try {
        if (seed) await seed();
        const page = await loadOpenIssues();
        setRows(page.items);
        setCursor(page.endCursor ?? undefined);
        setMore(page.hasNextPage);
      } catch (error) {
        setError(error instanceof Error ? error.message : 'Unable to load issues.');
      } finally {
        setLoading(false);
      }
    }

    async function handleSeedIssues() {
      if (loading) return;
      await refreshIssues(seedIssues);
    }

    async function handleSeedManyIssues() {
      if (loading) return;
      await refreshIssues(seedMany);
    }

    async function loadMore() {
      if (loading || !more) return;
      setLoading(true);
      setError(null);
      try {
        const page = await loadOpenIssues(cursor);
        setRows((previousRows) => [...previousRows, ...page.items]);
        setCursor(page.endCursor ?? undefined);
        setMore(page.hasNextPage);
      } catch (error) {
        setError(error instanceof Error ? error.message : 'Unable to load issues.');
      } finally {
        setLoading(false);
      }
    }
    ```

1. In the existing `return` block, add `disabled={loading}` to both seed buttons. Insert the following code after `</ul>` and before the closing `</div>`. Keep both seed buttons and the list markup, including the store name and date.

    ```tsx
    {error && <p role="alert">{error}</p>}
    <button
      type="button"
      onClick={loadMore}
      disabled={loading || !more}
      className="bg-primary text-primary-foreground px-400 py-200 rounded-md disabled:opacity-60"
    >
      {loading ? 'Loading...' : 'Load more'}
    </button>
    ```

1. Open the app. The first 25 issues load automatically. Select **Load more** until the button stays disabled. Confirm that all 108 issues are reachable, five pages of 25 or fewer. If you created additional sample records, the total is higher.

## Add a status summary

1. Add a summary that groups by status, counts issues, and sums `unitsAffected`. Run the aggregation as its own query, and don't combine it with `select` or `orderBy`. `unitsAffected` is a required numeric field, so `count` on it returns the number of issues in each group.

    ```typescript
    const summary = await client.data.Issue
      .groupBy(['status'])
      .aggregate({
        issues: { count: 'unitsAffected' },
        affected: { sum: 'unitsAffected' },
      })
      .execute();
    ```

1. Display each status with its counted and summed values. Sort the rows in TypeScript if you want a fixed order.
1. Verify that the `issues` counts add up to the number of rows you reached with **Load more**. The summary is correct even though the unpaged list isn't, because the server computes it across all rows.