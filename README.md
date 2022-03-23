# otel-cli-notebook

a quick dockerfile for building a jupyter image with otel-cli running as a server

the entrypoint is a mess, and seems worth improving on

## Build

```sh
docker build --rm -t tobert/otel-cli-notebook .
```

## Usage

Works on my machine :) Adjust port bindings to taste. 8888 is Jupyter, 4317 will receive spans.

```sh
docker run --rm -p 8888:8888 -p 4317:4317 tobert/otel-cli-notebook
```

## Testing

```sh
export OTEL_EXPORTER_OTLP_ENDPOINT=localhost:4317
otel-cli span --name "test span" --verbose
```

or if you don't have otel-cli installed...

```sh
docker run --net=host ghcr.io/equinix-labs/otel-cli:v0.0.19 span \
    --name "test span" \
    --endpoint localhost:4317 \
    --verbose
```

