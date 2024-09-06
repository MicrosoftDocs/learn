All applications need a way to ensure that they don't leak sensitive information in their logs or telemetry. .NET provides a simple way to classify data and redact it. By applying classifications to all the microservices in your cloud-native application, you can ensure that no sensitive data is leaked.

## Cleanup Codespace

You can delete the codespace on [GitHub](https://github.com/codespaces) under **By repository** where you see **MicrosoftDocs/mslearn-dotnet-cloudnative**.

## References

The following are links to the API references for the compliance features of .NET:

- [Microsoft.Extensions.Compliance.Classification Namespace](/dotnet/api/microsoft.extensions.compliance.classification)
- [Microsoft.Extensions.Compliance.Redaction Namespace](/dotnet/api/microsoft.extensions.compliance.redaction)
- [Microsoft.Extensions.Compliance.Redaction Readme](https://github.com/dotnet/extensions/blob/main/src/Libraries/Microsoft.Extensions.Compliance.Redaction/README.md)
- [Microsoft.Extensions.Compliance.Abstractions Readme](https://github.com/dotnet/extensions/blob/main/src/Libraries/Microsoft.Extensions.Compliance.Abstractions/README.md)