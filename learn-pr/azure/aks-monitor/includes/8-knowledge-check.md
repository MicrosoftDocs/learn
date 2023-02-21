quiz:
  title: Check your knowledge
  questions:
    - content: "What monitoring data do you get from an AKS cluster without Container insights?"
      choices:
        - content: "None. You need Container insights to collect any monitoring data from the cluster."
          isCorrect: false
        - content: "Platform metrics. Enable Container insights to collect additional performance and log data."
          isCorrect: true
        - content: "Most logs and metrics. Enable Container insights to get curated views of data that’s already being collected."
          isCorrect: false

    - content: "How do you enable Container insights for a cluster?"
      choices:
        - content: "It’s enabled by default."
          isCorrect: false
        - content: "It can only be enabled with the Azure portal."
          isCorrect: false
        - content: "Enable it using the Azure portal, CLI, ARM, or Terraform."
          isCorrect: true

    - content: "How do you get an alert when your cluster has a problem?"
      choices:
        - content: "Alerts will automatically be created when Container insights detects a problem."
          isCorrect: false
        - content: "Enable any of a list of recommended alert rules in Container insights."
          isCorrect: true
        - content: "Create a new alert rule using Azure Monitor."
          isCorrect: false

    - content: "How can you receive a proactive message when an alert is fired?"
      choices:
        - content: "Specify your contact information in the administrator section of the alert rule."
          isCorrect: false
        - content: "Create an action group with an SMS action and associate it with the alert rule."
          isCorrect: true
        - content: "Create a Logic app with an SMS action and specify the Logic app as an action for the alert rule."
          isCorrect: false