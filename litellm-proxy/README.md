# LiteLLM Proxy

LiteLLM proxy provides an OpenAI-compatible API for Ollama models. This is used to make Ollama embedding models compatible with agent pipelines that expect OpenAI-style endpoints.

## Purpose

The agent RAG pipeline expects OpenAI-compatible endpoints at `/v1/embeddings`, but Ollama exposes `/api/embeddings`. This proxy translates between the two.

## Installation

```bash
helm install embedding-proxy ./litellm-proxy \
  --namespace team-demo \
  --set nameOverride=embedding-proxy
```

## Configuration

The default configuration proxies to `my-embed` service in the `team-demo` namespace. To customize:

```yaml
config:
  modelList:
    - model_name: all-minilm
      litellm_params:
        model: ollama/all-minilm
        api_base: http://my-embed.team-demo.svc.cluster.local:11434
```

## Usage with Agents

When deploying an agent, set the `EMBEDDING_MODEL_ENDPOINT` to point to this proxy:

```yaml
extraEnvVars:
  - name: EMBEDDING_MODEL_ENDPOINT
    value: embedding-proxy.team-demo.svc.cluster.local
```

The agent will then call `http://embedding-proxy.team-demo.svc.cluster.local/v1/embeddings` which will be proxied to the Ollama service.
