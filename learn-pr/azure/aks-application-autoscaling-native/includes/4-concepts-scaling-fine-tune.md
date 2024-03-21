The `v2` version of the HPA API allows you to fine-tune some aspects of its behavior by using a new key in the YAML file called `spec.behavior`. It accepts two other keys: `scaleDown` and `scaleUp`, which define how the HPA behaves when scaling down and when scaling up.

The following values are allowed for each of these keys:

|Key  |Type  |Description  |
|---------|---------|---------|
|stabilizationWindowSeconds     |int         |The period in which the HPA looks for metrics to compute the desired state. The default value for `scaleDown` is five minutes and there's no stabilization window for `scaleUp`.         |
|selectPolicy     |string         |The selected type of policy to use, this value can be `Min`, `Max`, or `Disabled`.         |
|policies     |array of `HPAScalingPolicy`         |An array of possible policies to apply.         |

The `HPAScalingPolicy` object is defined as an object with the following keys:

|Key  |Type  |Description  |
|---------|---------|---------|
|type     |string         |Type of policy, can be `Percent` or `Pods`.         |
|value     |int         |Value of the policy.         |
|periodSeconds     |int         |Amount of time required before this policy can be applied again.         |

Scaling policies allow you to fine-tune the way the scaling works. For example, you can completely disable the scale down operation by setting a `scaleDown` policy to `Disabled`, as shown in the following example:

```yml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: contoso-website
  namespace: hpa-contoso
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: contoso-website
  minReplicas: 1
  maxReplicas: 10
  behavior:
    scaleDown:
      selectPolicy: Disabled
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 20
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: 50
```

You can also set the number of replicas to scale out at a time by defining a `scaleUp` policy, like this:

```yml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: contoso-website
  namespace: hpa-contoso
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: contoso-website
  minReplicas: 1
  maxReplicas: 10
  behavior:
    scaleUp:
      selectPolicy: Max
      stabilizationWindowSeconds: 120
      policies:
        - type: Percent
          value: 30
          periodSeconds: 60
        - type: Pods
          value: 7
          periodSeconds: 90
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 20
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: 50
```

In this manifest, you're telling the HPA to look for the last 120 seconds of metrics to calculate the desired state and get the highest of these values. Once it does, it calculates 30% of the existing pods, rounds this number up, and compares it with the fixed value of seven pods. Since the `selectPolicy` is set to `Max`, it takes the larger number of those two numbers and applies that policy, then waits `periodSeconds` before applying any policies again.

For example, let's say the website is running with 18 pods, and then it experience a spike that lasts for about 120 seconds. The desired state is computed by calculating 30% of the current running pods, which is 5.4 (rounded to 6). This value is compared to the number of pods in the second policy, which is 7. Since the `selectPolicy` key is set to `Max`, it uses the larger value of those two values. Then, the HPA scales by 7 and waits 90 seconds before scaling up again. If the spike continued up to 25 pods, the calculation is done again. 30% of 25 pods is 7.5 (rounded to 8), which is greater than 7. Now, the HPA creates eight new pods and waits for 60 seconds before scaling up again.
