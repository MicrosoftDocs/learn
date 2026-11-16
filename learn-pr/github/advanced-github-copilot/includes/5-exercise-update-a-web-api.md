Let's explore how you can modify a Python repository using advanced GitHub Copilot techniques for an API endpoint. Gain more practical experience by using this repository that contains a Python web application that hosts a Travel Weather API.

## What is an API?

An API acts as the intermediary that allows different applications to communicate with each other. For example, a weather website can either share historical data or provide forecast functionality through its API. Using the API, you can embed the data into your website, or create an application that combines weather data with other features.

## Extend the Web API

The API already lists regions and returns monthly weather data for a region, city, and month. Add `GET /regions/{region}` to return a JSON array of the cities available for that region. For the supplied dataset, `GET /regions/Spain` should return `["Seville"]`. Preserve the existing endpoints, including the monthly weather endpoint.

For this exercise, use the [Codespace with the preconfigured environment](https://codespaces.new/MicrosoftDocs/mslearn-advanced-copilot?azure-portal=true) in your browser. The exercise requires an authenticated Codespaces editor in which your current account, editor version, and organization policy make the required Copilot session and Agent choice available. If a required feature isn't available, resolve that prerequisite before continuing; don't change policy settings, use unrestricted permissions, or treat an unverified workflow as equivalent.

> [!IMPORTANT]
> Select **Agent** explicitly in the Chat view when you want it to change files. For this interactive exercise, use **Manual permissions** when it's available and permitted by your organization. Review actions that request approval and inspect all resulting changes. Manual permissions don't require confirmation for every file edit, and edits can already be saved before you select **Keep**. A prompt requesting a narrow change doesn't enforce file-access restrictions.

### Step 1: Plan and add a new route

1. Open Chat, start a Copilot session for the current project, and select **Ask**. Attach `main.py`, `weather.json`, and `test_main.py`, then send this request:

   ```text
   Explain how the existing routes use the weather data and identify the current
   tests. Confirm which cities the Spain entry contains. Don't change files.
   ```

2. Compare the explanation with the attached files. In the same Copilot session, enter this planning request:

   ```text
   /plan Add GET /regions/{region} to return the city names from weather.json.
   Preserve the existing region-list and monthly weather endpoints. Use the
   existing app and data and the dataset's case-sensitive names. Return HTTP 404
   with detail "Region not found" for an unknown region. Register the
   route before the OpenAPI schema is generated. Include tests for the new
   route and a regression test for the existing monthly weather response.
   Propose the changes without implementing them.
   ```

   Review the plan and submit feedback if it doesn't meet these requirements.
   Select **Approve Plan Only**. Don't select **Implement Plan** in this
   exercise, because you'll implement the route with inline chat in the
   following steps.

3. Open `main.py` and update its existing FastAPI import, preserving `FastAPI`:

   ```python
   from fastapi import FastAPI, HTTPException
   ```

4. Locate the existing region-list route (`GET /regions`) and the `# Generate the OpenAPI schema:` block. The new route must be after the region-list route and before that schema-generation block.
5. Place the cursor at the required insertion point. Open inline chat with **Ctrl+I** on Windows or **Command+I** on macOS, and use this natural-language prompt:

   ```text
   Add GET /regions/{region} in main.py. Return the city names from the
   existing data dictionary loaded from weather.json for the requested region.
   Return HTTP 404 with detail "Region not found" if the region is absent.
   Preserve the existing routes, including the monthly weather endpoint, and
   the dataset's case-sensitive names. Place the new route before the block
   that generates the OpenAPI schema.
   ```

6. Review the proposed edit before retaining it. Confirm that it uses the existing `app` and loaded `data`, doesn't reload the fixture or create another application, and adds or replaces this route only once:

   ```python
   @app.get("/regions/{region}")
   def cities(region: str):
       if region not in data:
           raise HTTPException(status_code=404, detail="Region not found")
       return list(data[region].keys())
   ```

Inline chat uses the active editor context. Don't assume that attachments to a separate Chat request are also attached to inline chat. If the edit needs more context, continue in the Chat view with the relevant files attached and select **Agent**.

Region names must match the keys in the supplied dataset, including case. The expected Spain response is `["Seville"]`. A name that isn't present returns HTTP 404 with `{"detail": "Region not found"}`.

> [!IMPORTANT]
> This project generates and caches its OpenAPI schema when `main.py` is imported. A route added below the schema-generation block might work as an HTTP endpoint but be missing from the interactive documentation. Correct the source ordering; don't edit the generated `.well-known/openapi.json`.

#### Check the route manually

The container installs the project requirements into its configured Python environment. When you attach to the codespace, its configured startup command runs Uvicorn on port 8000 with automatic reload.

1. Check the startup terminal for successful application startup. Resolve any error before continuing. A port entry alone doesn't prove the application is running.
2. Open the **Ports** view, locate port **8000** labeled **Application**, and keep its visibility **Private**.
3. Open the forwarded application in your browser. The root redirects to the interactive API documentation at `/docs`.
4. Save `main.py` and wait for the automatic reload to finish successfully.
5. Refresh the forwarded application's `/docs` page.
6. Expand `GET /regions/{region}`, select **Try it out**, enter `Spain`, and select **Execute**.
7. Confirm HTTP 200 and the JSON array `["Seville"]`. If the operation is missing, check that the route is before schema generation. If the request fails, inspect the server output and share the relevant error with Copilot.

The server is normally already running. Don't start a second copy on port 8000, and don't use your local machine's `localhost:8000`. Saved Python changes trigger the existing server's automatic reload.

### Step 2: Create and run tests

Open the existing `test_main.py` in the repository root. In the Copilot session, select **Agent** and attach `test_main.py`, `main.py`, and `weather.json`. Use this prompt:

```text
Extend the existing test_main.py using its existing TestClient and client.
Keep its current tests. Verify that GET /regions/Spain returns HTTP 200 and
exactly ["Seville"], an unknown region returns HTTP 404 with the agreed error
detail, POST to the city-list route returns HTTP 405, and the new path is present
in /openapi.json. Also verify that GET /regions/Spain/Seville/January still
returns HTTP 200 with exactly {"high": 61, "low": 41}. Don't change the fixture
or weaken assertions to make tests pass.
```

Review the result and retain the existing imports, `TestClient`, `client`, and tests. The following five tests are a suitable addition:

```python
def test_cities_spain():
    response = client.get("/regions/Spain")
    assert response.status_code == 200
    assert response.json() == ["Seville"]


def test_cities_unknown_region():
    response = client.get("/regions/__unknown__")
    assert response.status_code == 404
    assert response.json() == {"detail": "Region not found"}


def test_cities_rejects_post():
    response = client.post("/regions/Spain")
    assert response.status_code == 405


def test_cities_in_openapi():
    response = client.get("/openapi.json")
    assert response.status_code == 200
    assert "get" in response.json()["paths"]["/regions/{region}"]


def test_monthly_weather_preserved():
    response = client.get("/regions/Spain/Seville/January")
    assert response.status_code == 200
    assert response.json() == {"high": 61, "low": 41}
```

Run the suite from the repository root in the Codespace:

```bash
/home/vscode/venv/bin/python -m pytest -q
```

If your copy has the two existing tests, these five additions should bring the total to seven passing tests. Keep any additional tests supplied by a newer template. A passing count alone isn't sufficient: review the assertions and confirm that the original monthly weather behavior is still covered. If your template already has equivalent monthly weather coverage, keep that test instead of adding a duplicate and use the actual test count.

The project already includes pytest, HTTPX, and a FastAPI TestClient in `test_main.py`. Reuse them. These tests run the application in process, so they don't depend on the forwarded browser URL or a running Uvicorn process. Don't upgrade an individual dependency merely because Copilot suggests doing so.

If a test fails, give Copilot the failing test, actual output, and expected result. For example:

```text
The fixture's Spain entry contains only Seville. Correct the city-list test to
expect exactly ["Seville"]. Preserve the fixture and the endpoint contract.
```

### Step 3: Use Agent to update the project documentation

1. Open Chat, start a Copilot session for the current project, select **Agent**, and review the session's permissions.
2. Attach `README.md`, `main.py`, `weather.json`, `test_main.py`, `requirements.txt`, and the effective `.devcontainer` configuration.
3. Send this prompt:

   ```text
   Update only README.md to explain how another learner can run this project in
   its configured Codespace. Read the attached source and configuration.
   Document the existing Python environment, automatic Uvicorn startup, private
   port-8000 preview, the city-list endpoint with its Spain example, and the command
   for running the existing tests. Don't change source code, dependencies, or the
   container configuration.
   ```

4. Review the README diff and every other changed or untracked file in Source Control. Correct unsupported claims and changes outside the requested scope. The narrow prompt isn't an access control, and the Agent's changed-files list might omit changes made through terminal commands.
5. Confirm that the documented test command works in the configured environment. Verify that the README describes the existing automatic Uvicorn startup and doesn't instruct readers to start a duplicate server. If it includes a manual recovery command, it must first tell readers to stop the existing process.
6. Retain the intended edits. **Keep** isn't a Git commit. Commit and push later using the summary's preservation steps.

Congratulations on completing this exercise. You used GitHub Copilot to plan, implement, and review a new API route, wrote and ran tests to verify its behavior, OpenAPI registration, and preservation of the monthly weather endpoint, and used Agent to improve project documentation.

When you've finished the exercise in GitHub, return here for:

> [!div class="checklist"]
> * A quick knowledge check
> * A summary of what you've learned
> * A badge for completing this module
