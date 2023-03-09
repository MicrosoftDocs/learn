The `v2beta2` version of the HPA API, allows you to fine-tune some aspects of its behavior. This is done through a new key in the YAML file called `spec.behavior`. It accepts two other keys, `scaleDown` and `scaleUp`, which defines, respectively, how the HPA will behave when scaling down and when scaling up.

These are the allowed values on each of these keys:

|Key  |Type  |Description  |
|---------|---------|---------|
|stabilizationWindowSeconds     |int         |The period the HPA will look for metrics to compute the desired state. The default value for `scaleDown` is 5 minutes and there's no stabilization window for `scaleUp`         |
|selectPolicy     |string         |The selected type of policy to use, this value can be `Min`, `Max`, or `Disabled`         |
|policies     |array of `HPAScalingPolicy`         |An array of possible policies to apply         |

The `HPAScalingPolicy` object is defined as an object with the following keys:

|Key  |Type  |Description  |
|---------|---------|---------|
|type     |string         |Type of policy, can be `Percent` or `Pods`         |
|value     |int         |Value of the policy         |
|periodSeconds     |int         |Amount of time required before this policy can be applied again         |

Scaling policies allows you to fine-tune the way the scaling works, for example, you can completely disable the scale down operation by setting a `scaleDown` policy to `Disabled`:

```yml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: contoso-website
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

In this manifest, you're telling the HPA to look for the last 120 seconds of metrics to calculate the desired state and get the highest of these values, once it does, it will calculate 30% of the existing pods, round this number up, and compare with the fixed value of seven pods, since the `selectPolicy` is defined to `Max` it will take the biggest of those two numbers and apply that policy, then wait `periodSeconds` before applying any policies again.

As an example, the website is running with 18 pods. Then it suffers a spike that lasts for at least 120 seconds. The desired state will be computed by calculating 30% of the current running pods, which is 5.4, which will be rounded to 6, and compared to the number of pods in the second policy, which is 7. Since the `selectPolicy` key is set to `Max` it will use the biggest of those two values, then the HPA will scale by 7 and wait 90 seconds before scaling up again.

If the spike continues, now with 25 pods, the calculation is done again, so 30% of 25 pods is 7.5, which will be rounded to 8, which is greater than 7, so now the HPA creates eight new pods and waits for 60 seconds before scaling up again.
