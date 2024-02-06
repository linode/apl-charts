# Otomi quick start for creating a RabbitMQ cluster and/or Queues

The `otomi-quickstart-rabbitmq` Helm chart can be used to create:
- RabbitMQ cluster
- Queues
- Policies


## How to use this Helm chart

TBD

## Parameters

### Mandatory parameters
TBD

### Optional parameters
TBD

## Network policies
If you have enabled network policies for teams then by default all ingress traffic is blocked. In order to enable traffic between RabbitMQ replicas set `networkPolicy.enabled: true` in the Helm chart values.
