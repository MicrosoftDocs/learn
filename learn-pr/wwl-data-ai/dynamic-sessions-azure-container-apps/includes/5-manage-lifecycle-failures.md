::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=210a1403-677a-45ab-b8ef-c5d02d79d067]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Dynamic sessions remove much of the work required to allocate and clean up isolated environments, but the AI backend still owns the request lifecycle. Reliable applications distinguish transport failures from code failures, tolerate expired state, and avoid repeating operations that might have side effects.

> [!NOTE]
> The API and Python examples in this unit are patterns that you can adapt to your application. Execution limits and API versions can change. Confirm current behavior in the [code interpreter session documentation](/azure/container-apps/sessions-code-interpreter) before you set production timeouts or retry policies.

## Plan for ephemeral session state

A timed session remains allocated while it receives requests. Each request resets the pool's idle cooldown. After the cooldown passes with no activity, Azure Container Apps destroys the session and its temporary files.

A later request can use the same identifier, but the pool might allocate a new empty session. The identifier preserves routing only while the original session exists. Store source documents and accepted outputs in durable application storage so the backend can upload required inputs again.

The backend can query a session when it needs creation, last-access, or expiration information. This operation is useful for diagnostics and proactive user messaging, but the application should still handle the session disappearing between the status request and the next operation.

```http
GET <POOL_MANAGEMENT_ENDPOINT>/session?identifier=<SESSION_ID>&api-version=2025-02-02-preview
Authorization: Bearer <ACCESS_TOKEN>
```

Design each workflow so it can recognize missing temporary state. For example, if analysis code reports that `/mnt/data/operational-data.csv` doesn't exist, the backend can retrieve the authorized source from durable storage, upload it to the newly allocated session, and restart an idempotent analysis step.

## Separate failure categories

An HTTP success response doesn't necessarily mean the submitted code produced a valid business result. The API transport can succeed while Python raises an exception or returns output that doesn't satisfy the application's contract. The backend must validate both layers before passing a result to the AI orchestration layer.

Use distinct result categories so monitoring and callers can respond correctly:

- **Transport failure:** Authentication, authorization, malformed request, capacity, network, or service errors prevent the API operation from completing.
- **Execution failure:** The session runs the payload, but the code raises an exception, exceeds a limit, or returns an unsuccessful execution result.
- **Validation failure:** The code completes, but its output has the wrong schema, omits a required artifact, or violates an application rule.
- **Successful result:** The transport succeeds, execution completes without an error, and the output passes application validation.

The following result model prevents the backend from representing a failed operation as an empty success response. The backend records the category and a safe message, while diagnostic details remain in protected logs.

```python
from dataclasses import dataclass
from enum import StrEnum
from typing import Any


class ResultStatus(StrEnum):
    SUCCEEDED = "succeeded"
    TRANSPORT_ERROR = "transport_error"
    EXECUTION_ERROR = "execution_error"
    VALIDATION_ERROR = "validation_error"


@dataclass(frozen=True)
class ExecutionResult:
    status: ResultStatus
    output: dict[str, Any] | None
    message: str | None
    trace_id: str | None
```

Don't expose raw stack traces, access tokens, or sensitive source content in an end-user message. Return a correlation value when appropriate so an operator can match the controlled response to protected diagnostic data.

## Set execution deadlines

Code interpreter executions have a platform maximum runtime, but the backend should also set its own HTTP deadline. A shorter application deadline reserves time to validate the result and send a controlled response before the caller's request expires. Different operations can use different deadlines because a file listing should complete faster than an analysis.

An HTTP client timeout limits how long the backend waits for the response. It doesn't guarantee that the remote execution stops at the same instant, so avoid assuming that a timed-out operation produced no effects. The platform execution limit and session lifecycle provide separate boundaries.

The following fragment uses explicit connection and response timeouts. Handle `Timeout` separately from HTTP status failures so telemetry shows whether the backend stopped waiting or the service rejected the request. Dynamic sessions return the diagnostic trace ID in the structured error response body, so the backend extracts that field when the body matches the documented contract.

```python
# Code fragment - focus on explicit timeout and error categories
import requests

try:
    response = requests.post(
        execution_url,
        headers=headers,
        params=params,
        json=payload,
        timeout=(5, 30),
    )
    response.raise_for_status()
except requests.Timeout as error:
    raise SessionExecutionTimeout(
        "The session didn't return a result before the application deadline."
    ) from error
except requests.HTTPError as error:
    try:
        error_body = error.response.json()
    except requests.JSONDecodeError:
        trace_id = None
    else:
        error_details = error_body.get("error")
        trace_id = (
            error_details.get("traceId")
            if isinstance(error_details, dict)
            else None
        )
    raise SessionTransportError(
        status_code=error.response.status_code,
        trace_id=trace_id,
    ) from error
```

The custom exceptions represent application-specific error types defined elsewhere in the backend. A production implementation should also handle connection failures explicitly and map each failure to repository-standard telemetry and user responses.

## Apply retries safely

Retries can recover from transient network or service failures, but repeating arbitrary generated code can duplicate side effects. A response timeout is ambiguous because the execution might have completed after the backend stopped waiting. Automatically retry only when the operation is idempotent and the application can verify the outcome.

File metadata reads and session status queries are natural retry candidates. A deterministic analysis that only reads an input and overwrites a known output might also be retryable after the backend confirms the intended state. The backend shouldn't automatically repeat code that sends messages, writes to external systems, or creates uniquely named artifacts.

The following decision fragment makes idempotency part of the retry policy rather than basing the decision only on an HTTP status:

```python
# Code fragment - focus on retry eligibility
TRANSIENT_STATUS_CODES = {429, 500, 502, 503, 504}


def can_retry(
    *,
    method: str,
    status_code: int,
    operation_is_idempotent: bool,
) -> bool:
    safe_method = method.upper() in {"GET", "HEAD"}
    return (
        status_code in TRANSIENT_STATUS_CODES
        and (safe_method or operation_is_idempotent)
    )
```

Use bounded retries with increasing delays and jitter. Preserve the service's trace ID and the application's session identifier in telemetry, but don't log bearer tokens or expose session identifiers to end users.

## Release completed sessions

The cooldown automatically cleans up inactive sessions, but the backend can delete a code interpreter session before the cooldown expires. Early deletion frees capacity and removes temporary data when a workflow finishes or a user explicitly ends the conversation. Don't delete a session while another request for the same conversation is still running.

The code interpreter session API uses an authenticated `DELETE` request. Treat a successful `204 No Content` response as confirmation that the environment no longer exists.

```http
DELETE <POOL_MANAGEMENT_ENDPOINT>/session?api-version=2025-02-02-preview&identifier=<SESSION_ID>
Authorization: Bearer <ACCESS_TOKEN>
```

If deletion fails, report the failure through application telemetry instead of claiming cleanup succeeded. The timed lifecycle remains a fallback, but a failed explicit operation still needs visibility because capacity or sensitive temporary data might remain until cooldown.

## Operate session workflows reliably

Reliable session integration requires coordinated controls at the application and platform boundaries. The session sandbox limits the impact of code, while backend validation, authorization, timeouts, and result checks determine what the AI application accepts. Neither layer replaces the other.

Apply these practices to production workflows:

- **Validate before execution:** Check payload size, language, requested operation, and required inputs before the backend submits code.
- **Authorize every operation:** Confirm that the authenticated user owns the conversation and its server-side session association.
- **Persist durable data elsewhere:** Treat session files as temporary working data and save approved artifacts in durable storage.
- **Classify failures:** Keep transport, execution, validation, and session-expiration outcomes distinct.
- **Retry with evidence:** Repeat only bounded, idempotent operations after evaluating the observed state.
- **Clean up intentionally:** Delete completed sessions when immediate data removal or capacity recovery matters.
- **Log safely:** Record timing, status, and trace IDs without recording tokens, sensitive code, or raw documents.

::: zone-end

## Additional resources

These resources describe current lifecycle operations, security boundaries, and troubleshooting approaches. You can use them to refine deadlines, cleanup behavior, and operational monitoring for your AI backend.

- [Session lifecycle guidance](/azure/container-apps/sessions-usage#session-lifecycle-in-practice)
- [Dynamic sessions security guidance](/azure/container-apps/sessions-usage#security)
- [Troubleshoot Azure Container Apps dynamic sessions](/azure/container-apps/troubleshooting)
