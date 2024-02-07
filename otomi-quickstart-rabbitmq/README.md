# Otomi quick start for creating a RabbitMQ cluster and/or Queues

The `otomi-quickstart-rabbitmq` Helm chart can be used to create:
- RabbitMQ cluster
- Queues
- Policies


## How to use this Helm chart

1. Enable RabbitMQ in the Core Apps
2. Go the to `values` tab and fill in a name for your Workload.


## Parameters

### Mandatory parameters
TBD

### Optional parameters
Queue Policy definitions:
Depending on the Queue type you can set different policy definitions.

#### Queues [All types]
| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `max-length` | PLACEHOLDER                                    | `number`  |
| `max-length-bytes` | PLACEHOLDER                                                                                      | `number`            |
| `overflow` | Quorum queue type only supports [drop-head, reject-publish]                                                                                | `[drop-head, reject-publish, reject-publish-dlx]`            |
| `expires` | PLACEHOLDER                                                                               | `number`            |
| `dead-letter-exchange` | PLACEHOLDER                                                                                | `string`            |
| `dead-letter-routing-key` | PLACEHOLDER                                                                                | `string`            |
| `message-ttl` | value is in milliseconds                                                                                | `number`            |
| `consumer-timeout` | Defaults to '30' minutes                                                                                | `number`            |

#### Queues [Classic]
| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `ha-mode` | If values is 'exactly' or 'nodes', you must also set ha-params                                    | `[all, exactly, nodes]`  |
| `ha-params` | If 'ha-mode' has the value 'exactly' fill in a number, if 'ha-mode' has the value 'nodes' fill in a list of strings                                                                                      | `number | string[]`            |
| `ha-sync-mode` | [manual, automatic]                                                                                | `[manual, automatic]`            |
| `ha-promote-on-shutdown` | PLACEHOLDER                                                                               | `[when-synced, always]`            |
| `ha-promote-on-failure` | PLACEHOLDER                                                                                | `[when-synced, always]`            |
| `queue-version` | Defaults to version '1'                                                                                | `number`            |
| `queue-master-locator` | PLACEHOLDER                                                                               | `string`            |

#### Queues [Quorum]
| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `delivery-limit` | PLACEHOLDER                                    | `number`  |
| `dead-letter-strategy` | Defaults to 'at-most-once', if the value is 'at-least-once' then 'overflow' must be set to 'reject-publish' | `[at-most-once, at-least-once]` |
| `queue-leader-locator` | Defaults to 'client-local'                                                                              | `[client-local, balanced]`            |

#### Streams
| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `max-age` | Use a number + letter to set the data retention, (Y=Years, M=Months, D=Days, h=hours, m=minutes, s=seconds), Ex: 1h = configures the stream to only keep the last 1 hour of received messages                                    | `string`  |
| `stream-max-segment-size-bytes` | PLACEHOLDER | `number` |
| `queue-leader-locator` | Defaults to 'client-local'                                                                              | `[client-local, balanced]`            |

#### Exchanges
| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `alternate-exchange` | PLACEHOLDER                                  | `string`  |

##### Federation
| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `federation-upstream-set` | Only works if federation plugin is enabled. Incompatible with 'federation-upstream'                                  | `string`  |
| `federation-upstream` | Only works if federation plugin is enabled. Incompatible with 'federation-upstream-set'                                  | `string`  |

## Network policies
If you have enabled network policies for teams then by default all ingress traffic is blocked. In order to enable traffic between RabbitMQ replicas set `networkPolicy.enabled: true` in the Helm chart values.
