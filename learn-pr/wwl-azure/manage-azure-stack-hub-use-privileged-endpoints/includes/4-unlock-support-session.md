During a support scenario, the Microsoft support engineer might need to elevate the privileged endpoint PowerShell session to access the internals of the Azure Stack Hub infrastructure. This process is sometimes informally referred to as "break the glass" or "unlock the PEP". The PEP session elevation process is a two-step, two people, two-organization authentication process. The unlock procedure is initiated by the Azure Stack Hub operator, who always retains control of their environment. The operator accesses the PEP and executes this cmdlet:

```
Get-SupportSessionToken

```

The cmdlet returns the support session request token, a long alphanumeric string. The operator then passes the request token to the Microsoft support engineer via a medium of their choice (for example, chat, email). The Microsoft support engineer uses the request token to generate, if valid, a support session authorization token and sends it back to the Azure Stack Hub operator. On the same PEP PowerShell session, the operator then passes the authorization token as input to this cmdlet:

```
unlock-supportsession
      cmdlet Unlock-SupportSession at command pipeline position 1
      Supply values for the following parameters:
      ResponseToken:

```

If the authorization token is valid, the PEP PowerShell session is elevated by providing full admin capabilities and full reachability into the infrastructure.

All the operations and cmdlets executed in an elevated PEP session must be performed under strict supervision of the Microsoft support engineer. Failure to do so could result in downtime, data loss, and could require a full redeployment of the Azure Stack Hub environment.

Once the support session is terminated, it is important to close back the elevated PEP session by using the **Close-PrivilegedEndpoint**. Once the PEP session is terminated, the unlock token is no longer valid and cannot be reused to unlock the PEP session again. An elevated PEP session has a validity of 8 hours, after which, if not terminated, the elevated PEP session will automatically lock back to a regular PEP session.
