AI-generated code often runs correctly, which makes security problems easy to miss. A security flaw usually doesn't cause a crash, so a passing test run doesn't prove the code is safe. Check for these risks on purpose during every review.

### Injection attacks

Injection happens when user input changes the meaning of a query or command. AI tools often build queries and commands with string formatting, which makes injection possible.

**SQL injection**

Prompt: "Write a function that finds a user by name in SQLite."

AI-generated code:

```python
def get_user(cursor, username):
    query = f"SELECT * FROM users WHERE name = '{username}'"
    cursor.execute(query)
    return cursor.fetchone()
```

If a user enters `' OR '1'='1`, the query condition is always true, so the code returns a row even when no name matches. The input has changed the query.

Safer version, which passes the value as a parameter:

```python
def get_user(cursor, username):
    cursor.execute("SELECT * FROM users WHERE name = ?", (username,))
    return cursor.fetchone()
```

The database driver treats the value as data, not as part of the SQL. The placeholder syntax depends on the driver. The `sqlite3` module uses `?`, and `psycopg` uses `%s`.

**Command injection**

AI-generated code:

```python
import os

def ping_host(host):
    os.system(f"ping -c 1 {host}")
```

If `host` is `example.com; cat secrets.txt`, the shell runs the second command too.

Safer version, which avoids the shell:

```python
import subprocess

def ping_host(host):
    subprocess.run(["ping", "-c", "1", host], check=True)
```

Passing a list of arguments means the host is always a single argument. The `-c` flag works on Linux and macOS. Windows uses `-n`. Validate the format of any host that comes from users.

### Hardcoded secrets

AI-generated examples often include API keys or passwords that look real. Developers sometimes keep them in the code.

```python
API_KEY = "sk-example-1234567890abcdef"
```

Anyone who can read the code can use this key. Read secrets from the environment instead:

```python
import os

API_KEY = os.environ["WEATHER_API_KEY"]
```

If the variable isn't set, this code raises an error at startup, which is easier to diagnose than a failure later. If a secret has appeared in code that other people can read, revoke it and create a new one.

### Unsafe evaluation and deserialization

AI tools sometimes use `eval` to parse data, which runs any Python expression in the input:

```python
def load_settings(text):
    return eval(text)
```

Safer version, which only reads data:

```python
import json

def load_settings(text):
    return json.loads(text)
```

Similarly, `pickle.loads` can run code while it loads data. Use JSON for data from outside your program.

### Path traversal

AI-generated file code often joins a user-supplied file name directly onto a folder path:

```python
def read_upload(filename):
    with open(f"uploads/{filename}") as file:
        return file.read()
```

A file name such as `../../secrets.txt` reads a file outside the uploads folder. Safer version, which checks the resolved path:

```python
from pathlib import Path

UPLOAD_DIR = Path("uploads").resolve()

def read_upload(filename):
    path = (UPLOAD_DIR / filename).resolve()
    if not path.is_relative_to(UPLOAD_DIR):
        raise ValueError("File is outside the uploads folder")
    return path.read_text()
```

`Path.is_relative_to` requires Python 3.9 or later.

### Weak randomness for security values

The `random` module is predictable, so it's unsafe for tokens and passwords:

```python
import random

def create_reset_token():
    return "".join(random.choices("0123456789abcdef", k=32))
```

Use the `secrets` module instead:

```python
import secrets

def create_reset_token():
    return secrets.token_hex(16)
```

### Packages and deprecated APIs

AI tools sometimes suggest packages that don't exist. Attackers can register those names and publish malicious code under them, so installing a suggested package without checking it is a risk. Before you install a package, check that:

- The name is spelled exactly as you expect on [PyPI](https://pypi.org). Attackers also publish packages with names that are one letter off from popular packages.
- The project has a known maintainer, a release history, and working project links.
- Download counts and recent activity support the choice. These are signals, not proof of safety.

After you choose a package, pin its version in `requirements.txt`, such as `requests==2.32.3`, so your environment doesn't change unexpectedly.

AI models are also trained on older code, so they often suggest deprecated functions. For example, `datetime.utcnow()` is deprecated since Python 3.12:

```python
from datetime import datetime

timestamp = datetime.utcnow()
```

The current replacement is timezone-aware:

```python
from datetime import datetime, timezone

timestamp = datetime.now(timezone.utc)
```

### Test security behavior

The unit tests in the previous unit showed how a test can enforce a requirement. The same approach can check security behavior:

```python
import pytest

def test_read_upload_rejects_path_traversal():
    with pytest.raises(ValueError):
        read_upload("../secrets.txt")
```

### Protect data in your prompts

Don't paste passwords, API keys, customer records, or confidential code into an AI tool unless your organization has approved that tool for that data. Check your organization's AI policy and the tool's data settings before you share code.

### The security review checklist

When you audit AI code for security, ask:

- Does user input reach a query, a shell command, or a file path without validation?
- Are there secrets, such as keys, passwords, or tokens, written directly in the code?
- Does the code use `eval`, `exec`, or `pickle` on data from outside the program?
- Do the imported packages exist, and are they maintained?
- Are tokens and other security values generated with the `secrets` module?

Security issues often pass normal testing. Review for them deliberately, even when the code appears to work.
