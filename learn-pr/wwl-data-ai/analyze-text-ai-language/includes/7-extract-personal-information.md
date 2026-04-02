
In many scenarios, you need to identify and protect sensitive personal information in documents. For example, you might need to remove personally identifiable information (PII) from customer feedback, medical records, or legal documents before sharing them.

Azure Language provides PII detection and redaction capabilities to identify sensitive information such as names, addresses, phone numbers, email addresses, social security numbers, and credit card numbers. You can both extract PII entities for analysis and redact (mask) them to protect privacy.

As with all Azure Language functions, you can submit one or more documents for analysis:

```python
# Example text to analyze
documents = ["John Smith works at Contoso Ltd. His email is john.smith@contoso.com and his phone number is 555-012-456.",
             "Patient Sarah Johnson, SSN 123-45-6789, was admitted on 03/15/2024."]

# Extract PII entities
response = client.recognize_pii_entities(documents=documents, language="en")
for doc in response:
    print(f"\nPII entities in document {doc.id}:")
    for entity in doc.entities:
        print(f" - {entity.text}: {entity.category} (confidence: {entity.confidence_score:.2f})")
```

The response includes the PII entities identified in the text along with their categories and confidence scores:

```output
PII entities in document 0:
 - John Smith: Person (confidence: 0.99)
 - Contoso Ltd: Organization (confidence: 0.85)
 - john.smith@contoso.com: Email (confidence: 1.00)
 - 555-012-456: PhoneNumber (confidence: 0.80)
PII entities in document 1:
 - Sarah Johnson: Person (confidence: 0.99)
 - 123-45-6789: USSocialSecurityNumber (confidence: 0.99)
 - 03/15/2024: DateTime (confidence: 0.80)
```

You can also redact the PII entities to protect sensitive information. The service returns a redacted version of the text with PII replaced by asterisks or a specified character:

```python
# Redact PII entities
response = client.recognize_pii_entities(documents=documents, language="en")
for doc in response:
    print(f"\nDocument {doc.id} (redacted):")
    print(f" {doc.redacted_text}")
```

This produces output with the sensitive information masked:

```output
Document 0 (redacted):
 ********** works at ************. His email is ************************ and his phone number is ********.
Document 1 (redacted):
 Patient *************, SSN ***********, was admitted on **********.
```
