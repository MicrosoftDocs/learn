Your app is collecting telemetry data and you now need a more comprehensive way to view it. In this unit, you'll see how to view telemetry data in many different tools.

## Monitoring and viewing telemetry data

A common way to view telemetry data is to use Prometheus and Grafana together. Prometheus is an open-source monitoring system that collects metrics from your cloud native app. Grafana is an open-source visualization tool that you use to create dashboards to view the metrics collected by Prometheus.

### Prometheus

The first step is to add a Prometheus container, and configure it to collect data from each microservice in your app. You'll then add the Prometheus .NET client library to collect metrics from the app.

:::image type="content" source="../media/prometheus.png" alt-text="A screenshot of the configured Prometheus app showing the health of the eShopLite app."  lightbox="../media/prometheus.png":::

OpenTelemetry provides an exporter for Prometheus. This exporter can be added to your app by including the `OpenTelemetry.Exporter.Prometheus.AspNetCore` NuGet package. This exports metrics to Prometheus in a format that it can understand. You'll replace the current console exporter with the Prometheus exporter.

You'll add the endpoints for all the microservices in your app. For example:

    ```yml
    global:
      scrape_interval: 1s
    
    scrape_configs:
      - job_name: 'products'
        static_configs:
          - targets: ['backend:8080']
      - job_name: 'store'
        static_configs:
          - targets: ['frontend:8080']
    ```

### Grafana

Grafana is an open-source visualization tool that can be used to create dashboards to view the metrics collected by Prometheus. Grafana can be configured to connect to Prometheus and display the metrics in a dashboard. Like before, you'll add a Grafana container to your app, and configure it to connect to Prometheus.

:::image type="content" source="../media/grafana.png" alt-text="A screenshot showing an ASP.NET dashboard in Grafana."  lightbox="../media/grafana.png":::

You'll add Prometheus as a data source to Grafana in a YAML file:

    ```yml
    apiVersion: 1
    
    datasources:
    - name: Prometheus
      type: prometheus
      url: http://prometheus:9090 
      isDefault: true
      access: proxy
      editable: true
    ```

### Enable distributed tracing

OpenTelemetry has support for both Jaeger and Zipkin. In this module, you'll use Zipkin, which is an open-source distributed tracing system. It helps gather timing data needed to troubleshoot latency problems in microservice architectures. It manages both the collection and lookup of this data.

:::image type="content" source="../media/zipkin.png" alt-text="A screenshot of Zipkin showing the dependencies of the eShopLite app, Store sending requests to the Products service.":::

In your diagnostics project, you'll need to add support for Zipkin via the `OpenTelemetry.Exporter.Zipkin` NuGet package. You then add code to the `AddObservability` method to export data to Zipkin.

### Go deeper with Application Insights

There's a tool that can combine looking at metrics and viewing distributed tracing, then merge it with data from logs. Azure Application Insights is an extensible Application Performance Management (APM) service. It can be used to monitor your live web application. Azure Application Insights automatically detects performance anomalies&mdash;it includes powerful analytics tools to help you diagnose issues and understand what users actually do with your app.

:::image type="content" source="../media/app-insights.png" alt-text="A screenshot of Azure Application Insights showing the health of the eShopLite app."  lightbox="../media/app-insights.png":::

Like the tools above, you'll need to add a NuGet package to your solution `Azure.Monitor.OpenTelemetry.AspNetCore` then introduce AzureMontior as an exporter to your diagnostics project.
