# Otomi quick start for creating a RabbitMQ cluster and/or Queues

The `rabbitmq` Helm chart can be used to create:
- A RabbitMQ cluster
- Queues
- Policies

## Prerequisites

To use this Helm chart:

- Make sure the administrator has enabled `rabbitmq`


## Queue Parameters
If a `queue` is added to the values.yaml their mandatory parameters also need to be filled in.

### Queue mandatory parameters
| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `name` | Name of queue.                                                                                        | `string`  |

### Optional parameters
Queue specification for additional configuration, to set the specification in the `values.yaml`, please look at the following example. 

```
queues:
  - name: "my-quorum-queue1"
    spec:
      durable: true
      arguments:
         x-queue-type: quorum
  - name: "my-queue2"
    spec:
      autoDelete: true
```

#### Queues optional parameters
| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `autoDelete` |  When set to true, queues that have had at least one consumer before are deleted after the last consumer unsubscribes.                                    | `boolean`  |
| `durable` |  When set to false queues does not survive server restart.                                    | `boolean`  |
| `vhost` |  Default to vhost '/'                                    | `string`  |

## Policy Parameters
If a `policy` is added to the values.yaml their mandatory parameters also need to be filled in.

### Policy mandatory parameters
| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `name` | Name of policy, cannot be updated.                                                                                       | `string`  |
| `pattern` | Regular expression pattern used to match queues and exchanges, e.g. "^amq.".                                          | `string`  |
| `definition` | Policy definition, for more explanation please look at `Policy definitions`.                                       | `string`  |


#### Policy optional parameters
| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `applyTo` | What this policy applies to: 'queues', 'classic_queues', 'quorum_queues', 'streams', 'exchanges', or 'all'. Default to 'all'.                                    | `string`  |
| `priority` |  In the event that more than one policy can match a given exchange or queue, the policy with the greatest priority applies. Default to '0'.                                     | `number`  |
| `vhost` |  Default to vhost '/'                                    | `string`  |

#### Queue Policy definitions:
Depending on the Queue type you can set different policy definitions. To set a definition in the `values.yaml`, please look at the following example.

```
policies:
  - name: "my-policy1"
    pattern: ".*"
    definition:
      dead-letter-exchange: "cc"
      ha-mode: "all"
    spec:
      applyTo: "classic_queues"
      priority: 1
      vhost: "/"
  - name: my-policy2
    pattern: .*
    definition:
      dead-letter-exchange: cc
      max-age: 1h
    spec:
      applyTo: "quorum_queues"
```

##### Queues [All types]
| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `max-length` |  The maximum length limit of the queue in number of messages                                    | `number`  |
| `max-length-bytes` |  The maximum length limit set to a number of bytes (the total of all message body lengths, ignoring message properties and any overheads),                                                                                     | `number`            |
| `overflow` | Sets the queue overflow behaviour. This determines what happens to messages when the maximum length of a queue is reached. Quorum queue type only supports [drop-head, reject-publish]                                                                                | `[drop-head, reject-publish, reject-publish-dlx]`            |
| `expires` | Controls for how long a queue can be unused before it is automatically deleted.                                                                               | `number`            |
| `dead-letter-exchange` | The exchange the message was published to.                                                                                | `string`            |
| `dead-letter-routing-key` | The routing keys (including CC keys but excluding  BCC ones) the message was published with.                 | `string`            |
| `message-ttl` | How long a message published to a queue can live before it is discarded (milliseconds).                                                                               | `number`            |
| `consumer-timeout` | If a consumer does not ack its delivery for more than the timeout value (30 minutes by default), its channel will be closed with a PRECONDITION_FAILED channel exception.                                                                                | `number`            |

##### Queues [Classic]
| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `ha-mode` | One of all (mirror to all nodes in the cluster), exactly (mirror to a set number of nodes) or nodes (mirror to an explicit list of nodes). If you choose one of the latter two, you must also set ha-params.                                     | `[all, exactly, nodes]`  |
| `ha-params` | Absent if ha-mode is all, a number if ha-mode is exactly, or a list of strings if ha-mode is nodes.                                                                                       | `number | string[]`            |
| `ha-sync-mode` | [manual, automatic]                                                                                | `[manual, automatic]`            |
| `ha-promote-on-shutdown` |  Provides an option to promote a node containing the queue as the master queue node. Is triggered when the node is shutdown gracefully.                                                    | `[when-synced, always]`            |
| `ha-promote-on-failure` | Provides an option to promote a node containing the queue as the master queue node. Is triggered when the node fails                                                                        | `[when-synced, always]`            |
| `queue-version` | Set the queue version. Defaults to version 1. Version 1 has a journal-based index that embeds small messages. Version 2 has a different index which improves memory usage and performance in many scenarios, as well as a per-queue store for messages that were previously embedded. | `number`            |
| `queue-master-locator` | The master queue node is automatically assigned using the rabbitmq node with less masters. `Min-masters`: Selects the master node as the one with the least running master queues. `Client-local`: Selects the queue master node as the local node on which the queue is being declared. `Random`: Selects the queue master node based on random selection.        | `[min-masters, client-local, random]`            |

##### Queues [Quorum]
| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `delivery-limit` | The number of allowed unsuccessful delivery attempts. Once a message has been delivered unsuccessfully more than this many times it will be dropped or dead-lettered, depending on the queue configuration.                                     | `number`  |
| `dead-letter-strategy` | Valid values are at-most-once or at-least-once. It defaults to at-most-once. This setting is understood only by quorum queues. If at-least-once is set, Overflow behaviour must be set to reject-publish. Otherwise, dead letter strategy will fall back to at-most-once. | `[at-most-once, at-least-once]` |
| `queue-leader-locator` | Set the rule by which the queue leader is located when declared on a cluster of nodes. Valid values are client-local (default) and balanced.                                                                               | `[client-local, balanced]`            |

##### Streams
| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `max-age` | Use a number + letter to set the data retention, (Y=Years, M=Months, D=Days, h=hours, m=minutes, s=seconds), Ex: 1h = configures the stream to only keep the last 1 hour of received messages                                    | `string`  |
| `stream-max-segment-size-bytes` | Total segment size for stream segments on disk. | `number` |
| `queue-leader-locator` | Set the rule by which the queue leader is located when declared on a cluster of nodes. Valid values are client-local (default) and balanced.                                                                               | `[client-local, balanced]`            |

##### Exchanges
| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `alternate-exchange` | If messages to this exchange cannot otherwise be routed, send them to the alternate exchange named here.                                  | `string`  |

##### Federation
| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `federation-upstream-set` | Only works if federation plugin is enabled. Chooses the name of a set of upstreams to use with federation, or "all" to use all upstreams.Incompatible with 'federation-upstream'                                  | `string`  |
| `federation-upstream` | Only works if federation plugin is enabled. Chooses a specific upstream set to use for federation. Incompatible with 'federation-upstream-set'                                  | `string`  |
