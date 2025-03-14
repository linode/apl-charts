# SpinApp

A SpinApp is a Custom Resource to deploy WebAssembly microservices and web applications based on Spin. Spin is a framework for building and running event-driven microservice applications with WebAssembly (Wasm) components. Spin uses Wasm because it is sand boxed, portable, and fast. Millisecond cold start times mean no need to keep applications “warm”. Many languages have Wasm implementations, so developers don’t have to learn new languages or libraries.

Spin is open source and built on standards, meaning you can take your Spin applications anywhere. There are Spin implementations for local development, for self-hosted servers, for Kubernetes, and for cloud-hosted services.

## Prerequisites

- `spin-operator` installed.
- `spin-shim-executor` CR added to the Team namespace.