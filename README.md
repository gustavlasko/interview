# Project for Tech Interviews

- [Backend Interview Guidelines](backend/README.md)
- [Frontend Interview Guidelines](frontend/README.md)
- [Data Interview Guidelines](data/README.md)
- [Site Reliability Engineer Interview Guidelines](sre/README.md)
- [QA Interview Guidelines](qa/README.md)

## Building

### Pre-requisites

- [Docker](https://docs.docker.com/get-started/get-docker/)

### Build the image

```bash
docker build -t interview-app .
```

### Run locally

```bash
docker run -p 8080:8080 interview-app
```

The app will be available at `http://localhost:8080`. Health endpoints are at `/actuator/health/liveness` and `/actuator/health/readiness`.

## Publishing

Publishing is handled automatically by CI on every merge to `master` that touches `backend/`, `Dockerfile`, or `.github/workflows/`.

The image is tagged with both `latest` and the version from `backend/pom.xml`, and pushed to:

`ghcr.io/<owner>/interview-app:<version>`
`ghcr.io/<owner>/interview-app:latest`


### Helm Chart

The chart at `sre/interview-app/` is published automatically on merges to `master` that touch `sre/interview-app/`. It is linted, validated with kube-linter, then pushed to:

`oci://ghcr.io/<owner>/charts/interview-app`

## Using the Helm Chart

### Pre-requisites

- [Helm 3](https://helm.sh/docs/intro/install/)
- A running Kubernetes cluster
- Access to pull from `ghcr.io` (public packages require no auth)

### Install

*Replace `<owner>` in the URLs with the ghcr.io oci owner - e.g., `gustavlasko`, `Tekmetric`

```bash
helm install interview-app oci://ghcr.io/<owner>/charts/interview-app --version 1.0.1
```

### Install with custom values

```bash
helm install interview-app oci://ghcr.io/<owner>/charts/interview-app \
  --version 1.0.1 \
  --set image.tag=1.1.0 \
  --set ingress.enabled=true \
  --set ingress.className=traefik \
  --set "ingress.hosts[0].host=myapp.example.com" \
  --set "ingress.hosts[0].paths[0].path=/" \
  --set "ingress.hosts[0].paths[0].pathType=Prefix"
```

Or with a values file:

```bash
helm install interview-app oci://ghcr.io/<owner>/charts/interview-app \
  --version 1.0.1 \
  -f my-values.yaml
```

Full values reference: [`sre/interview-app/values.yaml`](sre/interview-app/values.yaml)
