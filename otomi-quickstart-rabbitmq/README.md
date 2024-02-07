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
| `overflow` | Sets the queue overflow behaviour. This determines what happens to messages when the maximum length of a queue is reached. Quorum queue type only supports [drop-head, reject-publish]                                                                                | `[drop-head, reject-publish, reject-publish-dlx]`            |
| `expires` | PLACEHOLDER                                                                               | `number`            |
| `dead-letter-exchange` | PLACEHOLDER                                                                                | `string`            |
| `dead-letter-routing-key` | PLACEHOLDER                                                                                | `string`            |
| `message-ttl` | How long a message published to a queue can live before it is discarded (milliseconds).                                                                               | `number`            |
| `consumer-timeout` | If a consumer does not ack its delivery for more than the timeout value (30 minutes by default), its channel will be closed with a PRECONDITION_FAILED channel exception.                                                                                | `number`            |

#### Queues [Classic]
| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `ha-mode` | One of all (mirror to all nodes in the cluster), exactly (mirror to a set number of nodes) or nodes (mirror to an explicit list of nodes). If you choose one of the latter two, you must also set ha-params.                                     | `[all, exactly, nodes]`  |
| `ha-params` | Absent if ha-mode is all, a number if ha-mode is exactly, or a list of strings if ha-mode is nodes.                                                                                       | `number | string[]`            |
| `ha-sync-mode` | [manual, automatic]                                                                                | `[manual, automatic]`            |
| `ha-promote-on-shutdown` | PLACEHOLDER                                                                               | `[when-synced, always]`            |
| `ha-promote-on-failure` | PLACEHOLDER                                                                                | `[when-synced, always]`            |
| `queue-version` | Set the queue version. Defaults to version 1.
Version 1 has a journal-based index that embeds small messages.
Version 2 has a different index which improves memory usage and performance in many scenarios, as well as a per-queue store for messages that were previously embedded.                                                                               | `number`            |
| `queue-master-locator` | PLACEHOLDER                                                                               | `string`            |

#### Queues [Quorum]
| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `delivery-limit` | The number of allowed unsuccessful delivery attempts. Once a message has been delivered unsuccessfully more than this many times it will be dropped or dead-lettered, depending on the queue configuration.                                     | `number`  |
| `dead-letter-strategy` | Valid values are at-most-once or at-least-once. It defaults to at-most-once. This setting is understood only by quorum queues. If at-least-once is set, Overflow behaviour must be set to reject-publish. Otherwise, dead letter strategy will fall back to at-most-once. | `[at-most-once, at-least-once]` |
| `queue-leader-locator` | Set the rule by which the queue leader is located when declared on a cluster of nodes. Valid values are client-local (default) and balanced.                                                                               | `[client-local, balanced]`            |

#### Streams
| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `max-age` | Use a number + letter to set the data retention, (Y=Years, M=Months, D=Days, h=hours, m=minutes, s=seconds), Ex: 1h = configures the stream to only keep the last 1 hour of received messages                                    | `string`  |
| `stream-max-segment-size-bytes` | Total segment size for stream segments on disk. | `number` |
| `queue-leader-locator` | Set the rule by which the queue leader is located when declared on a cluster of nodes. Valid values are client-local (default) and balanced.                                                                               | `[client-local, balanced]`            |

#### Exchanges
| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `alternate-exchange` | If messages to this exchange cannot otherwise be routed, send them to the alternate exchange named here.                                  | `string`  |

##### Federation
| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `federation-upstream-set` | Only works if federation plugin is enabled. Chooses the name of a set of upstreams to use with federation, or "all" to use all upstreams.Incompatible with 'federation-upstream'                                  | `string`  |
| `federation-upstream` | Only works if federation plugin is enabled. Chooses a specific upstream set to use for federation. Incompatible with 'federation-upstream-set'                                  | `string`  |

## Network policies
If you have enabled network policies for teams then by default all ingress traffic is blocked. In order to enable traffic between RabbitMQ replicas set `networkPolicy.enabled: true` in the Helm chart values.
